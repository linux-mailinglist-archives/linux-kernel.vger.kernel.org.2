Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2E3A4668
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFKQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhFKQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623428528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFUFUhpRVdm5KPF6eO/SQzdrejXCHGdBfwZ+/vO4kMA=;
        b=Ah8iu2lHAn4ym8MfZpV82UOf3uR/XHbRMmm4wA3x8TwN6iWeCe57Tzk/liUIDrN4dcs1MB
        gPGGbxwY58BxNLLg9aLqs/zcpIdmzsRDwyy0O/Q69GngvuMW0KarZ4N2VqbgZd76awBKAH
        MXRzOgkZgU2SqJGNTwoBvdEbjVLtIeQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-Cae3AHnSOf6xH0VXISQS5g-1; Fri, 11 Jun 2021 12:22:07 -0400
X-MC-Unique: Cae3AHnSOf6xH0VXISQS5g-1
Received: by mail-oo1-f71.google.com with SMTP id f5-20020a4ab0050000b029023e3bd79e80so1812557oon.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFUFUhpRVdm5KPF6eO/SQzdrejXCHGdBfwZ+/vO4kMA=;
        b=bmVjYx6fBYdUnox2jcELOtOiCN65PBIgr5RY252m0c/z8jY8hCUySWSp9tvSE4E6ph
         yI0vGp6wXIzQQVAQ0eT60bCFdzY730QejifOxzS1CrcZdS4GXBsEN8NyjdVSQ/qZFCDg
         PgEkf7hHwbESRQNpJqwHMYqr2XyYp+K0JQyz9H/jzlDMOrkHkr1zp7lESjdqG2b2NhxP
         4vqDUvdBAizbkr6lj16YWoih4mDUoY8KOdvF33MtoajlayOxGHQ4xIpn9bhvScv1rLAQ
         lrBBXQBHNUmRI3dILhU16yUiHvcbWSi4QQumoA1Azd3311HfKyM0bF+9YPs56L1GbWLG
         Q87g==
X-Gm-Message-State: AOAM5330dvsVmal5jpgsvD3HceVQCFOjAeVvkhiVpjtdr4frg0rORvdi
        6JUAPhsICEhpnbhR2jL4BzCChvWeVpJQ7fcbwCUyecgMrxiUHYlk2Vil9P+tIDXoJjmpR85iOuo
        xDH7vlgJEsK0vwP7/rV9FGAJP
X-Received: by 2002:a9d:d55:: with SMTP id 79mr3845136oti.349.1623428525823;
        Fri, 11 Jun 2021 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXsqtwYvk6fOmqKdeHzPAmeHKW9yzHsy2fQHvVMb82tad8du7mMksaPZUfpYKRW0KJKlLdxg==
X-Received: by 2002:a9d:d55:: with SMTP id 79mr3845122oti.349.1623428525637;
        Fri, 11 Jun 2021 09:22:05 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m18sm1346345otr.61.2021.06.11.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:22:05 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com,
        dinguyen@kernel.org, nava.manne@xilinx.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 4/4] fpga: lattice: reorganize to subdir layout
Date:   Fri, 11 Jun 2021 09:21:29 -0700
Message-Id: <20210611162129.3203483-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210611162129.3203483-1-trix@redhat.com>
References: <20210611162129.3203483-1-trix@redhat.com>
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
index 885701b1356ad..a7dab0275f278 100644
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
index 0000000000000..6c2f1ae17e4f6
--- /dev/null
+++ b/drivers/fpga/lattice/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config FPGA_LATTICE
+	bool "Lattice FPGAs"
+	default y
+	help
+	  If you have a lattice fpga, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about lattice fpgas. If you say Y, you will be asked
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

