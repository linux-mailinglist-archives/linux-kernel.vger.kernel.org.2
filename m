Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0B44C09D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhKJMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhKJMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD6C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1481546pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi5LEJC966P67PNBIIhbeHLSWiolc3NsYfar0dw8aGU=;
        b=VQ0x8tHmk+flLo5jDFR+07CbiunePcpbPiPbMUklELvXanCuFy2BIbRfBl4oIwLdtG
         8kCotOAHlospEPqoDnI9iJveVLAKW7tBAxP5+/ISew+WgWLEcWwOpzjmFksENSlGOUOz
         ZVLyGniGbjUrb0jQ1jvSuvr8F8DDynGPAGfxcAEmlJExk3UGh8Qt8Xuz0qdpBPF91akq
         oBljgEYjw4FVjjljTqoZZ+mUleeQ6QN6fWiOzHkHyKU4YfMYG4ZGc+LJQkBrwddKFibU
         UYlpsAVV26uGB9ZDCI2c4NfdciLq2uJzd+PnIHA6UUYYzu2RGepAYDtntFdRVa7icLN7
         yovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi5LEJC966P67PNBIIhbeHLSWiolc3NsYfar0dw8aGU=;
        b=07FkJ/ZvNYHV7XJL8+lEaW191wly6fM3Cop2gIvcTuMB+a0futD4Too/+PGtR8/afo
         L0CfsbBHwNedFj+hcRkybFGAoDmi5XEXL5auufC4VJ4yos20ZzHFy40ELQPno4qr//tm
         u3kYlLtU9XQ/lIhVDgfGfMC2ZtgltgmmRHG6wBFrl3VZcdZm4FsuIU0rVlo/ijrNCksd
         oB/aP93lONCY3BS2hpPTLV3RQniNVNolfjxEWOBFU1bBDaBQLrEXPtuPh41VGjWxxcTF
         /My7Wss2l+5+LdB6E20j2Lp00UCf371x8LV/o2LNCGbblUVihLp4n5UH/qFyTZMHWzxi
         2qqQ==
X-Gm-Message-State: AOAM530+b2uSYPyvTWMSd0PhPJaUm/WJWCYTds74bozYlI5cRxkHdcxj
        bs/zrZqiTgOp/PiHFK0onTP2vewWtv8=
X-Google-Smtp-Source: ABdhPJyx3HkLDRF1slreJU8HkfoM7bRaBGp2WpoKyxzQrPSAInyeTbnGzacrj45T48ph4St+oYb2dw==
X-Received: by 2002:a17:90a:d192:: with SMTP id fu18mr16639553pjb.177.1636545654494;
        Wed, 10 Nov 2021 04:00:54 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id f16sm12321061pgi.28.2021.11.10.04.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:54 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 33/50] x86/entry: Add the C version ist_restore_cr3()
Date:   Wed, 10 Nov 2021 19:57:19 +0800
Message-Id: <20211110115736.3776-34-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the C version of RESTORE_CR3().

Not functional difference intended except the ASM code uses bit test
and clear operations while the C version uses mask check and 'AND'
operations.  The resulted asm code of both versions are very similar.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 283bd685a275..5f47221d8935 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -11,6 +11,7 @@
  * environments that the GS base is user controlled value, or the CR3
  * is PTI user CR3 or both.
  */
+#include <asm/tlbflush.h>
 #include <asm/traps.h>
 
 extern unsigned char asm_load_gs_index_gs_change[];
@@ -30,6 +31,26 @@ static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
 	native_write_cr3(cr3);
 }
 
+static __always_inline void pti_switch_to_user_cr3(unsigned long user_cr3)
+{
+#define KERN_PCID_MASK (CR3_PCID_MASK & ~PTI_USER_PCID_MASK)
+
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		int pcid = user_cr3 & KERN_PCID_MASK;
+		unsigned short pcid_mask = 1ull << pcid;
+
+		/*
+		 * Check if there's a pending flush for the user ASID we're
+		 * about to set.
+		 */
+		if (!(this_cpu_read(cpu_tlbstate.user_pcid_flush_mask) & pcid_mask))
+			user_cr3 |= X86_CR3_PCID_NOFLUSH;
+		else
+			this_cpu_and(cpu_tlbstate.user_pcid_flush_mask, ~pcid_mask);
+	}
+	native_write_cr3(user_cr3);
+}
+
 static __always_inline void switch_to_kernel_cr3(void)
 {
 	if (static_cpu_has(X86_FEATURE_PTI))
@@ -49,9 +70,20 @@ static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
 
 	return cr3;
 }
+
+static __always_inline void ist_restore_cr3(unsigned long cr3)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/* No need to restore when @cr3 is kernel CR3. */
+	if (cr3 & PTI_USER_PGTABLE_MASK)
+		pti_switch_to_user_cr3(cr3);
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
+static __always_inline void ist_restore_cr3(unsigned long cr3) {}
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

