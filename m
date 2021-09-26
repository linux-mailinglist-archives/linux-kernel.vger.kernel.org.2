Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578C04189BC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhIZPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhIZPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7FC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y186so3921398pgd.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jux03A5G22Hr1B69edcviOBsMFilW/tqMjWarTVyVm0=;
        b=Uze8Rsb4QPeFPYgZGsI7FbmK4E8FylARA2+uWhToRJJWA6wqVjfzIVeLtzsUS2kMGN
         c2tNbwUr1rHJcG74wAv59WHJ3hNZJufpnwgpQbY6D7xn0f4VL27njflj++iqEAKB2+JE
         QqQtlx6cCmsGE6iJbBrqw2mn8xTlAZsij0XAcqQ8W/CaY1D/rJmnvWHAYmhEnrSaTdmS
         /Y76IjexXJua7OyWHXcD4psnikY067krXPVpSzpKSD7U3VhfjGwi7AdgLxWXQ6B92CAM
         elQcadxvMYYMFupemppOGDcsFQzv7kfN1M3rpYs0kgDui6a2I8NHBNl+SllEObQhsMJP
         mOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jux03A5G22Hr1B69edcviOBsMFilW/tqMjWarTVyVm0=;
        b=JtlVcf+9MCt/mbfk+N9eHYbKe3QGiKqGLnwKBlkgDaSAyf0eE11xo2Vp5G9ZF48aIj
         Q6Rmo+1H1ptD0rW7MvLFc1s2jehNlqFFrNHD8hGfcd2e850u+8RXp1217ZaLof90Ws8H
         wRFiDSLlx002ifrmrIFSDH9eC/PBP5kVstAQZteqoO+uAHz3Y2Ox27Y/QQvaxc7LIf2o
         I7ow7bbPI3Kvjj2d4dogcNGF8Ns/FzfAexOdFGGmfs30p+k1GUFYw1edxz3ELcED9pX+
         834JP5x6YaoXuufssQKcZDf/4H9emTnRBcr6GIOsbTh4n38v1gAZHbTuKUoG2R9Qhd4W
         Tpqg==
X-Gm-Message-State: AOAM531FAqXUcNEQKQPBXVM0oq7GbGmKE5axmBWbV3F2H3db+ZgU/jar
        Pa9PnsG8HtaoxT4JaXJpm/UfUA16eZOECg==
X-Google-Smtp-Source: ABdhPJyxzN7g2Zsf+aBZ39XmDAlW7NVore/bN5eAj4NJROJeu33qH5sAxvXOT4yN7/zmp48P6e5Egw==
X-Received: by 2002:a63:9d43:: with SMTP id i64mr12596103pgd.262.1632668986822;
        Sun, 26 Sep 2021 08:09:46 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id l14sm17446403pjq.13.2021.09.26.08.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:46 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 10/41] x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Sun, 26 Sep 2021 23:08:07 +0800
Message-Id: <20210926150838.197719-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index 7272266a3726..77838e19f1ac 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -11,3 +11,27 @@
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

