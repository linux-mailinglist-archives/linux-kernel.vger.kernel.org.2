Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3309B3CC400
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhGQPRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhGQPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:17:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5BC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6//gKIUYgXVRrwNYGPqkyV0I6kQm87IlbBj8vVJYIvY=; b=UoJtjEs9ei98+3sZMChRLoxwlI
        8pTCI5334Zm8BLtolhxdDEgn+wZfMa9iAuJCib3PUVkyEhhR2Mb5M+gBRDAd0myhULGMgrw476cK4
        0hZHsJoVR1/QOTEOuwkZvq3nxf87ERJBk+a4ryXX5PTJcduKNRtXnRui7tnhf1wzxIzsjgnAQpcic
        ODesaH6TQyqf4Bi7q1XvNQgLR+RwjV359661pyJgJLhO4T2sGGOrGwOjtGL+qwAhH0TqvguCPlR9k
        O3Xpkv2TaAsJWxcWQOg2ILUHz6WCwcQ1pkRrBH8iLyn/1EgV0DAOVsCjusi2WwIsppYQtmIHjfmYY
        8GmH700A==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4m1b-006kWL-CT; Sat, 17 Jul 2021 15:14:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH] MAINTAINERS: mark all linux-arm-kernel@infradead list as moderated
Date:   Sat, 17 Jul 2021 08:14:40 -0700
Message-Id: <20210717151440.21599-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistenly mark all entries of "linux-arm-kernel@lists.infradead.org"
as moderated for non-subscribers.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 5.14-rc1

 MAINTAINERS |   56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

--- lnx-514-rc1.orig/MAINTAINERS
+++ lnx-514-rc1/MAINTAINERS
@@ -2306,14 +2306,14 @@ N:	oxnas
 
 ARM/PALM TREO SUPPORT
 M:	Tomas Cech <sleep_walker@suse.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmtreo.*
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/include/mach/palmld.h
@@ -2327,7 +2327,7 @@ F:	arch/arm/mach-pxa/palmtx.c
 
 ARM/PALMZ72 SUPPORT
 M:	Sergey Lapin <slapin@ossfans.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmz72.*
@@ -2497,7 +2497,7 @@ N:	s5pv210
 
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
 M:	Andrzej Hajda <a.hajda@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-g2d/
@@ -2514,14 +2514,14 @@ ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPOR
 M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
 M:	Jacek Anaszewski <jacek.anaszewski@gmail.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Andrzej Hajda <a.hajda@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-mfc/
@@ -3539,7 +3539,7 @@ BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
 M:	bcm-kernel-feedback-list@broadcom.com
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm470*
 F:	arch/arm/boot/dts/bcm5301*
@@ -3549,7 +3549,7 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 BROADCOM BCM53573 ARM ARCHITECTURE
 M:	Rafał Miłecki <rafal@milecki.pl>
 L:	bcm-kernel-feedback-list@broadcom.com
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/bcm47189*
 F:	arch/arm/boot/dts/bcm53573*
@@ -4833,7 +4833,7 @@ CPUIDLE DRIVER - ARM BIG LITTLE
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	drivers/cpuidle/cpuidle-big_little.c
@@ -4853,14 +4853,14 @@ CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.c
 
 CPUIDLE DRIVER - ARM PSCI PM DOMAIN
 M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.h
 F:	drivers/cpuidle/cpuidle-psci-domain.c
@@ -7195,7 +7195,7 @@ F:	tools/firewire/
 
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/arm_ffa/
 F:	include/linux/arm_ffa.h
@@ -7374,7 +7374,7 @@ F:	include/linux/platform_data/video-imx
 
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -7466,7 +7466,7 @@ F:	drivers/tty/serial/ucc_uart.c
 FREESCALE SOC DRIVERS
 M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
@@ -11091,7 +11091,7 @@ F:	drivers/net/wireless/marvell/libertas
 
 MARVELL MACCHIATOBIN SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
 
@@ -14134,7 +14134,7 @@ F:	drivers/pci/controller/pcie-altera.c
 PCI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci.txt
 F:	drivers/pci/controller/pci-xgene.c
@@ -14142,7 +14142,7 @@ F:	drivers/pci/controller/pci-xgene.c
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/versatile.yaml
 F:	drivers/pci/controller/pci-versatile.c
@@ -14150,7 +14150,7 @@ F:	drivers/pci/controller/pci-versatile.
 PCI DRIVER FOR ARMADA 8K
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
@@ -14168,7 +14168,7 @@ M:	Mingkai Hu <mingkai.hu@nxp.com>
 M:	Roy Zang <roy.zang@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
@@ -14248,7 +14248,7 @@ F:	drivers/pci/controller/pci-tegra.c
 PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -14282,7 +14282,7 @@ PCI DRIVER FOR TI DRA7XX/J721E
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/ti-pci.txt
 F:	drivers/pci/controller/cadence/pci-j721e.c
@@ -14338,7 +14338,7 @@ F:	drivers/pci/controller/pcie-altera-ms
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/controller/pci-xgene-msi.c
@@ -14836,7 +14836,7 @@ F:	include/linux/dtpm.h
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/psci/
 F:	include/linux/psci.h
@@ -15356,7 +15356,7 @@ F:	arch/hexagon/
 
 QUALCOMM HIDMA DRIVER
 M:	Sinan Kaya <okaya@kernel.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-msm@vger.kernel.org
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -17044,7 +17044,7 @@ SECURE MONITOR CALL(SMC) CALLING CONVENT
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/firmware/smccc/
 F:	include/linux/arm-smccc.h
@@ -17161,7 +17161,7 @@ F:	drivers/media/pci/solo6x10/
 
 SOFTWARE DELEGATED EXCEPTION INTERFACE (SDEI)
 M:	James Morse <james.morse@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/firmware/sdei.txt
 F:	drivers/firmware/arm_sdei.c
@@ -17929,7 +17929,7 @@ F:	drivers/mfd/syscon.c
 SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
 M:	Sudeep Holla <sudeep.holla@arm.com>
 R:	Cristian Marussi <cristian.marussi@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/arm,sc[mp]i.yaml
 F:	drivers/clk/clk-sc[mp]i.c
@@ -18301,7 +18301,7 @@ TEXAS INSTRUMENTS' SYSTEM CONTROL INTERF
 M:	Nishanth Menon <nm@ti.com>
 M:	Tero Kristo <kristo@kernel.org>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
-L:	linux-arm-kernel@lists.infradead.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
