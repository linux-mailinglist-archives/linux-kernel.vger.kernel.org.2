Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA544C072
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKJMBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhKJMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A88C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1632921pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=eiMDc/JD59APb5ZVi15YxMqmM4YF31gkArbRUBXMIJSMkcq2etUpsVK2mQ3a2bgFP4
         XWU2aggeWjgYTOwxsLHe35xmaoVlRJXiyZX4UWaGJdrRrqehplhAAPuIzryZKo/ZC78T
         aMxMaMaYt/thkWDrIQOpIKR6C2Kv/IPyLpVWBO+imA0VR3ik7puzugHQ1moVIxv8h0N/
         u5NpiufuQWa58KQd4F9nZ+wiNWwVb71ivyM/lRZIQYlki+ARrmAkgmdm35avrk8/SjGW
         tbqzMpwpBRKxbrLQ2N6l9VHKeBH1MFvPya9ZRfGRwm/8Pg+mQqB+13JpujYtaESwkBQM
         NN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=IkNaE4n1+H2/C2ZLpC6isVTfdCnOOc+wG4ucu/yaFyVM5oYYl0j4yFbVMkra1Rt+8W
         gO1QGj+vyBAZiPlIaZ9cVXVzFEHgAy0bJ/7e2xWBSELu2kxpwFglTZB0vN7s25KViTCn
         d5Q11KsONs4w31vFCsk1StP8amcXnLNrVH+xCA1Nl6bBDKc97obyX349V06iQ6OSTfTp
         JqJk/SMEBVs5FKGmSuHGYtCm+EJUVdH+tUrUtxQ7egrkXYNdtEa5TGFHFa+/o2a5By9t
         zf7G+Ydk+lhaXLlTvXdAlzMV8RjcWQRwAc0WlYrOsTvhO3ERtZ+8k6eJTr2VYLVjnCql
         cT3w==
X-Gm-Message-State: AOAM53134aSZRKAMiyxjBD12DKqCC7YIKKO/mdc63xlOi0vdnsanXf5g
        eott4VFPWxs05UcKyhJGOIpkQgfK3pY=
X-Google-Smtp-Source: ABdhPJx0eckkmz1h/owXXWlcQQM/XRqnLMZq0KNX1DT7oBKbrlkaWueRzmNg2scODTV69GA7U36jpg==
X-Received: by 2002:a17:902:7404:b0:142:3599:74c5 with SMTP id g4-20020a170902740400b00142359974c5mr14849424pll.67.1636545533632;
        Wed, 10 Nov 2021 03:58:53 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id na15sm6306249pjb.31.2021.11.10.03.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:53 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 13/50] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Wed, 10 Nov 2021 19:56:59 +0800
Message-Id: <20211110115736.3776-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

