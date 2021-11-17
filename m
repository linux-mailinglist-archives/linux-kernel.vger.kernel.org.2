Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7F454622
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhKQMJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:37 -0500
Received: from smtp88.ord1c.emailsrvr.com ([108.166.43.88]:39715 "EHLO
        smtp88.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237142AbhKQMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150787;
        bh=cY6CL4D3ltR//GryIpmSUCEGk9RGm+Ii4HjdGhzSvhI=;
        h=From:To:Subject:Date:From;
        b=IVYSTaFQmH1dBjS1g9JqtMr97RHIb4wT4MAuSrc2T4ElyhVV1NhodaKGTloYBLs/H
         auvCeh7ehipJuBq1lq+pz0AvJjqbbPmq/gJdC2sKjcjl33aNCpM+ZoSqovJVO480KW
         bkdDAdBCDyiGk7qNTnA+wZA3uSy0n2ZzA/PgkERY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 036F2E00F3;
        Wed, 17 Nov 2021 07:06:26 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 3/5] comedi: Move and rename "8255.h" to <linux/comedi/comedi_8255.h>
Date:   Wed, 17 Nov 2021 12:06:01 +0000
Message-Id: <20211117120604.117740-4-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117120604.117740-1-abbotti@mev.co.uk>
References: <20211117120604.117740-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-4-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the header files in "drivers/comedi/drivers/" are common enough
to be useful to out-of-tree comedi driver modules.  Using them for
out-of-tree module builds is hampered by the headers being outside the
"include/" directory so it is desirable to move them.

There are about a couple of dozen Comedi device drivers that use the
"comedi_8255" module to add digital I/O subdevices based on the
venerable 8255 Programmable Peripheral Interface chip.  The macros and
declarations to use that module are in the "8255.h" header file in the
comedi "drivers" directory.  Move it into "include/linux/comedi/" and
rename it to "comedi_8255.h" for naming consistency reasons.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/8255.c                             | 3 +--
 drivers/comedi/drivers/8255_pci.c                         | 3 +--
 drivers/comedi/drivers/adv_pci_dio.c                      | 2 +-
 drivers/comedi/drivers/aio_aio12_8.c                      | 2 +-
 drivers/comedi/drivers/amplc_dio200_common.c              | 2 +-
 drivers/comedi/drivers/amplc_pc236_common.c               | 2 +-
 drivers/comedi/drivers/amplc_pci230.c                     | 2 +-
 drivers/comedi/drivers/cb_pcidas.c                        | 2 +-
 drivers/comedi/drivers/cb_pcidas64.c                      | 2 +-
 drivers/comedi/drivers/cb_pcidda.c                        | 3 +--
 drivers/comedi/drivers/cb_pcimdas.c                       | 2 +-
 drivers/comedi/drivers/cb_pcimdda.c                       | 3 +--
 drivers/comedi/drivers/comedi_8255.c                      | 3 +--
 drivers/comedi/drivers/daqboard2000.c                     | 2 +-
 drivers/comedi/drivers/das08.c                            | 2 +-
 drivers/comedi/drivers/das16.c                            | 2 +-
 drivers/comedi/drivers/das16m1.c                          | 2 +-
 drivers/comedi/drivers/dmm32at.c                          | 3 +--
 drivers/comedi/drivers/ni_atmio.c                         | 2 +-
 drivers/comedi/drivers/ni_atmio16d.c                      | 3 +--
 drivers/comedi/drivers/ni_daq_dio24.c                     | 3 +--
 drivers/comedi/drivers/ni_labpc_common.c                  | 2 +-
 drivers/comedi/drivers/ni_mio_common.c                    | 2 +-
 drivers/comedi/drivers/ni_mio_cs.c                        | 2 +-
 drivers/comedi/drivers/pcl724.c                           | 3 +--
 drivers/comedi/drivers/pcm3724.c                          | 3 +--
 .../drivers/8255.h => include/linux/comedi/comedi_8255.h  | 8 ++++----
 27 files changed, 30 insertions(+), 40 deletions(-)
 rename drivers/comedi/drivers/8255.h => include/linux/comedi/comedi_8255.h (90%)

diff --git a/drivers/comedi/drivers/8255.c b/drivers/comedi/drivers/8255.c
index f23a52b7c919..ced8ea09d4fa 100644
--- a/drivers/comedi/drivers/8255.c
+++ b/drivers/comedi/drivers/8255.c
@@ -41,8 +41,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 static int dev_8255_attach(struct comedi_device *dev,
 			   struct comedi_devconfig *it)
