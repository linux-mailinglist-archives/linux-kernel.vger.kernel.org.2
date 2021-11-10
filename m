Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8692044C076
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhKJMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhKJMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E896C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x7so1342856pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=jehYUvu9M6N7NpDrUTNNnGX0W3hevA4GxuCLXRywLPzc8Wl3hUsO8MPLt2FjPrjfUc
         AlMi4v+QbrXmKB8BaqnFjwblM0uohpa1OWc1BflYhmCbEInQ0Lt270O3BKfdjgb6ClPr
         z4t/nv6RyXMmE4f8kHBiR2ptWuwLwo+8c0TS6vnvMLek95mnfIKAa0J5i860HVWwbSaH
         Ql+2ZK6JZPbffcb4HjFZ2dDnoFoRFx6B75yAKRgHduoZ9zT5qdICcPsa3J4mwc99gG7B
         T4t9jKsz3mS4I8mfqT2s+V8SlVo0HgXoDKvFUp4adBw4JPmfyD7Y2Iuss+jW49/jEzmL
         eoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=zS+0sclGoppZ7HcuJtQ6f287bPfCIEh8egiOJO4yNZNQ9/Ir/9jI47ImOsJCR7ihqX
         vwoZonPbW/qRek9EpYNeb3v5T2xPxsLIdmMqEJDtR+B41mbEbw68dv2WvOO+RESyG5F9
         SOm9V/51na7x4HNVBZ/svBFOOwYeauF1VhvCAhFsu9Kbd7NkMJZvOD4B8mGuNkCkTnnG
         liUrHmaSSrtRqf/GnAN+w88irwZ58uYp3PeAfKoGA9g7BDcRvZ7orP/m5uz3oUeFxZkC
         07854TkGTr1Y2Skce6dRzhwGK4tFpcQ2FIvPB5ed3r1iU9gA67xbcPsNiqdn4TjXhtZB
         swwA==
X-Gm-Message-State: AOAM5321kRfseFnfivE1G29rSvnd/81zre5ZtelxPU6mUKHm+MnqhcJm
        phdMiC+lamJkBcJ7PqI3IffkN/o0I/A=
X-Google-Smtp-Source: ABdhPJyiRJPhj8psV1oEJYpIBTBB2RGXaj5XbouqN78/aJRQPnZ0iWpkwGOiACSzvAywgVXEcR1nVA==
X-Received: by 2002:a17:90b:1bd1:: with SMTP id oa17mr16456308pjb.246.1636545544457;
        Wed, 10 Nov 2021 03:59:04 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id bf19sm5581227pjb.6.2021.11.10.03.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:03 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 15/50] x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Wed, 10 Nov 2021 19:57:01 +0800
Message-Id: <20211110115736.3776-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C version switch_to_kernel_cr3() implements SWITCH_TO_KERNEL_CR3().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 9813a30dbadb..9a5c535b1ddf 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -14,3 +14,27 @@
 #include <asm/traps.h>
 
 extern unsigned char asm_load_gs_index_gs_change[];
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
+{
+	/*
+	 * Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3
+	 * at kernel pagetables:
+	 */
+	unsigned long cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK;
+
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	native_write_cr3(cr3);
+}
+
+static __always_inline void switch_to_kernel_cr3(void)
+{
+	if (static_cpu_has(X86_FEATURE_PTI))
+		pti_switch_to_kernel_cr3(__native_read_cr3());
+}
+#else
+static __always_inline void switch_to_kernel_cr3(void) {}
+#endif
-- 
2.19.1.6.gb485710b

