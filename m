Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2733E0C98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhHEDBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbhHEDBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:01:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7DC061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 20:00:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e5so5367819pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMF6ZUuA0W1rsM+bv9FkawHAOaFfXZd6kN3VeluJtLc=;
        b=BmF817DA6Q3QLNl1ii8wC0qXYSTgw4m+WIjKLnyBufWdh1Q8M7i9OAcV8Av1TB3vqy
         6Dik9WMmaR6FeDgBB1VxF+1XcvY3FsAZFgUMXimMzZncyCDwLwrUxn+TW4v5oSQI9mOF
         EbHRqfW/aRt4UPf40sDuqKTIYCPbhDLwmhZqecKHeuinuItLrEwMOPhprKzC4kTM9BN+
         2TvuVhLwUK/QjVgFMgWIbQidnXNj3X29Zfu9lCYedxRNsSmx8uK83Pdl3dCreIju2QWN
         xw+T3NIAa3pxU5EKaNgOe8I8qFq7ibmDa34UpF/BiZFPcvZ1bauIafCOytJIgWYf0cqC
         b5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMF6ZUuA0W1rsM+bv9FkawHAOaFfXZd6kN3VeluJtLc=;
        b=b8TrO1L3lpBQNGdhTKP51XE46WWzW6jt6nN7VxLcu4qKM4Se+N+N3nz+P9mcya9pzk
         5Ms7RUW2jp+3Bo46seYyI30BqUvx2xpmUB6M7B9Olg8uzQRs5sSfWSCRa9ajPRIQmZm2
         z+KMWrhwV92nvoNKvCUo3ak1MD04dQPRICGHvVmQayrj6kouTPO6poqX0nNjPppE6YeK
         PrBferxzDBnI9i2KEEGQHtsx97QM4loyagEWD4AcmpL+V1TpKCCfD0Mj01CpdqIiL0B2
         62mFz7J1XtvgUSPoakvOCvi6sfnNnUN+4VQLiXFL1/a2or/37AFUlWUiboAy45LcSciS
         J1EQ==
X-Gm-Message-State: AOAM5326w7N34MiAfVir5RcCHIIq9HhyjQg4cdqjk5JsPxjNnNOa6qgf
        MUC4mvaS47yq6weZlGQ43Lwy7oaRDSOg1Q==
X-Google-Smtp-Source: ABdhPJwBa0siibV3F4DJSz7FN3pQpMtJ4n35ql8G4X1YKi2Xy3U7L4yXU33gNBuOSub1yU0qSUH9wQ==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr2565791pfl.51.1628132456110;
        Wed, 04 Aug 2021 20:00:56 -0700 (PDT)
Received: from localhost (g195.61-45-49.ppp.wakwak.ne.jp. [61.45.49.195])
        by smtp.gmail.com with ESMTPSA id x4sm336669pff.126.2021.08.04.20.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 20:00:55 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] openrisc: Fix compiler warnings in setup
Date:   Thu,  5 Aug 2021 12:00:33 +0900
Message-Id: <20210805030035.2994973-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was pointed out with the recent name change of or32_early_setup to
or1k_early_setup.  Investigating the file I found a few other warnings
so cleaning them up here.

    arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
      220 | void __init or1k_early_setup(void *fdt)
	  |             ^~~~~~~~~~~~~~~~

Fix this the missing or1k_early_setup prototype warning by adding an
asm/setup.h file to define the prototype.

    arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
      246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
	  |             ^~~~~~~~~~~~~~~~~~

The function detect_unit_config is not used, just remove it.

    arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'

Add @fdt docs to the function comment to suppress this warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/setup.h | 14 ++++++++++++++
 arch/openrisc/kernel/setup.c      | 16 +---------------
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 arch/openrisc/include/asm/setup.h

diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
new file mode 100644
index 000000000000..b6d096eeb11c
--- /dev/null
+++ b/arch/openrisc/include/asm/setup.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Stafford Horne
+ */
+#ifndef _ASM_OR1K_SETUP_H
+#define _ASM_OR1K_SETUP_H
+
+#include <asm-generic/setup.h>
+
+#ifndef __ASSEMBLY__
+void __init or1k_early_setup(void *fdt);
+#endif
+
+#endif /* _ASM_OR1K_SETUP_H */
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 7eddcac0ef2f..0cd04d936a7a 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
 
 /**
  * or1k_early_setup
+ * @fdt: pointer to the start of the device tree in memory or NULL
  *
  * Handles the pointer to the device tree that this kernel is to use
  * for establishing the available platform devices.
@@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
 	return mask & reg;
 }
 
-void __init detect_unit_config(unsigned long upr, unsigned long mask,
-			       char *text, void (*func) (void))
-{
-	if (text != NULL)
-		printk("%s", text);
-
-	if (upr & mask) {
-		if (func != NULL)
-			func();
-		else
-			printk("present\n");
-	} else
-		printk("not present\n");
-}
-
 /*
  * calibrate_delay
  *
-- 
2.31.1

