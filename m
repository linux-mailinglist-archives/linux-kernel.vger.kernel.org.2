Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF23B0E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhFVUIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233020AbhFVUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624392360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vueqp5/9s7lfGwIMwpU/0PSymm50fedJWz69+qj6nak=;
        b=REs40oXVQQHMa38BlYrkJR27pNUL2ZYGSOAZGwk2nTuu5OFOWLQgVFoXaV+bvoM3zWQNLI
        a5sjj42GNuECSWaQhf8qnV9fq+P9bKsSA9fA2cylEXSjm4jBV+AG9sIPMald7zd/5xvOiZ
        nWWvUwJhnvN6R0W5rgvVoeW13gilFy0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-Fe2d6BD1NcOOK2MRr52FZQ-1; Tue, 22 Jun 2021 16:05:59 -0400
X-MC-Unique: Fe2d6BD1NcOOK2MRr52FZQ-1
Received: by mail-ot1-f70.google.com with SMTP id x9-20020a9d20890000b02903c030760be3so590060ota.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vueqp5/9s7lfGwIMwpU/0PSymm50fedJWz69+qj6nak=;
        b=DhCWh7hd6gsesiKsjrmQT6XpeBghKeMG6TfnwWSEUgFk0ww5OkHNztg/C/uQOOMJHw
         2nLNHq5wMxkgfsi4AJdoSP00q5whpNQbrbRJ6LJWyfJTA1zwL8DD5AqdgEVOb6b6+n95
         JbNxs5/7gE63Vj2oWV7ZQVjzxvRnb/agzb2sFeHWtL4vzRN1ui7bpYyxjVgg3xY6MRAp
         0C3OBh7W/MM3gmE5t8xvmq1j6WhLNzP6mNY3u9oZZghIN8JJsWDZJMyfVu4bmDfjMHbG
         8xgJVR7Lge4YSUToVNiqRIrCIZ9yaiuuHpUr0QN27Vhva7WBMisjAoVgtAheDzjRWby+
         830w==
X-Gm-Message-State: AOAM533q+PRDoETTZzSrv1UR4o7f5kzteU+pjPkNKU/OTomz60qUTwNe
        Lqf4ODGYRVLnQKgbn3x2uim/Jc7VOVUmlSmHzCHe32LFmxtmXHnPvjvmUBv7vQXY8vKeUKIdDEu
        ldccSH+d/81olrPhkSLjeFr8q
X-Received: by 2002:aca:654c:: with SMTP id j12mr362078oiw.163.1624392357106;
        Tue, 22 Jun 2021 13:05:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWaG2CSBroZAks+yu+lTlx8m5PPcazaPB9K4jSe5JQDrXqq3OZ9wFCEQTuzH3IG8mQj1y77A==
X-Received: by 2002:aca:654c:: with SMTP id j12mr362053oiw.163.1624392356944;
        Tue, 22 Jun 2021 13:05:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 5sm727184oot.29.2021.06.22.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 13:05:56 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com,
        russell.h.weight@intel.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v5 4/4] fpga: lattice: reorganize to subdir layout
Date:   Tue, 22 Jun 2021 13:05:11 -0700
Message-Id: <20210622200511.3739914-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210622200511.3739914-1-trix@redhat.com>
References: <20210622200511.3739914-1-trix@redhat.com>
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

This is the lattice/ subdir part.

Create a lattice/ subdir
Move ice40* and machxo2* files to it.
Add a Kconfig and Makefile

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig                     | 14 +-----------
 drivers/fpga/Makefile                    | 13 ++++-------
 drivers/fpga/lattice/Kconfig             | 29 ++++++++++++++++++++++++
 drivers/fpga/lattice/Makefile            |  4 ++++
 drivers/fpga/{ => lattice}/ice40-spi.c   |  0
 drivers/fpga/{ => lattice}/machxo2-spi.c |  0
 6 files changed, 39 insertions(+), 21 deletions(-)
 create mode 100644 drivers/fpga/lattice/Kconfig
 create mode 100644 drivers/fpga/lattice/Makefile
 rename drivers/fpga/{ => lattice}/ice40-spi.c (100%)
 rename drivers/fpga/{ => lattice}/machxo2-spi.c (100%)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 2c829b1105925..955b155da3575 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -12,19 +12,6 @@ menuconfig FPGA
 
 if FPGA
 
