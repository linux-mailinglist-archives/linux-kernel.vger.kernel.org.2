Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6245461D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhKQMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:26 -0500
Received: from smtp89.ord1c.emailsrvr.com ([108.166.43.89]:40166 "EHLO
        smtp89.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237123AbhKQMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150785;
        bh=vLaFofZC+Ien2MxnORy7PapvHTFIkeuAYQliXGjhaic=;
        h=From:To:Subject:Date:From;
        b=ZjKyVK1lBz9PSjABlF7TalJWVBaZcC5JGfeAaiVweLC2lni/b55qzE65cmPNu8/sB
         1/VFDXqA9TljvEz4P8ESEAzLK8E4pkCGUG0EwJX0GwV6ukiuMLHxrb8IUzrpDUrjfl
         yzKI3UrTVsktGzrqBQxWVRsGFLh+4FEdoarfd1l0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 860DBE00FB;
        Wed, 17 Nov 2021 07:06:24 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 1/5] comedi: Move the main COMEDI headers
Date:   Wed, 17 Nov 2021 12:05:59 +0000
Message-Id: <20211117120604.117740-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117120604.117740-1-abbotti@mev.co.uk>
References: <20211117120604.117740-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-2-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the main COMEDI driver headers out of "drivers/comedi/" into new
directory "include/linux/comedi/".  These are "comedidev.h",
"comedilib.h", "comedi_pci.h", "comedi_pcmcia.h", and "comedi_usb.h".
Additionally, move the user-space API header "comedi.h" into
"include/uapi/linux/" and add "WITH Linux-syscall-note" to its
SPDX-License-Identifier.

Update the "COMEDI DRIVERS" section of the MAINTAINERS file to account
for these changes.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 MAINTAINERS                                         | 2 ++
 drivers/comedi/comedi_buf.c                         | 3 +--
 drivers/comedi/comedi_fops.c                        | 2 +-
 drivers/comedi/comedi_pci.c                         | 3 +--
 drivers/comedi/comedi_pcmcia.c                      | 3 +--
 drivers/comedi/comedi_usb.c                         | 3 +--
 drivers/comedi/drivers.c                            | 3 +--
 drivers/comedi/drivers/8255.c                       | 2 +-
 drivers/comedi/drivers/8255_pci.c                   | 3 +--
 drivers/comedi/drivers/addi_apci_1032.c             | 2 +-
 drivers/comedi/drivers/addi_apci_1500.c             | 2 +-
 drivers/comedi/drivers/addi_apci_1516.c             | 2 +-
 drivers/comedi/drivers/addi_apci_1564.c             | 2 +-
 drivers/comedi/drivers/addi_apci_16xx.c             | 3 +--
 drivers/comedi/drivers/addi_apci_2032.c             | 2 +-
 drivers/comedi/drivers/addi_apci_2200.c             | 2 +-
 drivers/comedi/drivers/addi_apci_3120.c             | 2 +-
 drivers/comedi/drivers/addi_apci_3501.c             | 2 +-
 drivers/comedi/drivers/addi_apci_3xxx.c             | 3 +--
 drivers/comedi/drivers/addi_watchdog.c              | 2 +-
 drivers/comedi/drivers/adl_pci6208.c                | 3 +--
 drivers/comedi/drivers/adl_pci7x3x.c                | 3 +--
 drivers/comedi/drivers/adl_pci8164.c                | 3 +--
 drivers/comedi/drivers/adl_pci9111.c                | 3 +--
 drivers/comedi/drivers/adl_pci9118.c                | 3 +--
 drivers/comedi/drivers/adq12b.c                     | 3 +--
 drivers/comedi/drivers/adv_pci1710.c                | 3 +--
 drivers/comedi/drivers/adv_pci1720.c                | 3 +--
 drivers/comedi/drivers/adv_pci1723.c                | 3 +--
 drivers/comedi/drivers/adv_pci1724.c                | 3 +--
 drivers/comedi/drivers/adv_pci1760.c                | 3 +--
 drivers/comedi/drivers/adv_pci_dio.c                | 3 +--
 drivers/comedi/drivers/aio_aio12_8.c                | 2 +-
 drivers/comedi/drivers/aio_iiro_16.c                | 3 +--
 drivers/comedi/drivers/amplc_dio200.c               | 2 +-
 drivers/comedi/drivers/amplc_dio200_common.c        | 3 +--
 drivers/comedi/drivers/amplc_dio200_pci.c           | 3 +--
 drivers/comedi/drivers/amplc_pc236.c                | 3 +--
 drivers/comedi/drivers/amplc_pc236_common.c         | 3 +--
 drivers/comedi/drivers/amplc_pc263.c                | 2 +-
 drivers/comedi/drivers/amplc_pci224.c               | 3 +--
 drivers/comedi/drivers/amplc_pci230.c               | 3 +--
 drivers/comedi/drivers/amplc_pci236.c               | 3 +--
 drivers/comedi/drivers/amplc_pci263.c               | 3 +--
 drivers/comedi/drivers/c6xdigio.c                   | 3 +--
 drivers/comedi/drivers/cb_das16_cs.c                | 3 +--
 drivers/comedi/drivers/cb_pcidas.c                  | 3 +--
 drivers/comedi/drivers/cb_pcidas64.c                | 3 +--
 drivers/comedi/drivers/cb_pcidda.c                  | 3 +--
 drivers/comedi/drivers/cb_pcimdas.c                 | 3 +--
 drivers/comedi/drivers/cb_pcimdda.c                 | 3 +--
 drivers/comedi/drivers/comedi_8254.c                | 3 +--
 drivers/comedi/drivers/comedi_8255.c                | 2 +-
 drivers/comedi/drivers/comedi_bond.c                | 6 +++---
 drivers/comedi/drivers/comedi_isadma.c              | 3 +--
 drivers/comedi/drivers/comedi_parport.c             | 3 +--
 drivers/comedi/drivers/comedi_test.c                | 4 +---
 drivers/comedi/drivers/contec_pci_dio.c             | 3 +--
 drivers/comedi/drivers/dac02.c                      | 3 +--
 drivers/comedi/drivers/daqboard2000.c               | 3 +--
 drivers/comedi/drivers/das08.c                      | 3 +--
 drivers/comedi/drivers/das08_cs.c                   | 3 +--
 drivers/comedi/drivers/das08_isa.c                  | 2 +-
 drivers/comedi/drivers/das08_pci.c                  | 3 +--
 drivers/comedi/drivers/das16.c                      | 3 +--
 drivers/comedi/drivers/das16m1.c                    | 2 +-
 drivers/comedi/drivers/das1800.c                    | 3 +--
 drivers/comedi/drivers/das6402.c                    | 3 +--
 drivers/comedi/drivers/das800.c                     | 3 +--
 drivers/comedi/drivers/dmm32at.c                    | 2 +-
 drivers/comedi/drivers/dt2801.c                     | 2 +-
 drivers/comedi/drivers/dt2811.c                     | 3 +--
 drivers/comedi/drivers/dt2814.c                     | 3 +--
 drivers/comedi/drivers/dt2815.c                     | 3 +--
 drivers/comedi/drivers/dt2817.c                     | 2 +-
 drivers/comedi/drivers/dt282x.c                     | 3 +--
 drivers/comedi/drivers/dt3000.c                     | 3 +--
 drivers/comedi/drivers/dt9812.c                     | 3 +--
 drivers/comedi/drivers/dyna_pci10xx.c               | 3 +--
 drivers/comedi/drivers/fl512.c                      | 3 +--
 drivers/comedi/drivers/gsc_hpdi.c                   | 3 +--
 drivers/comedi/drivers/icp_multi.c                  | 3 +--
 drivers/comedi/drivers/ii_pci20kc.c                 | 2 +-
 drivers/comedi/drivers/jr3_pci.c                    | 3 +--
 drivers/comedi/drivers/ke_counter.c                 | 3 +--
 drivers/comedi/drivers/me4000.c                     | 3 +--
 drivers/comedi/drivers/me_daq.c                     | 3 +--
 drivers/comedi/drivers/mf6x4.c                      | 3 +--
 drivers/comedi/drivers/mite.c                       | 3 +--
 drivers/comedi/drivers/mpc624.c                     | 3 +--
 drivers/comedi/drivers/multiq3.c                    | 3 +--
 drivers/comedi/drivers/ni_6527.c                    | 3 +--
 drivers/comedi/drivers/ni_65xx.c                    | 3 +--
 drivers/comedi/drivers/ni_660x.c                    | 3 +--
 drivers/comedi/drivers/ni_670x.c                    | 3 +--
 drivers/comedi/drivers/ni_at_a2150.c                | 3 +--
 drivers/comedi/drivers/ni_at_ao.c                   | 3 +--
 drivers/comedi/drivers/ni_atmio.c                   | 3 +--
 drivers/comedi/drivers/ni_atmio16d.c                | 2 +-
 drivers/comedi/drivers/ni_daq_700.c                 | 3 +--
 drivers/comedi/drivers/ni_daq_dio24.c               | 2 +-
 drivers/comedi/drivers/ni_labpc.c                   | 3 +--
 drivers/comedi/drivers/ni_labpc_common.c            | 3 +--
 drivers/comedi/drivers/ni_labpc_cs.c                | 3 +--
 drivers/comedi/drivers/ni_labpc_isadma.c            | 3 +--
 drivers/comedi/drivers/ni_labpc_pci.c               | 3 +--
 drivers/comedi/drivers/ni_mio_cs.c                  | 2 +-
 drivers/comedi/drivers/ni_pcidio.c                  | 3 +--
 drivers/comedi/drivers/ni_pcimio.c                  | 4 +---
 drivers/comedi/drivers/ni_routes.c                  | 3 +--
 drivers/comedi/drivers/ni_routes.h                  | 2 +-
 drivers/comedi/drivers/ni_routing/ni_route_values.h | 2 +-
 drivers/comedi/drivers/ni_tio.h                     | 2 +-
 drivers/comedi/drivers/ni_usb6501.c                 | 3 +--
 drivers/comedi/drivers/pcl711.c                     | 3 +--
 drivers/comedi/drivers/pcl724.c                     | 2 +-
 drivers/comedi/drivers/pcl726.c                     | 3 +--
 drivers/comedi/drivers/pcl730.c                     | 2 +-
 drivers/comedi/drivers/pcl812.c                     | 3 +--
 drivers/comedi/drivers/pcl816.c                     | 3 +--
 drivers/comedi/drivers/pcl818.c                     | 3 +--
 drivers/comedi/drivers/pcm3724.c                    | 2 +-
 drivers/comedi/drivers/pcmad.c                      | 2 +-
 drivers/comedi/drivers/pcmda12.c                    | 2 +-
 drivers/comedi/drivers/pcmmio.c                     | 3 +--
 drivers/comedi/drivers/pcmuio.c                     | 3 +--
 drivers/comedi/drivers/quatech_daqp_cs.c            | 3 +--
 drivers/comedi/drivers/rtd520.c                     | 3 +--
 drivers/comedi/drivers/rti800.c                     | 2 +-
 drivers/comedi/drivers/rti802.c                     | 2 +-
 drivers/comedi/drivers/s526.c                       | 2 +-
 drivers/comedi/drivers/s626.c                       | 3 +--
 drivers/comedi/drivers/ssv_dnp.c                    | 2 +-
 drivers/comedi/drivers/usbdux.c                     | 3 +--
 drivers/comedi/drivers/usbduxfast.c                 | 2 +-
 drivers/comedi/drivers/usbduxsigma.c                | 3 +--
 drivers/comedi/drivers/vmk80xx.c                    | 3 +--
 drivers/comedi/kcomedilib/kcomedilib_main.c         | 6 +++---
 drivers/comedi/proc.c                               | 2 +-
 drivers/comedi/range.c                              | 2 +-
 {drivers => include/linux}/comedi/comedi_pci.h      | 3 +--
 {drivers => include/linux}/comedi/comedi_pcmcia.h   | 3 +--
 {drivers => include/linux}/comedi/comedi_usb.h      | 3 +--
 {drivers => include/linux}/comedi/comedidev.h       | 3 +--
 {drivers => include/linux}/comedi/comedilib.h       | 0
 {drivers/comedi => include/uapi/linux}/comedi.h     | 2 +-
 146 files changed, 150 insertions(+), 252 deletions(-)
 rename {drivers => include/linux}/comedi/comedi_pci.h (98%)
 rename {drivers => include/linux}/comedi/comedi_pcmcia.h (97%)
 rename {drivers => include/linux}/comedi/comedi_usb.h (97%)
 rename {drivers => include/linux}/comedi/comedidev.h (99%)
 rename {drivers => include/linux}/comedi/comedilib.h (100%)
 rename {drivers/comedi => include/uapi/linux}/comedi.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0c634c1da64..1e83269c0982 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4716,6 +4716,8 @@ M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
 S:	Odd Fixes
 F:	drivers/comedi/
