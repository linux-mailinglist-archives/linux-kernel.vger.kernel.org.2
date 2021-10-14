Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25B242D146
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhJNDxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJNDxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:53:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E90C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i76so2153877pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hg5X/fXuO5IzWpbw25ZvrVT5KoY60jnAFeBGvtwJeGk=;
        b=Jr9WfnZbxH44R0hNtS5cd0SxIF5JOr1aQ8XQx11V6sXTPF9vhbzXVIEQ5otk9DzJGU
         r7Uf1C/yadLrdBF0OjFbG5+rVnH3H9Lnxscc9vRd+bS7LHxPlA8FPuaYnNBpf6pea9rX
         n1O7X6S3N/qWSV6EyJK81RSaL4ihmqpOXWT9YREpxek+oq00SGLxgmvR/at6yGNXWSRW
         js2ayko5hCZavztQFH5zhXLHrJZEvwQ70/VXVzZHSv+N87ka6js4zCsytH3Y5zxHXJYl
         /TMRdVpOHz0WsIt0jyMZhjwq4sFAf5c7hzmz3v0KPCy4u2DJeAUESymgO05NXZdj8b7g
         xtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hg5X/fXuO5IzWpbw25ZvrVT5KoY60jnAFeBGvtwJeGk=;
        b=5Hkvrhl3tlnR2FH03UCeb3WYl2JpL9zFyVwyVr5MDlYVzR/nvN8wMOCYF70is8fllZ
         0Uawl6DWLKgCj6e6P/mHDmw9Wic8KVQVNPHs+5sWKNyaMt3UOTvTVLUp3gMgbYP6GTNt
         3MQHWMlJ+lifB0N7pJyuwZeh7e2e/5V+LivHpILacmL48x34vol1fYezQw5fkHW7r4Va
         fZDsdeD3QYj47bKhXsLP+pt5b6Xn0V0dKylC91NkII+FOjUjtWginB+Mp+bmbLx0tdEP
         EO1E9EJ4DVbia5EpE0YDLxOPdAz86DON/oTiOsjem1uh6bKnsi0uIkTGX0BdJTZx+9+h
         2RMg==
X-Gm-Message-State: AOAM533ZWJ/snceJHqjc79nLELZqnO4MMuq2xNXhd0OyaDmEuNV53kQe
        n5ofzsQhmLhpbdWeSe1ig1e81CltiYk=
X-Google-Smtp-Source: ABdhPJxjPvjyFQX8pl+c1QTfglagEinkoH2+yyuzAHza3HbOcbe8LVP29BCc7koPZ1bj1mAADi/V7w==
X-Received: by 2002:a62:1c52:0:b0:44c:f1c3:9cb5 with SMTP id c79-20020a621c52000000b0044cf1c39cb5mr3325783pfc.14.1634183469722;
        Wed, 13 Oct 2021 20:51:09 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id k1sm864037pjj.54.2021.10.13.20.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:51:09 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>
Subject: [PATCH V3 41/49] x86/nmi: Use C entry code
Date:   Thu, 14 Oct 2021 11:50:18 +0800
Message-Id: <20211014035027.17681-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 17 ++---------------
 arch/x86/include/asm/idtentry.h |  5 ++++-
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7c994bcde1b0..0a1a55c8207e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1309,21 +1309,8 @@ end_repeat_nmi:
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/*
-	 * Use paranoid_entry to handle SWAPGS and CR3.
-	 */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi
-	movq	$-1, %rsi
-	call	exc_nmi
-
-	/*
-	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
-	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
-	 */
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_exc_nmi
 
 	POP_REGS
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b9a6750dbba2..57636844b0fd 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -372,6 +372,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY_RAW(noist_##func)
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
@@ -421,6 +423,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 
 #else	/* CONFIG_X86_64 */
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
  * @vector:	Vector number (ignored for C)
@@ -452,7 +456,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8ac45801ba8b..28815c2e6cb2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -51,6 +51,7 @@ KCOV_INSTRUMENT		:= n
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 CFLAGS_traps.o		+= -fno-stack-protector
+CFLAGS_nmi.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

