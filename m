Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E770045EB78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbhKZK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376908AbhKZK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98392C0613BF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so6374578plx.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi5LEJC966P67PNBIIhbeHLSWiolc3NsYfar0dw8aGU=;
        b=YViHSGrMJqkitiUa5DB7Gk770MJmEsmfKk/ZGJW3fqGo6JoK8BIHxwanEKipvuSXbl
         BAaIV99A7Vfq6hKmyhRxa/gPfYR3O8An9UObwfp/Oxcjc+X60n7utz+pUJBLuQempvQ2
         8MVHS752+h9x9v+p18mRxpuUcC1IGelYzLJb0sK4aw9MOl6CeCRmnzFE+bz2xXAuLGk2
         QWO4xq0oe4x5un+euZF5unxdum4xtuWc5JL6r3ii/LS34aRT7DOpftqxLqGPq4g72Sl+
         eGzgG+GN7ijqx/3iTG83zudO5YDRtA76Zu+osS+VL38bzvEKwr7lxxnJLJDjPNrDTVR8
         D7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi5LEJC966P67PNBIIhbeHLSWiolc3NsYfar0dw8aGU=;
        b=UI/+LrNwvdHZ5JyT08GSZimjNTBmU3vr+OfeQ2ovCa33taXfSLmHGq5Kmfk+e9OxuQ
         qWNV/ij9Mr81rVn4R0a/cYu9CGW/v2HWa6Vmh5XRGRM7pdsdLZS3IOqtNt5/8oOVuCBP
         Era0UU2fnEldtZe+799jlul2xnONIDrwUg880yd3PhgF75goH9a4ddM2Uspt8Oe8osVj
         PDwpWE9u3SV2WgWRbgwHENoNT1mUd64OvCNBIfhTbFdi4rzH+Pf/UzOdGciNaYFfbcsM
         1Sh2WsJi6EpuMrDEEVpbLrzVt7oNmT45ql03pn8+CgRgcEvgE+mA9lyoONgWiXFY01FP
         OhKQ==
X-Gm-Message-State: AOAM531fqcJOecaQVK5a+BJ+bX2O1cjmrSj9JixBRHusmsxd09zG+LSJ
        Vg9TDsMx8y5twU+TL6tW2r12npOLLQ8=
X-Google-Smtp-Source: ABdhPJxZoVVXphlPqOWmQhc4tt6YPCkfqvS91AP5KAAbOFUd1pS5LQmC5pF2j33frYgoghw7n15fkg==
X-Received: by 2002:a17:90b:2252:: with SMTP id hk18mr14639621pjb.218.1637921715052;
        Fri, 26 Nov 2021 02:15:15 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h8sm6951417pfh.10.2021.11.26.02.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:14 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 32/49] x86/entry: Add the C version ist_restore_cr3()
Date:   Fri, 26 Nov 2021 18:11:52 +0800
Message-Id: <20211126101209.8613-33-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

