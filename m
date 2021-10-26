Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06943B40D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhJZObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbhJZOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:30:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4AC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1834026pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=XoBtR3vIQXaOLJhHcBP0PxdJposDjjjTVcj5gJMP2n1vuF8fJCjnQfjaNpUh2Tg4xm
         etwbT7AvlsrW9b16G6yc7ZHDnH9E7qUrsoRsdvv0aSI2Tol8M0LFTx4wsnj8cbYouGMk
         vmMd0Fdorkwug9N1s9Cz+d1iV2hehsd88hV0+gWL3RH++nEY5zvrQ0WP80zXCrVOJp93
         3ZJWJbFuIJwY4BfUHbHJILcluhQOZeNCK9W/k4sOWdX+6ZYHj1grZjPu13mmSsbAEM/G
         ZDC5dgEKpIgO+i5FdK0ifWGFwdsEYaJ+Yy+n9fIIN/UmaTNqC62RR/w2l1DA/leR9M9J
         Evlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0go08qE6YjF720dW2xAnGLMtyjjxpO8kE2iuFpdx1kM=;
        b=EkF1UUc7PFddsRXA8JW+wSV/jMcaAC0pf9Z9e+zAQHv0Voe9I7HK8hdHG9oJd9pRxZ
         kDrUfqwULOe09a0rMpspYwOja+8alQ32O6JKtarlzBqP4TpTjZh2KsPQsVkLO++8hhIh
         QMb9xsM4oYzvTsZJ4hnks1zsYH/a6UKiUO21sH8QxZEdb6t5Qm/JzbswT60jX3O/YVzV
         Wg6+H5zGX7uZsJROl27XDjQ7zvZW74qYYwH8cQSOILk0GcHX+fuzUSGLsqkIKAAVYopB
         ceL8bQu64HB86DO9lBRoFAtDjb8EVIahy0TVWtIBMyHkwkiVrV+ME/BpCkDAwRWdbH15
         rCMw==
X-Gm-Message-State: AOAM530576de+JTy9TihiL/0UItYmt81T32B4tB0MlfXXWOt1UNbu5te
        56QvVuGCJECXWkUFVs0w95125Oks3Uc=
X-Google-Smtp-Source: ABdhPJz9UYJL+pcyhokS4grZE99PTsjSJwJberiX7CZSDi2sPWmR79BvAj09aVd5NXKFTisUzlKzCQ==
X-Received: by 2002:a17:90b:1811:: with SMTP id lw17mr10923845pjb.22.1635258513083;
        Tue, 26 Oct 2021 07:28:33 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id b2sm7760766pgh.33.2021.10.26.07.28.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:32 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 13/50] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Tue, 26 Oct 2021 22:27:45 +0800
Message-Id: <20211026142824.18362-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

