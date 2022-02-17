; ModuleID = 'static_boundaries.ll'
source_filename = "static_boundaries.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@N = local_unnamed_addr global i32 2048, align 4

; Function Attrs: norecurse nounwind uwtable
define void @sum(i32* nocapture readonly %a, i32* nocapture readonly %b, i32* nocapture %c) local_unnamed_addr #0 {
entry:
  %0 = load i32, i32* @N, align 4, !tbaa !2
  %cmp5 = icmp sgt i32 %0, 0
  br i1 %cmp5, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body.1, %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.1, %for.body.preheader
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next.1, %for.body.1 ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx2 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv
  %2 = load i32, i32* %arrayidx2, align 4, !tbaa !2
  %add = add nsw i32 %2, %1
  %arrayidx4 = getelementptr inbounds i32, i32* %c, i64 %indvars.iv
  store i32 %add, i32* %arrayidx4, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %3 = load i32, i32* @N, align 4, !tbaa !2
  %4 = sext i32 %3 to i64
  %cmp = icmp slt i64 %indvars.iv.next, %4
  br i1 %cmp, label %for.body.1, label %for.cond.cleanup.loopexit

for.body.1:                                       ; preds = %for.body
  %arrayidx.1 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv.next
  %5 = load i32, i32* %arrayidx.1, align 4, !tbaa !2
  %arrayidx2.1 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next
  %6 = load i32, i32* %arrayidx2.1, align 4, !tbaa !2
  %add.1 = add nsw i32 %6, %5
  %arrayidx4.1 = getelementptr inbounds i32, i32* %c, i64 %indvars.iv.next
  store i32 %add.1, i32* %arrayidx4.1, align 4, !tbaa !2
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.next, 1
  %7 = load i32, i32* @N, align 4, !tbaa !2
  %8 = sext i32 %7 to i64
  %cmp.1 = icmp slt i64 %indvars.iv.next.1, %8
  br i1 %cmp.1, label %for.body, label %for.cond.cleanup.loopexit, !llvm.loop !6
}

; Function Attrs: nounwind readonly uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) local_unnamed_addr #1 {
entry:
  ret i32 0
}

attributes #0 = { norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.unroll.disable"}
