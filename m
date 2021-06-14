Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E743A7015
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhFNUTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235093AbhFNUTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623701847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deF1y3uXnOYh8KHSZy40SPrVBxHgGTmDPBUWYgjIGVk=;
        b=QfHyvTebnTK9HcfB2K4aaHJ9SzTHFhN/2i7NZCrKjCPQpl8M+AoK4P0SshLOTEjiz+H3JV
        EN2FN+MhZoWzGLTAxRTfmxi1I3Xi66IGnmYg6L2L9LMnOzJYT8qP/qCaq5F64levysR/Uo
        jzfuQupVUEyErbH6rrr1AXiIUXh8pzA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Rx3yKxS8OFaiHZJez-luOw-1; Mon, 14 Jun 2021 16:17:26 -0400
X-MC-Unique: Rx3yKxS8OFaiHZJez-luOw-1
Received: by mail-oo1-f71.google.com with SMTP id 185-20020a4a09c20000b029024ac8624e53so2839236ooa.16
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deF1y3uXnOYh8KHSZy40SPrVBxHgGTmDPBUWYgjIGVk=;
        b=uIfM5u852eyJOf+uuthaVPgZehJh7LUKFc6ACxNr9iRy+FxDWvIwTDvW5ZBHFSvRgf
         2tasIwHTURpRtnOZjw3YPSCu5TJsCxf4pDn03YbS3mz2O3ahh0OAp++RtpGQfU0oumbJ
         1qgstaGlqMmmwF/qhkjcObsiuFeR68JNRpwdVqYCra0QuERNGDDO6W7Szz3/8xffhyf5
         HDYgNl2300izO/GL8Vz392e6nyl0okBf3USmKhkmwh8pDn1Vz7+s3JkNsaFd14I3EMxP
         qC5PI236Ge4m2ZEARJWiFSJivR1YTf6HwyH4x4Ls28A+N3Zb+98787DWpluszSigtIVZ
         hINA==
X-Gm-Message-State: AOAM533kJt+KL9JXytaBAgjNU70MDZZKgTjCu+6x2f+QxkFRZubdeZuO
        9fyL8b0cDxKUmrq/AFWrf5Uzx2fhFhLH96PTL9y4tbuwha/294CLOFzrrCYC9eHhaAXR7BS5z9x
        Y8L9kgA3jYd8DjAzqZXpzQW2G
X-Received: by 2002:a05:6808:15a0:: with SMTP id t32mr627123oiw.90.1623701845306;
        Mon, 14 Jun 2021 13:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9ihSkzWKYE+RNWK7ultwITITDH5R7KQxnE5GidKW3BxwKMFKMjVT5vD2//drk/nGfLjX/XA==
X-Received: by 2002:a05:6808:15a0:: with SMTP id t32mr627101oiw.90.1623701845099;
        Mon, 14 Jun 2021 13:17:25 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b198sm408535oii.19.2021.06.14.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:17:24 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@canonical.com, nava.manne@xilinx.com,
        yilun.xu@intel.com, davidgow@google.com, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v4 3/4] fpga: altera: reorganize to subdir layout
Date:   Mon, 14 Jun 2021 13:16:47 -0700
Message-Id: <20210614201648.3358206-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210614201648.3358206-1-trix@redhat.com>
References: <20210614201648.3358206-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Follow drivers/net/ethernet/ which has control configs
NET_VENDOR_BLA that map to drivers/net/ethernet/bla
Since fpgas do not have many vendors, drop the 'VENDOR' and use
FPGA_BLA.

There are several new subdirs
altera/
dfl/
lattice/
xilinx/

Each subdir has a Kconfig that has a new/reused

if FPGA_BLA
  ... existing configs ...
endif FPGA_BLA

Which is sourced into the main fpga/Kconfig

Each subdir has a Makefile whose transversal is controlled in the
fpga/Makefile by

obj-$(CONFIG_FPGA_BLA) += bla/

This is the altera/ subdir part.

