Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8343B450
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhJZOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbhJZOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E3C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1857021pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ITPFdIVq9iLReAgnTtHs8NsJSzIq2a/Az/wL9KiH8g=;
        b=N0eYxiilcja3LD/MbBSLt+B7Ql4Z+nUdDAf1iFRU+HC0wBbVIM1zEkE4giFTdztljz
         E851Vhbdkp1WXt6mFo+CrYRInYutZ1uEvy++vf8PmK0zGw2wLTg5bihsdj3cRynQgW04
         YpdmLu7dpMRnDTAB70tMIv725OJ1hKGju1PHOqIsu8hEmHo/Zs4PqSZuUyvBMmip0qfD
         9pIXTcw+4X2r+rEBBY3NlvRI1FX5uMmivL691+kqH6lBzVNF3IWK2HNr2wrwr9a7lax0
         rEuIMh8rqnYyhTjEECnavLayMR6kcftzwFiN6azT4TXjxHSgHKo/Ji86DU4xjRIkidm/
         QKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ITPFdIVq9iLReAgnTtHs8NsJSzIq2a/Az/wL9KiH8g=;
        b=1yflNvFx6+zGYfX9NoDbdO6JdOi1l3Ac4dNzQ6dwgWy0Hn+FGPF1fQ5OJqqG8LFouk
         h02u75r6mExnIEbRk9TzqtWbXy62Mz+bN8T43wI17rUcOsaLuV4od7w07kdPu13uWD1s
         wnmuJIfMaENCZtDcOzFNUKq4O4e4z/tylIvL4Vkd+W94X/QJsSTew+fApUpi3j7Febc9
         bppidaNHBjhOUZtYePctu8PTpkCe3UamRoYb7MoOcvXTNFQ2zGaWVKTAVBK1oipWFY45
         pO2KE0i+cwPTNa0lQDXnust+bZuJNcLa8g+Nv7hXIm4xDB1idKuASkIqxay6H6G8rmPt
         6c4A==
X-Gm-Message-State: AOAM531aVQ5o6lHldbHrXlPevDt3kBo+mUwNRzaAp3AKPxBvJqDFVT6s
        6HeaXISxWSWZsB4ySXPHSvz+bo+a4oA=
X-Google-Smtp-Source: ABdhPJzUuFG5M0sscM3B3KK/5CricBOam0diEvPVqjMbv+Xmh6OPzEZYl7UBW/4LAxNXFC21U6XaJA==
X-Received: by 2002:a17:902:c407:b0:13f:68f:6753 with SMTP id k7-20020a170902c40700b0013f068f6753mr22367790plk.39.1635258941116;
        Tue, 26 Oct 2021 07:35:41 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id i2sm22662361pfa.34.2021.10.26.07.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 33/50] x86/entry: Add the C version ist_restore_cr3()
Date:   Tue, 26 Oct 2021 22:34:19 +0800
Message-Id: <20211026143436.19071-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 1d6ed444fee0..446d91d7b376 100644
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

