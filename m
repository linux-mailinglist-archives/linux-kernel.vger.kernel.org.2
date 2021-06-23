Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013363B17E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFWKOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhFWKNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F9C861289;
        Wed, 23 Jun 2021 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624443093;
        bh=kNW8d6FYZrp5TtEV5EAD/yTf6uEn3NfrV8G5pXUZGlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVc4nPA4POXg+vjYZHThwRLWCR7/+2z2H1niAaSSVYDeHP2JoQwDc+l7wYCtlOmQq
         7KJPGgfPe3bL/4QK9ylPB6aBGcuwYFEtcShL5w3F+3/5poiHBYdoioFaARqdr+Qn6M
         ZnNkCGfTI+RQth2EPMQN9UEjn55q4ZBrxSBQkDgxyJ0NSHZtiSLlVaqEDN4XBp9/hr
         2r3Y2frSlNE3U3Q4TOPVL2ffOGROBJ22eM2EbPH7smy8+U8S7I5Zind+9lqZ3a83TY
         LrOZQKJ7c54zSryUSvfvdTPiHNsdL3rksqQ6ceAGqI5/XB4RlMufFjQ/3W51lPueb7
         nA828WdDTVCSw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lvzr1-002pFf-7e; Wed, 23 Jun 2021 12:11:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Atul Gopinathan <leoatul12@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 4/8] phy: phy-hi3670-usb3: move driver from staging into phy
Date:   Wed, 23 Jun 2021 12:11:26 +0200
Message-Id: <fbdfbb4579e5f0b5b1c5f3f81d7a71b897d86b67.1624442566.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624442566.git.mchehab+huawei@kernel.org>
References: <cover.1624442566.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy USB3 driver for Hisilicon 970 (hi3670) is ready
for mainstream. Mode it from staging into the main driver's
phy/ directory.

Acked-by: Rob Herring <robh@kernel.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/phy/hisilicon,hi3670-usb3.yaml           |  0
 MAINTAINERS                                           |  9 ++++++++-
 drivers/phy/hisilicon/Kconfig                         | 10 ++++++++++
 drivers/phy/hisilicon/Makefile                        |  1 +
 .../hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c      |  0
 drivers/staging/hikey9xx/Kconfig                      | 11 -----------
 drivers/staging/hikey9xx/Makefile                     |  2 --
 7 files changed, 19 insertions(+), 14 deletions(-)
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
similarity index 100%
rename from drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
rename to Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c5ee008301a..6e01424234eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18859,7 +18859,7 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
 
-USB IP DRIVER FOR HISILICON KIRIN
+USB IP DRIVER FOR HISILICON KIRIN 960
 M:	Yu Chen <chenyu56@huawei.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-usb@vger.kernel.org
@@ -18867,6 +18867,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
 F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
 
+USB IP DRIVER FOR HISILICON KIRIN 970
+M:	Mauro Carvalho Chehab <mchehab@kernel.org>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
+F:	drivers/phy/hisilicon/phy-kirin970-usb3.c
+
 USB ISP116X DRIVER
 M:	Olav Kongas <ok@artecdesign.ee>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 1c73053bcc98..4d008cfc279c 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -23,6 +23,16 @@ config PHY_HI3660_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HI3670_USB
+	tristate "hi3670 USB PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON HI3670 USB PHY.
+
+	  To compile this driver as a module, choose M here.
+
 config PHY_HISTB_COMBPHY
 	tristate "HiSilicon STB SoCs COMBPHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 92e874ae9c74..51729868145b 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
 obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
+obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
 obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
similarity index 100%
rename from drivers/staging/hikey9xx/phy-hi3670-usb3.c
rename to drivers/phy/hisilicon/phy-hi3670-usb3.c
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index c4dc1016edf2..3ceda03f2864 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -1,16 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# to be placed at drivers/phy
-config PHY_HI3670_USB
-	tristate "hi3670 USB PHY support"
-	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
-	select GENERIC_PHY
-	select MFD_SYSCON
-	help
-	  Enable this to support the HISILICON HI3670 USB PHY.
-
-	  To compile this driver as a module, choose M here.
-
 # to be placed at drivers/spmi
 config SPMI_HISI3670
 	tristate "Hisilicon 3670 SPMI Controller"
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 9103735d8377..42d486104525 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
-
 obj-$(CONFIG_SPMI_HISI3670)		+= hisi-spmi-controller.o
 obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
-- 
2.31.1

