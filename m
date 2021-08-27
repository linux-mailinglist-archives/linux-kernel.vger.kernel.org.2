Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867013F9C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhH0QdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhH0QdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:33:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7EEC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:32:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq28so15538187lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDEyniYnUo6SP9JGWjfsS6i4iPrH22gq5zNs0dJFqeQ=;
        b=nWFz0ZQ+mJ29vyniEQlz/brm3kzo7t3aCrZmz9gBloLSWgjsf5eDaCZeuQF/YXiGt9
         tUfh/bHva0S8doRgMygMZBLdjx8d9+uJYGUCoaO1AL5l1jrMYFjU4JZSL5/RtAJkoO/J
         z4c5608vgAw0jUUvF79lmVEPePKKEOq/wBAwG3mVWRfv/su3lcLTMxDpo/gED1wXPD8v
         +tUuOMvkPXVaCe973zVQEMTpGWJYQ5d8x21p2t/XvNIEsl9Qe2zz62/+NnncnqkDSaO3
         db5HPcbHOpahh6Sji1/ofty4l6QOTu2u/A0yn5jH+OSc9gC3iofDQ4MXNkBtIlyH8RnT
         jrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDEyniYnUo6SP9JGWjfsS6i4iPrH22gq5zNs0dJFqeQ=;
        b=VuI2JWVinZI4wGONtpC1TiCjO1kKoJq1CThb2idtp/I3x+HxRkMzEqkgqzboUHJdrA
         UbCEmzKakmXxDPRack6Ip+dkCOgPrJHaOIl/IIflaYk6L4Y0MsKfOGOTKuzzHwQlOjLS
         ZKbuUJsnECqDyGZa1V8PUjsDGpHwxoJ1AerB7mBdL6AcwYi3DS9bETK/IKrbhS97XFVS
         pGMRhQ51Pcg9yFzSvTzGGf753WXLthr/So51P/AsrnWeWJK909xrseOdn8QY07+62WBM
         oWllYe0VQWtgMT4DjvopH6/JTB41PUdrW9gruLNtSBaGKerM0ht7BJ37ki1PODMRPmA3
         XAMQ==
X-Gm-Message-State: AOAM533izvKfh3YPV26rwGDaDTxRnvOzDZJXlvjGXIoipGkMDDu7nfoD
        iHh/dltnTNHW+egWJ9nkVxo=
X-Google-Smtp-Source: ABdhPJz2TfsSfJlx0fzh0sqfW8FsA2oVlt/8oGp3MDnp1ubPztetO15Q7WSUSfCfgaFr51R/S7ZjWw==
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr7277813lfu.516.1630081945128;
        Fri, 27 Aug 2021 09:32:25 -0700 (PDT)
Received: from DESKTOP-5EKDQDN.localdomain (78-63-10-115.static.zebra.lt. [78.63.10.115])
        by smtp.gmail.com with ESMTPSA id bq18sm633211lfb.183.2021.08.27.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:32:24 -0700 (PDT)
From:   =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
To:     gregkh@linuxfoundation.org, forest@alittletooquiet.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
Subject: [PATCH] staging: vt6656: Remove filenames in files
Date:   Fri, 27 Aug 2021 19:32:03 +0300
Message-Id: <20210827163203.4100-1-aldas60@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl warning: It's generally not useful to have the filename in
the file

Remove the filenames.

Signed-off-by: Aldas Taraškevičius <aldas60@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 2 --
 drivers/staging/vt6656/baseband.h | 2 --
 drivers/staging/vt6656/card.c     | 1 -
 drivers/staging/vt6656/card.h     | 2 --
 drivers/staging/vt6656/channel.c  | 2 --
 drivers/staging/vt6656/channel.h  | 2 --
 drivers/staging/vt6656/desc.h     | 2 --
 drivers/staging/vt6656/device.h   | 2 --
 drivers/staging/vt6656/key.c      | 2 --
 drivers/staging/vt6656/key.h      | 2 --
 drivers/staging/vt6656/mac.c      | 2 --
 drivers/staging/vt6656/mac.h      | 2 --
 drivers/staging/vt6656/main_usb.c | 2 --
 drivers/staging/vt6656/power.c    | 2 --
 drivers/staging/vt6656/power.h    | 2 --
 drivers/staging/vt6656/rf.c       | 2 --
 drivers/staging/vt6656/rf.h       | 2 --
 drivers/staging/vt6656/rxtx.c     | 2 --
 drivers/staging/vt6656/rxtx.h     | 2 --
 drivers/staging/vt6656/usbpipe.c  | 2 --
 drivers/staging/vt6656/usbpipe.h  | 2 --
 drivers/staging/vt6656/wcmd.c     | 2 --
 drivers/staging/vt6656/wcmd.h     | 2 --
 23 files changed, 45 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index 41ae779ec61f..1e1c5a7d8968 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: baseband.c
- *
  * Purpose: Implement functions to access baseband
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/baseband.h b/drivers/staging/vt6656/baseband.h
index 12456ebc23ec..dce50a311f24 100644
--- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: baseband.h
- *
  * Purpose: Implement functions to access baseband
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 396736eee690..e92ecfad26d2 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -3,7 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: card.c
  * Purpose: Provide functions to setup NIC operation mode
  * Functions:
  *      vnt_set_rspinf - Set RSPINF
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index a524fdc60ae3..be32c25c95de 100644
--- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: card.h
- *
  * Purpose: Provide functions to setup NIC operation mode
  *
  * Author: Tevin Chen
