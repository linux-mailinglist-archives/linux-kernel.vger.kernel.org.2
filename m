Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FB44C09F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhKJMD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhKJMDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q126so2032100pgq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6L1pAJZsA8SjHBkuS6Qt3v4RFKt+72Ap0HcrabTfxgM=;
        b=MTcdHkh5uHcdLeKbBYr1Q4ZiyGEzipvh7xFSxVb8C5BIR+urUPaaCCwhVFQQiD6qVW
         V+eFW1xVzVGYroTw0fJvJgo8yXty2wt5mjfS8f5MLalX9e4wvxV4kS0uvf43kcEKJwIq
         FyeM14CJkoxXPN2KGZr2Vi6nuPzxqXfgGJJ6TDmIHjvoMP/Ty8w/HKECnyggnQHyBXlG
         flo3772Wsyj328/zjS9MfzDkhJVaZqL99x9QN6lIuGnryKPSUnU8t5X21LAmsxj2BbDp
         jClhmKKfTALztZgknWw8P3T7HILHu3+ySdi1pKYJLy3j5zoBnWI9sgHLPMjhLxdx3KH5
         BowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6L1pAJZsA8SjHBkuS6Qt3v4RFKt+72Ap0HcrabTfxgM=;
        b=nrwn/2D8kJ5o4f2GxGPLZaw/cT824Kr4sYVZ3CPpsagt3aPcAUjXk5pAgvoOLcgCGk
         apORIFat6MjVj7gUQEs2FdZSnmp0ewwLDB4JYbWQyYUtEN7EeOx8VEmvDEzcFfexiXri
         m+DrTeI88cpJPXFpStDhGfok+T7bMKB/00oiqFXF48QZduJSkUWarT54KqM7KOw3cRJ+
         Sx522NMGsvFIiUCch1CiFYqSJDi5piN5BEUk4qpIAllN2puDyAMPA6rmyjb7J/yqoi64
         gjGvY7rSInzrtaEe4v6mDwud55hrzmlGhZSKTEneJCzlILWZjSL//INLZ+peb01PZhvW
         jHBg==
X-Gm-Message-State: AOAM5337IRFjoJ+Be4N9JgFfl8jlP40xJeF91Przlo7biy6tt/K6FATc
        NVbh+02CQlxMEqxjZuykSLqpvo6gabE=
X-Google-Smtp-Source: ABdhPJy6LuDPhd6NCLXRQFDKjLsNU0nBKXeJtrQm+ngvwbq/Mxw/YmFYeGpz39g90QngIrp/tCWH7A==
X-Received: by 2002:a05:6a00:b8b:b0:481:16a1:abff with SMTP id g11-20020a056a000b8b00b0048116a1abffmr15326610pfj.77.1636545665301;
        Wed, 10 Nov 2021 04:01:05 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id z8sm19006036pgi.45.2021.11.10.04.01.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:04 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 35/50] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Wed, 10 Nov 2021 19:57:21 +0800
Message-Id: <20211110115736.3776-36-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the second half of paranoid_entry() whose functionality
is to switch to kernel gsbase.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 3ec145c38e9e..6eb8ccfc5a8b 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -219,3 +219,50 @@ static __always_inline unsigned long get_percpu_base(void)
 	return pcpu_unit_offsets;
 }
 #endif
+
+/*
+ * Handle GSBASE depends on the availability of FSGSBASE.
+ *
+ * Without FSGSBASE the kernel enforces that negative GSBASE
+ * values indicate kernel GSBASE. With FSGSBASE no assumptions
+ * can be made about the GSBASE value when entering from user
+ * space.
+ */
+static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * Read the current GSBASE for return.
+		 * Retrieve and set the current CPUs kernel GSBASE.
+		 *
+		 * The unconditional write to GS base below ensures that
+		 * no subsequent loads based on a mispredicted GS base can
+		 * happen, therefore no LFENCE is needed here.
+		 */
+		gsbase = rdgsbase();
+		wrgsbase(get_percpu_base());
+		return gsbase;
+	}
+
+	/*
+	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
+	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
+	 * speculation, regardless of whether PTI is enabled.
+	 */
+	fence_swapgs_kernel_entry();
+
+	gsbase = __rdmsr(MSR_GS_BASE);
+
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value.  No SWAPGS needed on entry and exit.
+	 */
+	if ((long)gsbase < 0)
+		return 1;
+
+	/* User GSBASE active, SWAPGS required on exit */
+	native_swapgs();
+	return 0;
+}
-- 
2.19.1.6.gb485710b

