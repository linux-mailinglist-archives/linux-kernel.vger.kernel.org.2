Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498734554BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbhKRGZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhKRGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:24:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=q9zYad4IkVx8WQ5GILNcaiEsJwNxxgcbDaRqT7OPn10=; b=PvpSdbtQw9PNk+TIuIy4KalS3p
        6kF6M10JOGUqUXOKvozEyDzDlLuQfrFZdOkJfDWZB59TzVxWfrdAgoqN3Qbh+z0Gk0TaUcGyELDEX
        xE/NhkZnw/W1eAZIYxG7jFz4E4wEvlUKG84OBjlhqiLhFJ/UYjOmDkQq7qQhbuIL1suWB3qP+tlYJ
        5q7IEZ0Tnob+d8r6HTcAr1/C73Yl/Z7b/4SteTmbchEEd4jZrndGlBNIpkk/izsbqsET6ET0MclRS
        NCYib63P1yp8KLqmj5VQZFoS88njTBL2zEB9FpxZfngOqOxvsY8UGlHVtadx/fnusssXw+syj4I89
        c0eB8Qmw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnanr-006yRc-3n; Thu, 18 Nov 2021 06:21:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] sound/oss/dmasound: fix build when some drivers are =m and others are =y
Date:   Wed, 17 Nov 2021 22:21:46 -0800
Message-Id: <20211118062146.11850-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DMASOUND_ATARI=y and CONFIG_DMASOUND_Q40=m,
dmasound_atari.o is built first (listed first in the Makefile),
so dmasound_core.o is built as builtin, not for use by loadable
modules. Then dmasound_q40.o is built and linked with the
already-built dmasound_core.o, but the latter does not support
use by loadable modules. This causes the missing symbol to be
undefined.

Fixes this build error:
ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_q40.ko] undefined!

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # "forever"
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
There may be some Makefile solution to this but I don't know what
it is. I didn't want to spend lots of time on these old drivers.

 sound/oss/dmasound/Makefile         |    6 +++---
 sound/oss/dmasound/dmasound_atari.c |    2 +-
 sound/oss/dmasound/dmasound_core.c  |   16 ----------------
 sound/oss/dmasound/dmasound_paula.c |    2 +-
 sound/oss/dmasound/dmasound_q40.c   |    2 +-
 5 files changed, 6 insertions(+), 22 deletions(-)

--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_atari.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_atari.c
@@ -27,7 +27,7 @@
 #include <asm/atariints.h>
 #include <asm/atari_stram.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_ATARI_REVISION 0
 #define DMASOUND_ATARI_EDITION 3
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_paula.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_paula.c
@@ -30,7 +30,7 @@
 #include <asm/amigaints.h>
 #include <asm/machdep.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_PAULA_REVISION 0
 #define DMASOUND_PAULA_EDITION 4
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_q40.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_q40.c
@@ -25,7 +25,7 @@
 #include <asm/q40ints.h>
 #include <asm/q40_master.h>
 
-#include "dmasound.h"
+#include "dmasound_core.c"
 
 #define DMASOUND_Q40_REVISION 0
 #define DMASOUND_Q40_EDITION 3
--- linux-next-20211117.orig/sound/oss/dmasound/Makefile
+++ linux-next-20211117/sound/oss/dmasound/Makefile
@@ -3,6 +3,6 @@
 # Makefile for the DMA sound driver
 #
 
-obj-$(CONFIG_DMASOUND_ATARI)	+= dmasound_core.o dmasound_atari.o
-obj-$(CONFIG_DMASOUND_PAULA)	+= dmasound_core.o dmasound_paula.o
-obj-$(CONFIG_DMASOUND_Q40)	+= dmasound_core.o dmasound_q40.o
+obj-$(CONFIG_DMASOUND_ATARI)	+= dmasound_atari.o
+obj-$(CONFIG_DMASOUND_PAULA)	+= dmasound_paula.o
+obj-$(CONFIG_DMASOUND_Q40)	+= dmasound_q40.o
--- linux-next-20211117.orig/sound/oss/dmasound/dmasound_core.c
+++ linux-next-20211117/sound/oss/dmasound/dmasound_core.c
@@ -1570,19 +1570,3 @@ char dmasound_alaw2dma8[] = {
 	3,	3,	3,	3,	3,	3,	3,	3
 };
 #endif /* HAS_8BIT_TABLES */
-
-    /*
-     *  Visible symbols for modules
-     */
-
-EXPORT_SYMBOL(dmasound);
-EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
-EXPORT_SYMBOL(dmasound_deinit);
-#endif
-EXPORT_SYMBOL(dmasound_write_sq);
-EXPORT_SYMBOL(dmasound_catchRadius);
-#ifdef HAS_8BIT_TABLES
-EXPORT_SYMBOL(dmasound_ulaw2dma8);
-EXPORT_SYMBOL(dmasound_alaw2dma8);
-#endif
