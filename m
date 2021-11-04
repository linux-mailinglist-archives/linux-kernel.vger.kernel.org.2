Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31D5444E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKDFcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:32:08 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:47918 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhKDFcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:32:04 -0400
IronPort-SDR: nZ8ZZBuZGEvOt9R5+GVNFoAZjmMVunTWC8DoHtFzwqPAgdxiOubLFy6w41hRLb/5GT1gUF5YtB
 nvNdAUBxkUoHBD1jeEXQAHY0axEo8L9zk4B5/xwvUDLWvRU95PvKk9huoZmGdwDLzyudv34ctH
 7wy8+9zAwpRIvZeGN8/jzzY8vF9TFVJn/hNjv6+fSmsCM2NzRadsls1z58B1KQMXZaGxVcCuge
 CC/YQmctNyXJZ+AXjPQWWzIonIjkN04DFsmwFaw6DmVVG0gQ6BaSX5Ic3adzI5k5V6Owss0wSs
 /g3+ThVL+3WpUSalR/invUqv
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="51365131"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="51365131"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:15 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8AC681273CD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:15 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CD62323ACB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:14 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 948AB400C07DD;
        Thu,  4 Nov 2021 14:22:14 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 4/5] driver: hwpf: Add Kconfig/Makefile to build hardware prefetch driver
Date:   Thu,  4 Nov 2021 14:21:21 +0900
Message-Id: <20211104052122.553868-5-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds kconfig/Makefile to build hardware prefetch driver for
A64FX and Intel support. This also add MAINTAINERS entry.

Note that this is the first time to add A64FX specific driver,
this adds A64FX entry in Kconfig.platforms of arm64 Kconfig.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  |  7 +++++++
 arch/arm64/Kconfig.platforms |  6 ++++++
 arch/x86/Kconfig             | 12 ++++++++++++
 drivers/Kconfig              |  2 ++
 drivers/Makefile             |  1 +
 drivers/hwpf/Kconfig         | 24 ++++++++++++++++++++++++
 drivers/hwpf/Makefile        |  9 +++++++++
 7 files changed, 61 insertions(+)
 create mode 100644 drivers/hwpf/Kconfig
 create mode 100644 drivers/hwpf/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index f26920f0f..29ad0e613 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1588,6 +1588,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 F:	arch/arm/mach-*/
 F:	arch/arm/plat-*/
 
+HARDWARE PREFETCH DRIVERS
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d9830e7e1..d60ec8eb7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1356,6 +1356,18 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config INTEL_HARDWARE_PREFETCH
+	tristate "Intel Hardware Prefetch support"
+	select ARCH_HAS_HARDWARE_PREFETCH
+	select HARDWARE_PREFETCH
+	depends on X86_64
+	help
+	  This option enables a Hardware Prefetch sysfs interface.
+	  This requires an Intel processor that has MSR about Hardware Prefetch.
+
+	  See Documentation/ABI/testing/sysfs-devices-system-cpu for more
+	  information.
+
 choice
 	prompt "High Memory Support"
 	default HIGHMEM4G
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0d399ddaa..c46702569 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -236,4 +236,6 @@ source "drivers/interconnect/Kconfig"
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
index 000000000..e011fa6e0
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
+	  for changing the feature's enablement, prefetch distance and strongness.
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
index 000000000..6790eb2d2
--- /dev/null
+++ b/drivers/hwpf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Hardware prefetch core driver
+obj-$(CONFIG_HARDWARE_PREFETCH) += hwpf.o
+
+# FUJITSU SoC driver
+obj-$(CONFIG_A64FX_HARDWARE_PREFETCH) += fujitsu_hwpf.o
+
+# Intel SoC driver
+obj-$(CONFIG_INTEL_HARDWARE_PREFETCH) += intel_hwpf.o
-- 
2.27.0

