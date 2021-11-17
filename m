Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8294745461F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbhKQMJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:32 -0500
Received: from smtp91.ord1c.emailsrvr.com ([108.166.43.91]:55134 "EHLO
        smtp91.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237144AbhKQMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150788;
        bh=MLIEloc/l8nt0OgjV9PGItgL4Mx3YiT4kIaL3VsSWyo=;
        h=From:To:Subject:Date:From;
        b=kvY/nas2I+FyscR3+oc6yS54eKnGTGlx50G8BgRwjG5aM3VZvX002HXThqVFydrgF
         wMObBY9WdFD1r448NG2TXfiy3nZxUgCzSubyTqxTm5C/ZKCE6YH1+lmGKhes4JQT6A
         b9Xwyts5nq1lfoKDiCbo8ElmhyeeVFgv06iKXH68=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0CE64E00F0;
        Wed, 17 Nov 2021 07:06:27 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 4/5] comedi: Move "comedi_8254.h" to <linux/comedi/comedi_8254.h>
Date:   Wed, 17 Nov 2021 12:06:02 +0000
Message-Id: <20211117120604.117740-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117120604.117740-1-abbotti@mev.co.uk>
References: <20211117120604.117740-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-5-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the header files in "drivers/comedi/drivers/" are common enough
to be useful to out-of-tree comedi driver modules.  Using them for
out-of-tree module builds is hampered by the headers being outside the
"include/" directory so it is desirable to move them.

There are about a couple of dozen or so Comedi device drivers that use
the "comedi_8254" module to add timers based on the venerable 8254
Programmable Interval Timer chip.  The macros and declarations to use
that module are in the "comedi_8254.h" header file in the comedi
"drivers" directory.  Move it into "include/linux/comedi/".

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/adl_pci9111.c                           | 2 +-
 drivers/comedi/drivers/adl_pci9118.c                           | 2 +-
 drivers/comedi/drivers/adv_pci1710.c                           | 2 +-
 drivers/comedi/drivers/adv_pci_dio.c                           | 3 +--
 drivers/comedi/drivers/aio_aio12_8.c                           | 3 +--
 drivers/comedi/drivers/amplc_dio200_common.c                   | 2 +-
 drivers/comedi/drivers/amplc_pci224.c                          | 3 +--
 drivers/comedi/drivers/amplc_pci230.c                          | 3 +--
 drivers/comedi/drivers/cb_das16_cs.c                           | 3 +--
 drivers/comedi/drivers/cb_pcidas.c                             | 2 +-
 drivers/comedi/drivers/cb_pcimdas.c                            | 2 +-
 drivers/comedi/drivers/comedi_8254.c                           | 3 +--
 drivers/comedi/drivers/das08.c                                 | 2 +-
 drivers/comedi/drivers/das16.c                                 | 2 +-
 drivers/comedi/drivers/das16m1.c                               | 3 +--
 drivers/comedi/drivers/das1800.c                               | 2 +-
 drivers/comedi/drivers/das6402.c                               | 3 +--
 drivers/comedi/drivers/das800.c                                | 3 +--
 drivers/comedi/drivers/me4000.c                                | 2 +-
 drivers/comedi/drivers/ni_at_a2150.c                           | 2 +-
 drivers/comedi/drivers/ni_at_ao.c                              | 3 +--
 drivers/comedi/drivers/ni_labpc_common.c                       | 2 +-
 drivers/comedi/drivers/pcl711.c                                | 3 +--
 drivers/comedi/drivers/pcl812.c                                | 2 +-
 drivers/comedi/drivers/pcl816.c                                | 2 +-
 drivers/comedi/drivers/pcl818.c                                | 2 +-
 drivers/comedi/drivers/rtd520.c                                | 2 +-
 {drivers/comedi/drivers => include/linux/comedi}/comedi_8254.h | 0
 28 files changed, 27 insertions(+), 38 deletions(-)
 rename {drivers/comedi/drivers => include/linux/comedi}/comedi_8254.h (100%)

diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
index 65454f3ecc91..c50f94272a74 100644
--- a/drivers/comedi/drivers/adl_pci9111.c
+++ b/drivers/comedi/drivers/adl_pci9111.c
@@ -43,9 +43,9 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "plx9052.h"
-#include "comedi_8254.h"
 
 #define PCI9111_FIFO_HALF_SIZE	512
 
