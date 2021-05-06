Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA6374F40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhEFGPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhEFGPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:15:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE635C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 23:14:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so2833642plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=gbqKHbpw3h7WUhKtmIh7lCwa6u4+vakPW0cMHwa4RI8=;
        b=VPC151BBtxxibLaIYwadUQHHv9kP3BRFJntrcijQG36lrC4+n2fJEEiN0WZL8fHeLL
         qnJrdxCrrMVWZpcD8TTFqZMuW2J2fHZ5DQO4K4fTb1vncxzuzRtXtjbBgW0Hdc4RYvOl
         tcQxTLLQf8NAlUStclchV+Z0JMe39cYhZBk7RRNMONrTM5SNomC2HwW4HD8/Fe9fna3Q
         jFLCGI5FblwF8cvy8zBVnQDwMCE0PFx7HvZ3+SL1NcYY/V4zylE+yof9t0sXXBtwmOFH
         p83+wQzkWKHw3Rr7683gEL+H/neVnfY8PdYDQlnVlrdPgUVkJPduNQmHyRgHjaXNjxNQ
         3iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=gbqKHbpw3h7WUhKtmIh7lCwa6u4+vakPW0cMHwa4RI8=;
        b=otgSXjrUnd2oz1+mhtTWo7wyq4/TN7dWawvDIuH+oiXVi4RjxDk22MbYHLyx8EPdtO
         iaZxwoovm1gHiNAqc/fZuKzFtgXaVW+/4bE7TXjfxU4z9l+aG4mR0DY16s739kRt8lMn
         vn8/GUC1BrOdvhAGl5cVlY5batoct1jZbsuy0pgfsAzzfHJZDCGqqlmdsd77AWh5o7sj
         rI8YZEKQ6dsZwyBKTK+RB6ZVJSi8+nuaSHjlHv0c84zF/14bik5y2ED6rds9UeahlPCV
         CDqtDMnE9L3w+igXU/vDaTHmvZqhoCPSC2qDYZbQCj+MF4ifInr6+v4GZWJWicNlfuDA
         AfdQ==
X-Gm-Message-State: AOAM5326fHS6MqN4/yJ976rBr/KKZr54AkvaxKknjwHD+qYSiWCp5Ero
        vx9ipuKGXSldXUhrsqFEbTuIbA==
X-Google-Smtp-Source: ABdhPJxUmkdKiQuialVQnku6YJhKcopVsDfowlrQeD/XhJedrfgASyW7+jgshIt8whTmZwmfLLrpTw==
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id 4-20020a1709020004b02900ee8f40ecbfmr2974172pla.28.1620281652240;
        Wed, 05 May 2021 23:14:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 79sm1030558pfz.202.2021.05.05.23.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:14:11 -0700 (PDT)
Subject: [PATCH] RISC-V: Protect reads from other harts stack frames
Date:   Wed,  5 May 2021 23:13:52 -0700
Message-Id: <20210506061352.340752-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        wangkefeng.wang@huawei.com, akpm@linux-foundation.org,
        0x7f454c46@gmail.com, rostedt@goodmis.org, chenhuang5@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        syzbot+0806291048161061627c@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

The stack walking code wasn't correctly decorated with READ_ONCE_NOCHECK
when reading from other harts stack frames, which can trigger a kasan
failure.  This may also manifest as a bug, as without the READ_ONCE we
may get inconsistent results.

Reported-by: syzbot+0806291048161061627c@syzkaller.appspotmail.com
Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

I don't actually have a test for stack walking aside from just crashing
the kernel and making sure things look roughly OK.  I haven't gotten
around to that because this got lost in the merge window shuffle, but I
thought I'd send this out in case someone has a better test for stack
walking so I can start running that.
---
 arch/riscv/kernel/stacktrace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 3f893c9d9d85..7f3914756915 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,6 +18,9 @@ register const unsigned long sp_in_global __asm__("sp");
 
 #ifdef CONFIG_FRAME_POINTER
 
+#define READ_FRAME(frame, off)	\
+	(READ_ONCE_NOCHECK(*(unsigned long *)(frame + offsetof(struct stackframe, off))))
+
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
@@ -40,7 +43,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 
 	for (;;) {
 		unsigned long low, high;
-		struct stackframe *frame;
+		unsigned long frame;
 
 		if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
 			break;
@@ -51,14 +54,14 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		if (unlikely(fp < low || fp > high || fp & 0x7))
 			break;
 		/* Unwind stack frame */
-		frame = (struct stackframe *)fp - 1;
+		frame = fp - sizeof(struct stackframe);
 		sp = fp;
-		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
-			fp = frame->ra;
+		if (regs && (regs->epc == pc) && (READ_FRAME(frame, fp) & 0x7)) {
+			fp = READ_FRAME(frame, ra);
 			pc = regs->ra;
 		} else {
-			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+			fp = READ_FRAME(frame, fp);
+			pc = ftrace_graph_ret_addr(current, NULL, READ_FRAME(frame, ra),
 						   (unsigned long *)(fp - 8));
 		}
 
-- 
2.31.1.527.g47e6f16901-goog