diff --git a/drivers/staging/vt6656/channel.c b/drivers/staging/vt6656/channel.c
index 7855689af7cb..eb2d52e6420b 100644
--- a/drivers/staging/vt6656/channel.c
+++ b/drivers/staging/vt6656/channel.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: channel.c
- *
  * Purpose: Channel number mapping
  *
  * Author: Lucas Lin
diff --git a/drivers/staging/vt6656/channel.h b/drivers/staging/vt6656/channel.h
index cca330f0daf4..723660e40310 100644
--- a/drivers/staging/vt6656/channel.h
+++ b/drivers/staging/vt6656/channel.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: channel.h
- *
  * Purpose: Country Regulation Rules header file
  *
  * Author: Lucas Lin
diff --git a/drivers/staging/vt6656/desc.h b/drivers/staging/vt6656/desc.h
index 703597a911f4..c13561e528db 100644
--- a/drivers/staging/vt6656/desc.h
+++ b/drivers/staging/vt6656/desc.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: desc.h
- *
  * Purpose:The header file of descriptor
  *
  * Revision History:
diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 2c93a2e66c8a..8b6623a751f0 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: device.h
- *
  * Purpose: MAC Data structure
  *
  * Author: Tevin Chen
diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index 70f75c5760ce..bdc5f30c4f9d 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: key.c
- *
  * Purpose: Implement functions for 802.11i Key management
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/key.h b/drivers/staging/vt6656/key.h
index 1f3449e66143..6f1d5b4f6da7 100644
--- a/drivers/staging/vt6656/key.h
+++ b/drivers/staging/vt6656/key.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: key.h
- *
  * Purpose: Implement functions for 802.11i Key management
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/mac.c b/drivers/staging/vt6656/mac.c
index da7067c34643..4f1f9b03a678 100644
--- a/drivers/staging/vt6656/mac.c
+++ b/drivers/staging/vt6656/mac.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: mac.c
- *
  * Purpose:  MAC routines
  *
  * Author: Tevin Chen
diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index dae70b5c7634..05af9ca7d69c 100644
--- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: mac.h
- *
  * Purpose: MAC routines
  *
  * Author: Tevin Chen
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index b90d3dab28b1..ae7f5916d4d6 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: main_usb.c
- *
  * Purpose: driver entry for initial, open, close, tx and rx.
  *
  * Author: Lyndon Chen
diff --git a/drivers/staging/vt6656/power.c b/drivers/staging/vt6656/power.c
index 2f49c870272a..e5411f6284c7 100644
--- a/drivers/staging/vt6656/power.c
+++ b/drivers/staging/vt6656/power.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: power.c
- *
  * Purpose: Handles 802.11 power management functions
  *
  * Author: Lyndon Chen
diff --git a/drivers/staging/vt6656/power.h b/drivers/staging/vt6656/power.h
index 160872026db3..9f9c70072933 100644
--- a/drivers/staging/vt6656/power.h
+++ b/drivers/staging/vt6656/power.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: power.h
- *
  * Purpose: Handles 802.11 power management  functions
  *
  * Author: Lyndon Chen
diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index bcd4d467e03a..b9c06b312ae1 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: rf.c
- *
  * Purpose: rf function code
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/rf.h b/drivers/staging/vt6656/rf.h
index 493faaf4e2b5..b47e149875d1 100644
--- a/drivers/staging/vt6656/rf.h
+++ b/drivers/staging/vt6656/rf.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: rf.h
- *
  * Purpose:
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 5dd6b4d2bf20..a31947f2620d 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: rxtx.c
- *
  * Purpose: handle WMAC/802.3/802.11 rx & tx functions
  *
  * Author: Lyndon Chen
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index f23440799443..b9df0854b4b0 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: rxtx.h
- *
  * Purpose:
  *
  * Author: Jerry Chen
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 82b774be6485..7f45734390f6 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: usbpipe.c
- *
  * Purpose: Handle USB control endpoint
  *
  * Author: Warren Hsu
diff --git a/drivers/staging/vt6656/usbpipe.h b/drivers/staging/vt6656/usbpipe.h
index 52c2a928c9c1..922312e299bf 100644
--- a/drivers/staging/vt6656/usbpipe.h
+++ b/drivers/staging/vt6656/usbpipe.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: usbpipe.h
- *
  * Purpose:
  *
  * Author: Warren Hsu
diff --git a/drivers/staging/vt6656/wcmd.c b/drivers/staging/vt6656/wcmd.c
index 0ccc87da394e..e8ee2fbee76c 100644
--- a/drivers/staging/vt6656/wcmd.c
+++ b/drivers/staging/vt6656/wcmd.c
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: wcmd.c
- *
  * Purpose: Handles the management command interface functions
  *
  * Author: Lyndon Chen
diff --git a/drivers/staging/vt6656/wcmd.h b/drivers/staging/vt6656/wcmd.h
index a0d98cf74998..a62924671b17 100644
--- a/drivers/staging/vt6656/wcmd.h
+++ b/drivers/staging/vt6656/wcmd.h
@@ -3,8 +3,6 @@
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
  *
- * File: wcmd.h
- *
  * Purpose: Handles the management command interface functions
  *
  * Author: Lyndon Chen
-- 
2.30.2

