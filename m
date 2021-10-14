Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5B42D102
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJNDhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJNDhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B319C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 21so3183978plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=OWXYdNcON1tButwYuFkY6vYZueS6eXtU0jSooqr9DEKr/KHzDVal/Ggc/A1Vhkk9WI
         fYuYsSV2HMGfVaaN6IzMi2bQSUYSbDSung6gg2dLlwhTpqGUPrbaEMUwTPZPqahCCz7B
         hFsRZmTxd4lP/RSWHrop/6jIdS5y+hTxLqEhwviRhPo5ElxUDty3yJWHEKN0hY0F5Y6M
         XJKESiNBAK65UI4ymasNRORZuWqrrHzIeP1/6h9wBLuzWTjzkAPuG58sXnTkh2wJAVLA
         Z7lybj5s7mZvqSY6P+1Qot7AipaIdD4KuyEISkx+uFT5gxBxeTUMa4OyAenD+oFZrmbq
         1vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=1oloV086/KBFDXNR1mmmatANHcH0Rk96RuSuXEOEPEhJicZ1j4GxuMT4e6tV3yZTdM
         8czXh7KtKpbqQJfe1EioKKSml9JHoh78jEbqXtipOrJpiarmfwDneIre7LzcdScJ3AKX
         XqpsSHZWsc6+rRiwe7R6obfyazoW9a7R95DilW0HuHchWilyysZcETU4EH+klda9Z8ZY
         EdaWot9ETnHl4PET33bDNVG4E6eygLiKh+5+renhzk4v/DORenJuxa885+YWReyO1ZoQ
         nn2DGIx/V3aECbEzCeQNOlzmKOGn1cPU5qMiUEms1kszbDQs+7vwoW6B/bPWwEbu7cIu
         jIKg==
X-Gm-Message-State: AOAM5303Gfl2FJ3n289KGCdHWrkZVXHGuryn/jAPZGosLMcQMHjfra9a
        r3/PPpt1eqpBVSbd3BtlWCd36UNdqNE=
X-Google-Smtp-Source: ABdhPJx+cGqdufKN8LbxktrovklneVcFTKb4palFeV5zhTpD3PyCEGIt6Majn9V9RIMNNJW3eM35jg==
X-Received: by 2002:a17:902:f54c:b0:13f:1e7:e467 with SMTP id h12-20020a170902f54c00b0013f01e7e467mr2903858plf.40.1634182515550;
        Wed, 13 Oct 2021 20:35:15 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d6sm832198pfa.39.2021.10.13.20.35.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:15 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 13/49] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Thu, 14 Oct 2021 11:33:36 +0800
Message-Id: <20211014033414.16321-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add a C file "entry64.c" to deposit C entry code for traps and faults
which will be as the same logic as the existing ASM code in entry_64.S.

The file is as low level as entry_64.S and its code can be running in
the environments that the GS base is user controlled value, or the CR3
is PTI user CR3 or both.

All the code in this file should not be instrumentable.  Many instrument
facilities can be disabled by per-function attributes which are included
in __noinstr_section.  But stack-protector can not be disabled function-
granularly by many versions of GCC that can be supported for compiling
the kernel.  So stack-protector is disabled for the whole file in Makefile.

It is prepared for later patches that implement C version of the entry
code in entry64.c.

Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/Makefile  |  3 ++-
 arch/x86/entry/entry64.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/entry64.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 7fec5dcf6438..792f7009ff32 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -10,13 +10,14 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_entry64.o		+= -fno-stack-protector
 
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
+obj-$(CONFIG_X86_64)		+= entry64.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
-
diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
new file mode 100644
index 000000000000..762595603ce7
--- /dev/null
+++ b/arch/x86/entry/entry64.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002  Andi Kleen SuSE Labs
+ *  Copyright (C) 2000  Pavel Machek <pavel@suse.cz>
+ *  Copyright (C) 2021 Lai Jiangshan, Alibaba
+ *
+ * Handle entries and exits for hardware traps and faults.
+ *
+ * It is as low level as entry_64.S and its code can be running in the
+ * environments that the GS base is user controlled value, or the CR3
+ * is PTI user CR3 or both.
+ */
+#include <asm/traps.h>
-- 
2.19.1.6.gb485710b

