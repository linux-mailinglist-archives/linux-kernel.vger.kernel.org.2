Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF837B94F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:34:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhELJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:34:29 -0400
Received: from zn.tnic (p200300ec2f0bb800ec6923be2c5225a4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b800:ec69:23be:2c52:25a4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81FF41EC02E6;
        Wed, 12 May 2021 11:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620812000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZLhbZuuCMLlj0Z4qrwrYvpSTEI0aCJ4rAXqOt/GpHdw=;
        b=dWOjGstHDHRftU5HAjUI1r4Ub7YJMlUtnLhXgLpcC3kAqIoucXus+ckNGm26JJ9DjrM/W0
        byfIUsPXFsvui/s5rfNTBGiqHBas3Ull5WIReAILEYoZIyx6KpyPt7PFS5CWezNkoMrkg/
        ONGlDjzhmdUQ2FiH5ZE4Z4+HEioYGkY=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/asm: Simplify __smp_mb() definition
Date:   Wed, 12 May 2021 11:33:10 +0200
Message-Id: <20210512093310.5635-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Drop the bitness ifdeffery in favor of using the rSP register
specification for 32 and 64 bit depending on the build.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/barrier.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 4819d5e5a335..3ba772a69cc8 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -54,11 +54,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 #define dma_rmb()	barrier()
 #define dma_wmb()	barrier()
 
-#ifdef CONFIG_X86_32
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
-#else
-#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
-#endif
+#define __smp_mb()	asm volatile("lock; addl $0,-4(%%" _ASM_SP ")" ::: "memory", "cc")
+
 #define __smp_rmb()	dma_rmb()
 #define __smp_wmb()	barrier()
 #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
-- 
2.29.2

