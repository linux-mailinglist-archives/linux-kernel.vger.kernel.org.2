Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681AB45EB52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbhKZK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhKZKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E84C0613E1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so9587777pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=Ts4Fcyw+TL2O2SI/vQp5E3TfBLXs64W+N6vCVtCe6g0XBx5Y+YnkpG5K0XmRouprgl
         6N6MJmip37hMoHmimT5+c9GfSnr6w7NQlwD3KtchrvP4WNNWQIgEXpITlh19pM0kmL3w
         581o7UDn0nj1A+F3sZa7uJ3z9jIiANWY39Db+AVY8c2y9t5LTUhSthsMGLsysgjrgyQy
         6SBqmYJ511I3ke4h26nLN+5fXYqxWC3y6L+tlqS3wMT7I4LvN9WTa5rAS2sSyhyuyazv
         FfsvRekA+qSkp/gO9SKzcp6wURi/9zVJqEuQunkf1yu/JmTZM68zMy1KL7fbc0cIVbg8
         GB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=s6mGQSqpDL6FPe9s35jgRHhfdtI0LBkJTp76qfXzM8ILM0+xPz848vqdCGDTEy2qsm
         v1INr0qF4bNETpv7GI9SLnohEgOL3aMP6WPgpJVPQYJyzo+8HOVTNhRBAGH/xW2Ou13W
         ftGqV25O0z29xw+Cj/oAUzZ/s9jQHX9mTXx+pgRYRZBcEEqpQcOMr4+XCpm5ceY+klie
         MZ1jk7KLHpF31wdpf2z6SbDwr9BYhIqQVMl/3uzKRhymLaytHtnWeiGlH9v4mhjVzzCN
         Fgl2QNmcC1A22e0eLVSpiFYkZIxVAqwDHZiyIgdagltmfAWvl/evRYE18lY4l91fywE5
         tW4Q==
X-Gm-Message-State: AOAM531cTyMKsE53ybYwx14NNO2QbOO7NJVguyMUjbNUu0x2nwvAIZH1
        Xign5RVT/4GdKqmZFAKTJCNBW7k2s5o=
X-Google-Smtp-Source: ABdhPJxOHAB/oZz2ZO35Ff/S6nWsBnk39CjhFqLnywUcvhzGwtRfa0EZfJmoiUkhvxp/K+ahaoLfbw==
X-Received: by 2002:a17:902:e885:b0:142:1500:d2ba with SMTP id w5-20020a170902e88500b001421500d2bamr36775654plg.19.1637921596059;
        Fri, 26 Nov 2021 02:13:16 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id t4sm5830880pfj.168.2021.11.26.02.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:15 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 12/49] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Fri, 26 Nov 2021 18:11:32 +0800
Message-Id: <20211126101209.8613-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

