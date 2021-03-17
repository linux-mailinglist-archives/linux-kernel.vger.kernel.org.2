Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF333EE93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhCQKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhCQKqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:46:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D79B64F38;
        Wed, 17 Mar 2021 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615977965;
        bh=27y9/K9DSkrLEa8ia/y8h/4yrfxxvEctj+nQcYCUuSI=;
        h=From:To:Cc:Subject:Date:From;
        b=WTXGb8gfo3Gn3jlPyY4J87mfMlHz8jUgKgUwHWfw5HoFtkxlsg93tYAUvjcZ++Bfd
         MXJgWAbkNcm+Z4fvzKx0bwQ3TODid+EDq6FnevWt29Sijne7yI8EcFM97Lp/nIhr8J
         lcDcFO4uLBtMHG14lVJMg0/Vn37W+E3IBxWgsfIWnYS0C4RmM6cH6gi2U7PgViQNMQ
         Pfqg6o1KDR/mGVGBIl/PnYLE1I7SG6DVe06YwgaaQX/RrMzd/WoJY/x5aAWJ6nCU9K
         BN96FQlL++ByQAf5tBguONK+p+3/OIz+5YV35bTUfgkbofs0/gRQQRr3ksEpcHfiuZ
         zxcwCPfLiwJgQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH master] module: remove never implemented MODULE_SUPPORTED_DEVICE
Date:   Wed, 17 Mar 2021 12:45:47 +0200
Message-Id: <20210317104547.442203-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

MODULE_SUPPORTED_DEVICE was added in pre-git era and never was
implemented. We can safely remove it, because the kernel has grown
to have many more reliable mechanisms to determine if device is
supported or not.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Hi Linus,

I'm sending this patch to you directly because it is much saner to
apply it in one place instead of multiple patches saga that will
span for at least two cycles if per-maintainer path will be taken.

It applies cleanly on v5.12-rc2 and completely unharmful.

Thanks
---
 arch/x86/platform/iris/iris.c                 |  1 -
 drivers/atm/fore200e.c                        |  2 --
 drivers/block/floppy.c                        |  1 -
 drivers/bluetooth/btrsi.c                     |  1 -
 drivers/char/applicom.c                       |  3 --
 drivers/char/toshiba.c                        |  1 -
 drivers/input/joydev.c                        |  1 -
 drivers/media/firewire/firedtv-fw.c           |  1 -
 drivers/media/pci/cx18/cx18-alsa-main.c       |  1 -
 drivers/media/pci/cx18/cx18-driver.c          |  1 -
 drivers/media/pci/cx25821/cx25821-alsa.c      |  1 -
 drivers/media/pci/cx88/cx88-alsa.c            |  1 -
 drivers/media/pci/ivtv/ivtv-alsa-main.c       |  1 -
 drivers/media/pci/ivtv/ivtv-driver.c          |  3 --
 drivers/media/pci/sta2x11/sta2x11_vip.c       |  1 -
 drivers/media/platform/atmel/atmel-isi.c      |  1 -
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  1 -
 .../media/platform/marvell-ccic/cafe-driver.c |  4 ---
 drivers/media/platform/stm32/stm32-dcmi.c     |  1 -
 drivers/media/usb/cpia2/cpia2_v4l.c           |  1 -
 drivers/media/usb/tm6000/tm6000-alsa.c        |  1 -
 drivers/media/usb/tm6000/tm6000-dvb.c         |  2 --
 drivers/mtd/maps/sun_uflash.c                 |  1 -
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  1 -
 drivers/net/can/sja1000/ems_pci.c             |  1 -
 drivers/net/can/sja1000/ems_pcmcia.c          |  1 -
 drivers/net/can/sja1000/kvaser_pci.c          |  1 -
 drivers/net/can/sja1000/peak_pci.c            |  2 --
 drivers/net/can/sja1000/peak_pcmcia.c         |  1 -
 drivers/net/can/sja1000/plx_pci.c             | 12 -------
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  2 --
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  3 --
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |  2 --
 drivers/net/hamradio/scc.c                    |  1 -
 drivers/net/wireless/admtek/adm8211.c         |  1 -
 drivers/net/wireless/ath/ath5k/base.c         |  1 -
 drivers/net/wireless/ath/ath9k/hw.c           |  1 -
 drivers/net/wireless/ath/ath9k/init.c         |  1 -
 drivers/net/wireless/atmel/atmel.c            |  1 -
 drivers/net/wireless/atmel/atmel_cs.c         |  1 -
 drivers/net/wireless/atmel/atmel_pci.c        |  1 -
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  1 -
 .../broadcom/brcm80211/brcmutil/utils.c       |  1 -
 drivers/net/wireless/cisco/airo.c             |  1 -
 drivers/net/wireless/cisco/airo_cs.c          |  1 -
 .../net/wireless/intersil/hostap/hostap_cs.c  |  1 -
 .../net/wireless/intersil/hostap/hostap_pci.c |  1 -
 .../net/wireless/intersil/hostap/hostap_plx.c |  1 -
 .../net/wireless/ralink/rt2x00/rt2400pci.c    |  1 -
 .../net/wireless/ralink/rt2x00/rt2500pci.c    |  1 -
 .../net/wireless/ralink/rt2x00/rt2500usb.c    |  1 -
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  1 -
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |  1 -
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  2 --
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  1 -
 drivers/net/wireless/rsi/rsi_91x_main.c       |  1 -
 drivers/net/wireless/rsi/rsi_91x_sdio.c       |  1 -
 drivers/net/wireless/rsi/rsi_91x_usb.c        |  1 -
 drivers/parport/parport_amiga.c               |  1 -
 drivers/parport/parport_atari.c               |  1 -
 drivers/parport/parport_gsc.c                 |  1 -
 drivers/parport/parport_mfc3.c                |  1 -
 drivers/parport/parport_sunbpp.c              |  1 -
 drivers/s390/block/dasd.c                     |  1 -
 drivers/sbus/char/display7seg.c               |  1 -
 drivers/scsi/hpsa.c                           |  1 -
 drivers/scsi/pcmcia/nsp_cs.c                  |  1 -
 drivers/scsi/smartpqi/smartpqi_init.c         |  1 -
 drivers/sh/maple/maple.c                      |  1 -
 drivers/staging/comedi/drivers/vmk80xx.c      |  1 -
 drivers/tee/optee/core.c                      |  1 -
 drivers/tty/serial/icom.c                     |  2 --
 drivers/tty/serial/jsm/jsm_driver.c           |  1 -
 drivers/usb/misc/ldusb.c                      |  1 -
 drivers/watchdog/cpu5wdt.c                    |  1 -
 drivers/watchdog/cpwd.c                       |  1 -
 drivers/watchdog/riowd.c                      |  1 -
 include/linux/module.h                        |  3 --
 net/batman-adv/main.c                         |  1 -
 sound/drivers/aloop.c                         |  1 -
 sound/drivers/dummy.c                         |  1 -
 sound/drivers/mtpav.c                         |  1 -
 sound/drivers/mts64.c                         |  1 -
 sound/drivers/pcsp/pcsp.c                     |  1 -
 sound/drivers/portman2x4.c                    |  1 -
 sound/drivers/serial-u16550.c                 |  1 -
 sound/drivers/virmidi.c                       |  1 -
 sound/isa/ad1816a/ad1816a.c                   |  7 ----
 sound/isa/ad1848/ad1848.c                     |  3 --
 sound/isa/als100.c                            | 11 ------
 sound/isa/azt2320.c                           |  5 ---
 sound/isa/cmi8330.c                           |  1 -
 sound/isa/cs423x/cs4231.c                     |  1 -
 sound/isa/cs423x/cs4236.c                     | 34 -------------------
 sound/isa/es1688/es1688.c                     |  5 ---
 sound/isa/es18xx.c                            |  8 -----
 sound/isa/gus/gusclassic.c                    |  1 -
 sound/isa/gus/gusextreme.c                    |  1 -
 sound/isa/gus/gusmax.c                        |  1 -
 sound/isa/gus/interwave.c                     |  6 ----
 sound/isa/opl3sa2.c                           |  5 ---
 sound/isa/opti9xx/miro.c                      |  3 --
 sound/isa/opti9xx/opti92x-ad1848.c            |  6 ----
 sound/isa/sb/jazz16.c                         |  3 --
 sound/isa/sb/sb16.c                           |  8 -----
 sound/isa/sb/sb8.c                            |  1 -
 sound/isa/sc6000.c                            |  3 --
 sound/isa/wavefront/wavefront.c               |  1 -
 sound/mips/sgio2audio.c                       |  1 -
 sound/pci/ad1889.c                            |  1 -
 sound/pci/ali5451/ali5451.c                   |  1 -
 sound/pci/als300.c                            |  1 -
 sound/pci/als4000.c                           |  1 -
 sound/pci/atiixp.c                            |  1 -
 sound/pci/atiixp_modem.c                      |  1 -
 sound/pci/au88x0/au88x0.c                     |  2 --
 sound/pci/azt3328.c                           |  1 -
 sound/pci/bt87x.c                             |  2 --
 sound/pci/ca0106/ca0106_main.c                |  1 -
 sound/pci/cmipci.c                            |  4 ---
 sound/pci/cs4281.c                            |  1 -
 sound/pci/cs46xx/cs46xx.c                     |  7 ----
 sound/pci/cs5535audio/cs5535audio.c           |  1 -
 sound/pci/ctxfi/xfi.c                         |  1 -
 sound/pci/echoaudio/echoaudio.c               |  1 -
 sound/pci/emu10k1/emu10k1.c                   |  2 --
 sound/pci/emu10k1/emu10k1x.c                  |  1 -
 sound/pci/ens1370.c                           |  8 -----
 sound/pci/es1938.c                            |  4 ---
 sound/pci/es1968.c                            |  4 ---
 sound/pci/fm801.c                             |  2 --
 sound/pci/hda/hda_intel.c                     | 34 -------------------
 sound/pci/ice1712/ice1712.c                   |  6 ----
 sound/pci/ice1712/ice1724.c                   | 19 -----------
 sound/pci/intel8x0.c                          | 23 -------------
 sound/pci/intel8x0m.c                         | 15 --------
 sound/pci/korg1212/korg1212.c                 |  1 -
 sound/pci/lola/lola.c                         |  1 -
 sound/pci/lx6464es/lx6464es.c                 |  2 --
 sound/pci/maestro3.c                          |  5 ---
 sound/pci/mixart/mixart.c                     |  1 -
 sound/pci/nm256/nm256.c                       |  2 --
 sound/pci/oxygen/oxygen.c                     |  3 --
 sound/pci/oxygen/se6x.c                       |  1 -
 sound/pci/oxygen/virtuoso.c                   |  1 -
 sound/pci/pcxhr/pcxhr.c                       |  1 -
 sound/pci/riptide/riptide.c                   |  1 -
 sound/pci/rme32.c                             |  1 -
 sound/pci/rme96.c                             |  5 ---
 sound/pci/rme9652/hdsp.c                      |  3 --
 sound/pci/rme9652/hdspm.c                     |  1 -
 sound/pci/rme9652/rme9652.c                   |  4 +--
 sound/pci/sis7019.c                           |  1 -
 sound/pci/sonicvibes.c                        |  1 -
 sound/pci/trident/trident.c                   | 12 -------
 sound/pci/via82xx.c                           |  1 -
 sound/pci/via82xx_modem.c                     |  1 -
 sound/pci/vx222/vx222.c                       |  1 -
 sound/pci/ymfpci/ymfpci.c                     |  6 ----
 sound/pcmcia/pdaudiocf/pdaudiocf.c            |  1 -
 sound/pcmcia/vx/vxpocket.c                    |  4 ---
 sound/ppc/powermac.c                          |  1 -
 sound/sh/aica.c                               |  1 -
 sound/sh/sh_dac_audio.c                       |  1 -
 sound/sparc/amd7930.c                         |  1 -
 sound/sparc/cs4231.c                          |  1 -
 sound/sparc/dbri.c                            |  1 -
 sound/usb/6fire/chip.c                        |  1 -
 sound/usb/caiaq/device.c                      | 14 --------
 sound/usb/card.c                              |  2 --
 sound/usb/hiface/chip.c                       | 17 ----------
 sound/usb/misc/ua101.c                        |  1 -
 sound/usb/usx2y/usbusx2y.c                    |  1 -
 sound/x86/intel_hdmi_audio.c                  |  1 -
 sound/xen/xen_snd_front.c                     |  1 -
 175 files changed, 1 insertion(+), 480 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index 1ac8578258af..b42bfdab01a9 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -27,7 +27,6 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sébastien Hinderer <Sebastien.Hinderer@ens-lyon.org>");
 MODULE_DESCRIPTION("A power_off handler for Iris devices from EuroBraille");
