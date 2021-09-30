Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E741DA65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351214AbhI3NAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348795AbhI3NAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE90C61452;
        Thu, 30 Sep 2021 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006735;
        bh=emladKJ0A33DnFCj9EHk8afqzI3B+MLuCGI9gHOGbvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hcs+FekalTTYSum9FUiFFrkisEFmHPXipv4rtxVogorwZ9n97X0/AoH8jOz27DUqc
         u7K8auSwYP9q4YnLxOx8lAYfFtPhMBiU77jBvMLm2eiVRYo+eLOFUcwUSsM9lOlCi8
         kRf5vwGQmA1DJJDI1AXF5d5FeKaflR+dc6K0GJ41Qgpqpcu0Z63v5sc9u9cbjRFEuw
         tl3hTwePHz1Fk/BInlahpOg6K0UcNxOxsrvqq/o9IR6tvuLPgHvIHlXs1HPVBQhQL/
         vFyzjWInSZlKaVx8eLC8k4E9XbkW3wsSSvDX0sSMS7Gn2DnVdgtuGM0j9MS7tmpRKy
         Hocvq7oUJ6hKw==
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/7] arm64: add CPU field to struct thread_info
Date:   Thu, 30 Sep 2021 14:58:07 +0200
Message-Id: <20210930125813.197418-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930125813.197418-1-ardb@kernel.org>
References: <20210930125813.197418-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU field will be moved back into thread_info even when
THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
struct thread_info.

Note that arm64 always has CONFIG_SMP=y so there is no point in guarding
the CPU field with an #ifdef.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
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

