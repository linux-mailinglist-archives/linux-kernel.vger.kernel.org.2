Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC29454620
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhKQMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:09:35 -0500
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:55731 "EHLO
        smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237149AbhKQMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1637150789;
        bh=kE+MTiK5CwMCa8fVuSZzq76MHd9HJsaBM7XFcT5fWXc=;
        h=From:To:Subject:Date:From;
        b=IkI9cod56Kk4h/7XiWWKoYKdMizc85V22/7K1VJb6h2CkOFDgU4lKihQtC4wQieaj
         9Yp8xNNoZALYx75YZXchtASU8miNmRnyb6SbeyvrrWRLEFVKfoJb+TXVqi5JW6hVW8
         amWvzWBXeJVJgh8C7kaG1Coh5bQgT23e7Uai5S+k=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 15747E0138;
        Wed, 17 Nov 2021 07:06:28 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH 5/5] comedi: Move "comedi_isadma.h" to <linux/comedi/comedi_isadma.h>
Date:   Wed, 17 Nov 2021 12:06:03 +0000
Message-Id: <20211117120604.117740-6-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117120604.117740-1-abbotti@mev.co.uk>
References: <20211117120604.117740-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b7289a69-3998-4ed4-bad0-ca7f3c79a866-6-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the header files in "drivers/comedi/drivers/" are common enough
to be useful to out-of-tree comedi driver modules.  Using them for
out-of-tree module builds is hampered by the headers being outside the
"include/" directory so it is desirable to move them.

There are about a half a dozen or so Comedi device drivers that use the
"comedi_isadma" module to add ISA DMA support.  The macros and
declarations to use that module are in the "comedi_isadma.h" header file
in the comedi "drivers" directory.  Move it into
"include/linux/comedi/".

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_isadma.c                         | 3 +--
 drivers/comedi/drivers/das16.c                                 | 3 +--
 drivers/comedi/drivers/das1800.c                               | 3 +--
 drivers/comedi/drivers/dt282x.c                                | 3 +--
 drivers/comedi/drivers/ni_at_a2150.c                           | 3 +--
 drivers/comedi/drivers/ni_labpc_isadma.c                       | 2 +-
 drivers/comedi/drivers/pcl812.c                                | 3 +--
 drivers/comedi/drivers/pcl816.c                                | 3 +--
 drivers/comedi/drivers/pcl818.c                                | 3 +--
 .../comedi/drivers => include/linux/comedi}/comedi_isadma.h    | 0
 10 files changed, 9 insertions(+), 17 deletions(-)
 rename {drivers/comedi/drivers => include/linux/comedi}/comedi_isadma.h (100%)

diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
index 63457bd4ff78..700982464c53 100644
--- a/drivers/comedi/drivers/comedi_isadma.c
+++ b/drivers/comedi/drivers/comedi_isadma.c
@@ -10,8 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/dma.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /**
  * comedi_isadma_program - program and enable an ISA DMA transfer
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index f6649ffa9670..937a69ce0977 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -66,8 +66,7 @@
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8255.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 #define DAS16_DMA_SIZE 0xff00	/*  size in bytes of allocated dma buffer */
 
diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index a43d3414a122..f09608c0f4ff 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -75,8 +75,7 @@
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /* misc. defines */
 #define DAS1800_SIZE           16	/* uses 16 io addresses */
diff --git a/drivers/comedi/drivers/dt282x.c b/drivers/comedi/drivers/dt282x.c
index 078f8fba7183..4ae80e6c7266 100644
--- a/drivers/comedi/drivers/dt282x.c
+++ b/drivers/comedi/drivers/dt282x.c
@@ -52,8 +52,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /*
  * Register map
diff --git a/drivers/comedi/drivers/ni_at_a2150.c b/drivers/comedi/drivers/ni_at_a2150.c
index 9942d770add8..df8d219e6723 100644
--- a/drivers/comedi/drivers/ni_at_a2150.c
+++ b/drivers/comedi/drivers/ni_at_a2150.c
@@ -41,8 +41,7 @@
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 #define A2150_DMA_BUFFER_SIZE	0xff00	/*  size in bytes of dma buffer */
 
diff --git a/drivers/comedi/drivers/ni_labpc_isadma.c b/drivers/comedi/drivers/ni_labpc_isadma.c
index dd37ec0d9b15..0652ca8345b6 100644
--- a/drivers/comedi/drivers/ni_labpc_isadma.c
+++ b/drivers/comedi/drivers/ni_labpc_isadma.c
@@ -11,8 +11,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/comedi/comedidev.h>
+#include <linux/comedi/comedi_isadma.h>
 
-#include "comedi_isadma.h"
 #include "ni_labpc.h"
 #include "ni_labpc_regs.h"
 #include "ni_labpc_isadma.h"
diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index 790f54476a91..70dbc129fcf5 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -116,8 +116,7 @@
 #include <linux/io.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/pcl816.c b/drivers/comedi/drivers/pcl816.c
index 77b30246d966..a5e5320be648 100644
--- a/drivers/comedi/drivers/pcl816.c
+++ b/drivers/comedi/drivers/pcl816.c
@@ -37,8 +37,7 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index e5b7793cce05..29e503de8267 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -99,8 +99,7 @@
 #include <linux/interrupt.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
-
-#include "comedi_isadma.h"
+#include <linux/comedi/comedi_isadma.h>
 
 /*
  * Register I/O map
diff --git a/drivers/comedi/drivers/comedi_isadma.h b/include/linux/comedi/comedi_isadma.h
similarity index 100%
rename from drivers/comedi/drivers/comedi_isadma.h
rename to include/linux/comedi/comedi_isadma.h
-- 
2.33.0

