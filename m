Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E13A4260
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhFKMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:49:50 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42734 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhFKMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:49:48 -0400
Received: by mail-pl1-f172.google.com with SMTP id v13so2780261ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AE3To/S2wXDjBGxOMUQqWoGcFGQ4LG3QMNrQoU63RTk=;
        b=NZIahI+z75IWJiV27ZfoKIr+JftTfzPOdFitcNdNyV1IsC4F0EYCvWoy4zfao4+VXH
         OxWoNN5w99jg6L7rbTUR1FF7/u5a3RVRhLPQS8azTyZZxLWC0hAx/lhAgx2pTpfemdVp
         hFbRXKv1/WLZt60hlePQunO624bPq7uQV9iowDCaii7UZDR4/RE9GDHu/GGiKTc7H5r0
         /wUotC3CHQxNDX7n4zjFpvk16wlM872XI3h6LuRRt3Mng5+dVc1HwO/VX9ZA0PdcDiwN
         cXQLAg3+bQweSB83VxsKB9RFruo8jNLgced0EBf439jH52VN6edJpx99jVkOXiyET4Sy
         va4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AE3To/S2wXDjBGxOMUQqWoGcFGQ4LG3QMNrQoU63RTk=;
        b=VIvC3ZvC84s5+EMc2W238nTqKZdzkSvfhkVADXC9V22xkuB1b7qG+NkHnZ7kFbOAMN
         kj8RhFgoKY/pkds979h1dJCbv7xKnsvBdxEZbRE1wnWZzCV1HKTO1C7nlMKz9EHKTGma
         ZO6J6x8fqxTUM9B3uSm5MTQCj6c3TokRs1doaeigcj1/guV42TxqacVuxbBzSUVZqyfv
         c1SlyEsgsqDECXqPT7DqukqoUrWM74SIwjOmE3VFf/YYZdg0eBci4wZzMKUi6EJBjcVb
         8gBCfmXVOty2Qf5eA3R0yRO8Ev4Vs1XAAUEtxGgcQro5XSRhApsMKlUfxbLUUuu/x6iv
         FP7w==
X-Gm-Message-State: AOAM531n1ZJgZm1CI8PBeuwCOBkxUtvBJkVex5YGd1I8wSd6oEvc2V1d
        8+VtYv5Ge3ujeSYBlBsxXCpD4PcJjXeamA==
X-Google-Smtp-Source: ABdhPJx2URTNWRZ3cCYRxJYE3zGLlfRMolF+ggHJz87TLuTHudz20Mzg8r6hDUao+GnWZCxtMLcMMg==
X-Received: by 2002:a17:90b:108f:: with SMTP id gj15mr4550563pjb.124.1623415610527;
        Fri, 11 Jun 2021 05:46:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id f8sm4874186pfv.73.2021.06.11.05.46.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 05:46:50 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] x86: fix get_wchan() not support the ORC unwinder
Date:   Fri, 11 Jun 2021 20:46:42 +0800
Message-Id: <20210611124642.72910-1-zhengqi.arch@bytedance.com>
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
 arch/x86/kernel/process.c | 51 +++--------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e1f38179f49..976a36918ed7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -928,58 +928,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || p->state == TASK_RUNNING)
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
-	} while (count++ < 16 && p->state != TASK_RUNNING);
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

