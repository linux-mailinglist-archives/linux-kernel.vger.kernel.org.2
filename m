Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0142D121
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhJNDoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhJNDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:43:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A3DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x130so4287305pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BlKZBSYzGKeJ7dR8x6r3jtlj/6PUsFcD4Ka+y7mVPo=;
        b=LSqXcfpd3k5YJwKc/d8KBoRPBKYU/uZRGnUN9s+iWgSKYxOdCrjzGVbh6zt/F9qZIF
         xw1HrPSf8fGKx342vjVoo/wuUsBxm3THaF/7zA5iscPjVKgF8lEOyh4Hdq5N+lE8c5+o
         yvfDlaMUEcuB88oInxOlsBdbdQ0/bmGecxE/9Xo5E7N4DJnsjVSQkMcMtPq15TYF/BdE
         jWZ4bahKUPEDc5x5TdQM5HpeSUawBVFstc+/XQy8nyf8LULHHFHqZk9MVfeCLdbnuEFU
         js96IN9wsjSAdMxde7wRzw+HZgQjg5Iu8AeZOuQJi8ma11ZdfkB9BAPgR/4oUY+iWJ5t
         LJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BlKZBSYzGKeJ7dR8x6r3jtlj/6PUsFcD4Ka+y7mVPo=;
        b=aoD17IA5OC3DE2sll7VmLg3YK92XX+VRy4CL9+qNLUSX+86/mdM6FNSciddNy9ePBp
         7L1H4+A6toV41edFme7q+K4X5lfw+N8xnUBDJshA/xa//vQx85TW+6OOgWqw2xF3sI4V
         SVSMi15l9UC1v4Dg5iF19GZf1xK96kSjhtmFgAsF5O2iiMbj50US6hjC9N3KFZphmGdV
         0Fx9ZqlO4H9mBMWytBY7fcKUIwLmr4DX3gFhqdgBJuXsOyD6xthlKgwil8kq9VOosmii
         iyy54ioyQZRbDBhWwv6BzzaVIN6IRQqtgXyPfhT4vwMn+KfbIcKcZzbbDcek1Ma2X9gR
         DwlQ==
X-Gm-Message-State: AOAM533b0uL6DLkysRYKjvUhG+WbFp2l328XwznIOyU/EeDAhO46Vliu
        twEre352acTHiRh98jsmRofdXPtPVaE=
X-Google-Smtp-Source: ABdhPJwbSrFgmoB3vpmcFuYz+uK3Jyu3tkboCW3G7kjJPu545Ue0fYwgrqY5ES+nc26ubFCjNuzI0Q==
X-Received: by 2002:a63:1444:: with SMTP id 4mr2401946pgu.251.1634182882565;
        Wed, 13 Oct 2021 20:41:22 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id u9sm844799pfk.82.2021.10.13.20.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:41:22 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 32/49] x86/entry: Add the C version ist_restore_cr3()
Date:   Thu, 14 Oct 2021 11:41:04 +0800
Message-Id: <20211014034121.17025-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 7e6c1b8a93d1..5edbb4bb4786 100644
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
@@ -49,9 +70,34 @@ static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
 
 	return cr3;
 }
+
+static __always_inline void ist_restore_cr3(unsigned long cr3)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	if (unlikely(cr3 & PTI_USER_PGTABLE_MASK)) {
+		pti_switch_to_user_cr3(cr3);
+		return;
+	}
+
+	/*
+	 * KERNEL pages can always resume with NOFLUSH as we do
+	 * explicit flushes.
+	 */
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	/*
+	 * The CR3 write could be avoided when not changing its value,
+	 * but would require a CR3 read.
+	 */
+	native_write_cr3(cr3);
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
+static __always_inline void ist_restore_cr3(unsigned long cr3) {}
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

