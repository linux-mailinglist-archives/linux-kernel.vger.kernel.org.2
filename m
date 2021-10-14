Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB84B42D11D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJNDoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhJNDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:43:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF09C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 75so4272982pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8v1lJEcNZ/4QXqfpYTpG6GQy3KUL6Ro/b9jCQmcPx6s=;
        b=eou3KQkrDQDDzAw1z7tIsAqilO7FQ+yS3DuDegUYgubU+JmvtxTeMhoJwUxQ1K19aR
         wz/5MvPViVX+s9pMG4uB0rOcyCmGLjgpqKD8FhX3R/5EmFnTTFwop/Qd++cx8wpaAUHm
         +fmIFBJ3zyY6F/nVuaheDOrSJRZH8RuL8JRJwHvgfxeHrGQ951/pgrT7P54G5djNAovN
         XhwqvVXUuRZdZMea2f25XqP0MiKgMnwWEJXlgemTd8YhzdB0u4A8jYax0l0mOgesGjEG
         Ex6kS7MqCwMAOdLF60vHdSVmkHyDbcn7T7bh38f1dGU40DM2JobYOCcV0F3juyA8HZlH
         z0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v1lJEcNZ/4QXqfpYTpG6GQy3KUL6Ro/b9jCQmcPx6s=;
        b=DtqooIEdazDv9zf0gccur9posJGm6gPFdSLz+ucTivYZzL0XfmV3KFfuGNX81OtUqH
         Z7y9YCYzcj026tPNRas7ZPvtWbhjMWhsUC4+8W1WCFH7/ENHV/4Q2mkNG0Ycs/vtwCpY
         07zC4KF1AAoQAL5oYYo7kSyPFA9LC5tYJiywgPltoh+Oy3RR613ZNk7cnBqfgNM2wZ5D
         cHJKITOcgKm8FVlnwlm8iSluC54wdjIpSvK05onHnbxNhIH/b+Fepp2y4muNG7bF1nHC
         urgr0Jr5qw8sLXJw/MpGybrOXmtVXmsJieh1nqwM1YsJx5UW1/XMz8ZNcjqKAJUk/fnM
         vaLQ==
X-Gm-Message-State: AOAM532DClQ8CJ9ocrUPIb14Rbw2dsEbeyINzo84pjr8sAxBo7kjz36A
        lMkv3Vb6t3FqA+PNTA9NnyE8dM3YwrU=
X-Google-Smtp-Source: ABdhPJya//SLdbO0yGTpqNgs+2bUrChtdWsZa3d+NF8HhXQOrGNKS7/5NiK/rAtgd4k9dcfjQufvxg==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr3202210pfj.79.1634182893585;
        Wed, 13 Oct 2021 20:41:33 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id lb5sm890008pjb.11.2021.10.13.20.41.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:41:33 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 34/49] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Thu, 14 Oct 2021 11:41:06 +0800
Message-Id: <20211014034121.17025-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 48fd3199f00b..06f7476d78b4 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -237,3 +237,54 @@ static __always_inline unsigned long get_percpu_base(void)
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
+	gsbase = __rdmsr(MSR_GS_BASE);
+
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	if ((long)gsbase < 0) {
+		fence_swapgs_kernel_entry();
+		/* no SWAPGS required on exit */
+		return 1;
+	}
+
+	/*
+	 * SWAPGS is needed.
+	 *
+	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
+	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
+	 * speculation, regardless of whether PTI is enabled.
+	 */
+	kernel_entry_swapgs_and_fence();
+
+	/* SWAPGS required on exit */
+	return 0;
+}
-- 
2.19.1.6.gb485710b