Create a altera/ subdir
Move altera-* and soc* ts73xx* files to it.
Add a Kconfig and Makefile

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig                          | 70 +--------------
 drivers/fpga/Makefile                         | 11 +--
 drivers/fpga/altera/Kconfig                   | 85 +++++++++++++++++++
 drivers/fpga/altera/Makefile                  | 12 +++
 drivers/fpga/{ => altera}/altera-cvp.c        |  0
 drivers/fpga/{ => altera}/altera-fpga2sdram.c |  0
 .../fpga/{ => altera}/altera-freeze-bridge.c  |  0
 drivers/fpga/{ => altera}/altera-hps2fpga.c   |  0
 .../{ => altera}/altera-pr-ip-core-plat.c     |  0
 drivers/fpga/{ => altera}/altera-pr-ip-core.c |  0
 drivers/fpga/{ => altera}/altera-ps-spi.c     |  0
 drivers/fpga/{ => altera}/socfpga-a10.c       |  0
 drivers/fpga/{ => altera}/socfpga.c           |  0
 drivers/fpga/{ => altera}/stratix10-soc.c     |  0
 drivers/fpga/{ => altera}/ts73xx-fpga.c       |  0
 15 files changed, 99 insertions(+), 79 deletions(-)
 create mode 100644 drivers/fpga/altera/Kconfig
 create mode 100644 drivers/fpga/altera/Makefile
 rename drivers/fpga/{ => altera}/altera-cvp.c (100%)
 rename drivers/fpga/{ => altera}/altera-fpga2sdram.c (100%)
 rename drivers/fpga/{ => altera}/altera-freeze-bridge.c (100%)
 rename drivers/fpga/{ => altera}/altera-hps2fpga.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core-plat.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core.c (100%)
 rename drivers/fpga/{ => altera}/altera-ps-spi.c (100%)
 rename drivers/fpga/{ => altera}/socfpga-a10.c (100%)
 rename drivers/fpga/{ => altera}/socfpga.c (100%)
 rename drivers/fpga/{ => altera}/stratix10-soc.c (100%)
 rename drivers/fpga/{ => altera}/ts73xx-fpga.c (100%)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 28c261807b428..2c829b1105925 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -12,52 +12,6 @@ menuconfig FPGA
 
 if FPGA
 
-config FPGA_MGR_SOCFPGA
-	tristate "Altera SOCFPGA FPGA Manager"
-	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
-	help
-	  FPGA manager driver support for Altera SOCFPGA.
-
-config FPGA_MGR_SOCFPGA_A10
-	tristate "Altera SoCFPGA Arria10"
-	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
-	select REGMAP_MMIO
-	help
-	  FPGA manager driver support for Altera Arria10 SoCFPGA.
-
-config ALTERA_PR_IP_CORE
-	tristate "Altera Partial Reconfiguration IP Core"
-	help
-	  Core driver support for Altera Partial Reconfiguration IP component
-
-config ALTERA_PR_IP_CORE_PLAT
-	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-	depends on ALTERA_PR_IP_CORE && OF && HAS_IOMEM
-	help
-	  Platform driver support for Altera Partial Reconfiguration IP
-	  component
-
-config FPGA_MGR_ALTERA_PS_SPI
-	tristate "Altera FPGA Passive Serial over SPI"
-	depends on SPI
-	select BITREVERSE
-	help
-	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
-	  using the passive serial interface over SPI.
-
-config FPGA_MGR_ALTERA_CVP
-	tristate "Altera CvP FPGA Manager"
-	depends on PCI
-	help
-	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
-	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
-
-config FPGA_MGR_STRATIX10_SOC
-	tristate "Intel Stratix10 SoC FPGA Manager"
-	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
-	help
-	  FPGA manager driver support for the Intel Stratix10 SoC.
-
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
@@ -71,35 +25,12 @@ config FPGA_MGR_MACHXO2_SPI
 	  FPGA manager driver support for Lattice MachXO2 configuration
 	  over slave SPI interface.
 