-MODULE_SUPPORTED_DEVICE("Eurobraille/Iris");

 static bool force;

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 9a70bee84125..495fd0a1f040 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -100,8 +100,6 @@ static LIST_HEAD(fore200e_boards);

 MODULE_AUTHOR("Christophe Lizzi - credits to Uwe Dannowski and Heikki Vatiainen");
 MODULE_DESCRIPTION("FORE Systems 200E-series ATM driver - version " FORE200E_VERSION);
-MODULE_SUPPORTED_DEVICE("PCA-200E, SBA-200E");
-

 static const int fore200e_rx_buf_nbr[ BUFFER_SCHEME_NBR ][ BUFFER_MAGN_NBR ] = {
     { BUFFER_S1_NBR, BUFFER_L1_NBR },
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 0b71292d9d5a..4aa9683ee0c1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -5091,7 +5091,6 @@ module_param(floppy, charp, 0);
 module_param(FLOPPY_IRQ, int, 0);
 module_param(FLOPPY_DMA, int, 0);
 MODULE_AUTHOR("Alain L. Knaff");
-MODULE_SUPPORTED_DEVICE("fd");
 MODULE_LICENSE("GPL");

 /* This doesn't actually get used other than for module information */
diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index 3951f7b23840..bea1595f6432 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -194,5 +194,4 @@ module_init(rsi_91x_bt_module_init);
 module_exit(rsi_91x_bt_module_exit);
 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("RSI BT driver");
-MODULE_SUPPORTED_DEVICE("RSI-BT");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 14b2d8034c51..45ac7ab003ce 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -81,9 +81,6 @@ MODULE_DESCRIPTION("Driver for Applicom Profibus card");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(AC_MINOR);

-MODULE_SUPPORTED_DEVICE("ac");
-
-
 static struct applicom_board {
 	unsigned long PhysIO;
 	void __iomem *RamIO;
diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index aff0a8e44fff..776abbfd85d6 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -64,7 +64,6 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
 MODULE_DESCRIPTION("Toshiba laptop SMM driver");
-MODULE_SUPPORTED_DEVICE("toshiba");

 static DEFINE_MUTEX(tosh_mutex);
 static int tosh_fn;
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 430dc6975004..da8963a9f044 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -26,7 +26,6 @@

 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Joystick device interfaces");
-MODULE_SUPPORTED_DEVICE("input/js");
 MODULE_LICENSE("GPL");

 #define JOYDEV_MINOR_BASE	0
diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
index 8a8585261bb8..5f6e97a8d1c0 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -430,4 +430,3 @@ MODULE_AUTHOR("Andreas Monitzer <andy@monitzer.com>");
 MODULE_AUTHOR("Ben Backx <ben@bbackx.com>");
 MODULE_DESCRIPTION("FireDTV DVB Driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("FireDTV DVB");
diff --git a/drivers/media/pci/cx18/cx18-alsa-main.c b/drivers/media/pci/cx18/cx18-alsa-main.c
index 692b95a685d1..9a82e68303b6 100644
--- a/drivers/media/pci/cx18/cx18-alsa-main.c
+++ b/drivers/media/pci/cx18/cx18-alsa-main.c
@@ -41,7 +41,6 @@ MODULE_PARM_DESC(debug,

 MODULE_AUTHOR("Andy Walls");
 MODULE_DESCRIPTION("CX23418 ALSA Interface");
-MODULE_SUPPORTED_DEVICE("CX23418 MPEG2 encoder");
 MODULE_LICENSE("GPL");

 MODULE_VERSION(CX18_VERSION);
diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 95aed00f353b..f2440eb38820 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -232,7 +232,6 @@ MODULE_PARM_DESC(cx18_first_minor,

 MODULE_AUTHOR("Hans Verkuil");
 MODULE_DESCRIPTION("CX23418 driver");
-MODULE_SUPPORTED_DEVICE("CX23418 MPEG2 encoder");
 MODULE_LICENSE("GPL");

 MODULE_VERSION(CX18_VERSION);
diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
index 608fbaf0f659..8797d85a6b0a 100644
--- a/drivers/media/pci/cx25821/cx25821-alsa.c
+++ b/drivers/media/pci/cx25821/cx25821-alsa.c
@@ -104,7 +104,6 @@ MODULE_PARM_DESC(index, "Index value for cx25821 capture interface(s).");
 MODULE_DESCRIPTION("ALSA driver module for cx25821 based capture cards");
 MODULE_AUTHOR("Hiep Huynh");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Conexant,25821}");	/* "{{Conexant,23881}," */

 static unsigned int debug;
 module_param(debug, int, 0644);
diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
index 95e0cbb1277d..c83814c052d3 100644
--- a/drivers/media/pci/cx88/cx88-alsa.c
+++ b/drivers/media/pci/cx88/cx88-alsa.c
@@ -98,7 +98,6 @@ MODULE_AUTHOR("Mauro Carvalho Chehab <mchehab@kernel.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_VERSION(CX88_VERSION);

-MODULE_SUPPORTED_DEVICE("{{Conexant,23881},{{Conexant,23882},{{Conexant,23883}");
 static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "enable debug messages");
diff --git a/drivers/media/pci/ivtv/ivtv-alsa-main.c b/drivers/media/pci/ivtv/ivtv-alsa-main.c
index 39029b8e12c9..4cefdb2e4d40 100644
--- a/drivers/media/pci/ivtv/ivtv-alsa-main.c
+++ b/drivers/media/pci/ivtv/ivtv-alsa-main.c
@@ -38,7 +38,6 @@ MODULE_PARM_DESC(index,

 MODULE_AUTHOR("Andy Walls");
 MODULE_DESCRIPTION("CX23415/CX23416 ALSA Interface");
-MODULE_SUPPORTED_DEVICE("CX23415/CX23416 MPEG2 encoder");
 MODULE_LICENSE("GPL");

 MODULE_VERSION(IVTV_VERSION);
diff --git a/drivers/media/pci/ivtv/ivtv-driver.c b/drivers/media/pci/ivtv/ivtv-driver.c
index 6e448cb3b51c..942b8c266f50 100644
--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -275,9 +275,6 @@ MODULE_PARM_DESC(ivtv_first_minor, "Set device node number assigned to first car

 MODULE_AUTHOR("Kevin Thayer, Chris Kennedy, Hans Verkuil");
 MODULE_DESCRIPTION("CX23415/CX23416 driver");
-MODULE_SUPPORTED_DEVICE
-    ("CX23415/CX23416 MPEG2 encoder (WinTV PVR-150/250/350/500,\n"
-		"\t\t\tYuan MPG series and similar)");
 MODULE_LICENSE("GPL");

 MODULE_VERSION(IVTV_VERSION);
diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index 336df65c8af1..524912f20d9f 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -1269,6 +1269,5 @@ late_initcall_sync(sta2x11_vip_init_module);
 MODULE_DESCRIPTION("STA2X11 Video Input Port driver");
 MODULE_AUTHOR("Wind River");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("sta2x11 video input");
 MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, sta2x11_vip_pci_tbl);
diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index 0514be6153df..e392b3efe363 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1363,4 +1363,3 @@ module_platform_driver(atmel_isi_driver);
 MODULE_AUTHOR("Josh Wu <josh.wu@atmel.com>");
 MODULE_DESCRIPTION("The V4L2 driver for Atmel Linux");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("video");
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 0b78fecfd2a8..61d9885765f4 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -330,4 +330,3 @@ module_platform_driver(atmel_isc_driver);
 MODULE_AUTHOR("Songjun Wu");
 MODULE_DESCRIPTION("The V4L2 driver for Atmel-ISC");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("video");
diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 9c94a8b58b7c..baac86f3d153 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -44,10 +44,6 @@
 MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
 MODULE_DESCRIPTION("Marvell 88ALP01 CMOS Camera Controller driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("Video");
-
-
-

 struct cafe_camera {
 	int registered;			/* Fully initialized? */
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index bbcc2254fa2e..d9b4ad0abf0c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -2149,4 +2149,3 @@ MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
 MODULE_AUTHOR("Hugues Fruchet <hugues.fruchet@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics STM32 Digital Camera Memory Interface driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("video");
diff --git a/drivers/media/usb/cpia2/cpia2_v4l.c b/drivers/media/usb/cpia2/cpia2_v4l.c
index e488e7870f42..69d5c628a797 100644
--- a/drivers/media/usb/cpia2/cpia2_v4l.c
+++ b/drivers/media/usb/cpia2/cpia2_v4l.c
@@ -56,7 +56,6 @@ MODULE_PARM_DESC(flicker_mode, "Flicker frequency (0 (disabled), " __stringify(5

 MODULE_AUTHOR("Steve Miller (STMicroelectronics) <steve.miller@st.com>");
 MODULE_DESCRIPTION("V4L-driver for STMicroelectronics CPiA2 based cameras");
-MODULE_SUPPORTED_DEVICE("video");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(CPIA_VERSION);

diff --git a/drivers/media/usb/tm6000/tm6000-alsa.c b/drivers/media/usb/tm6000/tm6000-alsa.c
index 3a2df36ef1db..a19a46770c2b 100644
--- a/drivers/media/usb/tm6000/tm6000-alsa.c
+++ b/drivers/media/usb/tm6000/tm6000-alsa.c
@@ -51,7 +51,6 @@ MODULE_PARM_DESC(index, "Index value for tm6000x capture interface(s).");
 MODULE_DESCRIPTION("ALSA driver module for tm5600/tm6000/tm6010 based TV cards");
 MODULE_AUTHOR("Mauro Carvalho Chehab");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{Trident,tm5600},{{Trident,tm6000},{{Trident,tm6010}");
 static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "enable debug messages");
diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm6000/tm6000-dvb.c
index 293a460f4616..4990fa886d7a 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -23,8 +23,6 @@ MODULE_DESCRIPTION("DVB driver extension module for tm5600/6000/6010 based TV ca
 MODULE_AUTHOR("Mauro Carvalho Chehab");
 MODULE_LICENSE("GPL");

-MODULE_SUPPORTED_DEVICE("{{Trident, tm5600},{{Trident, tm6000},{{Trident, tm6010}");
-
 static int debug;

 module_param(debug, int, 0644);
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index eb7258293256..f9cfb084c029 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -32,7 +32,6 @@

 MODULE_AUTHOR("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION("User-programmable flash device on Sun Microsystems boardsets");
-MODULE_SUPPORTED_DEVICE(DRIVER_NAME);
 MODULE_LICENSE("GPL");
 MODULE_VERSION("2.1");

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 0df1cdfa6835..1df3c4b54f03 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -21,7 +21,6 @@

 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe/M.2 FD family cards");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe/M.2 FD CAN cards");
 MODULE_LICENSE("GPL v2");

 #define PCIEFD_DRV_NAME		"peak_pciefd"
diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 6f88c9932920..4ab91759a5c6 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -21,7 +21,6 @@

 MODULE_AUTHOR("Sebastian Haas <haas@ems-wuenche.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-PCI/PCIe/104P CAN cards");
-MODULE_SUPPORTED_DEVICE("EMS CPC-PCI/PCIe/104P CAN card");
 MODULE_LICENSE("GPL v2");

 #define EMS_PCI_V1_MAX_CHAN 2
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 770304eaef95..e21b169c14c0 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -21,7 +21,6 @@

 MODULE_AUTHOR("Markus Plessing <plessing@ems-wuensche.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for EMS CPC-CARD cards");
-MODULE_SUPPORTED_DEVICE("EMS CPC-CARD CAN card");
 MODULE_LICENSE("GPL v2");

 #define EMS_PCMCIA_MAX_CHAN 2
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index 0ea6b711c07b..95fe9ee1ce32 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -33,7 +33,6 @@

 MODULE_AUTHOR("Per Dalen <per.dalen@cnw.se>");
 MODULE_DESCRIPTION("Socket-CAN driver for KVASER PCAN PCI cards");
-MODULE_SUPPORTED_DEVICE("KVASER PCAN PCI CAN card");
 MODULE_LICENSE("GPL v2");

 #define MAX_NO_OF_CHANNELS        4 /* max no of channels on a single card */
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 4713921bd511..84eac8cb8686 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -24,8 +24,6 @@

 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
 MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN miniPCIe/cPCI PC/104+ PCI/104e CAN Cards");
 MODULE_LICENSE("GPL v2");

 #define DRV_NAME  "peak_pci"
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index cf951a783078..131a084c3535 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -22,7 +22,6 @@
 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
 MODULE_DESCRIPTION("CAN driver for PEAK-System PCAN-PC Cards");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN-PC Card");

 /* PEAK-System PCMCIA driver name */
 #define PCC_NAME		"peak_pcmcia"
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 85679588ef73..5de1ebb0c6f0 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -25,18 +25,6 @@
 MODULE_AUTHOR("Pavel Cheblakov <P.B.Cheblakov@inp.nsk.su>");
 MODULE_DESCRIPTION("Socket-CAN driver for PLX90xx PCI-bridge cards with "
 		   "the SJA1000 chips");
-MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
-			"Adlink PCI-7841/cPCI-7841 SE, "
-			"Marathon CAN-bus-PCI, "
-			"Marathon CAN-bus-PCIe, "
-			"TEWS TECHNOLOGIES TPMC810, "
-			"esd CAN-PCI/CPCI/PCI104/200, "
-			"esd CAN-PCI/PMC/266, "
-			"esd CAN-PCIe/2000, "
-			"Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
-			"IXXAT PC-I 04/PCI, "
-			"ELCUS CAN-200-PCI, "
-			"ASEM DUAL CAN-RAW")
 MODULE_LICENSE("GPL v2");

 #define PLX_PCI_MAX_CHAN 2
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index e6c1e5d33924..e393e8457d77 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -18,8 +18,6 @@

 #include "pcan_usb_core.h"

-MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
-
 /* PCAN-USB Endpoints */
 #define PCAN_USB_EP_CMDOUT		1
 #define PCAN_USB_EP_CMDIN		(PCAN_USB_EP_CMDOUT | USB_DIR_IN)
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index f347ecc79aef..bae078579c0d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -16,9 +16,6 @@
 #include "pcan_usb_core.h"
 #include "pcan_usb_pro.h"

-MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
-MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
-
 #define PCAN_USBPROFD_CHANNEL_COUNT	2
 #define PCAN_USBFD_CHANNEL_COUNT	1

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 275087c39602..18fa180ecc81 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -17,8 +17,6 @@
 #include "pcan_usb_core.h"
 #include "pcan_usb_pro.h"

-MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
-
 #define PCAN_USBPRO_CHANNEL_COUNT	2

 /* PCAN-USB Pro adapter internal clock (MHz) */
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index 36eeb80406f2..4690c6a59054 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -2167,7 +2167,6 @@ static void __exit scc_cleanup_driver(void)

 MODULE_AUTHOR("Joerg Reuter <jreuter@yaina.de>");
 MODULE_DESCRIPTION("AX.25 Device Driver for Z8530 based HDLC cards");
-MODULE_SUPPORTED_DEVICE("Z8530 based SCC cards for Amateur Radio");
 MODULE_LICENSE("GPL");
 module_init(scc_init_driver);
 module_exit(scc_cleanup_driver);
diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index c41e72508d3d..2db9c948c0fc 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -28,7 +28,6 @@
 MODULE_AUTHOR("Michael Wu <flamingice@sourmilk.net>");
 MODULE_AUTHOR("Jouni Malinen <j@w1.fi>");
 MODULE_DESCRIPTION("Driver for IEEE 802.11b wireless cards based on ADMtek ADM8211");
-MODULE_SUPPORTED_DEVICE("ADM8211");
 MODULE_LICENSE("GPL");

 static unsigned int tx_ring_size __read_mostly = 16;
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 4c6e57f9976d..cef17f33c69e 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -90,7 +90,6 @@ MODULE_PARM_DESC(no_hw_rfkill_switch, "Ignore the GPIO RFKill switch state");
 MODULE_AUTHOR("Jiri Slaby");
 MODULE_AUTHOR("Nick Kossifidis");
 MODULE_DESCRIPTION("Support for 5xxx series of Atheros 802.11 wireless LAN cards.");
-MODULE_SUPPORTED_DEVICE("Atheros 5xxx WLAN cards");
 MODULE_LICENSE("Dual BSD/GPL");

 static int ath5k_init(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index b66eeb577272..5abc2a5526ec 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -34,7 +34,6 @@ static bool ath9k_hw_set_reset_reg(struct ath_hw *ah, u32 type);

 MODULE_AUTHOR("Atheros Communications");
 MODULE_DESCRIPTION("Support for Atheros 802.11n wireless LAN cards.");
-MODULE_SUPPORTED_DEVICE("Atheros 802.11n WLAN cards");
 MODULE_LICENSE("Dual BSD/GPL");

 static void ath9k_hw_set_clockrate(struct ath_hw *ah)
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 42a208787f5a..01f9c26f9bf3 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -37,7 +37,6 @@ static char *dev_info = "ath9k";

 MODULE_AUTHOR("Atheros Communications");
 MODULE_DESCRIPTION("Support for Atheros 802.11n wireless LAN cards.");
-MODULE_SUPPORTED_DEVICE("Atheros 802.11n WLAN cards");
 MODULE_LICENSE("Dual BSD/GPL");

 static unsigned int ath9k_debug = ATH_DBG_DEFAULT;
diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 707fe66727f8..febce4e8b3dd 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -75,7 +75,6 @@
 MODULE_AUTHOR("Simon Kelley");
 MODULE_DESCRIPTION("Support for Atmel at76c50x 802.11 wireless ethernet cards.");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("Atmel at76c50x wireless cards");

 /* The name of the firmware file to be loaded
    over-rides any automatic selection */
diff --git a/drivers/net/wireless/atmel/atmel_cs.c b/drivers/net/wireless/atmel/atmel_cs.c
index 368eebefa741..453bb84cb338 100644
--- a/drivers/net/wireless/atmel/atmel_cs.c
+++ b/drivers/net/wireless/atmel/atmel_cs.c
@@ -57,7 +57,6 @@
 MODULE_AUTHOR("Simon Kelley");
 MODULE_DESCRIPTION("Support for Atmel at76c50x 802.11 wireless ethernet cards.");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("Atmel at76c50x PCMCIA cards");

 /*====================================================================*/

diff --git a/drivers/net/wireless/atmel/atmel_pci.c b/drivers/net/wireless/atmel/atmel_pci.c
index 47f7ccb32414..f428dc79d916 100644
--- a/drivers/net/wireless/atmel/atmel_pci.c
+++ b/drivers/net/wireless/atmel/atmel_pci.c
@@ -16,7 +16,6 @@
 MODULE_AUTHOR("Simon Kelley");
 MODULE_DESCRIPTION("Support for Atmel at76c50x 802.11 wireless ethernet cards.");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("Atmel at76c506 PCI wireless cards");

 static const struct pci_device_id card_ids[] = {
 	{ 0x1114, 0x0506, PCI_ANY_ID, PCI_ANY_ID },
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 818e523f6025..39f3af2d0439 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -87,7 +87,6 @@ static int n_adapters_found;

 MODULE_AUTHOR("Broadcom Corporation");
 MODULE_DESCRIPTION("Broadcom 802.11n wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Broadcom 802.11n WLAN cards");
 MODULE_LICENSE("Dual BSD/GPL");
 /* This needs to be adjusted when brcms_firmwares changes */
 MODULE_FIRMWARE("brcm/bcm43xx-0.fw");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c b/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
index 4c84c3001c3f..e87e68cc46e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c
@@ -12,7 +12,6 @@

 MODULE_AUTHOR("Broadcom Corporation");
 MODULE_DESCRIPTION("Broadcom 802.11n wireless LAN driver utilities.");
-MODULE_SUPPORTED_DEVICE("Broadcom 802.11n WLAN cards");
 MODULE_LICENSE("Dual BSD/GPL");

 struct sk_buff *brcmu_pkt_buf_get_skb(uint len)
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index e35e1380ae43..60db38c38960 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -251,7 +251,6 @@ MODULE_AUTHOR("Benjamin Reed");
 MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet cards.  "
 		   "Direct support for ISA/PCI/MPI cards and support for PCMCIA when used with airo_cs.");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_SUPPORTED_DEVICE("Aironet 4500, 4800 and Cisco 340/350");
 module_param_hw_array(io, int, ioport, NULL, 0);
 module_param_hw_array(irq, int, irq, NULL, 0);
 module_param_array(rates, int, NULL, 0);
diff --git a/drivers/net/wireless/cisco/airo_cs.c b/drivers/net/wireless/cisco/airo_cs.c
index 3718f958c0fc..fcfe4c6d62f0 100644
--- a/drivers/net/wireless/cisco/airo_cs.c
+++ b/drivers/net/wireless/cisco/airo_cs.c
@@ -47,7 +47,6 @@ MODULE_DESCRIPTION("Support for Cisco/Aironet 802.11 wireless ethernet "
 		   "cards.  This is the module that links the PCMCIA card "
 		   "with the airo module.");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_SUPPORTED_DEVICE("Aironet 4500, 4800 and Cisco 340 PCMCIA cards");

 /*====================================================================*/

diff --git a/drivers/net/wireless/intersil/hostap/hostap_cs.c b/drivers/net/wireless/intersil/hostap/hostap_cs.c
index 1a748670835a..ec7db2badc40 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_cs.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_cs.c
@@ -26,7 +26,6 @@ static char *dev_info = "hostap_cs";
 MODULE_AUTHOR("Jouni Malinen");
 MODULE_DESCRIPTION("Support for Intersil Prism2-based 802.11 wireless LAN "
 		   "cards (PC Card).");
-MODULE_SUPPORTED_DEVICE("Intersil Prism2-based WLAN cards (PC Card)");
 MODULE_LICENSE("GPL");


diff --git a/drivers/net/wireless/intersil/hostap/hostap_pci.c b/drivers/net/wireless/intersil/hostap/hostap_pci.c
index 101887e6bd0f..52d77506effd 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_pci.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_pci.c
@@ -27,7 +27,6 @@ static char *dev_info = "hostap_pci";
 MODULE_AUTHOR("Jouni Malinen");
 MODULE_DESCRIPTION("Support for Intersil Prism2.5-based 802.11 wireless LAN "
 		   "PCI cards.");
-MODULE_SUPPORTED_DEVICE("Intersil Prism2.5-based WLAN PCI cards");
 MODULE_LICENSE("GPL");


diff --git a/drivers/net/wireless/intersil/hostap/hostap_plx.c b/drivers/net/wireless/intersil/hostap/hostap_plx.c
index 841cfc68ce84..58247290fcbc 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_plx.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_plx.c
@@ -30,7 +30,6 @@ static char *dev_info = "hostap_plx";
 MODULE_AUTHOR("Jouni Malinen");
 MODULE_DESCRIPTION("Support for Intersil Prism2-based 802.11 wireless LAN "
 		   "cards (PLX).");
-MODULE_SUPPORTED_DEVICE("Intersil Prism2-based WLAN cards (PLX)");
 MODULE_LICENSE("GPL");


diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 8f860c14da58..dec6ffdf07c4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1821,7 +1821,6 @@ static const struct pci_device_id rt2400pci_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT2400 PCI & PCMCIA Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2460 PCI & PCMCIA chipset based cards");
 MODULE_DEVICE_TABLE(pci, rt2400pci_device_table);
 MODULE_LICENSE("GPL");

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index e940443c52ad..8faa0a80e73a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -2119,7 +2119,6 @@ static const struct pci_device_id rt2500pci_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT2500 PCI & PCMCIA Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2560 PCI & PCMCIA chipset based cards");
 MODULE_DEVICE_TABLE(pci, rt2500pci_device_table);
 MODULE_LICENSE("GPL");

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
index fce05fc88aaf..bb5ed6630645 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500usb.c
@@ -1956,7 +1956,6 @@ static const struct usb_device_id rt2500usb_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT2500 USB Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2570 USB chipset based cards");
 MODULE_DEVICE_TABLE(usb, rt2500usb_device_table);
 MODULE_LICENSE("GPL");

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 9a33baaa6184..1fde0e767ce3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -439,7 +439,6 @@ static const struct pci_device_id rt2800pci_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT2800 PCI & PCMCIA Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2860 PCI & PCMCIA chipset based cards");
 MODULE_FIRMWARE(FIRMWARE_RT2860);
 MODULE_DEVICE_TABLE(pci, rt2800pci_device_table);
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index 36ac18ca8082..b5c67f656cfd 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -1248,7 +1248,6 @@ static const struct usb_device_id rt2800usb_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT2800 USB Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2870 USB chipset based cards");
 MODULE_DEVICE_TABLE(usb, rt2800usb_device_table);
 MODULE_FIRMWARE(FIRMWARE_RT2870);
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 02da5dd37ddd..82cfc2aadc2b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2993,8 +2993,6 @@ static const struct pci_device_id rt61pci_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT61 PCI & PCMCIA Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2561, RT2561s & RT2661 "
-			"PCI & PCMCIA chipset based cards");
 MODULE_DEVICE_TABLE(pci, rt61pci_device_table);
 MODULE_FIRMWARE(FIRMWARE_RT2561);
 MODULE_FIRMWARE(FIRMWARE_RT2561s);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index e69793773d87..5ff2c740c3ea 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2513,7 +2513,6 @@ static const struct usb_device_id rt73usb_device_table[] = {
 MODULE_AUTHOR(DRV_PROJECT);
 MODULE_VERSION(DRV_VERSION);
 MODULE_DESCRIPTION("Ralink RT73 USB Wireless LAN driver.");
-MODULE_SUPPORTED_DEVICE("Ralink RT2571W & RT2671 USB chipset based cards");
 MODULE_DEVICE_TABLE(usb, rt73usb_device_table);
 MODULE_FIRMWARE(FIRMWARE_RT2571);
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 9a3d2439a8e7..d98483298555 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -441,6 +441,5 @@ module_init(rsi_91x_hal_module_init);
 module_exit(rsi_91x_hal_module_exit);
 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Station driver for RSI 91x devices");
-MODULE_SUPPORTED_DEVICE("RSI-91x");
 MODULE_VERSION("0.1");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 592e9dadcb55..fe0287b22a25 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1571,7 +1571,6 @@ module_exit(rsi_module_exit);

 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Common SDIO layer for RSI drivers");
-MODULE_SUPPORTED_DEVICE("RSI-91x");
 MODULE_DEVICE_TABLE(sdio, rsi_dev_table);
 MODULE_FIRMWARE(FIRMWARE_RSI9113);
 MODULE_VERSION("0.1");
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index a4a533c2a783..3fbe2a3c1455 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -928,7 +928,6 @@ module_usb_driver(rsi_driver);

 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Common USB layer for RSI drivers");
-MODULE_SUPPORTED_DEVICE("RSI-91x");
 MODULE_DEVICE_TABLE(usb, rsi_dev_table);
 MODULE_FIRMWARE(FIRMWARE_RSI9113);
 MODULE_VERSION("0.1");
diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 1e88bcfe0d7b..84d5701d606c 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -241,6 +241,5 @@ module_platform_driver_probe(amiga_parallel_driver, amiga_parallel_probe);

 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Parport Driver for Amiga builtin Port");
-MODULE_SUPPORTED_DEVICE("Amiga builtin Parallel Port");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:amiga-parallel");
diff --git a/drivers/parport/parport_atari.c b/drivers/parport/parport_atari.c
index 2ff0fe053e6e..1623f010cdcc 100644
--- a/drivers/parport/parport_atari.c
+++ b/drivers/parport/parport_atari.c
@@ -218,7 +218,6 @@ static void __exit parport_atari_exit(void)

 MODULE_AUTHOR("Andreas Schwab");
 MODULE_DESCRIPTION("Parport Driver for Atari builtin Port");
-MODULE_SUPPORTED_DEVICE("Atari builtin Parallel Port");
 MODULE_LICENSE("GPL");

 module_init(parport_atari_init)
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 9228e8f90309..1e43b3f399a8 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -41,7 +41,6 @@

 MODULE_AUTHOR("Helge Deller <deller@gmx.de>");
 MODULE_DESCRIPTION("HP-PARISC PC-style parallel port driver");
-MODULE_SUPPORTED_DEVICE("integrated PC-style parallel port");
 MODULE_LICENSE("GPL");


diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index d6bbe8446301..f4d0da741e85 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -359,7 +359,6 @@ static void __exit parport_mfc3_exit(void)

 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Parport Driver for Multiface 3 expansion cards Parallel Port");
-MODULE_SUPPORTED_DEVICE("Multiface 3 Parallel Port");
 MODULE_LICENSE("GPL");

 module_init(parport_mfc3_init)
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index e840c1b5ab90..865fc41dbb6c 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -377,6 +377,5 @@ module_platform_driver(bpp_sbus_driver);

 MODULE_AUTHOR("Derrick J Brashear");
 MODULE_DESCRIPTION("Parport Driver for Sparc bidirectional Port");
-MODULE_SUPPORTED_DEVICE("Sparc Bidirectional Parallel Port");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 28c04a4efa66..664fc19f60e4 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -63,7 +63,6 @@ void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
 MODULE_AUTHOR("Holger Smolinski <Holger.Smolinski@de.ibm.com>");
 MODULE_DESCRIPTION("Linux on S/390 DASD device driver,"
 		   " Copyright IBM Corp. 2000");
-MODULE_SUPPORTED_DEVICE("dasd");
 MODULE_LICENSE("GPL");

 /*
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 00e72b97d0b6..d93595b39afa 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -50,7 +50,6 @@ MODULE_PARM_DESC(sol_compat,
 MODULE_AUTHOR("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION("7-Segment Display driver for Sun Microsystems CP1400/1500");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("d7s");

 struct d7s {
 	void __iomem	*regs;
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 38369766511c..f135a10f582b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -80,7 +80,6 @@
 MODULE_AUTHOR("Hewlett-Packard Company");
 MODULE_DESCRIPTION("Driver for HP Smart Array Controller version " \
 	HPSA_DRIVER_VERSION);
-MODULE_SUPPORTED_DEVICE("HP Smart Array Controllers");
 MODULE_VERSION(HPSA_DRIVER_VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("cciss");
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 5d5f50d6a02d..ac89002646a3 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -55,7 +55,6 @@

 MODULE_AUTHOR("YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>");
 MODULE_DESCRIPTION("WorkBit NinjaSCSI-3 / NinjaSCSI-32Bi(16bit) PCMCIA SCSI host adapter module");
-MODULE_SUPPORTED_DEVICE("sd,sr,sg,st");
 MODULE_LICENSE("GPL");

 #include "nsp_io.h"
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c53f456fbd09..a1dacb6e993e 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -48,7 +48,6 @@
 MODULE_AUTHOR("Microsemi");
 MODULE_DESCRIPTION("Driver for Microsemi Smart Family Controller version "
 	DRIVER_VERSION);
-MODULE_SUPPORTED_DEVICE("Microsemi Smart Family Controllers");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL");

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e5d7fb81ad66..bd0fbcdbdefe 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -30,7 +30,6 @@
 MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
 MODULE_DESCRIPTION("Maple bus driver for Dreamcast");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{SEGA, Dreamcast/Maple}}");

 static void maple_dma_handler(struct work_struct *work);
 static void maple_vblank_handler(struct work_struct *work);
diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index 7956abcbae22..9f920819cd74 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -877,5 +877,4 @@ module_comedi_usb_driver(vmk80xx_driver, vmk80xx_usb_driver);

 MODULE_AUTHOR("Manuel Gebele <forensixs@gmx.de>");
 MODULE_DESCRIPTION("Velleman USB Board Low-Level Driver");
-MODULE_SUPPORTED_DEVICE("K8055/K8061 aka VM110/VM140");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..319a1e701163 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -747,7 +747,6 @@ module_platform_driver(optee_driver);

 MODULE_AUTHOR("Linaro");
 MODULE_DESCRIPTION("OP-TEE driver");
-MODULE_SUPPORTED_DEVICE("");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:optee");
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 9a872750581c..94af7a5ea497 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1639,8 +1639,6 @@ module_exit(icom_exit);

 MODULE_AUTHOR("Michael Anderson <mjanders@us.ibm.com>");
 MODULE_DESCRIPTION("IBM iSeries Serial IOA driver");
-MODULE_SUPPORTED_DEVICE
-    ("IBM iSeries 2745, 2771, 2772, 2742, 2793 and 2805 Communications adapters");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("icom_call_setup.bin");
 MODULE_FIRMWARE("icom_res_dce.bin");
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index cd30da0ef083..0ea799bf8dbb 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -19,7 +19,6 @@
 MODULE_AUTHOR("Digi International, https://www.digi.com");
 MODULE_DESCRIPTION("Driver for the Digi International Neo and Classic PCI based product line");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("jsm");

 #define JSM_DRIVER_NAME "jsm"
 #define NR_PORTS	32
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 670e4d91e9ca..dcc88df72df4 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -117,7 +117,6 @@ MODULE_DEVICE_TABLE(usb, ld_usb_table);
 MODULE_AUTHOR("Michael Hund <mhund@ld-didactic.de>");
 MODULE_DESCRIPTION("LD USB Driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("LD USB Devices");

 /* All interrupt in transfers are collected in a ring buffer to
  * avoid racing conditions and get better performance of the driver.
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 9867a3a936df..688b112e712b 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -273,7 +273,6 @@ module_exit(cpu5wdt_exit_module);

 MODULE_AUTHOR("Heiko Ronsdorf <hero@ihg.uni-duisburg.de>");
 MODULE_DESCRIPTION("sma cpu5 watchdog driver");
-MODULE_SUPPORTED_DEVICE("sma cpu5 watchdog");
 MODULE_LICENSE("GPL");

 module_param_hw(port, int, ioport, 0);
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 808eeb4779e4..1eafe0b4d71c 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -172,7 +172,6 @@ MODULE_PARM_DESC(wd2_timeout, "Default watchdog2 timeout in 1/10secs");
 MODULE_AUTHOR("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION("Hardware watchdog driver for Sun Microsystems CP1400/1500");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("watchdog");

 static void cpwd_writew(u16 val, void __iomem *addr)
 {
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 7008596a575f..747e346ed06c 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -46,7 +46,6 @@

 MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Hardware watchdog driver for Sun RIO");
-MODULE_SUPPORTED_DEVICE("watchdog");
 MODULE_LICENSE("GPL");

 #define DRIVER_NAME	"riowd"
diff --git a/include/linux/module.h b/include/linux/module.h
index 59f094fa6f74..da4b6fbe8ebe 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -30,9 +30,6 @@
 #include <linux/percpu.h>
 #include <asm/module.h>

-/* Not Yet Implemented */
-#define MODULE_SUPPORTED_DEVICE(name)
-
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN

 struct modversion_info {
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e48f7ac8a854..3ddd66e4c29e 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -702,7 +702,6 @@ MODULE_LICENSE("GPL");

 MODULE_AUTHOR(BATADV_DRIVER_AUTHOR);
 MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
-MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
 MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
 MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 8a24e5ae7cef..52637180af33 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -33,7 +33,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("A loopback soundcard");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ALSA,Loopback soundcard}}");

 #define MAX_PCM_SUBSTREAMS	8

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 316c9afadefe..01a3eab50d7b 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -25,7 +25,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Dummy soundcard (/dev/null)");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ALSA,Dummy soundcard}}");

 #define MAX_PCM_DEVICES		4
 #define MAX_PCM_SUBSTREAMS	128
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index ce5fd17bd720..df4b7f9cd50f 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -53,7 +53,6 @@
 MODULE_AUTHOR("Michael T. Mayers");
 MODULE_DESCRIPTION("MOTU MidiTimePiece AV multiport MIDI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{MOTU,MidiTimePiece AV multiport MIDI}}");

 // io resources
 #define MTPAV_IOBASE		0x378
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 9c708b693cb3..322d530ab07b 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -37,7 +37,6 @@ MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 MODULE_AUTHOR("Matthias Koenig <mk@phasorlab.de>");
 MODULE_DESCRIPTION("ESI Miditerminal 4140");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESI,Miditerminal 4140}}");

 /*********************************************************************
  * Chip specific
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index fd79e57c85ca..7689fa2f9531 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -22,7 +22,6 @@
 MODULE_AUTHOR("Stas Sergeev <stsp@users.sourceforge.net>");
 MODULE_DESCRIPTION("PC-Speaker driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{PC-Speaker, pcsp}}");
 MODULE_ALIAS("platform:pcspkr");

 static int index = SNDRV_DEFAULT_IDX1;	/* Index 0-MAX */
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index c876cf9b5005..2f4514ed47c5 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -57,7 +57,6 @@ MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 MODULE_AUTHOR("Levent Guendogdu, Tobias Gehrig, Matthias Koenig");
 MODULE_DESCRIPTION("Midiman Portman2x4");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Midiman,Portman2x4}}");

 /*********************************************************************
  * Chip specific
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 3947f084dd6b..6d5d1ca59ecf 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -34,7 +34,6 @@

 MODULE_DESCRIPTION("MIDI serial u16550");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ALSA, MIDI serial u16550}}");

 #define SNDRV_SERIAL_SOUNDCANVAS 0 /* Roland Soundcanvas; F5 NN selects part */
 #define SNDRV_SERIAL_MS124T 1      /* Midiator MS-124T */
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index f1fb68b15498..4206d93ab47e 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -43,7 +43,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("Dummy soundcard for virtual rawmidi devices");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ALSA,Virtual rawmidi device}}");

 #define MAX_MIDI_DEVICES	4

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index ca18fe3ff8a5..f11af983b3b6 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -22,13 +22,6 @@
 MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_DESCRIPTION("AD1816A, AD1815");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Highscreen,Sound-Boostar 16 3D},"
-		"{Analog Devices,AD1815},"
-		"{Analog Devices,AD1816A},"
-		"{TerraTec,Base 64},"
-		"{TerraTec,AudioSystem EWS64S},"
-		"{Aztech/Newcom SC-16 3D},"
-		"{Shark Predator ISA}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 1-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 6f221eed44e2..edafb49797e7 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -22,9 +22,6 @@
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Tugrul Galatali <galatalt@stuy.edu>, Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1848},"
-	        "{Analog Devices,AD1847},"
-		"{Crystal Semiconductors,CS4248}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 1085f5b01318..bacb7a1b930c 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -26,17 +26,6 @@
 #define PFX "als100: "

 MODULE_DESCRIPTION("Avance Logic ALS007/ALS1X0");
-MODULE_SUPPORTED_DEVICE("{{Diamond Technologies DT-019X},"
-		"{Avance Logic ALS-007}}"
-		"{{Avance Logic,ALS100 - PRO16PNP},"
-	        "{Avance Logic,ALS110},"
-	        "{Avance Logic,ALS120},"
-	        "{Avance Logic,ALS200},"
-	        "{3D Melody,MF1000},"
-	        "{Digimate,3D Sound},"
-	        "{Avance Logic,ALS120},"
-	        "{RTL,RTL3000}}");
-
 MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_LICENSE("GPL");

diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 4ed52094fc8d..867e9ae8f65a 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -35,11 +35,6 @@
 MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_DESCRIPTION("Aztech Systems AZT2320");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Aztech Systems,PRO16V},"
-		"{Aztech Systems,AZT2320},"
-		"{Aztech Systems,AZT3300},"
-		"{Aztech Systems,AZT2320},"
-		"{Aztech Systems,AZT3000}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 19e258527d69..bc112df10fc5 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -51,7 +51,6 @@
 MODULE_AUTHOR("George Talusan <gstalusan@uwaterloo.ca>");
 MODULE_DESCRIPTION("C-Media CMI8330/CMI8329");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{C-Media,CMI8330,isapnp:{CMI0001,@@@0001,@X@0001}}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index c56cbc072918..ec054b929214 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -23,7 +23,6 @@
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Crystal Semiconductors,CS4231}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 63fb0cb754d0..186d7d4db45e 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -18,40 +18,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cirrus Logic CS4232-9");
-MODULE_SUPPORTED_DEVICE("{{Turtle Beach,TBS-2000},"
-		"{Turtle Beach,Tropez Plus},"
-		"{SIC CrystalWave 32},"
-		"{Hewlett Packard,Omnibook 5500},"
-		"{TerraTec,Maestro 32/96},"
-		"{Philips,PCA70PS}},"
-		"{{Crystal Semiconductors,CS4235},"
-		"{Crystal Semiconductors,CS4236},"
-		"{Crystal Semiconductors,CS4237},"
-		"{Crystal Semiconductors,CS4238},"
-		"{Crystal Semiconductors,CS4239},"
-		"{Acer,AW37},"
-		"{Acer,AW35/Pro},"
-		"{Crystal,3D},"
-		"{Crystal Computer,TidalWave128},"
-		"{Dell,Optiplex GX1},"
-		"{Dell,Workstation 400 sound},"
-		"{EliteGroup,P5TX-LA sound},"
-		"{Gallant,SC-70P},"
-		"{Gateway,E1000 Onboard CS4236B},"
-		"{Genius,Sound Maker 3DJ},"
-		"{Hewlett Packard,HP6330 sound},"
-		"{IBM,PC 300PL sound},"
-		"{IBM,Aptiva 2137 E24},"
-		"{IBM,IntelliStation M Pro},"
-		"{Intel,Marlin Spike Mobo CS4235},"
-		"{Intel PR440FX Onboard},"
-		"{Guillemot,MaxiSound 16 PnP},"
-		"{NewClear,3D},"
-		"{TerraTec,AudioSystem EWS64L/XL},"
-		"{Typhoon Soundsystem,CS4236B},"
-		"{Turtle Beach,Malibu},"
-		"{Unknown,Digital PC 5000 Onboard}}");
-
 MODULE_ALIAS("snd_cs4232");

 #define IDENT "CS4232+"
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 4a1f61f1a331..750d4995634f 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -26,11 +26,6 @@
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,ES688 PnP AudioDrive,pnp:ESS0100},"
-	        "{ESS,ES1688 PnP AudioDrive,pnp:ESS0102},"
-	        "{ESS,ES688 AudioDrive,pnp:ESS6881},"
-	        "{ESS,ES1688 AudioDrive,pnp:ESS1681}}");
-
 MODULE_ALIAS("snd_es968");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 9beef8079177..b70bd4a0c0de 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1932,14 +1932,6 @@ static int snd_es18xx_mixer(struct snd_card *card)
 MODULE_AUTHOR("Christian Fischbach <fishbach@pool.informatik.rwth-aachen.de>, Abramo Bagnara <abramo@alsa-project.org>");
 MODULE_DESCRIPTION("ESS ES18xx AudioDrive");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,ES1868 PnP AudioDrive},"
