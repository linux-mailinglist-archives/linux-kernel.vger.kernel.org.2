Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3732238CC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhEURaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:30:05 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:49352 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEURaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:30:03 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 7F55FBA5BDA; Fri, 21 May 2021 19:28:38 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] comedi: Make ni_mio_common a standalone module
Date:   Fri, 21 May 2021 19:27:50 +0200
Message-Id: <20210521172749.579900-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to get rid of the ugly

	#include "ni_mio_common.c"

in three modules.

For an amd64 allmodconfig this changed the size for the following object
files:
                                       |  before |  after
drivers/comedi/drivers/ni_atmio.o      |  323944 |  20752
drivers/comedi/drivers/ni_mio_cs.o     |  318376 |  14920
drivers/comedi/drivers/ni_mio_common.o |       - | 324872
drivers/comedi/drivers/ni_pcimio.o     |  389344 |  48168
---------------------------------------+---------+-------
 sum                                   | 1031664 | 408712

So this results in a considerable decrease in binary size of more than
600 KiB.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

my plan was to just quickly check what needs to be done to get rid of
the #include for c files we agreed to be ugly in
https://lore.kernel.org/r/20210521075133.rditsyeiz3qah7qo@pengutronix.de

In the end it wasn't as quick as I hoped, but here it is.

Best regards
Uwe

 drivers/comedi/Kconfig                 |  6 +++
 drivers/comedi/drivers/Makefile        |  1 +
 drivers/comedi/drivers/ni_atmio.c      |  6 +--
 drivers/comedi/drivers/ni_mio.h        | 33 ++++++++++++++
 drivers/comedi/drivers/ni_mio_common.c | 63 ++++++++++++--------------
 drivers/comedi/drivers/ni_mio_cs.c     |  6 +--
 drivers/comedi/drivers/ni_pcimio.c     |  3 +-
 drivers/comedi/drivers/ni_stc.h        |  2 +-
 8 files changed, 76 insertions(+), 44 deletions(-)
 create mode 100644 drivers/comedi/drivers/ni_mio.h

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 3cb61fa2c5c3..8137b94001ea 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -473,9 +473,13 @@ config COMEDI_NI_AT_AO
 	  To compile this driver as a module, choose M here: the module will be
 	  called ni_at_ao.
 
+config COMEDI_NI_MIO
+	tristate
+
 config COMEDI_NI_ATMIO
 	tristate "NI AT-MIO E series ISA-PNP card support"
 	select COMEDI_8255
+	select COMEDI_NI_MIO
 	select COMEDI_NI_TIO
 	help
 	  Enable support for National Instruments AT-MIO E series cards
@@ -1053,6 +1057,7 @@ config COMEDI_NI_PCIDIO
 config COMEDI_NI_PCIMIO
 	tristate "NI PCI-MIO-E series and M series support"
 	depends on HAS_DMA
+	select COMEDI_NI_MIO
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
 	help
@@ -1160,6 +1165,7 @@ config COMEDI_NI_LABPC_CS
 
 config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
+	select COMEDI_NI_MIO
 	select COMEDI_NI_TIO
 	select COMEDI_8255
 	help
diff --git a/drivers/comedi/drivers/Makefile b/drivers/comedi/drivers/Makefile
index b24ac00cab73..725ad62f4c99 100644
--- a/drivers/comedi/drivers/Makefile
+++ b/drivers/comedi/drivers/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_COMEDI_MPC624)		+= mpc624.o
 obj-$(CONFIG_COMEDI_ADQ12B)		+= adq12b.o
 obj-$(CONFIG_COMEDI_NI_AT_A2150)	+= ni_at_a2150.o
 obj-$(CONFIG_COMEDI_NI_AT_AO)		+= ni_at_ao.o
+obj-$(CONFIG_COMEDI_NI_MIO)		+= ni_mio_common.o
 obj-$(CONFIG_COMEDI_NI_ATMIO)		+= ni_atmio.o
 obj-$(CONFIG_COMEDI_NI_ATMIO16D)	+= ni_atmio16d.o
 obj-$(CONFIG_COMEDI_NI_LABPC_ISA)	+= ni_labpc.o
diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 56c78da475e7..d2c211788109 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -44,8 +44,7 @@
  */
 
 /*
- * The real guts of the driver is in ni_mio_common.c, which is included
- * both here and in ni_pcimio.c
+ * The real guts of the driver is in ni_mio_common.c.
  *
  * Interrupt support added by Truxton Fulton <trux@truxton.com>
  *
@@ -78,6 +77,7 @@
 #include <linux/isapnp.h>
 
 #include "ni_stc.h"
+#include "ni_mio.h"
 #include "8255.h"
 
 /* AT specific setup */
@@ -205,8 +205,6 @@ static const int ni_irqpin[] = {
 	-1, -1, -1, 0, 1, 2, -1, 3, -1, -1, 4, 5, 6, -1, -1, 7
 };
 
-#include "ni_mio_common.c"
-
 static const struct pnp_device_id device_ids[] = {
 	{.id = "NIC1900", .driver_data = 0},
 	{.id = "NIC2400", .driver_data = 0},
diff --git a/drivers/comedi/drivers/ni_mio.h b/drivers/comedi/drivers/ni_mio.h
new file mode 100644
index 000000000000..0c8aeb334f34
--- /dev/null
+++ b/drivers/comedi/drivers/ni_mio.h
@@ -0,0 +1,33 @@
+#include <linux/interrupt.h>
+
+#define NI_GPCT_SUBDEV(x)	(NI_GPCT0_SUBDEV + (x))
+
+enum ni_common_subdevices {
+	NI_AI_SUBDEV,
+	NI_AO_SUBDEV,
+	NI_DIO_SUBDEV,
+	NI_8255_DIO_SUBDEV,
+	NI_UNUSED_SUBDEV,
+	NI_CALIBRATION_SUBDEV,
+	NI_EEPROM_SUBDEV,
+	NI_PFI_DIO_SUBDEV,
+	NI_CS5529_CALIBRATION_SUBDEV,
+	NI_SERIAL_SUBDEV,
+	NI_RTSI_SUBDEV,
+	NI_GPCT0_SUBDEV,
+	NI_GPCT1_SUBDEV,
+	NI_FREQ_OUT_SUBDEV,
+	NI_NUM_SUBDEVICES
+};
+
+extern void ni_writel(struct comedi_device *dev, unsigned int data, int reg);
+extern void ni_writew(struct comedi_device *dev, unsigned int data, int reg);
+extern void ni_writeb(struct comedi_device *dev, unsigned int data, int reg);
+extern unsigned int ni_readb(struct comedi_device *dev, int reg);
+extern void ni_stc_writew(struct comedi_device *dev, unsigned int data, int reg);
+extern int ni_read_eeprom(struct comedi_device *dev, int addr);
+extern irqreturn_t ni_E_interrupt(int irq, void *d);
+extern int ni_alloc_private(struct comedi_device *dev);
+extern int ni_E_init(struct comedi_device *dev,
+		     unsigned int interrupt_pin, unsigned int irq_polarity);
+extern void mio_common_detach(struct comedi_device *dev);
diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 4f80a4991f95..95f1abcd52ec 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -41,11 +41,16 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include "8255.h"
 #include "mite.h"
 
+#include "ni_stc.h"
+#include "ni_mio.h"
+#include "../comedidev.h"
+
 /* A timeout count */
 #define NI_TIMEOUT 1000
 
@@ -160,7 +165,7 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
 	}
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext = {
+const struct comedi_lrange range_ni_E_ao_ext = {
 	4, {
 		BIP_RANGE(10),
 		UNI_RANGE(10),
@@ -168,6 +173,7 @@ static const struct comedi_lrange range_ni_E_ao_ext = {
 		RANGE_ext(0, 1)
 	}
 };
+EXPORT_SYMBOL_GPL(range_ni_E_ao_ext);
 
 static const struct comedi_lrange *const ni_range_lkup[] = {
 	[ai_gain_16] = &range_ni_E_ai,
@@ -187,26 +193,6 @@ enum aimodes {
 	AIMODE_SAMPLE = 3,
 };
 
-enum ni_common_subdevices {
-	NI_AI_SUBDEV,
-	NI_AO_SUBDEV,
-	NI_DIO_SUBDEV,
-	NI_8255_DIO_SUBDEV,
-	NI_UNUSED_SUBDEV,
-	NI_CALIBRATION_SUBDEV,
-	NI_EEPROM_SUBDEV,
-	NI_PFI_DIO_SUBDEV,
-	NI_CS5529_CALIBRATION_SUBDEV,
-	NI_SERIAL_SUBDEV,
-	NI_RTSI_SUBDEV,
-	NI_GPCT0_SUBDEV,
-	NI_GPCT1_SUBDEV,
-	NI_FREQ_OUT_SUBDEV,
-	NI_NUM_SUBDEVICES
-};
-
-#define NI_GPCT_SUBDEV(x)	(NI_GPCT0_SUBDEV + (x))
-
 enum timebase_nanoseconds {
 	TIMEBASE_1_NS = 50,
 	TIMEBASE_2_NS = 10000
@@ -219,29 +205,32 @@ enum timebase_nanoseconds {
 
 static const int num_adc_stages_611x = 3;
 
-static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
+void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
 {
 	if (dev->mmio)
 		writel(data, dev->mmio + reg);
 	else
 		outl(data, dev->iobase + reg);
 }
+EXPORT_SYMBOL_GPL(ni_writel);
 
-static void ni_writew(struct comedi_device *dev, unsigned int data, int reg)
+void ni_writew(struct comedi_device *dev, unsigned int data, int reg)
 {
 	if (dev->mmio)
 		writew(data, dev->mmio + reg);
 	else
 		outw(data, dev->iobase + reg);
 }
+EXPORT_SYMBOL_GPL(ni_writew);
 
-static void ni_writeb(struct comedi_device *dev, unsigned int data, int reg)
+void ni_writeb(struct comedi_device *dev, unsigned int data, int reg)
 {
 	if (dev->mmio)
 		writeb(data, dev->mmio + reg);
 	else
 		outb(data, dev->iobase + reg);
 }
+EXPORT_SYMBOL_GPL(ni_writeb);
 
 static unsigned int ni_readl(struct comedi_device *dev, int reg)
 {
@@ -259,13 +248,14 @@ static unsigned int ni_readw(struct comedi_device *dev, int reg)
 	return inw(dev->iobase + reg);
 }
 
-static unsigned int ni_readb(struct comedi_device *dev, int reg)
+unsigned int ni_readb(struct comedi_device *dev, int reg)
 {
 	if (dev->mmio)
 		return readb(dev->mmio + reg);
 
 	return inb(dev->iobase + reg);
 }
+EXPORT_SYMBOL_GPL(ni_readb);
 
 /*
  * We automatically take advantage of STC registers that can be
@@ -435,8 +425,7 @@ static unsigned int m_series_stc_read(struct comedi_device *dev,
 	}
 }
 
-static void ni_stc_writew(struct comedi_device *dev,
-			  unsigned int data, int reg)
+void ni_stc_writew(struct comedi_device *dev, unsigned int data, int reg)
 {
 	struct ni_private *devpriv = dev->private;
 	unsigned long flags;
@@ -454,6 +443,7 @@ static void ni_stc_writew(struct comedi_device *dev,
 		spin_unlock_irqrestore(&devpriv->window_lock, flags);
 	}
 }
+EXPORT_SYMBOL_GPL(ni_stc_writew);
 
 static void ni_stc_writel(struct comedi_device *dev,
 			  unsigned int data, int reg)
@@ -4482,7 +4472,7 @@ static void caldac_setup(struct comedi_device *dev, struct comedi_subdevice *s)
 	}
 }
 
-static int ni_read_eeprom(struct comedi_device *dev, int addr)
+int ni_read_eeprom(struct comedi_device *dev, int addr)
 {
 	unsigned int cmd = NI_E_SERIAL_CMD_EEPROM_CS;
 	int bit;
@@ -4511,6 +4501,7 @@ static int ni_read_eeprom(struct comedi_device *dev, int addr)
 
 	return bitstring;
 }
+EXPORT_SYMBOL_GPL(ni_read_eeprom);
 
 static int ni_eeprom_insn_read(struct comedi_device *dev,
 			       struct comedi_subdevice *s,
@@ -5885,7 +5876,7 @@ static int ni_gpct_cancel(struct comedi_device *dev, struct comedi_subdevice *s)
 }
 #endif
 
-static irqreturn_t ni_E_interrupt(int irq, void *d)
+irqreturn_t ni_E_interrupt(int irq, void *d)
 {
 	struct comedi_device *dev = d;
 	struct comedi_subdevice *s_ai = dev->read_subdev;
@@ -5941,8 +5932,9 @@ static irqreturn_t ni_E_interrupt(int irq, void *d)
 	spin_unlock_irqrestore(&dev->spinlock, flags);
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(ni_E_interrupt);
 
-static int ni_alloc_private(struct comedi_device *dev)
+int ni_alloc_private(struct comedi_device *dev)
 {
 	struct ni_private *devpriv;
 
@@ -5956,6 +5948,7 @@ static int ni_alloc_private(struct comedi_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ni_alloc_private);
 
 static unsigned int _ni_get_valid_routes(struct comedi_device *dev,
 					 unsigned int n_pairs,
@@ -5967,8 +5960,8 @@ static unsigned int _ni_get_valid_routes(struct comedi_device *dev,
 				   pair_data);
 }
 
-static int ni_E_init(struct comedi_device *dev,
-		     unsigned int interrupt_pin, unsigned int irq_polarity)
+int ni_E_init(struct comedi_device *dev,
+	      unsigned int interrupt_pin, unsigned int irq_polarity)
 {
 	const struct ni_board_struct *board = dev->board_ptr;
 	struct ni_private *devpriv = dev->private;
@@ -6331,11 +6324,15 @@ static int ni_E_init(struct comedi_device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ni_E_init);
 
-static void mio_common_detach(struct comedi_device *dev)
+void mio_common_detach(struct comedi_device *dev)
 {
 	struct ni_private *devpriv = dev->private;
 
 	if (devpriv)
 		ni_gpct_device_destroy(devpriv->counter_dev);
 }
+EXPORT_SYMBOL_GPL(mio_common_detach);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/comedi/drivers/ni_mio_cs.c b/drivers/comedi/drivers/ni_mio_cs.c
index 4f37b4e58f09..9f11efde28f9 100644
--- a/drivers/comedi/drivers/ni_mio_cs.c
+++ b/drivers/comedi/drivers/ni_mio_cs.c
@@ -19,8 +19,7 @@
  */
 
 /*
- * The real guts of the driver is in ni_mio_common.c, which is
- * included by all the E series drivers.
+ * The real guts of the driver is in ni_mio_common.c
  *
  * References for specifications:
  *	341080a.pdf  DAQCard E Series Register Level Programmer Manual
@@ -31,6 +30,7 @@
 
 #include "../comedi_pcmcia.h"
 #include "ni_stc.h"
+#include "ni_mio.h"
 #include "8255.h"
 
 /*
@@ -112,8 +112,6 @@ static const struct ni_board_struct ni_boards[] = {
 #endif
 };
 
-#include "ni_mio_common.c"
-
 static const void *ni_getboardtype(struct comedi_device *dev,
 				   struct pcmcia_device *link)
 {
diff --git a/drivers/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
index 6c813a490ba5..f74114e883be 100644
--- a/drivers/comedi/drivers/ni_pcimio.c
+++ b/drivers/comedi/drivers/ni_pcimio.c
@@ -100,6 +100,7 @@
 #include <asm/byteorder.h>
 
 #include "ni_stc.h"
+#include "ni_mio.h"
 #include "mite.h"
 
 #define PCIDMA
@@ -1142,8 +1143,6 @@ static const struct ni_board_struct ni_boards[] = {
 	},
 };
 
-#include "ni_mio_common.c"
-
 static int pcimio_ai_change(struct comedi_device *dev,
 			    struct comedi_subdevice *s)
 {
diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
index fbc0b753a0f5..026d215f2ef2 100644
--- a/drivers/comedi/drivers/ni_stc.h
+++ b/drivers/comedi/drivers/ni_stc.h
@@ -1137,6 +1137,6 @@ struct ni_private {
 	u8 rgout0_usage;
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext;
+extern const struct comedi_lrange range_ni_E_ao_ext;
 
 #endif /* _COMEDI_NI_STC_H */

base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.30.2

