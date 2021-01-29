Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC74308DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhA2TzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhA2Tx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6593B64E17;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=AJO3Jg29PQAZCJZ6h5SvYabrMU1xPHVVrGc1e52tIjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXogrSC+ri1KByqe2Xnqh7nozzB2cgv6RYF8f57Q+v0FBBDINCIS3YwjC+YiiKO7p
         jW0NvtTN+x6Eg7hLWYdk8ZU5laCUpOpmTgTWHihkpiWOQFGRit+TN2XgQsaNrQjAcw
         t47VZzSuDvrJmrGJir8fDkjbK+6SwlcH+ZtyCpD0zjtoODT25InhXVwUVibKxpSKsD
         BVQQrWihYYYo6Dl4r75j5o9sbHnUj3m+FZpeEnKCGqbkDebF/vQnMMHNCdBdlU11Kd
         Ch1lek6ii8CQ7ngIsQEBbfVbq3fureCGWGuVbsxyAw9QUYBJnpZMjZD7WTqp3Njjim
         t9g6WWx3X/C/w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wk5-A9; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Gow <davidgow@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 13/14] regulator: hi6421v600-regulator: move it from staging
Date:   Fri, 29 Jan 2021 20:51:59 +0100
Message-Id: <812b6c0edd9ce9a5a8d0c5ca90cf0ee5c91aae26.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is ready for mainstream. Move it out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                                          |  7 +------
 drivers/regulator/Kconfig                            |  9 +++++++++
 drivers/regulator/Makefile                           |  1 +
 .../hikey9xx => regulator}/hi6421v600-regulator.c    |  0
 drivers/staging/Kconfig                              |  2 --
 drivers/staging/Makefile                             |  1 -
 drivers/staging/hikey9xx/Kconfig                     | 12 ------------
 drivers/staging/hikey9xx/Makefile                    |  3 ---
 drivers/staging/hikey9xx/TODO                        |  5 -----
 9 files changed, 11 insertions(+), 29 deletions(-)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (100%)
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO

diff --git a/MAINTAINERS b/MAINTAINERS
index 241f11b7d48a..5c5ad946c5d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8091,12 +8091,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
-
-HISILICON STAGING DRIVERS FOR HIKEY 960/970
-M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-L:	devel@driverdev.osuosl.org
-S:	Maintained
-F:	drivers/staging/hikey9xx/
+F:	drivers/regulator/hi6421v600-regulator.c
 
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5abdd29fb9f3..a520c313a00d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -423,6 +423,15 @@ config REGULATOR_HI655X
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
index 680e539f6579..77e519d2bc68 100644
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
index b22f73d7bfc4..db7ec218644f 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -112,6 +112,4 @@ source "drivers/staging/wimax/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
-source "drivers/staging/hikey9xx/Kconfig"
-
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2245059e69c7..7b0ef538dcce 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,4 +46,3 @@ obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WIMAX)		+= wimax/
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
2.29.2

