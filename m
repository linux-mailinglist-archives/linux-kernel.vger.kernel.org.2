Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8051E39FC70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhFHQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233238AbhFHQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hE6HSHMIRX+gAlRokY5aHJhvIk3ZJblkRJXqZXARHDc=;
        b=elsUNVAiZCc4dgwL+UHaxx+KQGpDZfkVcTbyFoaEI+eR6orKoLMsxg8mZG75ifKs/VI4eV
        lXObeY9U9Qc/1xw18DmedOtthMxcX9rcX2mmCH/l+cBACXzIo/B2bLlwx+6c7fsvQVUrP+
        AOIDsICfu1nKt82t5qfKF2hr8v9f1ls=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-gLjLUYXrOT-63aP8uZ4hoA-1; Tue, 08 Jun 2021 12:24:08 -0400
X-MC-Unique: gLjLUYXrOT-63aP8uZ4hoA-1
Received: by mail-ot1-f71.google.com with SMTP id 19-20020a9d04130000b02903cb28b38d0aso12846739otc.19
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hE6HSHMIRX+gAlRokY5aHJhvIk3ZJblkRJXqZXARHDc=;
        b=uUt6uq6tM2kL5HWA0c5O00xzguS/zFTHDrMETBFVoQzKgXHSfZfTooNaPbu4pvr5Zm
         AyHWkPOBnXQgHqafdl3vvOlzLRwQIdN771tvvVnPVk1wWvmVEVmc8FqjfB2Y2Y4gXAgK
         4x6Dk7ECLncKXqOFU0zlCdiixakLhVjYwgJ10XPdP+R9GXhk85QuRuGgmPLNt84+povl
         Y8A6ElNqM5JKfW4I2sDhiwnawVT0xljp9DpW30Lr3RMg0KfIzSFd1Nfo9y8V9q9xS7d6
         MyaxrfFAc+oOTNmXoyNUBZ/MePCJ7y+vGZGXh59WOnWw6ylmRgbETMnceNFFf5fQcUXM
         cr/Q==
X-Gm-Message-State: AOAM531hVxbE1qIwYPXU1smpv5iErASgmgCmxGXvepxn2QxPWTh8QnGW
        RcM1wyPtWKZVHG5H8L7o1LmhuMCuvebKrAULjCEa4LYdxMu4u3EM3b2grs/Ixbj9WxxWvr+0u0k
        AB9CeF49CR8XjcwybcKKvti92
X-Received: by 2002:a05:6808:55c:: with SMTP id i28mr3440173oig.66.1623169446382;
        Tue, 08 Jun 2021 09:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz871oBeLPJEBJQHL79uFGPE47JE/Fxob6zrZrwY6gtaALlSf91P0rx0V53f1omTZuqN8Zfig==
X-Received: by 2002:a05:6808:55c:: with SMTP id i28mr3440166oig.66.1623169446230;
        Tue, 08 Jun 2021 09:24:06 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s4sm3225773otr.80.2021.06.08.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:24:05 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        dinguyen@kernel.org, krzysztof.kozlowski@canonical.com,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 4/7] fpga: lattice: reorganize to subdir layout
Date:   Tue,  8 Jun 2021 09:23:37 -0700
Message-Id: <20210608162340.3010204-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608162340.3010204-1-trix@redhat.com>
References: <20210608162340.3010204-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Create a lattice/ subdir
Move ice40* and machxo2* files to it.
Add a Kconfig and Makefile

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig                     | 14 +-------------
 drivers/fpga/Makefile                    | 13 +++++--------
 drivers/fpga/lattice/Kconfig             | 22 ++++++++++++++++++++++
 drivers/fpga/lattice/Makefile            |  4 ++++
 drivers/fpga/{ => lattice}/ice40-spi.c   |  0
 drivers/fpga/{ => lattice}/machxo2-spi.c |  0
 6 files changed, 32 insertions(+), 21 deletions(-)
 create mode 100644 drivers/fpga/lattice/Kconfig
 create mode 100644 drivers/fpga/lattice/Makefile
 rename drivers/fpga/{ => lattice}/ice40-spi.c (100%)
 rename drivers/fpga/{ => lattice}/machxo2-spi.c (100%)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 885701b1356ad..0cce719d6af84 100644
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
@@ -47,6 +34,7 @@ config OF_FPGA_REGION
 	  overlay.
 
 source "drivers/fpga/altera/Kconfig"
+source "drivers/fpga/lattice/Kconfig"
 source "drivers/fpga/dfl/Kconfig"
 source "drivers/fpga/xilinx/Kconfig"
 
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
index 0000000000000..4619aac49ef57
--- /dev/null
+++ b/drivers/fpga/lattice/Kconfig
@@ -0,0 +1,22 @@
+config FPGA_LATTICE
+	bool "Lattice Devices"
+	default y
+	help
+	  If you have a lattic fpga, say Y.
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
index 0000000000000..42d01c1b61704
--- /dev/null
+++ b/drivers/fpga/lattice/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
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

