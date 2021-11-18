Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915C456453
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhKRUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhKRUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:39:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA387C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:36:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9210857pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVkmmvG/j7pAxwD3ZkAKM2VobhK3Up8KSyZejtIse54=;
        b=PPEK73YjIZ+zZ041dY75YBSx5UtWt6K5MgviG4QHxEGeyCZYxwFP/0FoKTcDhNwWHC
         DjxZfKR0TwBk1ezwU++Gp3NdN8T4UpAE1jftPiLiojqArr4Bk4saT/OECZiSBnn9rMX+
         5YllHgwKvZv6KkYUv+yIEa5C6M5sCoUb0pPY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVkmmvG/j7pAxwD3ZkAKM2VobhK3Up8KSyZejtIse54=;
        b=6PdEx96xQzZP5qx7qFQOsOkRsURMYjdt2CnVhfysTDGulFE0rQ6GtFVa3oPoJoyN+k
         X6+n9u3YAdH9E67oEceKCZsF+QWmdwA0AXErMJzP5XRaNDsdqUK3yk819CP7PrKjZD6u
         knxKHZUwMPowZL9sLqkm01VwgHhOrKUHAerR0D648FQBTCaJrO8lbwG7kvpg9ixw0oP2
         o+JzQE0THSD0ppQICAWspDfe0PbdKCw9Y3kZESXR6/Z9hOjtMPi16t1bBhN0t4TnINGv
         gfC/OqEs6Ei3R2NPkWlHgkbTUSR6UBBjk/P/fTYgvHlvhEllShSNsGKiUZMdnCVsRQOw
         hVOQ==
X-Gm-Message-State: AOAM532dLnOe49xtPEIOMOg+E6f8fpqvDHD5ZfZcUMn/8OV54aGq4RCy
        kqL+4iZObqA012aPnRZm1Tiz0A==
X-Google-Smtp-Source: ABdhPJxMwU1fSwD50NTL/ixCZzNZiTT9wK+rF5Dat8y+lnVThvSBnIvaT6qSQYGBMA8U9DmIJMZ29A==
X-Received: by 2002:a17:90a:7ac8:: with SMTP id b8mr13874273pjl.206.1637267766535;
        Thu, 18 Nov 2021 12:36:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gc22sm8900753pjb.57.2021.11.18.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:36:06 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Date:   Thu, 18 Nov 2021 12:36:04 -0800
Message-Id: <20211118203604.1288379-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131; h=from:subject; bh=Nd4ePfUzckpA23dYadFOEde2uR/aV7RLm1vyTElA6rM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrkzlK5F2t3ltvzRwjCkTmaKG7QFHzINoff+dGs2 EAsb07CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa5MwAKCRCJcvTf3G3AJsaxEA CdO3ZJYc4b0R3BTvkb66wG6EJaEgsRZ85XsSStLG9iLH8wNFFNYQaU2QY37x0PV8Hld/mIQjl0s24m OamYw0ox0n67RvD21GiL6V6fBuzBIqLl//8XKH1HuXVmUR5KP8FpuugmilDvAaXHyVkHmaI9Ft+d2G W5tB+zXf3G5PwWLJBU6dt7fAJYGjJUkGXZE8TdBUdRcS5yXKd5VkLYvB6wr+eN79xCZPzW2jhCqPH8 w7E0lW9r+wt4BjmCQ1q4pp/mHYkJcQFkSdzoiBWWIOnZoGQSDhfaROvr7cNOL2ampq9sNvcrsV15Yt +FD1hU5ZmX8dzFDk2iAqhMxTYIaHHxhFm+yeyZd8CKrZReuCECztiTNoUTpfnMiwcZd5pkrJjjnGAU 2EKQLvWqqK1LVKzR3rcm6MnyNhVduUwF3hqkS632N8ZvuQ1+IsXctxfBiN4icsN9LnYmigrZ2Ojuh8 uuq6hpntjT9q1kqSJMVZkFCOo97YS1i+J0QhIOlCOqR4eabzITemH7qSirg0sm5QIMiR8/Bpfk8i2h Ds5O48/TYaLwyz9TCCGtYCSbAYZTl7LXFpl3ShVhl9+RoYqbxQ9f2LTVI7TRBMk6W6BfzDylb8Skvj T9oPd1+dRKTkj2RX7oH+CzFt3t98ieoJmtPy2h+SXNBcrI7KOfnOvuhfLadA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add a struct_group() for the spe registers so that memset() can correctly reason
about the size:

   In function 'fortify_memset_chk',
       inlined from 'restore_user_regs.part.0' at arch/powerpc/kernel/signal_32.c:539:3:
   >> include/linux/fortify-string.h:195:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
     195 |    __write_overflow_field();
         |    ^~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/include/asm/processor.h |  6 ++++--
 arch/powerpc/kernel/signal_32.c      | 14 +++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e39bd0ff69f3..978a80308466 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -191,8 +191,10 @@ struct thread_struct {
 	int		used_vsr;	/* set if process has used VSX */
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_SPE
-	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
-	u64		acc;		/* Accumulator */
+	struct_group(spe,
+		unsigned long	evr[32];	/* upper 32-bits of SPE regs */
+		u64		acc;		/* Accumulator */
+	);
 	unsigned long	spefscr;	/* SPE & eFP status */
 	unsigned long	spefscr_last;	/* SPEFSCR value on last prctl
 					   call or trap return */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 00a9c9cd6d42..5e1664b501e4 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -527,16 +527,20 @@ static long restore_user_regs(struct pt_regs *regs,
 	regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
 
 #ifdef CONFIG_SPE
-	/* force the process to reload the spe registers from
-	   current->thread when it next does spe instructions */
+	/*
+	 * Force the process to reload the spe registers from
+	 * current->thread when it next does spe instructions.
+	 * Since this is user ABI, we must enforce the sizing.
+	 */
+	BUILD_BUG_ON(sizeof(current->thread.spe) != ELF_NEVRREG * sizeof(u32));
 	regs_set_return_msr(regs, regs->msr & ~MSR_SPE);
 	if (msr & MSR_SPE) {
 		/* restore spe registers from the stack */
-		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
-				      ELF_NEVRREG * sizeof(u32), failed);
+		unsafe_copy_from_user(&current->thread.spe, &sr->mc_vregs,
+				      sizeof(current->thread.spe), failed);
 		current->thread.used_spe = true;
 	} else if (current->thread.used_spe)
-		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
+		memset(&current->thread.spe, 0, sizeof(current->thread.spe));
 
 	/* Always get SPEFSCR back */
 	unsafe_get_user(current->thread.spefscr, (u32 __user *)&sr->mc_vregs + ELF_NEVRREG, failed);
-- 
2.30.2

