Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284A542D147
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhJNDxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhJNDxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:53:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BEBC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so4250613pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=bKjBM5zvSD9U12vC8f7pvAaqwweMeduCm88+NMeXgi+uWDoRfiQWtNRRUOvAaRshig
         Fes6dvBSj53auToDD6GCQ9BYkViXj/wF90eb4drzr+zCcdZuO0vXowkIHety5J3W1qjy
         ERY5iUqv3DGWrEO+8WgRNPImvR2FUjchV75ri4jRoJrOPUigUA3Jw9UnlmxL9ZexwkSQ
         RrzybpcPzdE6KaWKXe7IDiBa23sI4STAyzGrvG6KWysRiOTAiSgdlZY0A8cOMFuuhhJW
         UwaHF4gqxHwH8j6f2zkGnxgYpkIKnHEI0dJStJIMXlfZMukYXjtkFjcsjaWs7RSQ6i1m
         RJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=q0RGtbjhd+oO6y28R41d95tJIhyyMTmLvzW2VJhaW19bVF1SDDvXHT7LyI1L+X5cL1
         4ICdtamMmQKVp/u2n0URsgcwfqYFdZF/dYzV3qH3551RqiYGoXx0WvVGHDMkpxsT5WQR
         ncC/atYG3OuT/rcSq+f8viZHNDV4Vi3ATLQf1e+4G4vLjlThhqXqH2YtXM8jThznRf2F
         5YNp4q8/+EPWlj4tcKSGXRuDzFd2QbjtuXp8peobZeB83A8JyC6M8xPDnHPofeyOwHnU
         ZAVjOziDn1guZzkTu5F0KgV8Q6re39Xr3BsfbZjOsA9jdsXah4y3jfSEJVq7ruT6KSI0
         mNNg==
X-Gm-Message-State: AOAM5320lyLZmTR25GtPyaRWGjxYDE6Y0GCxVX6rleozddn3ltzZz7wJ
        ruc11w0y5+X3pnRp94he6tacipmbLBQ=
X-Google-Smtp-Source: ABdhPJzG+voc5/56R4311RnRmWrMnKe5z0u5Prya65yUQ38GW2v9KCJkg39J/LYtdHNAscF5a9rbeQ==
X-Received: by 2002:a05:6a00:22d4:b0:44d:1c39:a8d3 with SMTP id f20-20020a056a0022d400b0044d1c39a8d3mr3314474pfj.56.1634183476484;
        Wed, 13 Oct 2021 20:51:16 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id k9sm864641pfa.88.2021.10.13.20.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:51:16 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 42/49] x86/entry: Add a C macro to define the function body for IST in .entry.text with an error code
Date:   Thu, 14 Oct 2021 11:50:19 +0800
Message-Id: <20211014035027.17681-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE() macro to define C code to
implement the ASM code which calls paranoid_entry(), modify orig_ax,
cfunc(), paranoid_exit() in series for IST exceptions with an error code.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 57636844b0fd..c57606948433 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -351,6 +351,22 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 	ist_paranoid_exit(cr3, gsbase);					\
 }
 
+/**
+ * DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE - Emit __entry_text code for IST
+ *					 entry points with an error code
+ * @func:	Function name of the entry point
+ */
+#define DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
+__visible __entry_text void ist_##func(struct pt_regs *regs)		\
+{									\
+	unsigned long cr3, gsbase, error_code = regs->orig_ax;		\
+									\
+	ist_paranoid_entry(&cr3, &gsbase);				\
+	regs->orig_ax = -1;	/* no syscall to restart */		\
+	func(regs, error_code);						\
+	ist_paranoid_exit(cr3, gsbase);					\
+}
+
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
-- 
2.19.1.6.gb485710b

