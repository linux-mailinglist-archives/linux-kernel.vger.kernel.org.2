Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301893B17E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFWKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhFWKNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A7A6611C1;
        Wed, 23 Jun 2021 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624443093;
        bh=X49QbVdp2wcX1M4XdpxJx3+JuBS5Ijyqkq2xf2hfPgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKKUGZAAHkwaFyPiDce4C/b5R7rQ3hD1zMWD80WD37xJVcLv4oNupxTi+cjZCMWfh
         lCFtt8ZeKoqqf8RvHrq+m2jPiEluwZ4cxad7IVsUVvEgnq8VMoCAsZ66Q6/sm09HY4
         dMAkYOtgodRZI137kik4S/gHCT+gAPvewvdAA6bVYhuiFooI3gvVkARDjnsvGDgaHm
         ZNCUMrPM4cMwFiesjlLQU7KaEDmmi/nm1VK87WA3okQdHgtLROiPFT0u9okf7f/6nZ
         50Fz680Upjq7vU04oZ4qGnDsHkQkRrbUnMQOvH4xrNI3yFs3fcECnT86rwA9Hlt8Vp
         3IIzB17U+H4Bw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lvzr1-002pFj-9T; Wed, 23 Jun 2021 12:11:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v6 5/8] spmi: hisi-spmi-controller: move driver from staging
Date:   Wed, 23 Jun 2021 12:11:27 +0200
Message-Id: <4ce8900042177b5ead12b906712f965e72a1fb77.1624442566.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624442566.git.mchehab+huawei@kernel.org>
References: <cover.1624442566.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hisilicon 6421v600 SPMI driver is ready for mainstream.

So, move it from staging.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../spmi}/hisilicon,hisi-spmi-controller.yaml         |  0
 MAINTAINERS                                           |  7 +++++++
 drivers/spmi/Kconfig                                  |  9 +++++++++
 drivers/spmi/Makefile                                 |  1 +
 .../{staging/hikey9xx => spmi}/hisi-spmi-controller.c |  0
 drivers/staging/hikey9xx/Kconfig                      | 11 -----------
 drivers/staging/hikey9xx/Makefile                     |  1 -
 7 files changed, 17 insertions(+), 12 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (100%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (100%)

diff --git a/drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
similarity index 100%
rename from drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
rename to Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e01424234eb..9a69e3810964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8284,6 +8284,13 @@ S:	Maintained
 W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-kunpeng.c
 
+HISILICON SPMI CONTROLLER DRIVER FOR HIKEY 970
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
+F:	drivers/spmi/hisi-spmi-controller.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S:	Maintained
diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index a53bad541f1a..2874b6c26028 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -11,6 +11,15 @@ menuconfig SPMI
 
 if SPMI
 
+config SPMI_HISI3670
+	tristate "Hisilicon 3670 SPMI Controller"
+	select IRQ_DOMAIN_HIERARCHY
+	depends on HAS_IOMEM
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
+	  processors.
+
 config SPMI_MSM_PMIC_ARB
 	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 55a94cadeffe..6e092e6f290c 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -4,4 +4,5 @@
 #
 obj-$(CONFIG_SPMI)	+= spmi.o
 
+obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
similarity index 100%
rename from drivers/staging/hikey9xx/hisi-spmi-controller.c
rename to drivers/spmi/hisi-spmi-controller.c
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 3ceda03f2864..9f53df9068fe 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -1,16 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# to be placed at drivers/spmi
-config SPMI_HISI3670
-	tristate "Hisilicon 3670 SPMI Controller"
-	select IRQ_DOMAIN_HIERARCHY
-	depends on HAS_IOMEM
-	depends on SPMI
-	help
-	  If you say yes to this option, support will be included for the
-	  built-in SPMI PMIC Arbiter interface on Hisilicon 3670
-	  processors.
-
 # to be placed at drivers/mfd
 config MFD_HI6421_SPMI
 	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 42d486104525..e3108d7dd849 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
 obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
-- 
2.31.1