-		"{ESS,ES1869 PnP AudioDrive},"
-		"{ESS,ES1878 PnP AudioDrive},"
-		"{ESS,ES1879 PnP AudioDrive},"
-		"{ESS,ES1887 PnP AudioDrive},"
-		"{ESS,ES1888 PnP AudioDrive},"
-		"{ESS,ES1887 AudioDrive},"
-		"{ESS,ES1888 AudioDrive}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 015f88a11352..0fba5d8fe84f 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -23,7 +23,6 @@
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Classic}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index c9f31b4fb887..da2b2ca6b721 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -27,7 +27,6 @@
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Extreme}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index dc09fbd6f88d..24b945f1768d 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -21,7 +21,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Gravis UltraSound MAX");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound MAX}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index e4d412e72b75..99581fba4ca8 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -28,14 +28,8 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
 #ifndef SNDRV_STB
 MODULE_DESCRIPTION("AMD InterWave");
-MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Plug & Play},"
-		"{STB,SoundRage32},"
-		"{MED,MED3210},"
-		"{Dynasonix,Dynasonix Pro},"
-		"{Panasonic,PCA761AW}}");
 #else
 MODULE_DESCRIPTION("AMD InterWave STB with TEA6330T");
-MODULE_SUPPORTED_DEVICE("{{AMD,InterWave STB with TEA6330T}}");
 #endif

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 7649a8a4128d..9bde11d1cfe8 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -22,11 +22,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Yamaha OPL3SA2+");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Yamaha,YMF719E-S},"
-		"{Genius,Sound Maker 3DX},"
-		"{Yamaha,OPL3SA3},"
-		"{Intel,AL440LX sound},"
-	        "{NeoMagic,MagicWave 3DX}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 20933342f5eb..a510b201143c 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -33,9 +33,6 @@
 MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Miro miroSOUND PCM1 pro, PCM12, PCM20 Radio");
