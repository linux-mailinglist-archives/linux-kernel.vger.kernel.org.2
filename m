Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF63370249
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhD3UjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhD3UjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:39:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C06C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so10654743wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wp7Rsa3dbFK1Rt2HaXcIflNA2UCoRc1Jacf2kiGOD4Y=;
        b=fTWIgIXXXBicM8mkR4e+jMmoMkXLMfXIPA8qQJfimikpqNo4e6OavH5E2OFZQldeFV
         wdFu2C17LBu3ZAafS1DpnRtyU4zQ1q7hL/DdUZUopyaPYWKVkOnAOVxVT7gmhzihNhkA
         RpwpPqwn/JyMXn7bsws+DE6vi1jEZxsi1D6DQpfPSaHA3VYErEIxGP10opO3WQRGovzW
         T/gZAAry1kzu0qIbeQif93P8myozy7i4SphAn7qrDDyLLQv9S7SYSkKQkEa1nvU7F0fu
         P87agY0+PtB1lGoj+4fEcJ0rH2pAb6xB6djbUyfg4cZoHgAYFjtdJxqY/OGX56xL2bHV
         yc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wp7Rsa3dbFK1Rt2HaXcIflNA2UCoRc1Jacf2kiGOD4Y=;
        b=oXig2t+wgGKzDEVL9T/4TWo2+QLqsePcYlk0Qky0KCUP3BdgcdwwSJ7GbIlfQ+oJ0o
         YnMh3pMUH2BC/Nj26GvlYUQ7/LKVtPeXXX4Dqyech588FOTbyQuWAror6ap17lsMIET7
         +iekBqIpHRWBl1Ka655nb6RrxsahChLnXiXOsRFTDgOmK6XNWTx7XpVGUmIikZqR/G4X
         S5qE+FiipYHAYVcG6HYeicZR8Bptp140UbTxPHcqZKazdCpS6W2yqpfSR0Sh4zQW30t4
         ryuXtFau3w+gwPXoIDuBK/FEGKNeaBDPorirD/LIAbjOmkLcjMICHibyU/G5cu/302Mc
         +Jqg==
X-Gm-Message-State: AOAM530nKriyPu6W5LWAvXpmi/fD2FeHL8hlIO7D7GsGMTfLbqw07WJy
        CFNrqn5gOgY9864imEJBJ5s=
X-Google-Smtp-Source: ABdhPJwsNZHj8NpnDYRZa7EoRD8F5v2Z3j4FTMvwiwmwQHZqMamEq3kqT32JAYW/vdBQAdOO2UmHUw==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr9644074wrq.168.1619815094834;
        Fri, 30 Apr 2021 13:38:14 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:14 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] arm64: Add a compat syscall flag to thread_info
Date:   Fri, 30 Apr 2021 21:37:55 +0100
Message-Id: <20210430203757.47653-5-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is used by in_compat_syscall to handle compat syscalls coming
from 64-bit tasks.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/include/asm/compat.h      |  4 ++--
 arch/arm64/include/asm/elf.h         | 13 ++++++++++++-
 arch/arm64/include/asm/thread_info.h |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index a2f5001f7793..124f4487dfee 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -190,13 +190,13 @@ static inline bool is_compat_thread(struct thread_info *thread)
 
 static inline bool in_compat_syscall(void)
 {
-	return is_compat_task();
+	return current_thread_info()->use_compat_syscall;
 }
 #define in_compat_syscall in_compat_syscall	/* override the generic impl */
 
 static inline bool thread_in_compat_syscall(struct thread_info *thread)
 {
-	return is_compat_thread(thread);
+	return thread->use_compat_syscall;
 }
 
 #else /* !CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index e21964898d06..49a9a9db612c 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -158,10 +158,20 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
+#ifdef CONFIG_COMPAT
+#define CLEAR_COMPAT_SYSCALL()						\
+({									\
+	current_thread_info()->use_compat_syscall = false;		\
+})
+#else
+#define CLEAR_COMPAT_SYSCALL()	((void)0)
+#endif
+
 #define SET_PERSONALITY(ex)						\
 ({									\
 	clear_thread_flag(TIF_32BIT);					\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
+	CLEAR_COMPAT_SYSCALL();						\
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
@@ -228,7 +238,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
 	set_thread_flag(TIF_32BIT);					\
- })
+	current_thread_info()->use_compat_syscall = true;		\
+})
 #ifdef CONFIG_COMPAT_VDSO
 #define COMPAT_ARCH_DLINFO						\
 do {									\
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6623c99f0984..02310b45900d 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -42,6 +42,12 @@ struct thread_info {
 	void			*scs_base;
 	void			*scs_sp;
 #endif
+#ifdef CONFIG_COMPAT
+	/*
+	 * compat task or inside a compat syscall from a 64-bit task
+	 */
+	bool			use_compat_syscall;
+#endif
 };
 
 #define thread_saved_pc(tsk)	\
-- 
2.31.1

