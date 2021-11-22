Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0034593C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbhKVRRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhKVRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806BC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ov+WWsi/GJ+HW96vIOU67gocOYHQpc/crV5A/CpPjio=; b=SgtJ4xv7buKosw/iAzU/XG+kAh
        +GKNVzWcdgbMX5pwQwTyu/qthnmW4mrZJvfdswLlIcG7je3FALQE/iBpS+sAzjPmMbyUTFALZfq3i
        0lOfpeJPLmgugeOdoJbS6Keyol6CyOBmra1LjjwQ2yYMIuAifSxS1XStP/kuOpaqPV5kWpeDVnLcl
        fhIe3LFqn0D0vTsCNoVypsDxH4TQ+iB5JZL0B2tcreJ6mFoI167IVtlyMIjoBQ1Rf0f6FMTaO3ejA
        BphekqLOT6RKcQFw15OyaOVlg3zwclPrMVx1peFtiJ/oPGjI/qoLaZeDOjlcS/DHqPN4L0ZmOonZq
        AWWrWJhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpCtF-00HWQO-So; Mon, 22 Nov 2021 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FCE73005B9;
        Mon, 22 Nov 2021 18:13:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC0FA2C03BF87; Mon, 22 Nov 2021 18:13:58 +0100 (CET)
Message-ID: <20211122170805.088195171@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 18:03:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: [RFC][PATCH 2/6] x86: Base IBT bits
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig, Makefile and basic instruction support for x86 IBT.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig           |   10 ++++++++++
 arch/x86/Makefile          |    5 ++++-
 arch/x86/include/asm/ibt.h |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1848,6 +1848,16 @@ config X86_UMIP
 	  specific cases in protected and virtual-8086 modes. Emulated
 	  results are dummy.
 
+config CC_HAS_IBT
+	def_bool $(cc-option, -fcf-protection=branch)
+
+config X86_IBT
+	prompt "Indirect Branch Tracking"
+	bool
+	depends on X86_64 && CC_HAS_IBT
+	help
+	  Increase kernel text size for giggles
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -50,8 +50,11 @@ export BITS
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
-# Intel CET isn't enabled in the kernel
+ifeq ($(CONFIG_X86_IBT),y)
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
+else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+endif
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
--- /dev/null
+++ b/arch/x86/include/asm/ibt.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IBT_H
+#define _ASM_X86_IBT_H
+
+#ifdef CONFIG_X86_IBT
+
+#ifndef __ASSEMBLY__
+
+// XXX note about GAS version required
+
+#ifdef CONFIG_X86_64
+#define ASM_ENDBR	".byte 0xf3, 0x0f, 0x1e, 0xfa\n\t"
+#else
+#define ASM_ENDBR	".byte 0xf3, 0x0f, 0x1e, 0xfb\n\t"
+#endif
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+#define ENDBR	.byte 0xf3, 0x0f, 0x1e, 0xfa
+#else
+#define ENDBR	.byte 0xf3, 0x0f, 0x1e, 0xfb
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !IBT */
+
+#ifndef __ASSEMBLY__
+
+#define ASM_ENDBR
+
+#else /* __ASSEMBLY__ */
+
+#define ENDBR
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_X86_IBT */
+#endif /* _ASM_X86_IBT_H */


