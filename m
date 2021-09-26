Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC54189C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhIZPMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhIZPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CBC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x4so2493342pln.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDLojQo4L5uZ6hrSYULqYfkL9s5zdZRI3nePTnUWHEI=;
        b=Cd5fHQRWZC4ALwJWvo1Laef6ga7R8fyhgGLAD/gXCCqMFKxRt0d9+GpBkX8Mo7lzRM
         2AIAhjLFtJ3alMgdjH26X9sXaGn/E4/PoMuQ5NZmtuKh21Okfno9gFhA5i4+3SAZvNKG
         BczueiPGIcGuSz+NaAxiFpsVVNoLvEsCH4IcQtNfs1mKvimWVwdGtk+DMCwUSqq3qZxZ
         KZLu2liJ85a9zMGv1/ItDYcyfhrlKtPA2PTyVImN3NNnGSr3EeSlKPiV9Y88s3p46GJG
         OJvANPh2SEOCId468mZgRZGmROXZgdJCULmdra6dGCy8wsgwmN33Hn0vdhcnz+/BIY/c
         pwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDLojQo4L5uZ6hrSYULqYfkL9s5zdZRI3nePTnUWHEI=;
        b=Eyo6UDSyk8QkB5KnBJLvFM3rd9db9iG2sV6UO9lQxt+PnoqrP2c7vpqaP7/VFbjQJW
         lyZQ9bjHXaYbL81TgcV7BDs6bX1+0ud0OCWtllavu51Cy8WQqW0CG04RHTdtRGMuTof/
         PbXpJb+QujOBSWx4E5Dgiihl31O13wAVsYjGpLFjaH+Di/WRmlnjgab7Hvlv0t8HFRsN
         OjyTi9IRqFNxbwP39oFGUDwOgwtFwjBHAPjsjTeLdM6/0/KyGA4UVLLIG6GXsdvxYtgR
         hLiUTC4RBE5bW6JGnGwAhZihPFdcAlFIxvAiHR/lqEF44XXhpvQbZoQGBYWEGNAJzlUr
         uijQ==
X-Gm-Message-State: AOAM5313OdWwi2gos8pUN50QulafaZSsOjpIggnr2V2reIXo8aRPy4Qy
        BhomSrvqL8MCxem3ZHabxTnmdVZTjWrdEw==
X-Google-Smtp-Source: ABdhPJzIkeuUFGRWS8Lqho027pjDYe8RqnpADqQtSugh5koloF6J6WBXxZ01ojblkCLMNpFopz5nuA==
X-Received: by 2002:a17:902:7684:b0:13d:e9ec:b467 with SMTP id m4-20020a170902768400b0013de9ecb467mr11379259pll.77.1632669057982;
        Sun, 26 Sep 2021 08:10:57 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id n66sm14768802pfd.21.2021.09.26.08.10.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:57 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 21/41] x86/entry: Add the C version ist_restore_cr3()
Date:   Sun, 26 Sep 2021 23:08:18 +0800
Message-Id: <20210926150838.197719-22-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index faee44a3d1d8..2db9ae3508f1 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -8,6 +8,7 @@
  * environments that the GS base is user controlled value, or the CR3
  * is PTI user CR3 or both.
  */
+#include <asm/tlbflush.h>
 #include <asm/traps.h>
 
 extern unsigned char asm_load_gs_index_gs_change[];
@@ -27,6 +28,26 @@ static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
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
@@ -46,9 +67,34 @@ static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
 
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

