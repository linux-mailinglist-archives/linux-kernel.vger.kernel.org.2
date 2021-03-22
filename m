Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D568034529F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVWxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCVWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:53:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E00C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l3so12254716pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdPAri8WoNsvA6cnhWTwn4LuVR0p31oI0eOUDse1ymU=;
        b=o9q20IOjrMTNEMELiAE+McnFDmEU2NeXPn2ko/gUHyiZgS1jUYp0Xu1rmqBioWYI5z
         YqVjqqs5dNckbDiyZSqacUd8um6FoRBsTp2hbx85JPUrxvRgsuJ8mAR8PFuZBI0am4cB
         rij/jU3nk8puii6J6vNO+/3nPsnxFRyPjw1cjBDaRvPFYKU2bmVNVLvpcJ+uFrRzCtd6
         5Oz7gbP4gcTORSAAXu2uzsAGrSH3VZoxjONDroHWXMsPl5yCKqpvfh0cIOKwtTIfYpup
         0neIfRYYMhJ980XYJgfXLoGj/vSF/ywjBs1CLudb+59g7uwa6S+liubZ5Ls4/wMkUfLN
         F6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdPAri8WoNsvA6cnhWTwn4LuVR0p31oI0eOUDse1ymU=;
        b=kwvKVxIZmLH62wSjeqDKHzBeADBPvQLhykMloW9EEk2kSxJbseJ20RsK4d5fnBHACz
         1Hvllu1OH5uA3bv2JLSNYWjwYo0VdjjqUGDvpHkRuQeGXYAQXrpyzHDycs8avUQzYdTv
         JtDcZ2Q0xP2KiGmfbW+VoAwMmBiMrjyPx8w3N9oL5hZjeQq+EOXuXP3x8btIucn0GUcd
         /L6XyIrpulfyoJb+bsEhXTUumeEsKSeRNx9KJXgJAb19UfCRwM+IL8iqWtdd/s4GpGfI
         yE7M/9vgrg5rKcn8Ernimx0JJLe5lijbtVYAIxDUDm9jC1EHxdyKfT7Bt6Pr9r860xju
         nRgg==
X-Gm-Message-State: AOAM533k/u8VKkSUDbdQ0F9MbEeHaNVoeax9yhsH9fT3AXuwJpkuhKgz
        iQwcPFqNfw81IHHpDylInl2V2ba4EVKSfQ==
X-Google-Smtp-Source: ABdhPJyCo1Tsxnu9rig2t2KgMAcB3e7DRoJWJFvNaZoTvo5cXK5H0K/AscZbaDqkmYLKr0E6zpyEHg==
X-Received: by 2002:a17:902:8497:b029:e6:f01d:9c9f with SMTP id c23-20020a1709028497b02900e6f01d9c9fmr462781plo.7.1616453597180;
        Mon, 22 Mar 2021 15:53:17 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id j13sm8878211pfn.103.2021.03.22.15.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:53:16 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 2/4] arm64/ptrace: introduce orig_x7 in the user_pt_regs structure
Date:   Mon, 22 Mar 2021 15:50:51 -0700
Message-Id: <20210322225053.428615-3-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322225053.428615-1-avagin@gmail.com>
References: <20210322225053.428615-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some ABI weirdness in the way that we handle syscall exit stops
because we indicate whether or not the stop has been signalled from
syscall entry or syscall exit by clobbering a general purpose register
x7 in the tracee and restoring its old value after the stop.

This behavior was inherited from ARM and it isn't common for other
architectures. Now, we have PTRACE_GET_SYSCALL_INFO that gives all
required information about system calls, so the hack with clobbering
registers isn't needed anymore.

This change instroduces orig_x7 in the user_pt_regs structure that will
contains an origin value of the x7 register if the tracee is stopped in
a system call..

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/ptrace.h      |  1 +
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/ptrace.c           | 18 ++++++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index d4cdf98ac003..1008f0fbc5ea 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -184,6 +184,7 @@ struct pt_regs {
 			u64 pc;
 			u64 pstate;
 			u64 orig_x0;
+			u64 orig_x7;
 		};
 	};
 #ifdef __AARCH64EB__
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 3c118c5b0893..be7583ff5f4d 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -91,6 +91,7 @@ struct user_pt_regs {
 	__u64		pc;
 	__u64		pstate;
 	__u64		orig_x0;
+	__u64		orig_x7;
 };
 
 struct user_fpsimd_state {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 170f42fd6101..1ed5b4aa986b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1750,7 +1750,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 				     enum ptrace_syscall_dir dir)
 {
 	int regno;
-	unsigned long saved_reg;
+	u64 _saved_reg, *saved_reg;
 
 	/*
 	 * We have some ABI weirdness here in the way that we handle syscall
@@ -1768,19 +1768,25 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * - Syscall stops behave differently to seccomp and pseudo-step traps
 	 *   (the latter do not nobble any registers).
 	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
+	if (is_compat_task()) {
+		regno = 12;
+		saved_reg = &_saved_reg;
+	} else {
+		regno = 7;
+		saved_reg = &regs->orig_x7;
+	}
+	*saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
 	if (dir == PTRACE_SYSCALL_ENTER) {
 		if (tracehook_report_syscall_entry(regs))
 			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
+		regs->regs[regno] = *saved_reg;
 	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
 		tracehook_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
+		regs->regs[regno] = *saved_reg;
 	} else {
-		regs->regs[regno] = saved_reg;
+		regs->regs[regno] = *saved_reg;
 
 		/*
 		 * Signal a pseudo-step exception since we are stepping but
-- 
2.29.2