-MODULE_SUPPORTED_DEVICE("{{Miro,miroSOUND PCM1 pro}, "
-			"{Miro,miroSOUND PCM12}, "
-			"{Miro,miroSOUND PCM20 Radio}}");

 static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 758f5b579138..08e61d90057b 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -36,17 +36,11 @@ MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_LICENSE("GPL");
 #ifdef OPTi93X
 MODULE_DESCRIPTION("OPTi93X");
-MODULE_SUPPORTED_DEVICE("{{OPTi,82C931/3}}");
 #else	/* OPTi93X */
 #ifdef CS4231
 MODULE_DESCRIPTION("OPTi92X - CS4231");
-MODULE_SUPPORTED_DEVICE("{{OPTi,82C924 (CS4231)},"
-		"{OPTi,82C925 (CS4231)}}");
 #else	/* CS4231 */
 MODULE_DESCRIPTION("OPTi92X - AD1848");
-MODULE_SUPPORTED_DEVICE("{{OPTi,82C924 (AD1848)},"
-		"{OPTi,82C925 (AD1848)},"
-	        "{OAK,Mozart}}");
 #endif	/* CS4231 */
 #endif	/* OPTi93X */

diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 0e2e0ab3b9e4..7ba5dd1ec810 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -28,9 +28,6 @@
 #define PFX "jazz16: "

 MODULE_DESCRIPTION("Media Vision Jazz16");