+F:	include/linux/comedi/
+F:	include/uapi/linux/comedi.h
 
 COMMON CLK FRAMEWORK
 M:	Michael Turquette <mturquette@baylibre.com>
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 06bfc859ab31..393966c09740 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -9,8 +9,7 @@
 
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
-
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include "comedi_internal.h"
 
 #ifdef PAGE_KERNEL_NOCACHE
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 763cea8418f8..55a0cae04b8d 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -23,7 +23,7 @@
 #include <linux/poll.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include <linux/cdev.h>
 
 #include <linux/io.h>
diff --git a/drivers/comedi/comedi_pci.c b/drivers/comedi/comedi_pci.c
index 54739af7eb71..cc2581902195 100644
--- a/drivers/comedi/comedi_pci.c
+++ b/drivers/comedi/comedi_pci.c
@@ -9,8 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /**
  * comedi_to_pci_dev() - Return PCI device attached to COMEDI device
diff --git a/drivers/comedi/comedi_pcmcia.c b/drivers/comedi/comedi_pcmcia.c
index bb273bb202e6..c53aad0fc2ce 100644
--- a/drivers/comedi/comedi_pcmcia.c
+++ b/drivers/comedi/comedi_pcmcia.c
@@ -9,8 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-
-#include "comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 /**
  * comedi_to_pcmcia_dev() - Return PCMCIA device attached to COMEDI device
diff --git a/drivers/comedi/comedi_usb.c b/drivers/comedi/comedi_usb.c
index eea8ebf32ed0..d11ea148ebf8 100644
--- a/drivers/comedi/comedi_usb.c
+++ b/drivers/comedi/comedi_usb.c
@@ -8,8 +8,7 @@
  */
 
 #include <linux/module.h>
-
-#include "comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 /**
  * comedi_to_usb_interface() - Return USB interface attached to COMEDI device
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 750a6ff3c03c..8eb1f699a857 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -17,8 +17,7 @@
 #include <linux/dma-direction.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
-
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include "comedi_internal.h"
 
 struct comedi_driver *comedi_drivers;
diff --git a/drivers/comedi/drivers/8255.c b/drivers/comedi/drivers/8255.c
index e23335c75867..f23a52b7c919 100644
--- a/drivers/comedi/drivers/8255.c
+++ b/drivers/comedi/drivers/8255.c
@@ -40,7 +40,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/8255_pci.c b/drivers/comedi/drivers/8255_pci.c
index 5a810f0e532a..76b8b4762bae 100644
--- a/drivers/comedi/drivers/8255_pci.c
+++ b/drivers/comedi/drivers/8255_pci.c
@@ -53,8 +53,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/addi_apci_1032.c b/drivers/comedi/drivers/addi_apci_1032.c
index 81a246fbcc01..8eec6d9402de 100644
--- a/drivers/comedi/drivers/addi_apci_1032.c
+++ b/drivers/comedi/drivers/addi_apci_1032.c
@@ -63,8 +63,8 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "amcc_s5933.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_1500.c b/drivers/comedi/drivers/addi_apci_1500.c
index b04c15dcfb57..c94c78588889 100644
--- a/drivers/comedi/drivers/addi_apci_1500.c
+++ b/drivers/comedi/drivers/addi_apci_1500.c
@@ -14,8 +14,8 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "amcc_s5933.h"
 #include "z8536.h"
 
