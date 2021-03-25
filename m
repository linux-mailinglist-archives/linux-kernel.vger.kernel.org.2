Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC993495FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhCYPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCYPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46ECD61A2A;
        Thu, 25 Mar 2021 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616687207;
        bh=DmYd4DjbSpvDSEq1LVdPbWVBoNZBhMEQT+HAY1u1QEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJDTbPvLWdeq3/M6FM37boWV5+1iY3hCOLLKXf6jaHhb1xE4zAG0pisJO/uNs0Qfa
         Ud3gOravHFfOKKk/vQfDJTda3+xFNxJu8Qai7SqHIT/j/49nb5+4lpdzrnpLERiV5U
         NHqSuBpjQp5NdwRPEHfgrrZEghg4Haw5t2DLoATuZOBrC2URKT4mH3E1RhRF5iLc2o
         OeNbdlNYg1U21ONo1+z3GdL+DuwF3l+HjNGbYG6hAJYV5OaQFn9SIuhJVeCbB+Svsz
         Le4LhNA6rc8zo0G3gKqtsl9iXw/t7trJ5fJc3UMCKZm0RHUkKQAEntwjeVxZo0JiCg
         l8a6tIxG1rAiA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPSC4-001FYt-Ax; Thu, 25 Mar 2021 16:46:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v5 5/7] regulator: hi6421v600-regulator: move it from staging
Date:   Thu, 25 Mar 2021 16:46:39 +0100
Message-Id: <815b79a4e93f133478d9a5b2dd429526dcfe1dde.1616686958.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616686958.git.mchehab+huawei@kernel.org>
References: <cover.1616686958.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is ready for mainstream. Move it out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/Kconfig                            |  9 +++++++++
 drivers/regulator/Makefile                           |  1 +
 .../hikey9xx => regulator}/hi6421v600-regulator.c    |  0
 drivers/staging/Kconfig                              |  2 --
 drivers/staging/Makefile                             |  1 -
 drivers/staging/hikey9xx/Kconfig                     | 12 ------------
 drivers/staging/hikey9xx/Makefile                    |  3 ---
 drivers/staging/hikey9xx/TODO                        |  5 -----
 8 files changed, 10 insertions(+), 23 deletions(-)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (100%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 77c43134bc9e..ea1d284741cb 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -422,6 +422,15 @@ config REGULATOR_HI655X
 	  This driver provides support for the voltage regulators of the
 	  Hisilicon Hi655x PMIC device.
 
+config REGULATOR_HI6421V600
+	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
+	depends on MFD_HI6421_SPMI && OF
+	select REGMAP
+	help
+	  This driver provides support for the voltage regulators on
+	  HiSilicon Hi6421v600 PMU / Codec IC.
+	  This is used on Kirin 3670 boards, like HiKey 970.
+
 config REGULATOR_ISL9305
 	tristate "Intersil ISL9305 regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 44d2f8bf4b74..11c145886c98 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_REGULATOR_FAN53880) += fan53880.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421) += hi6421-regulator.o
 obj-$(CONFIG_REGULATOR_HI6421V530) += hi6421v530-regulator.o
+obj-$(CONFIG_REGULATOR_HI6421V600) += hi6421v600-regulator.o
 obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
similarity index 100%
rename from drivers/staging/hikey9xx/hi6421v600-regulator.c
rename to drivers/regulator/hi6421v600-regulator.c
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index a140e5452df4..692cdc224e54 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -106,6 +106,4 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
-source "drivers/staging/hikey9xx/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index cccf6243a5c0..92ab43ca4607 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -43,4 +43,3 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
-obj-y				+= hikey9xx/
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
deleted file mode 100644
index b17c047aa700..000000000000
--- a/drivers/staging/hikey9xx/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-# to be placed at drivers/regulator
-config REGULATOR_HI6421V600
-	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
-	depends on MFD_HI6421_SPMI && OF
-	depends on REGULATOR
-	select REGMAP
-	help
-	  This driver provides support for the voltage regulators on
-	  HiSilicon Hi6421v600 PMU / Codec IC.
-	  This is used on Kirin 3670 boards, like HiKey 970.
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
deleted file mode 100644
index 4d63184e6086..000000000000
--- a/drivers/staging/hikey9xx/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_REGULATOR_HI6421V600)	+= hi6421v600-regulator.o
diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
deleted file mode 100644
index 65e7996a3066..000000000000
--- a/drivers/staging/hikey9xx/TODO
+++ /dev/null
@@ -1,5 +0,0 @@
-ToDo list:
-
-- Port other drivers needed by Hikey 960/970;
-- Test drivers on Hikey 960;
-- Validate device tree bindings.
-- 
2.30.2

