Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB53FCCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbhHaRxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhHaRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so47724pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DjbSRkuBzVTA2zOc8J0hrJZ6hlx5ZXJZFRDh4eSBWE=;
        b=WNguegGqMBg56IbcxsfJzj+BKjNqRA1GD7xu+cwhRl0Pjd9egZlrOVxzRHxgHBDgIo
         DpOu0HSYWmz+3qtJLQQRJ074cgB3w0MGn1IFYF25ECaauEXMpNUngAtyWBy0oGDWmvmb
         jLPAPGOpLVR3ff7NF04eAsLuJubRA2PU7Qgq1NTeM0m4Ata8dIZPPtXFokmUDWqoig3+
         c5h6y4OHfkEwrdtEicPubYG2NYe5q/AEmTRCA8m6FKryIMoG1JrY7kizyUHlENFOfk3S
         rwrP0Nc6E0pziiXMvNwPPNOEeYctFsiBWLU6QziIeR8xWvn1rv2YnirbSfhc2+jkYiFK
         GiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DjbSRkuBzVTA2zOc8J0hrJZ6hlx5ZXJZFRDh4eSBWE=;
        b=Il3/cwhdwOpvMdvmc8p0FwEsgH589Hp/CxaHdwAZz0IcmyJcBx7U1AYuQVf2ATYezP
         /85tAJN1stPfHyqpghggoaOw5axRXcid4vBQy6NYjcnqLxxcuDxG7byCJ9Sf6kb9IXAK
         OGUhHKR2Q4bZ2wgoBG/Kt1PEWLc4MS5twiQyT8S3r3ynTclY7Wpn0lKPBhI9+tPCfEN9
         5Wvy6nJzohQpjQrEXWlZZx426XKWn6miYnv1dToyLbsF0ss2JPhPR2oBCpm/qUcsdXNA
         DYSZ0JAgWF5i1qV88DriyXhoZwANSPDiEwy6MojoYt6JuZw8BEBCfOBZtliGNVCdrlKy
         Z+tw==
X-Gm-Message-State: AOAM532cv2RM9KENUIQ1Q6urZzH/KCIpGHagMkvBYt4qgDxm7RTMiob/
        WIvu27snzqbki6KM2TkB7q4BwkgKHJg=
X-Google-Smtp-Source: ABdhPJxqknI9V+ShDT8bzhuG3ljWsAX80X+6AwQ8E9hpIBdOfyi5I1kEDSEL54r4ACTkOqDLvOVMKg==
X-Received: by 2002:a17:90a:f696:: with SMTP id cl22mr6933214pjb.216.1630432360617;
        Tue, 31 Aug 2021 10:52:40 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id i20sm6872408pfa.185.2021.08.31.10.52.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 21/24] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Wed,  1 Sep 2021 01:50:22 +0800
Message-Id: <20210831175025.27570-22-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/traps.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 9f4bc52410d0..b5c92b4e0cb5 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -981,6 +981,54 @@ static __always_inline unsigned long get_percpu_base(void)
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
+	if ((long)gsbase < 0)
+		return 1;
+
+	native_swapgs();
+
+	/*
+	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
+	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
+	 * speculation, regardless of whether PTI is enabled.
+	 */
+	fence_swapgs_kernel_entry();
+
+	/* SWAPGS required on exit */
+	return 0;
+}
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
-- 
2.19.1.6.gb485710b