diff --git a/drivers/comedi/drivers/addi_apci_1516.c b/drivers/comedi/drivers/addi_apci_1516.c
index 274ec9fb030c..3c48b72dad9d 100644
--- a/drivers/comedi/drivers/addi_apci_1516.c
+++ b/drivers/comedi/drivers/addi_apci_1516.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "addi_watchdog.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_1564.c b/drivers/comedi/drivers/addi_apci_1564.c
index 06fc7ed96200..0cd40948bee7 100644
--- a/drivers/comedi/drivers/addi_apci_1564.c
+++ b/drivers/comedi/drivers/addi_apci_1564.c
@@ -68,8 +68,8 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "addi_tcw.h"
 #include "addi_watchdog.h"
 
diff --git a/drivers/comedi/drivers/addi_apci_16xx.c b/drivers/comedi/drivers/addi_apci_16xx.c
index c306aa41df97..ec2c321d2431 100644
--- a/drivers/comedi/drivers/addi_apci_16xx.c
+++ b/drivers/comedi/drivers/addi_apci_16xx.c
@@ -14,8 +14,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/addi_apci_2032.c b/drivers/comedi/drivers/addi_apci_2032.c
index e9a2b37a4ae0..e048dfc3ec77 100644
--- a/drivers/comedi/drivers/addi_apci_2032.c
+++ b/drivers/comedi/drivers/addi_apci_2032.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "addi_watchdog.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_2200.c b/drivers/comedi/drivers/addi_apci_2200.c
index 4c5aee784bd9..00378c9dddc8 100644
--- a/drivers/comedi/drivers/addi_apci_2200.c
+++ b/drivers/comedi/drivers/addi_apci_2200.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "addi_watchdog.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_3120.c b/drivers/comedi/drivers/addi_apci_3120.c
index 1ed3b33d1a30..28a242e69721 100644
--- a/drivers/comedi/drivers/addi_apci_3120.c
+++ b/drivers/comedi/drivers/addi_apci_3120.c
@@ -14,8 +14,8 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "amcc_s5933.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_3501.c b/drivers/comedi/drivers/addi_apci_3501.c
index f0c9642f3f1a..ecb5552f1785 100644
--- a/drivers/comedi/drivers/addi_apci_3501.c
+++ b/drivers/comedi/drivers/addi_apci_3501.c
@@ -41,8 +41,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/comedi/comedi_pci.h>
 
-#include "../comedi_pci.h"
 #include "amcc_s5933.h"
 
 /*
diff --git a/drivers/comedi/drivers/addi_apci_3xxx.c b/drivers/comedi/drivers/addi_apci_3xxx.c
index a90d59377e18..bc72273e6a29 100644
--- a/drivers/comedi/drivers/addi_apci_3xxx.c
+++ b/drivers/comedi/drivers/addi_apci_3xxx.c
@@ -15,8 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #define CONV_UNIT_NS		BIT(0)
 #define CONV_UNIT_US		BIT(1)
diff --git a/drivers/comedi/drivers/addi_watchdog.c b/drivers/comedi/drivers/addi_watchdog.c
index 69b323fb869f..ed87ab432020 100644
--- a/drivers/comedi/drivers/addi_watchdog.c
+++ b/drivers/comedi/drivers/addi_watchdog.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include "addi_tcw.h"
 #include "addi_watchdog.h"
 
diff --git a/drivers/comedi/drivers/adl_pci6208.c b/drivers/comedi/drivers/adl_pci6208.c
index 9ae4cc523dd4..b27354a51f5c 100644
--- a/drivers/comedi/drivers/adl_pci6208.c
+++ b/drivers/comedi/drivers/adl_pci6208.c
@@ -24,8 +24,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI-6208/6216-GL register map
diff --git a/drivers/comedi/drivers/adl_pci7x3x.c b/drivers/comedi/drivers/adl_pci7x3x.c
index 8fc45638ff59..e9f22de9b6f1 100644
--- a/drivers/comedi/drivers/adl_pci7x3x.c
+++ b/drivers/comedi/drivers/adl_pci7x3x.c
@@ -46,8 +46,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "plx9052.h"
 
diff --git a/drivers/comedi/drivers/adl_pci8164.c b/drivers/comedi/drivers/adl_pci8164.c
index d5e1bda81557..0c513a67a264 100644
--- a/drivers/comedi/drivers/adl_pci8164.c
+++ b/drivers/comedi/drivers/adl_pci8164.c
@@ -19,8 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #define PCI8164_AXIS(x)		((x) * 0x08)
 #define PCI8164_CMD_MSTS_REG	0x00
diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
index a062c5ab20e9..65454f3ecc91 100644
--- a/drivers/comedi/drivers/adl_pci9111.c
+++ b/drivers/comedi/drivers/adl_pci9111.c
@@ -42,8 +42,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "plx9052.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/adl_pci9118.c b/drivers/comedi/drivers/adl_pci9118.c
index cda3a4267dca..248cec3d894f 100644
--- a/drivers/comedi/drivers/adl_pci9118.c
+++ b/drivers/comedi/drivers/adl_pci9118.c
@@ -78,8 +78,7 @@
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "amcc_s5933.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/adq12b.c b/drivers/comedi/drivers/adq12b.c
index d719f76709ef..19d765182006 100644
--- a/drivers/comedi/drivers/adq12b.c
+++ b/drivers/comedi/drivers/adq12b.c
@@ -48,8 +48,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /* address scheme (page 2.17 of the manual) */
 #define ADQ12B_CTREG		0x00
diff --git a/drivers/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
index 090607760be6..47a800d72e58 100644
--- a/drivers/comedi/drivers/adv_pci1710.c
+++ b/drivers/comedi/drivers/adv_pci1710.c
@@ -30,8 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "amcc_s5933.h"
diff --git a/drivers/comedi/drivers/adv_pci1720.c b/drivers/comedi/drivers/adv_pci1720.c
index 2fcd7e8e7d85..2619591ba301 100644
--- a/drivers/comedi/drivers/adv_pci1720.c
+++ b/drivers/comedi/drivers/adv_pci1720.c
@@ -42,8 +42,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI BAR2 Register map (dev->iobase)
diff --git a/drivers/comedi/drivers/adv_pci1723.c b/drivers/comedi/drivers/adv_pci1723.c
index 23660a9fdb9c..e2aedb152068 100644
--- a/drivers/comedi/drivers/adv_pci1723.c
+++ b/drivers/comedi/drivers/adv_pci1723.c
@@ -32,8 +32,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI Bar 2 I/O Register map (dev->iobase)
diff --git a/drivers/comedi/drivers/adv_pci1724.c b/drivers/comedi/drivers/adv_pci1724.c
index e8ab573c839f..bb43b7deeb56 100644
--- a/drivers/comedi/drivers/adv_pci1724.c
+++ b/drivers/comedi/drivers/adv_pci1724.c
@@ -38,8 +38,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI bar 2 Register I/O map (dev->iobase)
diff --git a/drivers/comedi/drivers/adv_pci1760.c b/drivers/comedi/drivers/adv_pci1760.c
index 6de8ab97d346..fcfc2e299110 100644
--- a/drivers/comedi/drivers/adv_pci1760.c
+++ b/drivers/comedi/drivers/adv_pci1760.c
@@ -22,8 +22,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI-1760 Register Map
diff --git a/drivers/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
index 54c7419c8ca6..5947f08b9a1e 100644
--- a/drivers/comedi/drivers/adv_pci_dio.c
+++ b/drivers/comedi/drivers/adv_pci_dio.c
@@ -23,8 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
index 4829115921a3..36c3a2d8a352 100644
--- a/drivers/comedi/drivers/aio_aio12_8.c
+++ b/drivers/comedi/drivers/aio_aio12_8.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 #include "8255.h"
diff --git a/drivers/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
index fe3876235075..b00fab0b89d4 100644
--- a/drivers/comedi/drivers/aio_iiro_16.c
+++ b/drivers/comedi/drivers/aio_iiro_16.c
@@ -30,8 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #define AIO_IIRO_16_RELAY_0_7		0x00
 #define AIO_IIRO_16_INPUT_0_7		0x01
