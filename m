Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14E4189B9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhIZPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhIZPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD2C061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so15236017pgm.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvptxDXdJ/oF67EIcfIWH7F7ItFjw8RfC654LyC0RLI=;
        b=SU3qYJF5D9sV6bURB55xn6FdACNptvu3y0WT1bwz+vQC8X0rffzvPo2YmkMLdDqKoG
         SkkWtD/SV16eA7KhNcPyNwCfBVYa38RJpNcIvj1O9HrunAiyCjjNwNVoWUGQOSB6ost9
         Ge9NIdIp9KqjMFQDhspSfRg2b5OJw7JtxN92jo4eFXrTgYrhaXNHcq05+HS+UGMJpZh4
         H9TEuDtYPPamjVxSOjXqdIIVexGxdTrKEW9BFtzS50uSo2/AOLAqvJvo9mNk7xzDu+tc
         fVopiPNYUkWt60l2FttdZYyJyiPdESgORz+o+5oN/0hdTFlg3LgWSQxZ3V7OwP3pN+Hv
         f8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvptxDXdJ/oF67EIcfIWH7F7ItFjw8RfC654LyC0RLI=;
        b=ftDNH8hnEk7Baan1PgTWWriE/QHGZoK8B0LUNLyAg4ZLoEXu5qlzJYWR7tebagMCcP
         psoFdsn5nEALgztR5stLEBhS43Dgsbrru07mcUkMGK7tboCTisS+LLMsEoW4xrmQUlyv
         J8OrsA9XVf8YOX5NEPzMXadRTiag3a4FBsvix38jqyF7IcRPYa+CRnlDZbwAquZqa1GA
         6Len4JzYZ6epoHqyyRNTqHaN9XzSeWirPXNVwHEarLQ4n6vxdRAIV85V0pUxTiHF7/ku
         MeKIascGX4Hl77Im6WM6GhSd0rGgXHW3QwpxgK+0EZbQTEQMSu+/Gfoo6T0sW6sMK48V
         vEOA==
X-Gm-Message-State: AOAM531ZghlCoqO49INzmVhEEBJfQUd8+OjUSIxRTecpkHaWpFm/0BH4
        fm+3Dcey6fbf/vWfdnRMawTpLjJXHCPWrw==
X-Google-Smtp-Source: ABdhPJwdO3Jr5OqPjclaF4zqMasu3IwcbxnsEB7f2eRsTNCNFO97XqVsyUCcCmQSxa73XplvhxrzJg==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr12653807pgs.115.1632668974567;
        Sun, 26 Sep 2021 08:09:34 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id b10sm14246590pfi.122.2021.09.26.08.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 08/41] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Sun, 26 Sep 2021 23:08:05 +0800
Message-Id: <20210926150838.197719-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/Makefile  |  5 ++++-
 arch/x86/entry/entry64.c | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/entry64.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 7fec5dcf6438..492e0b113bd0 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,12 +11,15 @@ CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 
+CFLAGS_REMOVE_entry64.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_entry64.o		+= -fno-stack-protector
+
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
index 000000000000..3a6d70367940
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

