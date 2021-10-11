Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8442860D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJKEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:49:46 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:13407 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233829AbhJKEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:49:40 -0400
IronPort-SDR: cdINeAhUrzP1dq/bYIC8Q04rO/9T72c2OLe+tBJX9WKGMPm0q3PvvhUUsgiWKHX9bjh+Uxkrl2
 duZJDvE3fmQ5sbKl4IUjDEMqJ9b1/FLq5o2slKTgqfY6Eejd3lw53EkLs9Omzg04RHdnRBCSaE
 pPKn147nRY5Yv0oZpb8UqCaQq96HjegSVxf2O2jLgaH9o3zbEi5U9zKLuATseRFXoxwsmyQL+g
 0lgI7yEuzxRfnFysJ7TQvUJ6Gv69OfxQuy4wL+PcxF9Y8RPZjGv3jvvC10BwTadFkeMmIWG6iH
 ySghd14TXgmo3esGss7E+i40
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="48057886"
X-IronPort-AV: E=Sophos;i="5.85,363,1624287600"; 
   d="scan'208";a="48057886"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Oct 2021 13:40:32 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DE82BEDF42
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:30 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1982EC5201
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:30 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id D8C7F4005E9CA;
        Mon, 11 Oct 2021 13:40:29 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH 3/4] driver: hwpf: Add Kconfig/Makefile to build hardware prefetch driver
Date:   Mon, 11 Oct 2021 13:39:51 +0900
Message-Id: <20211011043952.995856-4-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
References: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds kconfig/Makefile to build hardware prefetch core driver and
A64FX support.

Note that this is the first time to add A64FX specific driver,
this also adds A64FX entry in Kconfig.platforms of arm64 Kconfig.
Also add MAINTAINERS entry for ARM/A64FX accordingly.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  |  7 +++++++
 arch/arm64/Kconfig.platforms |  6 ++++++
 drivers/Kconfig              |  2 ++
 drivers/Makefile             |  1 +
 drivers/hwpf/Kconfig         | 24 ++++++++++++++++++++++++
 drivers/hwpf/Makefile        |  6 ++++++
 6 files changed, 46 insertions(+)
 create mode 100644 drivers/hwpf/Kconfig
 create mode 100644 drivers/hwpf/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3..1da61c4df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1586,6 +1586,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 F:	arch/arm/mach-*/
 F:	arch/arm/plat-*/
 
+ARM/A64FX HARDWARE PREFETCH DRIVERS
+M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/hwpf/
+F:	include/linux/hwpf.h
+
 ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d4c..8ecbcd0b7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -20,6 +20,12 @@ config ARCH_SUNXI
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
+config ARCH_A64FX
+	bool "Fujitsu A64FX Platforms"
+	select ARCH_HAS_HARDWARE_PREFETCH
+	help
+	  This enables support for Fujitsu A64FX SoC family.
+
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
 	select ALPINE_MSI if PCI
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 30d2db37c..ad90d0fb5 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -234,4 +234,6 @@ source "drivers/interconnect/Kconfig"
 source "drivers/counter/Kconfig"
 
 source "drivers/most/Kconfig"
+
+source "drivers/hwpf/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index be5d40ae1..8cb2e42f6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -188,3 +188,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
+obj-$(CONFIG_HARDWARE_PREFETCH)	+= hwpf/
diff --git a/drivers/hwpf/Kconfig b/drivers/hwpf/Kconfig
new file mode 100644
index 000000000..24528ca85
--- /dev/null
+++ b/drivers/hwpf/Kconfig
@@ -0,0 +1,24 @@
+config ARCH_HAS_HARDWARE_PREFETCH
+	bool
+
+menuconfig HARDWARE_PREFETCH
+	bool "Hardware Prefetch Control"
+	depends on ARCH_HAS_HARDWARE_PREFETCH
+	default y
+	help
+	  Hardware Prefetch Control Driver
+
+	  This driver allows you to control the Hardware Prefetch mechanism.
+	  If the hardware supports the mechanism, it provides a sysfs interface
+	  for changeing the feature's enablement, prefetch distance and strongness.
+
+if HARDWARE_PREFETCH
+
+config A64FX_HARDWARE_PREFETCH
+	tristate "A64FX Hardware Prefetch support"
+	depends on ARCH_A64FX
+	default m
+	help
+	  This adds Hardware Prefetch driver support for A64FX SOCs.
+
+endif
diff --git a/drivers/hwpf/Makefile b/drivers/hwpf/Makefile
new file mode 100644
index 000000000..56027da22
--- /dev/null
+++ b/drivers/hwpf/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Hardware prefetch core driver
+obj-$(CONFIG_HARDWARE_PREFETCH) += hwpf.o
+
+# ARM SoC driver
+obj-$(CONFIG_A64FX_HARDWARE_PREFETCH) += fujitsu_hwpf.o
-- 
2.27.0