-config FPGA_MGR_ICE40_SPI
-	tristate "Lattice iCE40 SPI"
-	depends on OF && SPI
-	help
-	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
-
-config FPGA_MGR_MACHXO2_SPI
-	tristate "Lattice MachXO2 SPI"
-	depends on SPI
-	help
-	  FPGA manager driver support for Lattice MachXO2 configuration
-	  over slave SPI interface.
-
 config FPGA_BRIDGE
 	tristate "FPGA Bridge Framework"
 	help
@@ -48,6 +35,7 @@ config OF_FPGA_REGION
 
 source "drivers/fpga/altera/Kconfig"
 source "drivers/fpga/dfl/Kconfig"
+source "drivers/fpga/lattice/Kconfig"
 source "drivers/fpga/xilinx/Kconfig"
 
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index db83aeb997f24..9197698201e3a 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -4,19 +4,16 @@
 #
 
 # Core FPGA Manager Framework
-obj-$(CONFIG_FPGA)			+= fpga-mgr.o
-
-# FPGA Manager Drivers
-obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
-obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)	+= machxo2-spi.o
+obj-$(CONFIG_FPGA) += fpga-mgr.o
 
 # FPGA Bridge Drivers
-obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
+obj-$(CONFIG_FPGA_BRIDGE) += fpga-bridge.o
 
 # High Level Interfaces
-obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
-obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
+obj-$(CONFIG_FPGA_REGION) += fpga-region.o
+obj-$(CONFIG_OF_FPGA_REGION) += of-fpga-region.o
 
 obj-$(CONFIG_FPGA_ALTERA) += altera/
 obj-$(CONFIG_FPGA_DFL) += dfl/
+obj-$(CONFIG_FPGA_LATTICE) += lattice/
 obj-$(CONFIG_FPGA_XILINX) += xilinx/
diff --git a/drivers/fpga/lattice/Kconfig b/drivers/fpga/lattice/Kconfig
new file mode 100644
index 0000000000000..47f5a0c62aa4e
--- /dev/null
+++ b/drivers/fpga/lattice/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FPGA_LATTICE
+	bool "Lattice FPGAs"
+	default y
+	help
+	  If you have a Lattice FPGA, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Lattice FPGAs. If you say Y, you will be asked
+	  for your specific device in the following questions.
+
+if FPGA_LATTICE
+
+config FPGA_MGR_ICE40_SPI
+	tristate "Lattice iCE40 SPI"
+	depends on OF && SPI
+	help
+	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
+
+config FPGA_MGR_MACHXO2_SPI
+	tristate "Lattice MachXO2 SPI"
+	depends on SPI
+	help
+	  FPGA manager driver support for Lattice MachXO2 configuration
+	  over slave SPI interface.
+
+endif #FPGA_LATTICE
diff --git a/drivers/fpga/lattice/Makefile b/drivers/fpga/lattice/Makefile
new file mode 100644
index 0000000000000..f542c96a73d40
--- /dev/null
+++ b/drivers/fpga/lattice/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_FPGA_MGR_ICE40_SPI) += ice40-spi.o
+obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI) += machxo2-spi.o
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/lattice/ice40-spi.c
similarity index 100%
rename from drivers/fpga/ice40-spi.c
rename to drivers/fpga/lattice/ice40-spi.c
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/lattice/machxo2-spi.c
similarity index 100%
rename from drivers/fpga/machxo2-spi.c
rename to drivers/fpga/lattice/machxo2-spi.c
-- 
2.26.3

