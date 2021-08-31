Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5F3FC462
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhHaIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbhHaIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:37:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78766C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:37:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u6so13752840pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHZl5BunAcxUHLFIakel1iz2POAJlqup+RiIGGyi0Ds=;
        b=y+s3k2EIXwWTcspLyTDtJETViQEcBIFXZKhO/PN8oj1CNT7TOfeJ1H6hviCTJTKzzD
         OUMFdQhcClqGf+R+YlnhyklgJX5gqw6TiEjkdhwYRuHP9kuhAL5YnH8WADuQSRkxBubj
         uMlqxG+0uRLSLU237Lvj1wDEyOA5swIKgnnnF/g/OISmB2Yyjm2/VnsxP5qSOPxkqRKZ
         95FYQt3XtFKuWUENUyEXpIDIc6iMoTtVlEjZd/gAOFB9X31OSbKzXY6R1JfrNhYiWqoE
         uDwpXxfgS/cuYKQQaOMxq326A8Q8bbvH2yYiGMYGB43HTbzyKyqRlXhiKgVHEhu5ov/a
         KBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHZl5BunAcxUHLFIakel1iz2POAJlqup+RiIGGyi0Ds=;
        b=Aum+gXPE5D+WW6VWbVSlMlgrXBH/pfe1dlF/isHAm8pDd+GczAU3VSgcj341fLLfYT
         9xAWnVql5pnLnegQZR8swwGzW9bfJ0/TT+yfDxilnd+UiAKNyGWvxf3iH7ooD+Z6NCYO
         C4aKv/+mWTSYxSBT7Qa4Qj7tsRlPXLj3+UWx7FtWeihytiU5KR4Or1NpD+BBcvyFwM6/
         avAwNb6FOF8JF5MbUgzJlcXc2QVbv6k4ku5Jsfy1hfUt0snkTXMDBynDqg5bjGXeisog
         RY8mpFCVRLNuS5f5VItLoCK9rMQ5UPm24YXxt80M19B6TlXYjm0J8cIWnUOHAZL3vBTY
         PQ5Q==
X-Gm-Message-State: AOAM530SdD04JMXRZwEhlxHtwmcBRuPjv3bn3dQNFy0HKpjXOrMbBf8u
        QIdRY+2w8vdtTF101csJfQ367Q==
X-Google-Smtp-Source: ABdhPJysikJpOKwYmFE6xVlR0daUy8pN/ZL545PbHdCTg3nuUMKycQBWO8lmgfVtTqxePjJIFyHU9g==
X-Received: by 2002:a63:d205:: with SMTP id a5mr2404473pgg.30.1630399023962;
        Tue, 31 Aug 2021 01:37:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w5sm19553898pgp.79.2021.08.31.01.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:37:03 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RESEND] x86: fix get_wchan() not support the ORC unwinder
Date:   Tue, 31 Aug 2021 16:36:25 +0800
Message-Id: <20210831083625.59554-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by
default on x86, but the implementation of get_wchan() is still
based on the frame pointer unwinder, so the /proc/<pid>/wchan
always return 0 regardless of whether the task <pid> is running.

We reimplement the get_wchan() by calling stack_trace_save_tsk(),
which is adapted to the ORC and frame pointer unwinders.

Fixes: ee9f8fce9964(x86/unwind: Add the ORC unwinder)
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Changlog in resend:
  - rebase on next-20210830

 In addition, this issue has existed for nearly 4 years and no one has
 fixed it, maybe we can return 0 or remove this function directly if
 nobody cares about the return value of the get_wchan() ?

 The following is the previous patch link:

	https://lore.kernel.org/patchwork/patch/1445013/

 arch/x86/kernel/process.c | 51 +++--------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..e645925f9f02 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -944,58 +944,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax = start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top = topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom = start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top = start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -= 2 * sizeof(unsigned long);
-	bottom = start;
-
-	sp = READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret = ip;
-			goto out;
-		}
-		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
-
-out:
-	put_task_stack(p);
-	return ret;
+	stack_trace_save_tsk(p, &entry, 1, 0);
+	return entry;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-- 
2.11.0