diff --git a/drivers/comedi/drivers/amplc_dio200.c b/drivers/comedi/drivers/amplc_dio200.c
index fa19c9e7c56b..4544bcdd8a70 100644
--- a/drivers/comedi/drivers/amplc_dio200.c
+++ b/drivers/comedi/drivers/amplc_dio200.c
@@ -185,7 +185,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "amplc_dio200.h"
 
diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index a3454130d5f8..950c50be4ff3 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -12,8 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "amplc_dio200.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/amplc_dio200_pci.c b/drivers/comedi/drivers/amplc_dio200_pci.c
index 1bd7a42c8464..527994d82a1f 100644
--- a/drivers/comedi/drivers/amplc_dio200_pci.c
+++ b/drivers/comedi/drivers/amplc_dio200_pci.c
@@ -214,8 +214,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "amplc_dio200.h"
 
diff --git a/drivers/comedi/drivers/amplc_pc236.c b/drivers/comedi/drivers/amplc_pc236.c
index c377af1d5246..b21e0c906aab 100644
--- a/drivers/comedi/drivers/amplc_pc236.c
+++ b/drivers/comedi/drivers/amplc_pc236.c
@@ -32,8 +32,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "amplc_pc236.h"
 
diff --git a/drivers/comedi/drivers/amplc_pc236_common.c b/drivers/comedi/drivers/amplc_pc236_common.c
index 981d281e87a1..b8b0a624f72b 100644
--- a/drivers/comedi/drivers/amplc_pc236_common.c
+++ b/drivers/comedi/drivers/amplc_pc236_common.c
@@ -11,8 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "amplc_pc236.h"
 #include "8255.h"
diff --git a/drivers/comedi/drivers/amplc_pc263.c b/drivers/comedi/drivers/amplc_pc263.c
index 68da6098ee84..d7f088a8a5e3 100644
--- a/drivers/comedi/drivers/amplc_pc263.c
+++ b/drivers/comedi/drivers/amplc_pc263.c
@@ -25,7 +25,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /* PC263 registers */
 #define PC263_DO_0_7_REG	0x00
diff --git a/drivers/comedi/drivers/amplc_pci224.c b/drivers/comedi/drivers/amplc_pci224.c
index bcf6d61af863..3cf1b7fa565d 100644
--- a/drivers/comedi/drivers/amplc_pci224.c
+++ b/drivers/comedi/drivers/amplc_pci224.c
@@ -96,8 +96,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
index 8911dc2bd2c6..554ee40e321f 100644
--- a/drivers/comedi/drivers/amplc_pci230.c
+++ b/drivers/comedi/drivers/amplc_pci230.c
@@ -174,8 +174,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "8255.h"
diff --git a/drivers/comedi/drivers/amplc_pci236.c b/drivers/comedi/drivers/amplc_pci236.c
index e7f6fa4d101a..482eb261c333 100644
--- a/drivers/comedi/drivers/amplc_pci236.c
+++ b/drivers/comedi/drivers/amplc_pci236.c
@@ -34,8 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "amplc_pc236.h"
 #include "plx9052.h"
diff --git a/drivers/comedi/drivers/amplc_pci263.c b/drivers/comedi/drivers/amplc_pci263.c
index 9217973f1141..1609665c4b18 100644
--- a/drivers/comedi/drivers/amplc_pci263.c
+++ b/drivers/comedi/drivers/amplc_pci263.c
@@ -24,8 +24,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /* PCI263 registers */
 #define PCI263_DO_0_7_REG	0x00
diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 786fd15698df..14b90d1c64dc 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -30,8 +30,7 @@
 #include <linux/timer.h>
 #include <linux/io.h>
 #include <linux/pnp.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/cb_das16_cs.c b/drivers/comedi/drivers/cb_das16_cs.c