-MODULE_SUPPORTED_DEVICE("{{Media Vision ??? },"
-		"{RTL,RTL3000}}");
-
 MODULE_AUTHOR("Krzysztof Helt <krzysztof.h1@wp.pl>");
 MODULE_LICENSE("GPL");

diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index db284b7b88a7..63ef960abd25 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -31,16 +31,8 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_LICENSE("GPL");
 #ifndef SNDRV_SBAWE
 MODULE_DESCRIPTION("Sound Blaster 16");
-MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB 16},"
-		"{Creative Labs,SB Vibra16S},"
-		"{Creative Labs,SB Vibra16C},"
-		"{Creative Labs,SB Vibra16CL},"
-		"{Creative Labs,SB Vibra16X}}");
 #else
 MODULE_DESCRIPTION("Sound Blaster AWE");
-MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB AWE 32},"
-		"{Creative Labs,SB AWE 64},"
-		"{Creative Labs,SB AWE 64 Gold}}");
 #endif

 #if 0
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 8e3e67b9a341..6c9d534ce8b6 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -17,7 +17,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Sound Blaster 1.0/2.0/Pro");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB 1.0/SB 2.0/SB Pro}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index def137579717..3462663050bb 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -29,9 +29,6 @@
 MODULE_AUTHOR("Krzysztof Helt");
 MODULE_DESCRIPTION("Gallant SC-6000");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Gallant, SC-6000},"