diff --git a/drivers/comedi/drivers/adl_pci9118.c b/drivers/comedi/drivers/adl_pci9118.c
index 248cec3d894f..9a816c718303 100644
--- a/drivers/comedi/drivers/adl_pci9118.c
+++ b/drivers/comedi/drivers/adl_pci9118.c
@@ -79,9 +79,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "amcc_s5933.h"
-#include "comedi_8254.h"
 
 /*
  * PCI BAR2 Register map (dev->iobase)
diff --git a/drivers/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
index 47a800d72e58..4f2639968260 100644
--- a/drivers/comedi/drivers/adv_pci1710.c
+++ b/drivers/comedi/drivers/adv_pci1710.c
@@ -31,8 +31,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "amcc_s5933.h"
 
 /*
diff --git a/drivers/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
index 1ec602f8c6e1..efa3e46b554b 100644
--- a/drivers/comedi/drivers/adv_pci_dio.c
+++ b/drivers/comedi/drivers/adv_pci_dio.c
@@ -25,8 +25,7 @@
 #include <linux/delay.h>
 #include <linux/comedi/comedi_pci.h>
 #include <linux/comedi/comedi_8255.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register offset definitions
diff --git a/drivers/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
index cd797dc0f828..30b8a32204d8 100644
--- a/drivers/comedi/drivers/aio_aio12_8.c
+++ b/drivers/comedi/drivers/aio_aio12_8.c
@@ -24,8 +24,7 @@
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index 26b4049b366c..ff651f2eb86c 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -14,9 +14,9 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>	/* only for register defines */
+#include <linux/comedi/comedi_8254.h>
 
 #include "amplc_dio200.h"
-#include "comedi_8254.h"
 
 /* 200 series registers */
 #define DIO200_IO_SIZE		0x20
diff --git a/drivers/comedi/drivers/amplc_pci224.c b/drivers/comedi/drivers/amplc_pci224.c
index 3cf1b7fa565d..5a04e55daeea 100644
--- a/drivers/comedi/drivers/amplc_pci224.c
+++ b/drivers/comedi/drivers/amplc_pci224.c
@@ -97,8 +97,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/comedi/comedi_pci.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * PCI224/234 i/o space 1 (PCIBAR2) registers.
diff --git a/drivers/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
index 93f7057d5b3f..92ba8b8c0172 100644
--- a/drivers/comedi/drivers/amplc_pci230.c
+++ b/drivers/comedi/drivers/amplc_pci230.c
@@ -176,8 +176,7 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
 #include <linux/comedi/comedi_8255.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * PCI230 PCI configuration register information
diff --git a/drivers/comedi/drivers/cb_das16_cs.c b/drivers/comedi/drivers/cb_das16_cs.c
index 190d73a7d12c..8e0d2fa5f95d 100644
--- a/drivers/comedi/drivers/cb_das16_cs.c
+++ b/drivers/comedi/drivers/cb_das16_cs.c
@@ -28,8 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/comedi/comedi_pcmcia.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
index 75ff02b47959..0c7576b967fc 100644
--- a/drivers/comedi/drivers/cb_pcidas.c
+++ b/drivers/comedi/drivers/cb_pcidas.c
@@ -56,8 +56,8 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
 #include <linux/comedi/comedi_8255.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "amcc_s5933.h"
 
 #define AI_BUFFER_SIZE		1024	/* max ai fifo size */
diff --git a/drivers/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
index 7bc0805c69e2..8bdb00774f11 100644
--- a/drivers/comedi/drivers/cb_pcimdas.c
+++ b/drivers/comedi/drivers/cb_pcimdas.c
@@ -36,8 +36,8 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
 #include <linux/comedi/comedi_8255.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "plx9052.h"
 
 /*
diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index fac81567133d..b4185c1b2695 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -117,8 +117,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 static unsigned int __i8254_read(struct comedi_8254 *i8254, unsigned int reg)
 {
diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index bab868de2967..f8ab3af2e391 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -12,8 +12,8 @@
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "das08.h"
 
 /*
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 338396736936..f6649ffa9670 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -65,9 +65,9 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 #define DAS16_DMA_SIZE 0xff00	/*  size in bytes of allocated dma buffer */
 
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index ea55024d8c5a..275effb77746 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -44,8 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register map (dev->iobase)
diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index 768803742350..a43d3414a122 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -74,9 +74,9 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 /* misc. defines */
 #define DAS1800_SIZE           16	/* uses 16 io addresses */
