Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4398C3874C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbhERJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347858AbhERJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C4C061346
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1174616wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wp7Rsa3dbFK1Rt2HaXcIflNA2UCoRc1Jacf2kiGOD4Y=;
        b=ff0261f4Hko1waXn6rNO/FtWFyjFfVyqzR/nJiZ3YbrHr8a+uxlj92umxGVEHT7Rt9
         p7Nq32ktvBjGCor012fDkLVAqz7tSaQ20lSavshJ2VCUUqljyNqk0l+VOOXSnWKmRdz9
         Aq8PgdJZSlFkh77zNfyCew+AZQvhdaJ8l+xcn4ZaxysJIKLjtRYr4qadcWnVpeDSPf0r
         xkfliCW42GMftD84B/E5qGVDZ5M/5i6FjYsAqwqXgE96DrjBaTF0taaZnbNZfplnNLyY
         q6heNIttlsHO+OuPperd2nY0U+xA0KpZx+JtuNX0CPxBItkloqBJVxSXLe4RmjfZU50Z
         tXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wp7Rsa3dbFK1Rt2HaXcIflNA2UCoRc1Jacf2kiGOD4Y=;
        b=EJnTs3lmgO+DKbMVSqSff5NPNkena/1mjjV2F4oSX6gGukDCwt0UJ3bL2Q/ijxzQOr
         5bzajt3KRgbZOCrAgKrUcioQbLIrrlTEpVRBFZGn7mZ0KXk9b20KYalS+NWuuRUH4MwY
         o3n7kj0ZdS7Hp3XyZOToCbijEtMDYth7TWfevvLRZfL0Ni50PEZjs3/bu0hMT32O3BSB
         7BgV3Oo2b1NJrEEgoEQ/QM0N3uVx/cqg4Y5bXEc1wacMhk9HT6p8owY/2TxinSo6L4ig
         5cdXxc/JCEC3+BjoNO78tmBcXnbarkE7y/n+BjW5HFWni/4wHaI4xJhlOAOWEiGTQHHg
         CfFw==
X-Gm-Message-State: AOAM530Zc89Yi0iI+FrQ5DHQLZQsK6uLtNZw7qU+vfURv7hc+zTKSFOU
        xUIMcD+AmCOFAli+QSrofXI=
X-Google-Smtp-Source: ABdhPJw1APcsYlGJ45XHsowAtoxXAPYrvMyzUxHQYFHWRpZRviO9X6zJ63aXS7UiWJjupn+s3oHHcA==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4335730wmi.187.1621328831729;
        Tue, 18 May 2021 02:07:11 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:11 -0700 (PDT)
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
Subject: [RESEND PATCH v4 6/8] arm64: Add a compat syscall flag to thread_info
Date:   Tue, 18 May 2021 10:06:56 +0100
Message-Id: <20210518090658.9519-7-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
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