-			"{AudioExcel, Audio Excel DSP 16},"
-			"{Zoltrix, AV302}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index b750a4fd40de..a4437971df2f 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -21,7 +21,6 @@
 MODULE_AUTHOR("Paul Barton-Davis <pbd@op.net>");
 MODULE_DESCRIPTION("Turtle Beach Wavefront");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Turtle Beach,Maui/Tropez/Tropez+}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	    /* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	    /* ID for this card */
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 5bf1ea150f26..989f656e2de7 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -32,7 +32,6 @@
 MODULE_AUTHOR("Vivien Chappelier <vivien.chappelier@linux-mips.org>");
 MODULE_DESCRIPTION("SGI O2 Audio");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Silicon Graphics, O2 Audio}}");

 static int index = SNDRV_DEFAULT_IDX1;  /* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;   /* ID for this card */
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 5d835d2af054..4520022801d9 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -43,7 +43,6 @@
 MODULE_AUTHOR("Kyle McMartin <kyle@parisc-linux.org>, Thibaut Varene <t-bone@parisc-linux.org>");
 MODULE_DESCRIPTION("Analog Devices AD1889 ALSA sound driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1889}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 module_param_array(index, int, NULL, 0444);
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 51f24796f03f..0d66b92466d5 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -29,7 +29,6 @@
 MODULE_AUTHOR("Matt Wu <Matt_Wu@acersoftech.com.cn>");
 MODULE_DESCRIPTION("ALI M5451");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ALI,M5451,pci},{ALI,M5451}}");

 static int index = SNDRV_DEFAULT_IDX1;	/* Index */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 1dc8c4ed0592..bd4fd09e982b 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -86,7 +86,6 @@ enum {DEVICE_ALS300, DEVICE_ALS300_PLUS};
 MODULE_AUTHOR("Ash Willis <ashwillis@programmer.net>");
 MODULE_DESCRIPTION("Avance Logic ALS300");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS300},{Avance Logic,ALS300+}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 2edc7455285a..139ac2a3a0ef 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -68,7 +68,6 @@
 MODULE_AUTHOR("Bart Hartgers <bart@etpmod.phys.tue.nl>, Andreas Mohr");
 MODULE_DESCRIPTION("Avance Logic ALS4000");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS4000}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a25d75455802..579425ccbb6a 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -23,7 +23,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ATI IXP AC97 controller");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ATI,IXP150/200/250/300/400/600}}");

 static int index = SNDRV_DEFAULT_IDX1;	/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index ae88217d685a..45e75afec7a0 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -23,7 +23,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ATI IXP MC97 controller");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ATI,IXP150/200/250}}");

 static int index = -2; /* Exclude the first card */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 5dd98e6ff34b..1b37b7225b1d 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -41,8 +41,6 @@ MODULE_PARM_DESC(pcifix, "Enable VIA-workaround for " CARD_NAME " soundcard.");

 MODULE_DESCRIPTION("Aureal vortex");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Aureal Semiconductor Inc., Aureal Vortex Sound Processor}}");
-
 MODULE_DEVICE_TABLE(pci, snd_vortex_ids);

 static void vortex_fix_latency(struct pci_dev *vortex)
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 2ac594dcf21c..51dcf1bc4c0c 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -196,7 +196,6 @@
 MODULE_AUTHOR("Andreas Mohr <andi AT lisas.de>");
 MODULE_DESCRIPTION("Aztech AZF3328 (PCI168)");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Aztech,AZF3328}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_GAMEPORT 1
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index cf9f8d80a0b6..91512b345d19 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -23,8 +23,6 @@
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("Brooktree Bt87x audio driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Brooktree,Bt878},"
-		"{Brooktree,Bt879}}");

 static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /* Exclude the first card */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index ee20f9a1aae9..bee4710916c4 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -137,7 +137,6 @@
 MODULE_AUTHOR("James Courtier-Dutton <James@superbug.demon.co.uk>");
 MODULE_DESCRIPTION("CA0106");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Creative,SB CA0106 chip}}");

 // module parameters (see "Module Parameters")
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 7363d61eaec2..598446348da6 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -30,10 +30,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("C-Media CMI8x38 PCI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{C-Media,CMI8738},"
-		"{C-Media,CMI8738B},"
-		"{C-Media,CMI8338A},"
-		"{C-Media,CMI8338B}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 94d2a6a466a8..bf3bb70ffaf9 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -25,7 +25,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Cirrus Logic CS4281");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Cirrus Logic,CS4281}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index a6e0a4439332..1db7b4112840 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -21,13 +21,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Cirrus Logic Sound Fusion CS46XX");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Cirrus Logic,Sound Fusion (CS4280)},"
-		"{Cirrus Logic,Sound Fusion (CS4610)},"
-		"{Cirrus Logic,Sound Fusion (CS4612)},"
-		"{Cirrus Logic,Sound Fusion (CS4615)},"
-		"{Cirrus Logic,Sound Fusion (CS4622)},"
-		"{Cirrus Logic,Sound Fusion (CS4624)},"
-		"{Cirrus Logic,Sound Fusion (CS4630)}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 359bc6af8670..9b716b56d739 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -393,4 +393,3 @@ module_pci_driver(cs5535audio_driver);
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("CS5535 Audio");
-MODULE_SUPPORTED_DEVICE("CS5535 Audio");
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index 8c07c6463c24..713d36ea40cb 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -18,7 +18,6 @@
 MODULE_AUTHOR("Creative Technology Ltd");
 MODULE_DESCRIPTION("X-Fi driver version 1.03");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{Creative Labs, Sound Blaster X-Fi}");

 static unsigned int reference_rate = 48000;
 static unsigned int multiple = 2;
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index a20b2bb5c898..9bd67ac33657 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -10,7 +10,6 @@
 MODULE_AUTHOR("Giuliano Pochini <pochini@shiny.it>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Echoaudio " ECHOCARD_NAME " soundcards driver");
