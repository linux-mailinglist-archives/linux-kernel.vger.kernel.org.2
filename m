Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F80740AD16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhINMMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhINMMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF0126112E;
        Tue, 14 Sep 2021 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621452;
        bh=ctJUbexNag4Ww69LjFDSR84qdpCMaKBOhiN3IwJaXws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUi18+jGcKYL2ZIvzB4Tdp9umFvvNxr8SxEbgK2vtVURDyopcc4j8SVgQHYRl+oSd
         jD1HDDdHCS0X2qFkxVSwjhCpW6s8Hp96/ONOJXprkzVEv8iiCPPpPOYqaeQC++qK+F
         gMuM2eHySUa6p6L2J2o9DQ8lStY2DIvZxyAiwjDg113m5y+NwLSEqaJgx8B5T++7Lg
         UVHXMyz3FmlndLNHzJ7jUxNrZyF0581QLC+4yGgW9GL8aZV0rNJVKBxnvp5vmlGZgc
         uCZQvfC/GHAQYEp5nHmE0lrfk4JBdK+S+UglEzmm10Apwya4T9Lm64gd4aM4NsUaOa
         Su6kXY2gKmo+A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH 1/8] arm64: add CPU field to struct thread_info
Date:   Tue, 14 Sep 2021 14:10:29 +0200
Message-Id: <20210914121036.3975026-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914121036.3975026-1-ardb@kernel.org>
References: <20210914121036.3975026-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
struct thread_info.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/thread_info.h | 1 +
 arch/arm64/kernel/asm-offsets.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6623c99f0984..c02bc8c183c3 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -42,6 +42,7 @@ struct thread_info {
 	void			*scs_base;
 	void			*scs_sp;
 #endif
+	u32			cpu;
 };
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 551427ae8cc5..cee9f3e9f906 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -29,6 +29,7 @@ int main(void)
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
   DEFINE(TSK_CPU,		offsetof(struct task_struct, cpu));
   BLANK();
+  DEFINE(TSK_TI_CPU,		offsetof(struct task_struct, thread_info.cpu));
   DEFINE(TSK_TI_FLAGS,		offsetof(struct task_struct, thread_info.flags));
   DEFINE(TSK_TI_PREEMPT,	offsetof(struct task_struct, thread_info.preempt_count));
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
-- 
2.30.2