diff --git a/drivers/comedi/drivers/8255_pci.c b/drivers/comedi/drivers/8255_pci.c
index 76b8b4762bae..0fec048e3a53 100644
--- a/drivers/comedi/drivers/8255_pci.c
+++ b/drivers/comedi/drivers/8255_pci.c
@@ -54,8 +54,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedi_pci.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 enum pci_8255_boardid {
 	BOARD_ADLINK_PCI7224,
diff --git a/drivers/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
index 5947f08b9a1e..1ec602f8c6e1 100644
--- a/drivers/comedi/drivers/adv_pci_dio.c
+++ b/drivers/comedi/drivers/adv_pci_dio.c
@@ -24,8 +24,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
-#include "8255.h"
 #include "comedi_8254.h"
 
 /*
diff --git a/drivers/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
index 36c3a2d8a352..cd797dc0f828 100644
--- a/drivers/comedi/drivers/aio_aio12_8.c
+++ b/drivers/comedi/drivers/aio_aio12_8.c
@@ -23,9 +23,9 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_8254.h"
-#include "8255.h"
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index 950c50be4ff3..26b4049b366c 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -13,10 +13,10 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>	/* only for register defines */
 
 #include "amplc_dio200.h"
 #include "comedi_8254.h"
-#include "8255.h"		/* only for register defines */
 
 /* 200 series registers */
 #define DIO200_IO_SIZE		0x20
diff --git a/drivers/comedi/drivers/amplc_pc236_common.c b/drivers/comedi/drivers/amplc_pc236_common.c
index b8b0a624f72b..9f4f89b1ef23 100644
--- a/drivers/comedi/drivers/amplc_pc236_common.c
+++ b/drivers/comedi/drivers/amplc_pc236_common.c
@@ -12,9 +12,9 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "amplc_pc236.h"
-#include "8255.h"
 
 static void pc236_intr_update(struct comedi_device *dev, bool enable)
 {
diff --git a/drivers/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
index 554ee40e321f..93f7057d5b3f 100644
--- a/drivers/comedi/drivers/amplc_pci230.c
+++ b/drivers/comedi/drivers/amplc_pci230.c
@@ -175,9 +175,9 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_8254.h"
-#include "8255.h"
 
 /*
  * PCI230 PCI configuration register information
diff --git a/drivers/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
index 9b603532a4e7..75ff02b47959 100644
--- a/drivers/comedi/drivers/cb_pcidas.c
+++ b/drivers/comedi/drivers/cb_pcidas.c
@@ -55,9 +55,9 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_8254.h"
-#include "8255.h"
 #include "amcc_s5933.h"
 
 #define AI_BUFFER_SIZE		1024	/* max ai fifo size */
diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
index 7d4808faa1fb..ca6038a25f26 100644
--- a/drivers/comedi/drivers/cb_pcidas64.c
+++ b/drivers/comedi/drivers/cb_pcidas64.c
@@ -74,8 +74,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
-#include "8255.h"
 #include "plx9080.h"
 
 #define TIMER_BASE 25		/*  40MHz master clock */
diff --git a/drivers/comedi/drivers/cb_pcidda.c b/drivers/comedi/drivers/cb_pcidda.c
index 4ed3bcf47973..c52204a6bda4 100644
--- a/drivers/comedi/drivers/cb_pcidda.c
+++ b/drivers/comedi/drivers/cb_pcidda.c
@@ -28,8 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedi_pci.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 #define EEPROM_SIZE	128	/*  number of entries in eeprom */
 /* maximum number of ao channels for supported boards */
diff --git a/drivers/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
index 64c7d72c7956..7bc0805c69e2 100644
--- a/drivers/comedi/drivers/cb_pcimdas.c
+++ b/drivers/comedi/drivers/cb_pcimdas.c
@@ -35,10 +35,10 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_8254.h"
 #include "plx9052.h"
-#include "8255.h"
 
 /*
  * PCI Bar 1 Register map
diff --git a/drivers/comedi/drivers/cb_pcimdda.c b/drivers/comedi/drivers/cb_pcimdda.c
index 69d7803b0e58..bf8093a10315 100644
--- a/drivers/comedi/drivers/cb_pcimdda.c
+++ b/drivers/comedi/drivers/cb_pcimdda.c
@@ -68,8 +68,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedi_pci.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 /* device ids of the cards we support -- currently only 1 card supported */
 #define PCI_ID_PCIM_DDA06_16		0x0053
diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
index 10614603d677..5562b9cd0a17 100644
--- a/drivers/comedi/drivers/comedi_8255.c
+++ b/drivers/comedi/drivers/comedi_8255.c
@@ -30,8 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 struct subdev_8255_private {
 	unsigned long regbase;
diff --git a/drivers/comedi/drivers/daqboard2000.c b/drivers/comedi/drivers/daqboard2000.c
index 52e4bf16cbda..c0a4e1b06fb3 100644
--- a/drivers/comedi/drivers/daqboard2000.c
+++ b/drivers/comedi/drivers/daqboard2000.c
@@ -97,8 +97,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8255.h>
 
-#include "8255.h"
 #include "plx9080.h"
 
 #define DB2K_FIRMWARE		"daqboard2000_firmware.bin"
diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index c146a168f43b..bab868de2967 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -11,8 +11,8 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
-#include "8255.h"
 #include "comedi_8254.h"
 #include "das08.h"
 
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 362232ad4409..338396736936 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -64,10 +64,10 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
-#include "8255.h"
 
 #define DAS16_DMA_SIZE 0xff00	/*  size in bytes of allocated dma buffer */
 
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index cc79e318cb2d..ea55024d8c5a 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -43,8 +43,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
-#include "8255.h"
 #include "comedi_8254.h"
 
 /*
diff --git a/drivers/comedi/drivers/dmm32at.c b/drivers/comedi/drivers/dmm32at.c
index 0f2bea88b8a7..fe023c722aa3 100644
--- a/drivers/comedi/drivers/dmm32at.c
+++ b/drivers/comedi/drivers/dmm32at.c
@@ -30,8 +30,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 /* Board register addresses */
 #define DMM32AT_AI_START_CONV_REG	0x00
diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index f60a4e459a98..8876a1d24c56 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -75,9 +75,9 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/isapnp.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "ni_stc.h"
-#include "8255.h"
 
 /* AT specific setup */
 static const struct ni_board_struct ni_boards[] = {
diff --git a/drivers/comedi/drivers/ni_atmio16d.c b/drivers/comedi/drivers/ni_atmio16d.c
index 0bd4f88a2ac8..9fa902529a8e 100644
--- a/drivers/comedi/drivers/ni_atmio16d.c
+++ b/drivers/comedi/drivers/ni_atmio16d.c
@@ -40,8 +40,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 /* Configuration and Status Registers */
 #define COM_REG_1	0x00	/* wo 16 */
diff --git a/drivers/comedi/drivers/ni_daq_dio24.c b/drivers/comedi/drivers/ni_daq_dio24.c
index 84d78f2ee5ac..487733111023 100644
--- a/drivers/comedi/drivers/ni_daq_dio24.c
+++ b/drivers/comedi/drivers/ni_daq_dio24.c
@@ -24,8 +24,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedi_pcmcia.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 static int dio24_auto_attach(struct comedi_device *dev,
 			     unsigned long context)
diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index 7c4687226450..4a1269aeb371 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -13,9 +13,9 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "comedi_8254.h"
-#include "8255.h"
 #include "ni_labpc.h"
 #include "ni_labpc_regs.h"
 #include "ni_labpc_isadma.h"
diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 4f80a4991f95..d39998565808 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -43,7 +43,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 #include "mite.h"
 
 /* A timeout count */
diff --git a/drivers/comedi/drivers/ni_mio_cs.c b/drivers/comedi/drivers/ni_mio_cs.c
index bd967cdb2036..796f0b743772 100644
--- a/drivers/comedi/drivers/ni_mio_cs.c
+++ b/drivers/comedi/drivers/ni_mio_cs.c
@@ -29,9 +29,9 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/comedi/comedi_pcmcia.h>
+#include <linux/comedi/comedi_8255.h>
 
 #include "ni_stc.h"
-#include "8255.h"
 
 /*
  *  AT specific setup
diff --git a/drivers/comedi/drivers/pcl724.c b/drivers/comedi/drivers/pcl724.c
index b3f472c93e80..948a0576c9ef 100644
--- a/drivers/comedi/drivers/pcl724.c
+++ b/drivers/comedi/drivers/pcl724.c
@@ -26,8 +26,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 struct pcl724_board {
 	const char *name;
diff --git a/drivers/comedi/drivers/pcm3724.c b/drivers/comedi/drivers/pcm3724.c
index 93ae6cffed44..e4103f9eeced 100644
--- a/drivers/comedi/drivers/pcm3724.c
+++ b/drivers/comedi/drivers/pcm3724.c
@@ -25,8 +25,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
-
-#include "8255.h"
+#include <linux/comedi/comedi_8255.h>
 
 /*
  * Register I/O Map
diff --git a/drivers/comedi/drivers/8255.h b/include/linux/comedi/comedi_8255.h
similarity index 90%
rename from drivers/comedi/drivers/8255.h
rename to include/linux/comedi/comedi_8255.h
index ceae3ca52e60..b2a5bc6b3a49 100644
--- a/drivers/comedi/drivers/8255.h
+++ b/include/linux/comedi/comedi_8255.h
@@ -1,14 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * module/8255.h
- * Header file for 8255
+ * comedi_8255.h
+ * Generic 8255 digital I/O subdevice support
  *
  * COMEDI - Linux Control and Measurement Device Interface
  * Copyright (C) 1998 David A. Schleef <ds@schleef.org>
  */
 
-#ifndef _8255_H
-#define _8255_H
+#ifndef _COMEDI_8255_H
+#define _COMEDI_8255_H
 
 #define I8255_SIZE		0x04
 
-- 
2.33.0