-config FPGA_MGR_TS73XX
-	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
-	depends on ARCH_EP93XX && MACH_TS72XX
-	help
-	  FPGA manager driver support for the Altera Cyclone II FPGA
-	  present on the TS-73xx SBC boards.
-
 config FPGA_BRIDGE
 	tristate "FPGA Bridge Framework"
 	help
 	  Say Y here if you want to support bridges connected between host
 	  processors and FPGAs or between FPGAs.
 
-config SOCFPGA_FPGA_BRIDGE
-	tristate "Altera SoCFPGA FPGA Bridges"
-	depends on ARCH_INTEL_SOCFPGA && FPGA_BRIDGE
-	help
-	  Say Y to enable drivers for FPGA bridges for Altera SOCFPGA
-	  devices.
-
-config ALTERA_FREEZE_BRIDGE
-	tristate "Altera FPGA Freeze Bridge"
-	depends on FPGA_BRIDGE && HAS_IOMEM
-	help
-	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
-	  freeze bridge is a bridge that exists in the FPGA fabric to
-	  isolate one region of the FPGA from the busses while that
-	  region is being reprogrammed.
-
 config FPGA_REGION
 	tristate "FPGA Region"
 	depends on FPGA_BRIDGE
@@ -115,6 +46,7 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+source "drivers/fpga/altera/Kconfig"
 source "drivers/fpga/dfl/Kconfig"
 source "drivers/fpga/xilinx/Kconfig"
 
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0868c7c4264d8..db83aeb997f24 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -7,25 +7,16 @@
 obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 
 # FPGA Manager Drivers
-obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+= altera-cvp.o
-obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)	+= altera-ps-spi.o
 obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
 obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)	+= machxo2-spi.o
-obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
-obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
-obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
-obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
-obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
-obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
 obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
+obj-$(CONFIG_FPGA_ALTERA) += altera/
 obj-$(CONFIG_FPGA_DFL) += dfl/
 obj-$(CONFIG_FPGA_XILINX) += xilinx/