diff --git a/drivers/comedi/drivers/das6402.c b/drivers/comedi/drivers/das6402.c
index d411ab7cf37c..1af394591e74 100644
--- a/drivers/comedi/drivers/das6402.c
+++ b/drivers/comedi/drivers/das6402.c
@@ -25,8 +25,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/das800.c b/drivers/comedi/drivers/das800.c
index c95e0fcb94a4..4ca33f46eaa7 100644
--- a/drivers/comedi/drivers/das800.c
+++ b/drivers/comedi/drivers/das800.c
@@ -47,8 +47,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 #define N_CHAN_AI             8	/*  number of analog input channels */
 
diff --git a/drivers/comedi/drivers/me4000.c b/drivers/comedi/drivers/me4000.c
index c5dc8199771f..9aea02b86ed9 100644
--- a/drivers/comedi/drivers/me4000.c
+++ b/drivers/comedi/drivers/me4000.c
@@ -33,8 +33,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "plx9052.h"
 
 #define ME4000_FIRMWARE		"me4000_firmware.bin"
diff --git a/drivers/comedi/drivers/ni_at_a2150.c b/drivers/comedi/drivers/ni_at_a2150.c
index ce5de58c499f..9942d770add8 100644
--- a/drivers/comedi/drivers/ni_at_a2150.c
+++ b/drivers/comedi/drivers/ni_at_a2150.c
@@ -40,9 +40,9 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 #define A2150_DMA_BUFFER_SIZE	0xff00	/*  size in bytes of dma buffer */
 
diff --git a/drivers/comedi/drivers/ni_at_ao.c b/drivers/comedi/drivers/ni_at_ao.c
index a06dfb9da329..9f3147b72aa8 100644
--- a/drivers/comedi/drivers/ni_at_ao.c
+++ b/drivers/comedi/drivers/ni_at_ao.c
@@ -26,8 +26,7 @@
 
 #include <linux/module.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index 4a1269aeb371..763249653228 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -14,8 +14,8 @@
 #include <linux/slab.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "ni_labpc.h"
 #include "ni_labpc_regs.h"
 #include "ni_labpc_isadma.h"
diff --git a/drivers/comedi/drivers/pcl711.c b/drivers/comedi/drivers/pcl711.c
index f1c383bd9d87..05172c553c8a 100644
--- a/drivers/comedi/drivers/pcl711.c
+++ b/drivers/comedi/drivers/pcl711.c
@@ -30,8 +30,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_8254.h"
+#include <linux/comedi/comedi_8254.h>
 
 /*
  * I/O port register map
diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index f00976ddfc2a..790f54476a91 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -115,9 +115,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/pcl816.c b/drivers/comedi/drivers/pcl816.c
index c5acdc8913f8..77b30246d966 100644
--- a/drivers/comedi/drivers/pcl816.c
+++ b/drivers/comedi/drivers/pcl816.c
@@ -36,9 +36,9 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index 20fcd6d588f8..e5b7793cce05 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -98,9 +98,9 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_8254.h>
 
 #include "comedi_isadma.h"
-#include "comedi_8254.h"
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/rtd520.c b/drivers/comedi/drivers/rtd520.c
index ee5bca2b1c09..7e0ec1a2a2ca 100644
--- a/drivers/comedi/drivers/rtd520.c
+++ b/drivers/comedi/drivers/rtd520.c
@@ -86,8 +86,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/comedi/comedi_pci.h>
+#include <linux/comedi/comedi_8254.h>
 
-#include "comedi_8254.h"
 #include "plx9080.h"
 
 /*
diff --git a/drivers/comedi/drivers/comedi_8254.h b/include/linux/comedi/comedi_8254.h
similarity index 100%
rename from drivers/comedi/drivers/comedi_8254.h
rename to include/linux/comedi/comedi_8254.h
-- 
2.33.0