index a5d171e71c33..190d73a7d12c 100644
--- a/drivers/comedi/drivers/cb_das16_cs.c
+++ b/drivers/comedi/drivers/cb_das16_cs.c
@@ -27,8 +27,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
index 2f20bd56ec6c..9b603532a4e7 100644
--- a/drivers/comedi/drivers/cb_pcidas.c
+++ b/drivers/comedi/drivers/cb_pcidas.c
@@ -54,8 +54,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "8255.h"
diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
index 41a8fea7f48a..7d4808faa1fb 100644
--- a/drivers/comedi/drivers/cb_pcidas64.c
+++ b/drivers/comedi/drivers/cb_pcidas64.c
@@ -73,8 +73,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 #include "plx9080.h"
diff --git a/drivers/comedi/drivers/cb_pcidda.c b/drivers/comedi/drivers/cb_pcidda.c
index 78cf1603638c..4ed3bcf47973 100644
--- a/drivers/comedi/drivers/cb_pcidda.c
+++ b/drivers/comedi/drivers/cb_pcidda.c
@@ -27,8 +27,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
index 2292f69da4f4..64c7d72c7956 100644
--- a/drivers/comedi/drivers/cb_pcimdas.c
+++ b/drivers/comedi/drivers/cb_pcimdas.c
@@ -34,8 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "plx9052.h"
diff --git a/drivers/comedi/drivers/cb_pcimdda.c b/drivers/comedi/drivers/cb_pcimdda.c
index 21fc7b3c5f60..69d7803b0e58 100644
--- a/drivers/comedi/drivers/cb_pcimdda.c
+++ b/drivers/comedi/drivers/cb_pcimdda.c
@@ -67,8 +67,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index 4bf5daa9e885..fac81567133d 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -116,8 +116,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
index b7ca465933ee..10614603d677 100644
--- a/drivers/comedi/drivers/comedi_8255.c
+++ b/drivers/comedi/drivers/comedi_8255.c
@@ -29,7 +29,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/drivers/comedi_bond.c
index 4392b5927a99..78c39fa84177 100644
--- a/drivers/comedi/drivers/comedi_bond.c
+++ b/drivers/comedi/drivers/comedi_bond.c
@@ -40,9 +40,9 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include "../comedi.h"
-#include "../comedilib.h"
-#include "../comedidev.h"
+#include <linux/comedi.h>
+#include <linux/comedi/comedilib.h>
+#include <linux/comedi/comedidev.h>
 
 struct bonded_device {
 	struct comedi_device *dev;
diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
index 479b58e209ba..63457bd4ff78 100644
--- a/drivers/comedi/drivers/comedi_isadma.c
+++ b/drivers/comedi/drivers/comedi_isadma.c
@@ -9,8 +9,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <asm/dma.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 
diff --git a/drivers/comedi/drivers/comedi_parport.c b/drivers/comedi/drivers/comedi_parport.c
index 5338b5eea440..098738a688fe 100644
--- a/drivers/comedi/drivers/comedi_parport.c
+++ b/drivers/comedi/drivers/comedi_parport.c
@@ -57,8 +57,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index cbc225eb1991..0b5c0af1cebf 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -45,10 +45,8 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <asm/div64.h>
-
 #include <linux/timer.h>
 #include <linux/ktime.h>
 #include <linux/jiffies.h>
diff --git a/drivers/comedi/drivers/contec_pci_dio.c b/drivers/comedi/drivers/contec_pci_dio.c
index b8fdd9c1f166..41d42ff14144 100644
--- a/drivers/comedi/drivers/contec_pci_dio.c
+++ b/drivers/comedi/drivers/contec_pci_dio.c
@@ -18,8 +18,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/dac02.c b/drivers/comedi/drivers/dac02.c
index 5ef8114c2c85..4b011d66d7b0 100644
--- a/drivers/comedi/drivers/dac02.c
+++ b/drivers/comedi/drivers/dac02.c
@@ -25,8 +25,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * The output range is selected by jumpering pins on the I/O connector.
diff --git a/drivers/comedi/drivers/daqboard2000.c b/drivers/comedi/drivers/daqboard2000.c
index f64e747078bd..52e4bf16cbda 100644
--- a/drivers/comedi/drivers/daqboard2000.c
+++ b/drivers/comedi/drivers/daqboard2000.c
@@ -96,8 +96,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "8255.h"
 #include "plx9080.h"
diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index b50743c5b822..c146a168f43b 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -10,8 +10,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/das08_cs.c b/drivers/comedi/drivers/das08_cs.c
index 223479f9ea3c..6075efcf10d6 100644
--- a/drivers/comedi/drivers/das08_cs.c
+++ b/drivers/comedi/drivers/das08_cs.c
@@ -30,8 +30,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 #include "das08.h"
 
diff --git a/drivers/comedi/drivers/das08_isa.c b/drivers/comedi/drivers/das08_isa.c
index 8c4cfa821423..3d43b77cc9f4 100644
--- a/drivers/comedi/drivers/das08_isa.c
+++ b/drivers/comedi/drivers/das08_isa.c
@@ -29,7 +29,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "das08.h"
 
diff --git a/drivers/comedi/drivers/das08_pci.c b/drivers/comedi/drivers/das08_pci.c
index 1cd903336a4c..982f3ab0ccbd 100644
--- a/drivers/comedi/drivers/das08_pci.c
+++ b/drivers/comedi/drivers/das08_pci.c
@@ -23,8 +23,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "das08.h"
 
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 4ac2622b0fac..362232ad4409 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -63,8 +63,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index 75f3dbbe97ac..cc79e318cb2d 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -42,7 +42,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index f50891a6ee7d..768803742350 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -73,8 +73,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/das6402.c b/drivers/comedi/drivers/das6402.c
index 96f4107b8054..d411ab7cf37c 100644
--- a/drivers/comedi/drivers/das6402.c
+++ b/drivers/comedi/drivers/das6402.c
@@ -24,8 +24,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/das800.c b/drivers/comedi/drivers/das800.c
index bc08324f422f..c95e0fcb94a4 100644
--- a/drivers/comedi/drivers/das800.c
+++ b/drivers/comedi/drivers/das800.c
@@ -46,8 +46,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/dmm32at.c b/drivers/comedi/drivers/dmm32at.c
index 56682f01242f..0f2bea88b8a7 100644
--- a/drivers/comedi/drivers/dmm32at.c
+++ b/drivers/comedi/drivers/dmm32at.c
@@ -29,7 +29,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/dt2801.c b/drivers/comedi/drivers/dt2801.c
index 0d571d817b4e..230d25010f58 100644
--- a/drivers/comedi/drivers/dt2801.c
+++ b/drivers/comedi/drivers/dt2801.c
@@ -31,7 +31,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include <linux/delay.h>
 
 #define DT2801_TIMEOUT 1000
diff --git a/drivers/comedi/drivers/dt2811.c b/drivers/comedi/drivers/dt2811.c
index 0eb5e6ba6916..dbb9f38da289 100644
--- a/drivers/comedi/drivers/dt2811.c
+++ b/drivers/comedi/drivers/dt2811.c
@@ -40,8 +40,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/dt2814.c b/drivers/comedi/drivers/dt2814.c
index ed44ce0d151b..c98a5a4a7aec 100644
--- a/drivers/comedi/drivers/dt2814.c
+++ b/drivers/comedi/drivers/dt2814.c
@@ -27,8 +27,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <linux/delay.h>
 
 #define DT2814_CSR 0
diff --git a/drivers/comedi/drivers/dt2815.c b/drivers/comedi/drivers/dt2815.c
index 5906f32aa01f..03ba2fd18a21 100644
--- a/drivers/comedi/drivers/dt2815.c
+++ b/drivers/comedi/drivers/dt2815.c
@@ -43,8 +43,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <linux/delay.h>
 
 #define DT2815_DATA 0
diff --git a/drivers/comedi/drivers/dt2817.c b/drivers/comedi/drivers/dt2817.c
index 7c1463e835d3..6738045c7531 100644
--- a/drivers/comedi/drivers/dt2817.c
+++ b/drivers/comedi/drivers/dt2817.c
@@ -25,7 +25,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #define DT2817_CR 0
 #define DT2817_DATA 1
diff --git a/drivers/comedi/drivers/dt282x.c b/drivers/comedi/drivers/dt282x.c
index 2656b4b0e3d0..078f8fba7183 100644
--- a/drivers/comedi/drivers/dt282x.c
+++ b/drivers/comedi/drivers/dt282x.c
@@ -51,8 +51,7 @@
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 
diff --git a/drivers/comedi/drivers/dt3000.c b/drivers/comedi/drivers/dt3000.c
index ec27aa4730d4..fc6e9c30e522 100644
--- a/drivers/comedi/drivers/dt3000.c
+++ b/drivers/comedi/drivers/dt3000.c
@@ -43,8 +43,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI BAR0 - dual-ported RAM location definitions (dev->mmio)
diff --git a/drivers/comedi/drivers/dt9812.c b/drivers/comedi/drivers/dt9812.c
index 704b04d2980d..b37b9d8eca0d 100644
--- a/drivers/comedi/drivers/dt9812.c
+++ b/drivers/comedi/drivers/dt9812.c
@@ -34,8 +34,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 #define DT9812_DIAGS_BOARD_INFO_ADDR	0xFBFF
 #define DT9812_MAX_WRITE_CMD_PIPE_SIZE	32
diff --git a/drivers/comedi/drivers/dyna_pci10xx.c b/drivers/comedi/drivers/dyna_pci10xx.c
index c224422bb126..407a038fb3e0 100644
--- a/drivers/comedi/drivers/dyna_pci10xx.c
+++ b/drivers/comedi/drivers/dyna_pci10xx.c
@@ -26,8 +26,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #define READ_TIMEOUT 50
 
diff --git a/drivers/comedi/drivers/fl512.c b/drivers/comedi/drivers/fl512.c
index b715f30659fa..139e801fc358 100644
--- a/drivers/comedi/drivers/fl512.c
+++ b/drivers/comedi/drivers/fl512.c
@@ -21,8 +21,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <linux/delay.h>
 
 /*
diff --git a/drivers/comedi/drivers/gsc_hpdi.c b/drivers/comedi/drivers/gsc_hpdi.c
index e35e4a743714..c09d135df38d 100644
--- a/drivers/comedi/drivers/gsc_hpdi.c
+++ b/drivers/comedi/drivers/gsc_hpdi.c
@@ -34,8 +34,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "plx9080.h"
 
diff --git a/drivers/comedi/drivers/icp_multi.c b/drivers/comedi/drivers/icp_multi.c
index 16d2b78de83c..ac4b11dbd741 100644
--- a/drivers/comedi/drivers/icp_multi.c
+++ b/drivers/comedi/drivers/icp_multi.c
@@ -36,8 +36,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #define ICP_MULTI_ADC_CSR	0x00	/* R/W: ADC command/status register */
 #define ICP_MULTI_ADC_CSR_ST	BIT(0)	/* Start ADC */
diff --git a/drivers/comedi/drivers/ii_pci20kc.c b/drivers/comedi/drivers/ii_pci20kc.c
index 399255dbe388..4a19bf8462be 100644
--- a/drivers/comedi/drivers/ii_pci20kc.c
+++ b/drivers/comedi/drivers/ii_pci20kc.c
@@ -30,7 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/io.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index f963080dd61f..951c23fa0369 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -35,8 +35,7 @@
 #include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "jr3_pci.h"
 
diff --git a/drivers/comedi/drivers/ke_counter.c b/drivers/comedi/drivers/ke_counter.c
index bef1b20c1c8d..b825cf60e1e0 100644
--- a/drivers/comedi/drivers/ke_counter.c
+++ b/drivers/comedi/drivers/ke_counter.c
@@ -19,8 +19,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI BAR 0 Register I/O map
diff --git a/drivers/comedi/drivers/me4000.c b/drivers/comedi/drivers/me4000.c
index 0d3d4cafce2e..c5dc8199771f 100644
--- a/drivers/comedi/drivers/me4000.c
+++ b/drivers/comedi/drivers/me4000.c
@@ -32,8 +32,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "plx9052.h"
diff --git a/drivers/comedi/drivers/me_daq.c b/drivers/comedi/drivers/me_daq.c
index ef18e387471b..076b15097afd 100644
--- a/drivers/comedi/drivers/me_daq.c
+++ b/drivers/comedi/drivers/me_daq.c
@@ -23,8 +23,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "plx9052.h"
 
diff --git a/drivers/comedi/drivers/mf6x4.c b/drivers/comedi/drivers/mf6x4.c
index 9da8dd748078..14f1d5e9cd59 100644
--- a/drivers/comedi/drivers/mf6x4.c
+++ b/drivers/comedi/drivers/mf6x4.c
@@ -18,8 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /* Registers present in BAR0 memory region */
 #define MF624_GPIOC_REG		0x54
diff --git a/drivers/comedi/drivers/mite.c b/drivers/comedi/drivers/mite.c
index 70960e3ba878..88f3cd6f54f1 100644
--- a/drivers/comedi/drivers/mite.c
+++ b/drivers/comedi/drivers/mite.c
@@ -38,8 +38,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "mite.h"
 
diff --git a/drivers/comedi/drivers/mpc624.c b/drivers/comedi/drivers/mpc624.c
index 646f4c086204..9e51ff528ed1 100644
--- a/drivers/comedi/drivers/mpc624.c
+++ b/drivers/comedi/drivers/mpc624.c
@@ -44,8 +44,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <linux/delay.h>
 
 /* Offsets of different ports */
diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
index c1897aee9a9a..07ff5383da99 100644
--- a/drivers/comedi/drivers/multiq3.c
+++ b/drivers/comedi/drivers/multiq3.c
@@ -26,8 +26,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/ni_6527.c b/drivers/comedi/drivers/ni_6527.c
index f1a45cf7342a..ac5820085231 100644
--- a/drivers/comedi/drivers/ni_6527.c
+++ b/drivers/comedi/drivers/ni_6527.c
@@ -20,8 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI BAR1 - Register memory map
diff --git a/drivers/comedi/drivers/ni_65xx.c b/drivers/comedi/drivers/ni_65xx.c
index 7cd8497420f2..58334de3b253 100644
--- a/drivers/comedi/drivers/ni_65xx.c
+++ b/drivers/comedi/drivers/ni_65xx.c
@@ -49,8 +49,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 /*
  * PCI BAR1 Register Map
diff --git a/drivers/comedi/drivers/ni_660x.c b/drivers/comedi/drivers/ni_660x.c
index e60d0125bcb2..0679bc39e0bc 100644
--- a/drivers/comedi/drivers/ni_660x.c
+++ b/drivers/comedi/drivers/ni_660x.c
@@ -26,8 +26,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "mite.h"
 #include "ni_tio.h"
diff --git a/drivers/comedi/drivers/ni_670x.c b/drivers/comedi/drivers/ni_670x.c
index c197e47486be..c875d251c230 100644
--- a/drivers/comedi/drivers/ni_670x.c
+++ b/drivers/comedi/drivers/ni_670x.c
@@ -24,8 +24,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #define AO_VALUE_OFFSET			0x00
 #define	AO_CHAN_OFFSET			0x0c
diff --git a/drivers/comedi/drivers/ni_at_a2150.c b/drivers/comedi/drivers/ni_at_a2150.c
index 10ad7b88713e..ce5de58c499f 100644
--- a/drivers/comedi/drivers/ni_at_a2150.c
+++ b/drivers/comedi/drivers/ni_at_a2150.c
@@ -39,8 +39,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/ni_at_ao.c b/drivers/comedi/drivers/ni_at_ao.c
index 2a0fb4d460db..a06dfb9da329 100644
--- a/drivers/comedi/drivers/ni_at_ao.c
+++ b/drivers/comedi/drivers/ni_at_ao.c
@@ -25,8 +25,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 56c78da475e7..f60a4e459a98 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -73,8 +73,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
-
+#include <linux/comedi/comedidev.h>
 #include <linux/isapnp.h>
 
 #include "ni_stc.h"
diff --git a/drivers/comedi/drivers/ni_atmio16d.c b/drivers/comedi/drivers/ni_atmio16d.c
index dffce1aa3e69..0bd4f88a2ac8 100644
--- a/drivers/comedi/drivers/ni_atmio16d.c
+++ b/drivers/comedi/drivers/ni_atmio16d.c
@@ -39,7 +39,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/ni_daq_700.c b/drivers/comedi/drivers/ni_daq_700.c
index d40fc89f9cef..0ef20e9a8bc4 100644
--- a/drivers/comedi/drivers/ni_daq_700.c
+++ b/drivers/comedi/drivers/ni_daq_700.c
@@ -41,8 +41,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 /* daqcard700 registers */
 #define DIO_W		0x04	/* WO 8bit */
diff --git a/drivers/comedi/drivers/ni_daq_dio24.c b/drivers/comedi/drivers/ni_daq_dio24.c
index 44fb65afc218..84d78f2ee5ac 100644
--- a/drivers/comedi/drivers/ni_daq_dio24.c
+++ b/drivers/comedi/drivers/ni_daq_dio24.c
@@ -23,7 +23,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/ni_labpc.c b/drivers/comedi/drivers/ni_labpc.c
index 1f4a07bd1d26..b25a8e117072 100644
--- a/drivers/comedi/drivers/ni_labpc.c
+++ b/drivers/comedi/drivers/ni_labpc.c
@@ -48,8 +48,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "ni_labpc.h"
 #include "ni_labpc_isadma.h"
diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index dd97946eacaf..7c4687226450 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 #include "8255.h"
diff --git a/drivers/comedi/drivers/ni_labpc_cs.c b/drivers/comedi/drivers/ni_labpc_cs.c
index 4f7e2fe21254..62fecb50ec6e 100644
--- a/drivers/comedi/drivers/ni_labpc_cs.c
+++ b/drivers/comedi/drivers/ni_labpc_cs.c
@@ -38,8 +38,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 #include "ni_labpc.h"
 
diff --git a/drivers/comedi/drivers/ni_labpc_isadma.c b/drivers/comedi/drivers/ni_labpc_isadma.c
index a551aca6e615..dd37ec0d9b15 100644
--- a/drivers/comedi/drivers/ni_labpc_isadma.c
+++ b/drivers/comedi/drivers/ni_labpc_isadma.c
@@ -10,8 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "ni_labpc.h"
diff --git a/drivers/comedi/drivers/ni_labpc_pci.c b/drivers/comedi/drivers/ni_labpc_pci.c
index ec180b0fedf7..e2a44bbd9fa6 100644
--- a/drivers/comedi/drivers/ni_labpc_pci.c
+++ b/drivers/comedi/drivers/ni_labpc_pci.c
@@ -22,8 +22,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "ni_labpc.h"
 
diff --git a/drivers/comedi/drivers/ni_mio_cs.c b/drivers/comedi/drivers/ni_mio_cs.c
index 4f37b4e58f09..bd967cdb2036 100644
--- a/drivers/comedi/drivers/ni_mio_cs.c
+++ b/drivers/comedi/drivers/ni_mio_cs.c
@@ -28,8 +28,8 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/comedi/comedi_pcmcia.h>
 
-#include "../comedi_pcmcia.h"
 #include "ni_stc.h"
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/ni_pcidio.c b/drivers/comedi/drivers/ni_pcidio.c
index 623f8d08d13a..2d58e83420e8 100644
--- a/drivers/comedi/drivers/ni_pcidio.c
+++ b/drivers/comedi/drivers/ni_pcidio.c
@@ -42,8 +42,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "mite.h"
 
diff --git a/drivers/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
index 6c813a490ba5..0b055321023d 100644
--- a/drivers/comedi/drivers/ni_pcimio.c
+++ b/drivers/comedi/drivers/ni_pcimio.c
@@ -94,9 +94,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-
-#include "../comedi_pci.h"
-
+#include <linux/comedi/comedi_pci.h>
 #include <asm/byteorder.h>
 
 #include "ni_stc.h"
diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
index f0f8cd424b30..f24eeb464eba 100644
--- a/drivers/comedi/drivers/ni_routes.c
+++ b/drivers/comedi/drivers/ni_routes.c
@@ -21,8 +21,7 @@
 #include <linux/slab.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
-
-#include "../comedi.h"
+#include <linux/comedi.h>
 
 #include "ni_routes.h"
 #include "ni_routing/ni_route_values.h"
diff --git a/drivers/comedi/drivers/ni_routes.h b/drivers/comedi/drivers/ni_routes.h
index 036982315584..cff8a463a03f 100644
--- a/drivers/comedi/drivers/ni_routes.h
+++ b/drivers/comedi/drivers/ni_routes.h
@@ -27,7 +27,7 @@
 #include <linux/bitops.h>
 #endif
 
-#include "../comedi.h"
+#include <linux/comedi.h>
 
 /**
  * struct ni_route_set - Set of destinations with a common source.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values.h b/drivers/comedi/drivers/ni_routing/ni_route_values.h
index 6e358efa6f7f..80880083ea41 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values.h
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values.h
@@ -20,7 +20,7 @@
 #ifndef _COMEDI_DRIVERS_NI_ROUTINT_NI_ROUTE_VALUES_H
 #define _COMEDI_DRIVERS_NI_ROUTINT_NI_ROUTE_VALUES_H
 
-#include "../../comedi.h"
+#include <linux/comedi.h>
 #include <linux/types.h>
 
 /*
diff --git a/drivers/comedi/drivers/ni_tio.h b/drivers/comedi/drivers/ni_tio.h
index e7b05718df9b..9ae2221c3c18 100644
--- a/drivers/comedi/drivers/ni_tio.h
+++ b/drivers/comedi/drivers/ni_tio.h
@@ -8,7 +8,7 @@
 #ifndef _COMEDI_NI_TIO_H
 #define _COMEDI_NI_TIO_H
 
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 enum ni_gpct_register {
 	NITIO_G0_AUTO_INC,
diff --git a/drivers/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
index c42987b74b1d..0dd9edf7bced 100644
--- a/drivers/comedi/drivers/ni_usb6501.c
+++ b/drivers/comedi/drivers/ni_usb6501.c
@@ -87,8 +87,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 #define	NI6501_TIMEOUT	1000
 
diff --git a/drivers/comedi/drivers/pcl711.c b/drivers/comedi/drivers/pcl711.c
index bd6f42fe9e3c..f1c383bd9d87 100644
--- a/drivers/comedi/drivers/pcl711.c
+++ b/drivers/comedi/drivers/pcl711.c
@@ -29,8 +29,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_8254.h"
 
diff --git a/drivers/comedi/drivers/pcl724.c b/drivers/comedi/drivers/pcl724.c
index 1a5799278a7a..b3f472c93e80 100644
--- a/drivers/comedi/drivers/pcl724.c
+++ b/drivers/comedi/drivers/pcl724.c
@@ -25,7 +25,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/pcl726.c b/drivers/comedi/drivers/pcl726.c
index 88f25d7e76f7..0430630e6ebb 100644
--- a/drivers/comedi/drivers/pcl726.c
+++ b/drivers/comedi/drivers/pcl726.c
@@ -50,8 +50,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #define PCL726_AO_MSB_REG(x)	(0x00 + ((x) * 2))
 #define PCL726_AO_LSB_REG(x)	(0x01 + ((x) * 2))
diff --git a/drivers/comedi/drivers/pcl730.c b/drivers/comedi/drivers/pcl730.c
index 32a29129e6e8..d2733cd5383d 100644
--- a/drivers/comedi/drivers/pcl730.c
+++ b/drivers/comedi/drivers/pcl730.c
@@ -25,7 +25,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index b87ab3840eee..f00976ddfc2a 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -114,8 +114,7 @@
 #include <linux/gfp.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/pcl816.c b/drivers/comedi/drivers/pcl816.c
index c368a337a0ae..c5acdc8913f8 100644
--- a/drivers/comedi/drivers/pcl816.c
+++ b/drivers/comedi/drivers/pcl816.c
@@ -35,8 +35,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index f4b4a686c710..20fcd6d588f8 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -97,8 +97,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "comedi_isadma.h"
 #include "comedi_8254.h"
diff --git a/drivers/comedi/drivers/pcm3724.c b/drivers/comedi/drivers/pcm3724.c
index 0cb1ad060402..93ae6cffed44 100644
--- a/drivers/comedi/drivers/pcm3724.c
+++ b/drivers/comedi/drivers/pcm3724.c
@@ -24,7 +24,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #include "8255.h"
 
diff --git a/drivers/comedi/drivers/pcmad.c b/drivers/comedi/drivers/pcmad.c
index eec89a0afb2f..976eda43881b 100644
--- a/drivers/comedi/drivers/pcmad.c
+++ b/drivers/comedi/drivers/pcmad.c
@@ -29,7 +29,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 #define PCMAD_STATUS		0
 #define PCMAD_LSB		1
diff --git a/drivers/comedi/drivers/pcmda12.c b/drivers/comedi/drivers/pcmda12.c
index 14ab1f0d1e9f..611f13bedca0 100644
--- a/drivers/comedi/drivers/pcmda12.c
+++ b/drivers/comedi/drivers/pcmda12.c
@@ -40,7 +40,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /* AI range is not configurable, it's set by jumpers on the board */
 static const struct comedi_lrange pcmda12_ranges = {
diff --git a/drivers/comedi/drivers/pcmmio.c b/drivers/comedi/drivers/pcmmio.c
index 24a9568d3378..c2402239d551 100644
--- a/drivers/comedi/drivers/pcmmio.c
+++ b/drivers/comedi/drivers/pcmmio.c
@@ -66,8 +66,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/pcmuio.c b/drivers/comedi/drivers/pcmuio.c
index b299d648a0eb..33b24dbbb919 100644
--- a/drivers/comedi/drivers/pcmuio.c
+++ b/drivers/comedi/drivers/pcmuio.c
@@ -65,8 +65,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
-
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/quatech_daqp_cs.c b/drivers/comedi/drivers/quatech_daqp_cs.c
index fe4408ebf6b3..2a76c75c513b 100644
--- a/drivers/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/comedi/drivers/quatech_daqp_cs.c
@@ -41,8 +41,7 @@
  */
 
 #include <linux/module.h>
-
-#include "../comedi_pcmcia.h"
+#include <linux/comedi/comedi_pcmcia.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/rtd520.c b/drivers/comedi/drivers/rtd520.c
index 2d99a648b054..ee5bca2b1c09 100644
--- a/drivers/comedi/drivers/rtd520.c
+++ b/drivers/comedi/drivers/rtd520.c
@@ -85,8 +85,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "comedi_8254.h"
 #include "plx9080.h"
diff --git a/drivers/comedi/drivers/rti800.c b/drivers/comedi/drivers/rti800.c
index 327fd93b8b12..1b02e47bdb4c 100644
--- a/drivers/comedi/drivers/rti800.c
+++ b/drivers/comedi/drivers/rti800.c
@@ -42,7 +42,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/rti802.c b/drivers/comedi/drivers/rti802.c
index 195e2b1ac4c1..d66762a22258 100644
--- a/drivers/comedi/drivers/rti802.c
+++ b/drivers/comedi/drivers/rti802.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/s526.c b/drivers/comedi/drivers/s526.c
index 085cf5b449e5..9245c679a3c4 100644
--- a/drivers/comedi/drivers/s526.c
+++ b/drivers/comedi/drivers/s526.c
@@ -27,7 +27,7 @@
  */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/s626.c b/drivers/comedi/drivers/s626.c
index e7aba937d896..0e5f9a9a7fd3 100644
--- a/drivers/comedi/drivers/s626.c
+++ b/drivers/comedi/drivers/s626.c
@@ -55,8 +55,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-
-#include "../comedi_pci.h"
+#include <linux/comedi/comedi_pci.h>
 
 #include "s626.h"
 
diff --git a/drivers/comedi/drivers/ssv_dnp.c b/drivers/comedi/drivers/ssv_dnp.c
index 016d315aa584..813bd0853b0b 100644
--- a/drivers/comedi/drivers/ssv_dnp.c
+++ b/drivers/comedi/drivers/ssv_dnp.c
@@ -19,7 +19,7 @@
 /* include files ----------------------------------------------------------- */
 
 #include <linux/module.h>
-#include "../comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /* Some global definitions: the registers of the DNP ----------------------- */
 /*                                                                           */
diff --git a/drivers/comedi/drivers/usbdux.c b/drivers/comedi/drivers/usbdux.c
index 0350f303d557..92d514b3c1c3 100644
--- a/drivers/comedi/drivers/usbdux.c
+++ b/drivers/comedi/drivers/usbdux.c
@@ -73,8 +73,7 @@
 #include <linux/input.h>
 #include <linux/fcntl.h>
 #include <linux/compiler.h>
-
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 /* constants for firmware upload and download */
 #define USBDUX_FIRMWARE		"usbdux_firmware.bin"
diff --git a/drivers/comedi/drivers/usbduxfast.c b/drivers/comedi/drivers/usbduxfast.c
index 4af012968cb6..39faae0ecb19 100644
--- a/drivers/comedi/drivers/usbduxfast.c
+++ b/drivers/comedi/drivers/usbduxfast.c
@@ -40,7 +40,7 @@
 #include <linux/input.h>
 #include <linux/fcntl.h>
 #include <linux/compiler.h>
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 /*
  * timeout for the USB-transfer
diff --git a/drivers/comedi/drivers/usbduxsigma.c b/drivers/comedi/drivers/usbduxsigma.c
index 54d7605e909f..2aaeaf44fbe5 100644
--- a/drivers/comedi/drivers/usbduxsigma.c
+++ b/drivers/comedi/drivers/usbduxsigma.c
@@ -40,8 +40,7 @@
 #include <linux/fcntl.h>
 #include <linux/compiler.h>
 #include <asm/unaligned.h>
-
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 /* timeout for the USB-transfer in ms*/
 #define BULK_TIMEOUT 1000
diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 4b00a9ea611a..46023adc5395 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -35,8 +35,7 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/uaccess.h>
-
-#include "../comedi_usb.h"
+#include <linux/comedi/comedi_usb.h>
 
 enum {
 	DEVICE_VMK8055,
diff --git a/drivers/comedi/kcomedilib/kcomedilib_main.c b/drivers/comedi/kcomedilib/kcomedilib_main.c
index df9bba1b69ed..43fbe1a63b14 100644
--- a/drivers/comedi/kcomedilib/kcomedilib_main.c
+++ b/drivers/comedi/kcomedilib/kcomedilib_main.c
@@ -16,9 +16,9 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-#include "../comedi.h"
-#include "../comedilib.h"
-#include "../comedidev.h"
+#include <linux/comedi.h>
+#include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedilib.h>
 
 MODULE_AUTHOR("David Schleef <ds@schleef.org>");
 MODULE_DESCRIPTION("Comedi kernel library");
diff --git a/drivers/comedi/proc.c b/drivers/comedi/proc.c
index 8bc8e42beb90..2e4496633d3d 100644
--- a/drivers/comedi/proc.c
+++ b/drivers/comedi/proc.c
@@ -13,7 +13,7 @@
  * was cool.
  */
 
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include "comedi_internal.h"
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/drivers/comedi/range.c b/drivers/comedi/range.c
index a4e6fe0fb729..8f43cf88d784 100644
--- a/drivers/comedi/range.c
+++ b/drivers/comedi/range.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/uaccess.h>
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 #include "comedi_internal.h"
 
 const struct comedi_lrange range_bipolar10 = { 1, {BIP_RANGE(10)} };
diff --git a/drivers/comedi/comedi_pci.h b/include/linux/comedi/comedi_pci.h
similarity index 98%
rename from drivers/comedi/comedi_pci.h
rename to include/linux/comedi/comedi_pci.h
index 4e069440cbdc..2fb50663e3ed 100644
--- a/drivers/comedi/comedi_pci.h
+++ b/include/linux/comedi/comedi_pci.h
@@ -11,8 +11,7 @@
 #define _COMEDI_PCI_H
 
 #include <linux/pci.h>
-
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 /*
  * PCI Vendor IDs not in <linux/pci_ids.h>
diff --git a/drivers/comedi/comedi_pcmcia.h b/include/linux/comedi/comedi_pcmcia.h
similarity index 97%
rename from drivers/comedi/comedi_pcmcia.h
rename to include/linux/comedi/comedi_pcmcia.h
index f2f6e779645b..a33dfb65b869 100644
--- a/drivers/comedi/comedi_pcmcia.h
+++ b/include/linux/comedi/comedi_pcmcia.h
@@ -12,8 +12,7 @@
 
 #include <pcmcia/cistpl.h>
 #include <pcmcia/ds.h>
-
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 struct pcmcia_device *comedi_to_pcmcia_dev(struct comedi_device *dev);
 
diff --git a/drivers/comedi/comedi_usb.h b/include/linux/comedi/comedi_usb.h
similarity index 97%
rename from drivers/comedi/comedi_usb.h
rename to include/linux/comedi/comedi_usb.h
index 601e29d3891c..5d17dd425bd2 100644
--- a/drivers/comedi/comedi_usb.h
+++ b/include/linux/comedi/comedi_usb.h
@@ -10,8 +10,7 @@
 #define _COMEDI_USB_H
 
 #include <linux/usb.h>
-
-#include "comedidev.h"
+#include <linux/comedi/comedidev.h>
 
 struct usb_interface *comedi_to_usb_interface(struct comedi_device *dev);
 struct usb_device *comedi_to_usb_dev(struct comedi_device *dev);
diff --git a/drivers/comedi/comedidev.h b/include/linux/comedi/comedidev.h
similarity index 99%
rename from drivers/comedi/comedidev.h
rename to include/linux/comedi/comedidev.h
index 0e1b95ef9a4d..0a1150900ef3 100644
--- a/drivers/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -15,8 +15,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
-
-#include "comedi.h"
+#include <linux/comedi.h>
 
 #define COMEDI_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + (c))
 #define COMEDI_VERSION_CODE COMEDI_VERSION(COMEDI_MAJORVERSION, \
diff --git a/drivers/comedi/comedilib.h b/include/linux/comedi/comedilib.h
similarity index 100%
rename from drivers/comedi/comedilib.h
rename to include/linux/comedi/comedilib.h
diff --git a/drivers/comedi/comedi.h b/include/uapi/linux/comedi.h
similarity index 99%
rename from drivers/comedi/comedi.h
rename to include/uapi/linux/comedi.h
index b5d00a006dbb..7314e5ee0a1e 100644
--- a/drivers/comedi/comedi.h
+++ b/include/uapi/linux/comedi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: LGPL-2.0+ */
+/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
 /*
  * comedi.h
  * header file for COMEDI user API
-- 
2.33.0