diff --git a/drivers/fpga/altera/Kconfig b/drivers/fpga/altera/Kconfig
new file mode 100644
index 0000000000000..b2385f0bf178d
--- /dev/null
+++ b/drivers/fpga/altera/Kconfig
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FPGA_ALTERA
+	bool "Altera FPGAs"
+	default y
+	help
+	  If you have an altera fpga, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about altera fpgas. If you say Y, you will be asked
+	  for your specific device in the following questions.
+
+if FPGA_ALTERA
+
+config FPGA_MGR_SOCFPGA
+	tristate "Altera SOCFPGA FPGA Manager"
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	help
+	  FPGA manager driver support for Altera SOCFPGA.
+
+config FPGA_MGR_SOCFPGA_A10
+	tristate "Altera SoCFPGA Arria10"
+	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  FPGA manager driver support for Altera Arria10 SoCFPGA.
+
+config ALTERA_PR_IP_CORE
+	tristate "Altera Partial Reconfiguration IP Core"
+	help
+	  Core driver support for Altera Partial Reconfiguration IP component
+
+config ALTERA_PR_IP_CORE_PLAT
+	tristate "Platform support of Altera Partial Reconfiguration IP Core"
+	depends on ALTERA_PR_IP_CORE && OF && HAS_IOMEM
+	help
+	  Platform driver support for Altera Partial Reconfiguration IP
+	  component
+
+config FPGA_MGR_ALTERA_PS_SPI
+	tristate "Altera FPGA Passive Serial over SPI"
+	depends on SPI
+	select BITREVERSE
+	help
+	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
+	  using the passive serial interface over SPI.
+
+config FPGA_MGR_ALTERA_CVP
+	tristate "Altera CvP FPGA Manager"
+	depends on PCI
+	help
+	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
+	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
+
+config FPGA_MGR_STRATIX10_SOC
+	tristate "Intel Stratix10 SoC FPGA Manager"
+	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
+	help
+	  FPGA manager driver support for the Intel Stratix10 SoC.
+
+config FPGA_MGR_TS73XX
+	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
+	depends on ARCH_EP93XX && MACH_TS72XX
+	help
+	  FPGA manager driver support for the Altera Cyclone II FPGA
+	  present on the TS-73xx SBC boards.
+
+config ALTERA_FREEZE_BRIDGE
+	tristate "Altera FPGA Freeze Bridge"
+	depends on FPGA_BRIDGE && HAS_IOMEM
+	help
+	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
+	  freeze bridge is a bridge that exists in the FPGA fabric to
+	  isolate one region of the FPGA from the busses while that
+	  region is being reprogrammed.
+
+config SOCFPGA_FPGA_BRIDGE
+	tristate "Altera SoCFPGA FPGA Bridges"
+	depends on ARCH_INTEL_SOCFPGA && FPGA_BRIDGE
+	help
+	  Say Y to enable drivers for FPGA bridges for Altera SOCFPGA
+	  devices.
+
+endif #FPGA_ALTERA
diff --git a/drivers/fpga/altera/Makefile b/drivers/fpga/altera/Makefile
new file mode 100644
index 0000000000000..9c86057cff110
--- /dev/null
+++ b/drivers/fpga/altera/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ALTERA_FREEZE_BRIDGE) += altera-freeze-bridge.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE) += altera-pr-ip-core.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT) += altera-pr-ip-core-plat.o
+obj-$(CONFIG_FPGA_MGR_ALTERA_CVP) += altera-cvp.o
+obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI) += altera-ps-spi.o
+obj-$(CONFIG_FPGA_MGR_SOCFPGA) += socfpga.o
+obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10) += socfpga-a10.o
+obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC) += stratix10-soc.o
+obj-$(CONFIG_FPGA_MGR_TS73XX) += ts73xx-fpga.o
+obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE) += altera-hps2fpga.o altera-fpga2sdram.o
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera/altera-cvp.c
similarity index 100%
rename from drivers/fpga/altera-cvp.c
rename to drivers/fpga/altera/altera-cvp.c
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera/altera-fpga2sdram.c
similarity index 100%
rename from drivers/fpga/altera-fpga2sdram.c
rename to drivers/fpga/altera/altera-fpga2sdram.c
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera/altera-freeze-bridge.c
similarity index 100%
rename from drivers/fpga/altera-freeze-bridge.c
rename to drivers/fpga/altera/altera-freeze-bridge.c
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera/altera-hps2fpga.c
similarity index 100%
rename from drivers/fpga/altera-hps2fpga.c
rename to drivers/fpga/altera/altera-hps2fpga.c
diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera/altera-pr-ip-core-plat.c
similarity index 100%
rename from drivers/fpga/altera-pr-ip-core-plat.c
rename to drivers/fpga/altera/altera-pr-ip-core-plat.c
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera/altera-pr-ip-core.c
similarity index 100%
rename from drivers/fpga/altera-pr-ip-core.c
rename to drivers/fpga/altera/altera-pr-ip-core.c
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera/altera-ps-spi.c
similarity index 100%
rename from drivers/fpga/altera-ps-spi.c
rename to drivers/fpga/altera/altera-ps-spi.c
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/altera/socfpga-a10.c
similarity index 100%
rename from drivers/fpga/socfpga-a10.c
rename to drivers/fpga/altera/socfpga-a10.c
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/altera/socfpga.c
similarity index 100%
rename from drivers/fpga/socfpga.c
rename to drivers/fpga/altera/socfpga.c
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/altera/stratix10-soc.c
similarity index 100%
rename from drivers/fpga/stratix10-soc.c
rename to drivers/fpga/altera/stratix10-soc.c
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/altera/ts73xx-fpga.c
similarity index 100%
rename from drivers/fpga/ts73xx-fpga.c
rename to drivers/fpga/altera/ts73xx-fpga.c
-- 
2.26.3

