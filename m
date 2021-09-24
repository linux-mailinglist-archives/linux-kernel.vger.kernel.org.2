Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE46417B94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbhIXTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346404AbhIXTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:12:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8625BC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:10:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r2so10739925pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9KldzmUy+AxgQS3kHRwtBzCyG9bYataJekQ7vF2DSA=;
        b=TB3H8TAGL+32tFmG+zxP9tk+qgqb1eLM9zpAcLGJZPn6lVaVY2QDT8Wrj76GUE/mV5
         aKFEs41RGpmL2eWrWqf/x3Cjnq6AbFdHJsyQI0djmNFkg1hEHWg+ewnxDSCR5mJBQFTA
         r0E1GbiJ2wUvR6qT6iLurNF7sxAWPWXzuVY67sn4NxdngRr6HgpI9NpnMBrRNY13p32y
         Ig35Dkp+zuUoUrKqDR8y28gW3eWfIrM6iD+OuH6m0Iy2ZMYqvveZ19ib7yR49m9VBrO4
         voAo7ztbVIiDKMV7yTq12kKj+/1ijSMIzjPGVxg2hollQlDe0MCm7BO8kUzR/u6lFmGx
         uB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9KldzmUy+AxgQS3kHRwtBzCyG9bYataJekQ7vF2DSA=;
        b=HSjfEOiV32ssB7DUu4hlKf6HgmIy01xTIvrKvBwdWgE4V6wq7U3QHRYPaCqIeaM8v0
         UbZKcrDVCOjNKieDN8y3Fe5HG7viWiTkzkhb5AeqSQ+a0waP1um9K1750j7d5vg2n9dF
         j6Ip6UtMCGhljKiRcjyZq30Kmf+zLtaDrMDuKvllXpXpeRiOQxlI185WjdN2UCo2tC8Y
         4pAWGG4Y/hVc2Twtb/5/Ws7o6B4djUh+8AQji1o1AZ8qSVvyvp/PjvAbXBV2V5zDsz89
         8nDq2jHaglMr2ERlIE3TdxNv+Gsnt/A4M5lNflK7Lxb6aaSGZiU2C6Wm4HJ/DhwabBH7
         TlTA==
X-Gm-Message-State: AOAM5318oGuJnDuObC1YZmyeocJmL5JwfY1u/VTQG/B3vW70Hf4nliCs
        rOOvcCDOZjVfwAvvUeEekpA=
X-Google-Smtp-Source: ABdhPJxdPGeNjKgiA5vWhO6rtJ1xKOHDM83oseTCyR0EAALGJnXJ2Q4aF7gSdY5uV2d9rAiqsQtF8w==
X-Received: by 2002:a62:4ecb:0:b0:447:a583:ce8f with SMTP id c194-20020a624ecb000000b00447a583ce8fmr11432326pfb.59.1632510641776;
        Fri, 24 Sep 2021 12:10:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x13sm9550025pfp.133.2021.09.24.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:10:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] bus: brcmstb_gisb: Allow building as module
Date:   Fri, 24 Sep 2021 12:10:34 -0700
Message-Id: <20210924191035.1032106-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building the Broadcom STB GISB arbiter driver as a module, however
similar to interrupt controller drivers, don't allow its unbind/removal
since it is not quite prepared for that and we want it to catch bus
errors all the time.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/Kconfig        | 2 +-
 drivers/bus/brcmstb_gisb.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index a5b96f3aad67..9cfeae3fc244 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -30,7 +30,7 @@ config ARM_INTEGRATOR_LM
 	  found on the ARM Integrator AP (Application Platform)
 
 config BRCMSTB_GISB_ARB
-	bool "Broadcom STB GISB bus arbiter"
+	tristate "Broadcom STB GISB bus arbiter"
 	depends on ARM || ARM64 || MIPS
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 6551286a60cc..4c2f7d61cb9b 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2021 Broadcom
  */
 
 #include <linux/init.h>
@@ -536,6 +536,7 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
 		.name	= "brcm-gisb-arb",
 		.of_match_table = brcmstb_gisb_arb_of_match,
 		.pm	= &brcmstb_gisb_arb_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -546,3 +547,7 @@ static int __init brcm_gisb_driver_init(void)
 }
 
 module_init(brcm_gisb_driver_init);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom STB GISB arbiter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