-MODULE_SUPPORTED_DEVICE("{{Echoaudio," ECHOCARD_NAME "}}");
 MODULE_DEVICE_TABLE(pci, snd_echo_ids);

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 353934c88cbd..45833bc2a7e7 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -18,8 +18,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("EMU10K1");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
-	       "{Creative Labs,SB Audigy}}");

 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
 #define ENABLE_SYNTH
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 785ec0cf3933..d9a12cd01647 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -31,7 +31,6 @@
 MODULE_AUTHOR("Francisco Moraes <fmoraes@nc.rr.com>");
 MODULE_DESCRIPTION("EMU10K1X");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Dell Creative Labs,SB Live!}");

 // module parameters (see "Module Parameters")
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 93c4fd313311..3ccccdbc0029 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -52,17 +52,9 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Thomas Sailer <sailer@ife.ee.et
 MODULE_LICENSE("GPL");
 #ifdef CHIP1370
 MODULE_DESCRIPTION("Ensoniq AudioPCI ES1370");
-MODULE_SUPPORTED_DEVICE("{{Ensoniq,AudioPCI-97 ES1370},"
-	        "{Creative Labs,SB PCI64/128 (ES1370)}}");
 #endif
 #ifdef CHIP1371
 MODULE_DESCRIPTION("Ensoniq/Creative AudioPCI ES1371+");
-MODULE_SUPPORTED_DEVICE("{{Ensoniq,AudioPCI ES1371/73},"
-		"{Ensoniq,AudioPCI ES1373},"
-		"{Creative Labs,Ectiva EV1938},"
-		"{Creative Labs,SB PCI64/128 (ES1371/73)},"
-		"{Creative Labs,Vibra PCI128},"
-		"{Ectiva,EV1938}}");
 #endif

 #if IS_REACHABLE(CONFIG_GAMEPORT)
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 3b5d68ce9dd5..afc66347d162 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -52,10 +52,6 @@
 MODULE_AUTHOR("Jaromir Koutek <miri@punknet.cz>");
 MODULE_DESCRIPTION("ESS Solo-1");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,ES1938},"
-                "{ESS,ES1946},"
-                "{ESS,ES1969},"
-		"{TerraTec,128i PCI}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 747fa69bb1c9..5fa1861236f5 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -107,10 +107,6 @@

 MODULE_DESCRIPTION("ESS Maestro");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,Maestro 2e},"
-		"{ESS,Maestro 2},"
-		"{ESS,Maestro 1},"
-		"{TerraTec,DMX}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c6ad6235a669..6279eb156e36 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -26,8 +26,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("ForteMedia FM801");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ForteMedia,FM801},"
-		"{Genius,SoundMaker Live 5.1}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5b492c3f816c..c5a50b953f4c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -208,40 +208,6 @@ MODULE_PARM_DESC(snoop, "Enable/disable snooping");


 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},"
-			 "{Intel, ICH6M},"
-			 "{Intel, ICH7},"
-			 "{Intel, ESB2},"
-			 "{Intel, ICH8},"
-			 "{Intel, ICH9},"
-			 "{Intel, ICH10},"
-			 "{Intel, PCH},"
-			 "{Intel, CPT},"
-			 "{Intel, PPT},"
-			 "{Intel, LPT},"
-			 "{Intel, LPT_LP},"
-			 "{Intel, WPT_LP},"
-			 "{Intel, SPT},"
-			 "{Intel, SPT_LP},"
-			 "{Intel, HPT},"
-			 "{Intel, PBG},"
-			 "{Intel, SCH},"
-			 "{ATI, SB450},"
-			 "{ATI, SB600},"
-			 "{ATI, RS600},"
-			 "{ATI, RS690},"
-			 "{ATI, RS780},"
-			 "{ATI, R600},"
-			 "{ATI, RV630},"
-			 "{ATI, RV610},"
-			 "{ATI, RV670},"
-			 "{ATI, RV635},"
-			 "{ATI, RV620},"
-			 "{ATI, RV770},"
-			 "{VIA, VT8251},"
-			 "{VIA, VT8237A},"
-			 "{SiS, SIS966},"
-			 "{ULI, M5461}}");
 MODULE_DESCRIPTION("Intel HDA driver");

 #if defined(CONFIG_PM) && defined(CONFIG_VGA_SWITCHEROO)
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index f814dbbec2a4..d54cd5143e9f 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -60,12 +60,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("ICEnsemble ICE1712 (Envy24)");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{"
-	       HOONTECH_DEVICE_DESC
-	       DELTA_DEVICE_DESC
-	       EWS_DEVICE_DESC
-	       "{ICEnsemble,Generic ICE1712},"
-	       "{ICEnsemble,Generic Envy24}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index c0fca94c1dd2..ef2367d86148 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -44,25 +44,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("VIA ICEnsemble ICE1724/1720 (Envy24HT/PT)");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{"
-	       REVO_DEVICE_DESC
-	       AMP_AUDIO2000_DEVICE_DESC
-	       AUREON_DEVICE_DESC
-	       VT1720_MOBO_DEVICE_DESC
-	       PONTIS_DEVICE_DESC
-	       PRODIGY192_DEVICE_DESC
-	       PRODIGY_HIFI_DEVICE_DESC
-	       JULI_DEVICE_DESC
-	       MAYA44_DEVICE_DESC
-	       PHASE_DEVICE_DESC
-	       WTM_DEVICE_DESC
-	       SE_DEVICE_DESC
-	       QTET_DEVICE_DESC
-		"{VIA,VT1720},"
-		"{VIA,VT1724},"
-		"{ICEnsemble,Generic ICE1724},"
-		"{ICEnsemble,Generic Envy24HT}"
-		"{ICEnsemble,Generic Envy24PT}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 3349e455a871..35903d1a1cbd 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -27,29 +27,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; SiS 7012; Ali 5455");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
-		"{Intel,82901AB-ICH0},"
-		"{Intel,82801BA-ICH2},"
-		"{Intel,82801CA-ICH3},"
-		"{Intel,82801DB-ICH4},"
-		"{Intel,ICH5},"
-		"{Intel,ICH6},"
-		"{Intel,ICH7},"
-		"{Intel,6300ESB},"
-		"{Intel,ESB2},"
-		"{Intel,MX440},"
-		"{SiS,SI7012},"
-		"{NVidia,nForce Audio},"
-		"{NVidia,nForce2 Audio},"
-		"{NVidia,nForce3 Audio},"
-		"{NVidia,MCP04},"
-		"{NVidia,MCP501},"
-		"{NVidia,CK804},"
-		"{NVidia,CK8},"
-		"{NVidia,CK8S},"
-		"{AMD,AMD768},"
-		"{AMD,AMD8111},"
-	        "{ALI,M5455}}");

 static int index = SNDRV_DEFAULT_IDX1;	/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 19872cecc9d2..13ef838b26c1 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -25,21 +25,6 @@ MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; "
 		   "SiS 7013; NVidia MCP/2/2S/3 modems");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
-		"{Intel,82901AB-ICH0},"
-		"{Intel,82801BA-ICH2},"
-		"{Intel,82801CA-ICH3},"
-		"{Intel,82801DB-ICH4},"
-		"{Intel,ICH5},"
-		"{Intel,ICH6},"
-		"{Intel,ICH7},"
-	        "{Intel,MX440},"
-		"{SiS,7013},"
-		"{NVidia,NForce Modem},"
-		"{NVidia,NForce2 Modem},"
-		"{NVidia,NForce2s Modem},"
-		"{NVidia,NForce3 Modem},"
-		"{AMD,AMD768}}");

 static int index = -2; /* Exclude the first card */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 2eddd9de9e6d..80ac3c6152ad 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -388,7 +388,6 @@ struct snd_korg1212 {

 MODULE_DESCRIPTION("korg1212");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{KORG,korg1212}}");
 MODULE_FIRMWARE("korg/k1212.dsp");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;     /* Index 0-MAX */
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 491c90f83fbc..03b4be44bb26 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -54,7 +54,6 @@ MODULE_PARM_DESC(sample_rate_min, "Minimal sample rate");
  */

 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Digigram, Lola}}");
 MODULE_DESCRIPTION("Digigram Lola driver");
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index b92ea074ff2a..1be97c38bc71 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -21,8 +21,6 @@
 MODULE_AUTHOR("Tim Blechmann");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("digigram lx6464es");
-MODULE_SUPPORTED_DEVICE("{digigram lx6464es{}}");
-

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index d2c2cd6006f0..cdc4b6106252 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -39,11 +39,6 @@
 MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ESS Maestro3 PCI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,Maestro3 PCI},"
-		"{ESS,ES1988},"
-		"{ESS,Allegro PCI},"
-		"{ESS,Allegro-1 PCI},"
-	        "{ESS,Canyon3D-2/LE PCI}}");
 MODULE_FIRMWARE("ess/maestro3_assp_kernel.fw");
 MODULE_FIRMWARE("ess/maestro3_assp_minisrc.fw");

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index efff220b26ea..a0bbb386dc25 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -32,7 +32,6 @@
 MODULE_AUTHOR("Digigram <alsa@digigram.com>");
 MODULE_DESCRIPTION("Digigram " CARD_NAME);
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Digigram," CARD_NAME "}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;             /* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;              /* ID for this card */
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 975994623c2c..6cb689aa28c2 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -32,8 +32,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("NeoMagic NM256AV/ZX");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{NeoMagic,NM256AV},"
-		"{NeoMagic,NM256ZX}}");

 /*
  * some compile conditions.
diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index a751fcce7c8e..e335c4b5b381 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -56,9 +56,6 @@
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("C-Media CMI8788 driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{C-Media,CMI8786}"
-			",{C-Media,CMI8787}"
-			",{C-Media,CMI8788}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/oxygen/se6x.c b/sound/pci/oxygen/se6x.c
index 78c35a0a5477..434f885f6f91 100644
--- a/sound/pci/oxygen/se6x.c
+++ b/sound/pci/oxygen/se6x.c
@@ -29,7 +29,6 @@
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("Studio Evolution SE6X driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{Studio Evolution,SE6X}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
index 98ab16329827..baa3244d4dab 100644
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -16,7 +16,6 @@
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("Asus Virtuoso driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{Asus,AV66},{Asus,AV100},{Asus,AV200}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index c2e4831c3a13..751f9744b089 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -35,7 +35,6 @@ MODULE_AUTHOR("Markus Bollinger <bollinger@digigram.com>, "
 	      "Marc Titinger <titinger@digigram.com>");
 MODULE_DESCRIPTION("Digigram " DRIVER_NAME " " PCXHR_DRIVER_VERSION_STRING);
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Digigram," DRIVER_NAME "}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index fcc2073c5025..56827db97239 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -103,7 +103,6 @@
 MODULE_AUTHOR("Peter Gruber <nokos@gmx.net>");
 MODULE_DESCRIPTION("riptide");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Conexant,Riptide}}");
 MODULE_FIRMWARE("riptide.hex");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 4eabece4dcba..54f3e39f97f5 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -88,7 +88,6 @@ MODULE_PARM_DESC(fullduplex, "Support full-duplex mode.");
 MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>, Pilo Chambert <pilo.c@wanadoo.fr>");
 MODULE_DESCRIPTION("RME Digi32, Digi32/8, Digi32 PRO");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{RME,Digi32}," "{RME,Digi32/8}," "{RME,Digi32 PRO}}");

 /* Defines for RME Digi32 series */
 #define RME32_SPDIF_NCHANNELS 2
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 84eef6a3739f..66082e9f526d 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -31,11 +31,6 @@ MODULE_AUTHOR("Anders Torger <torger@ludd.luth.se>");
 MODULE_DESCRIPTION("RME Digi96, Digi96/8, Digi96/8 PRO, Digi96/8 PST, "
 		   "Digi96/8 PAD");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{RME,Digi96},"
-		"{RME,Digi96/8},"
-		"{RME,Digi96/8 PRO},"
-		"{RME,Digi96/8 PST},"
-		"{RME,Digi96/8 PAD}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 6d9029333a12..4cf879c42dc4 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -44,9 +44,6 @@ MODULE_PARM_DESC(enable, "Enable/disable specific Hammerfall DSP soundcards.");
 MODULE_AUTHOR("Paul Davis <paul@linuxaudiosystems.com>, Marcus Andersson, Thomas Charbonnel <thomas@undata.org>");
 MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{RME Hammerfall-DSP},"
-	        "{RME HDSP-9652},"
-		"{RME HDSP-9632}}");
 MODULE_FIRMWARE("rpm_firmware.bin");
 MODULE_FIRMWARE("multiface_firmware.bin");
 MODULE_FIRMWARE("multiface_firmware_rev11.bin");
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index b66711574b1a..8d900c132f0f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -165,7 +165,6 @@ MODULE_AUTHOR
 );
 MODULE_DESCRIPTION("RME HDSPM");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");

 /* --- Write registers. ---
   These are defined as byte-offsets from the iobase value.  */
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 012fbec5e6a7..da5dcf4333c0 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -39,14 +39,12 @@ MODULE_PARM_DESC(precise_ptr, "Enable precise pointer (doesn't work reliably).")
 MODULE_AUTHOR("Paul Davis <pbd@op.net>, Winfried Ritsch");
 MODULE_DESCRIPTION("RME Digi9652/Digi9636");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{RME,Hammerfall},"
-		"{RME,Hammerfall-Light}}");

 /* The Hammerfall has two sets of 24 ADAT + 2 S/PDIF channels, one for
    capture, one for playback. Both the ADAT and S/PDIF channels appear
    to the host CPU in the same block of memory. There is no functional
    difference between them in terms of access.
-
+
    The Hammerfall Light is identical to the Hammerfall, except that it
    has 2 sets 18 channels (16 ADAT + 2 S/PDIF) for capture and playback.
 */
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 8ffa2f53c0b5..00ab51c889da 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -24,7 +24,6 @@
 MODULE_AUTHOR("David Dillow <dave@thedillows.org>");
 MODULE_DESCRIPTION("SiS7019");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{SiS,SiS7019 Audio Accelerator}}");

 static int index = SNDRV_DEFAULT_IDX1;	/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 26fd1d08c179..7de10997775f 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -29,7 +29,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("S3 SonicVibes PCI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{S3,SonicVibes PCI}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index 5bc79da6e35e..a51041205f7c 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -17,18 +17,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, <audio@tridentmicro.com>");
 MODULE_DESCRIPTION("Trident 4D-WaveDX/NX & SiS SI7018");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Trident,4DWave DX},"
-		"{Trident,4DWave NX},"
-		"{SiS,SI7018 PCI Audio},"
-		"{Best Union,Miss Melody 4DWave PCI},"
-		"{HIS,4DWave PCI},"
-		"{Warpspeed,ONSpeed 4DWave PCI},"
-		"{Aztech Systems,PCI 64-Q3D},"
-		"{Addonics,SV 750},"
-		"{CHIC,True Sound 4Dwave},"
-		"{Shark,Predator4D-PCI},"
-		"{Jaton,SonicWave 4D},"
-		"{Hoontech,SoundTrack Digital 4DWave NX}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 154d88ce8813..fd1f2f9cfbc3 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -56,7 +56,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("VIA VT82xx audio");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{VIA,VT82C686A/B/C,pci},{VIA,VT8233A/C,8235}}");

 #if IS_REACHABLE(CONFIG_GAMEPORT)
 #define SUPPORT_JOYSTICK 1
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index addfa196df21..30253306f67c 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -38,7 +38,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("VIA VT82xx modem");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{VIA,VT82C686A/B/C modem,pci}}");

 static int index = -2; /* Exclude the first card */
 static char *id = SNDRV_DEFAULT_STR1;	/* ID for this card */
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index f7800ed1b67e..2a9e1a77a81a 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -20,7 +20,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("Digigram VX222 V2/Mic");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Digigram," CARD_NAME "}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index 9b0d18a7bf35..99be1490ef0e 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -17,12 +17,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Yamaha DS-1 PCI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Yamaha,YMF724},"
-		"{Yamaha,YMF724F},"
-		"{Yamaha,YMF740},"
-		"{Yamaha,YMF740C},"
-		"{Yamaha,YMF744},"
-		"{Yamaha,YMF754}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 27d9da6d61e8..144582350a05 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -22,7 +22,6 @@
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Sound Core " CARD_NAME);
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Sound Core," CARD_NAME "}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index afd30a90c807..636320489805 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -17,13 +17,9 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>

-/*
- */
-
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("Digigram VXPocket");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Digigram,VXPocket},{Digigram,VXPocket440}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index 96ef55082bf9..9fb51ebafde1 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -18,7 +18,6 @@
 #define CHIP_NAME "PMac"

 MODULE_DESCRIPTION("PowerMac");
-MODULE_SUPPORTED_DEVICE("{{Apple,PowerMac}}");
 MODULE_LICENSE("GPL");

 static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 8fa68432d3c1..6e9d6bd67369 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -32,7 +32,6 @@
 MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
 MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");
 MODULE_FIRMWARE("aica_firmware.bin");

 /* module parameters */
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index feb28502940f..8ebd972846ac 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -25,7 +25,6 @@
 MODULE_AUTHOR("Rafael Ignacio Zurita <rizurita@yahoo.com>");
 MODULE_DESCRIPTION("SuperH DAC audio driver");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{SuperH DAC audio support}}");

 /* Module Parameters */
 static int index = SNDRV_DEFAULT_IDX1;
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 9d0da5fa1c70..d24ae00878f5 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -62,7 +62,6 @@ MODULE_PARM_DESC(enable, "Enable Sun AMD7930 soundcard.");
 MODULE_AUTHOR("Thomas K. Dyas and David S. Miller");
 MODULE_DESCRIPTION("Sun AMD7930");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Sun,AMD7930}}");

 /* Device register layout.  */

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 0eed5f79a2bf..35c17803a430 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -52,7 +52,6 @@ MODULE_PARM_DESC(enable, "Enable Sun CS4231 soundcard.");
 MODULE_AUTHOR("Jaroslav Kysela, Derrick J. Brashear and David S. Miller");
 MODULE_DESCRIPTION("Sun CS4231");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Sun,CS4231}}");

 #ifdef SBUS_SUPPORT
 struct sbus_dma_info {
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 5a6fb66dd118..b055f5839578 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -76,7 +76,6 @@
 MODULE_AUTHOR("Rudolf Koenig, Brent Baccala and Martin Habets");
 MODULE_DESCRIPTION("Sun DBRI");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Sun,DBRI}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 08c6e6a52eb9..33e962178c93 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -26,7 +26,6 @@
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
 MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{TerraTec,DMX 6Fire USB}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for card */
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index e03481caf7f6..49f63f878e6f 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -26,20 +26,6 @@
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("caiaq USB audio");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Native Instruments,RigKontrol2},"
-			 "{Native Instruments,RigKontrol3},"
-			 "{Native Instruments,Kore Controller},"
-			 "{Native Instruments,Kore Controller 2},"
-			 "{Native Instruments,Audio Kontrol 1},"
-			 "{Native Instruments,Audio 2 DJ},"
-			 "{Native Instruments,Audio 4 DJ},"
-			 "{Native Instruments,Audio 8 DJ},"
-			 "{Native Instruments,Traktor Audio 2},"
-			 "{Native Instruments,Session I/O},"
-			 "{Native Instruments,GuitarRig mobile},"
-			 "{Native Instruments,Traktor Kontrol X1},"
-			 "{Native Instruments,Traktor Kontrol S4},"
-			 "{Native Instruments,Maschine Controller}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 85ed8507e41a..ae5dda6cf84c 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -58,8 +58,6 @@
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("USB Audio");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Generic,USB Audio}}");
-

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/usb/hiface/chip.c b/sound/usb/hiface/chip.c
index c2824188d142..95385e90882c 100644
--- a/sound/usb/hiface/chip.c
+++ b/sound/usb/hiface/chip.c
@@ -21,23 +21,6 @@ MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
 MODULE_AUTHOR("Antonio Ospite <ao2@amarulasolutions.com>");
 MODULE_DESCRIPTION("M2Tech hiFace USB-SPDIF audio driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{M2Tech,Young},"
-			 "{M2Tech,hiFace},"
-			 "{M2Tech,North Star},"
-			 "{M2Tech,W4S Young},"
-			 "{M2Tech,Corrson},"
-			 "{M2Tech,AUDIA},"
-			 "{M2Tech,SL Audio},"
-			 "{M2Tech,Empirical},"
-			 "{M2Tech,Rockna},"
-			 "{M2Tech,Pathos},"
-			 "{M2Tech,Metronome},"
-			 "{M2Tech,CAD},"
-			 "{M2Tech,Audio Esclusive},"
-			 "{M2Tech,Rotel},"
-			 "{M2Tech,Eeaudio},"
-			 "{The Chord Company,CHORD},"
-			 "{AVA Group A/S,Vitus}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for card */
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 6b30155964ec..5834d1dc317e 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -19,7 +19,6 @@
 MODULE_DESCRIPTION("Edirol UA-101/1000 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{Edirol,UA-101},{Edirol,UA-1000}}");

 /*
  * Should not be lower than the minimum scheduling delay of the host
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index c54158146917..3cd28d24f0a7 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -137,7 +137,6 @@
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
 MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.2");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604),"NAME_ALLCAPS"(0x8001)(0x8005)(0x8007)}}");

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 1d66c3a4fb10..33b12aa67cf5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1887,4 +1887,3 @@ MODULE_AUTHOR("Vaibhav Agarwal <vaibhav.agarwal@intel.com>");
 MODULE_AUTHOR("Jerome Anand <jerome.anand@intel.com>");
 MODULE_DESCRIPTION("Intel HDMI Audio driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{Intel,Intel_HAD}");
diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
index 228d82031297..2cb0a19be2b8 100644
--- a/sound/xen/xen_snd_front.c
+++ b/sound/xen/xen_snd_front.c
@@ -391,4 +391,3 @@ module_exit(xen_drv_fini);
 MODULE_DESCRIPTION("Xen virtual sound device frontend");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("xen:" XENSND_DRIVER_NAME);
-MODULE_SUPPORTED_DEVICE("{{ALSA,Virtual soundcard}}");
--
2.30.2

