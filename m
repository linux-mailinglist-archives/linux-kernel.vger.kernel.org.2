Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA62F37B074
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKVFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:05:47 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:04:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o27so20236273qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edLVmjzTGYFDILBRsx2JiRtEVDibeAgER4zaH14Tzkw=;
        b=sGSHyK9pd9h6jVZP1jjG8rI6wi+fFoTokfcHIo8ktlR8kvWuti5Eg8Kb8JcvOG+o/F
         OIsc4K322GJ4AEgZTIkQPtPPJBXJWOluvoTArr5q8IT8K258sxHyFrY8EQO8eb43VKXu
         kcqxC6JPg+udx1C6lsUBPfWPfVng1hXzTKPnP6Y0Ka1vaaQcrtuF0AbZ7omik2Fx+sfY
         LDPb/YJ4MvL6UPUD+8Dl0px+bvTf/VAhe6HZtCn6PgelI3zh6Oz2myHVvASI0dAll1c7
         ysyOJ58RdvJi4XdvIgYY2ClN2wiW0xX5VdP1W5VQ9P55FI/WTj+wGxJhoVjjtwLq5FFi
         wTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=edLVmjzTGYFDILBRsx2JiRtEVDibeAgER4zaH14Tzkw=;
        b=WDBLF1AKbiVqYgHhZzc6BO8oxH9FmZCT5BJLlzWjTWow4g4xO4Bq7iuTMlNgoxczUj
         Tq3ISP0LY7qjKPlAMu521rxTgHj0UUtKdznlhDB78NTr10zHW3z+5BvCbpTj+xvn/KFV
         S7uYc+cvIvyx+vMWF/qbpDkLb9iG5tHU4yWMHrWgeCKVi9LyGY5+L6bPVGZZRGY7q3yU
         sWCCU0axGlCD/D91OERY3mAalD364ARY3OyjMFERIrCv4+gokhI+SjY/C2eVBmvo3Yf0
         P0jPkK5Cz7guwF1WPspcQaruEWvCUSTd8WtuBl+bA9F0tGflJuMEI0uPe64yIhY1jiX4
         WWEg==
X-Gm-Message-State: AOAM532ScZQIG5pFcX/kri2s3Q5s5NF4BNf00o0uD7IN7/sidIkyKOG4
        B3GtC/xG4RYvXvuP8nbm5LQ=
X-Google-Smtp-Source: ABdhPJy8jwZS0mnuoqs6Vwm+/BBw8ftkx1xLuYvT0hDq+he8yqRye7/9z1nC0SwfnvJu3muDYNXJ6w==
X-Received: by 2002:a37:a756:: with SMTP id q83mr28925320qke.134.1620767079414;
        Tue, 11 May 2021 14:04:39 -0700 (PDT)
Received: from crazyoreo0-latitudee7440.myfiosgateway.com (pool-138-88-168-130.washdc.fios.verizon.net. [138.88.168.130])
        by smtp.gmail.com with ESMTPSA id t5sm14610749qtr.19.2021.05.11.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:04:39 -0700 (PDT)
From:   uroshm <uroshm@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     uroshm <uroshm@gmail.com>
Subject: [PATCH] The following files had their respective file names in comments, and /scripts/checkpatch.pl flagged these. I went into each file, removed the respective filename from the leading comment from the following files in /drivers/wlan:
Date:   Tue, 11 May 2021 17:04:31 -0400
Message-Id: <20210511210431.3789-1-uroshm@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hfa384x.h
hfa384x_usb.c
p80211conv.c
p80211conv.h
p80211hdr.h
p80211ioctl.h
p80211mgmt.h
p80211msg.h
p80211netdev.h
p80211req.c
p80211req.h
p80211types.h
p80211wep.c
prism2mgmt.c
prism2mgmt.h
prism2mib.c
prism2sta.c

Signed-off-by: uroshm <uroshm@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x.h      | 2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c  | 2 +-
 drivers/staging/wlan-ng/p80211conv.c   | 2 +-
 drivers/staging/wlan-ng/p80211conv.h   | 2 +-
 drivers/staging/wlan-ng/p80211hdr.h    | 2 +-
 drivers/staging/wlan-ng/p80211ioctl.h  | 2 +-
 drivers/staging/wlan-ng/p80211mgmt.h   | 2 +-
 drivers/staging/wlan-ng/p80211msg.h    | 2 +-
 drivers/staging/wlan-ng/p80211netdev.h | 2 +-
 drivers/staging/wlan-ng/p80211req.c    | 2 +-
 drivers/staging/wlan-ng/p80211req.h    | 2 +-
 drivers/staging/wlan-ng/p80211types.h  | 2 +-
 drivers/staging/wlan-ng/p80211wep.c    | 2 +-
 drivers/staging/wlan-ng/prism2mgmt.c   | 2 +-
 drivers/staging/wlan-ng/prism2mgmt.h   | 2 +-
 drivers/staging/wlan-ng/prism2mib.c    | 2 +-
 drivers/staging/wlan-ng/prism2sta.c    | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 88e894dd3568..700ec58ef35a 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* hfa384x.h
+/*
  *
  * Defines the constants and data structures for the hfa384x
  *
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index f2a0e16b0318..a483c61092cc 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/prism2/driver/hfa384x_usb.c
+/*
  *
  * Functions that talk to the USB variant of the Intersil hfa384x MAC
  *
diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index 0ff5fda81b05..f2661157e87c 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/p80211/p80211conv.c
+/*
  *
  * Ether/802.11 conversions and packet buffer routines
  *
diff --git a/drivers/staging/wlan-ng/p80211conv.h b/drivers/staging/wlan-ng/p80211conv.h
index 15fd635d9770..b640a475e302 100644
--- a/drivers/staging/wlan-ng/p80211conv.h
+++ b/drivers/staging/wlan-ng/p80211conv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211conv.h
+/*
  *
  * Ether/802.11 conversions and packet buffer routines
  *
diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
index 6564810fd026..77ba16c65774 100644
--- a/drivers/staging/wlan-ng/p80211hdr.h
+++ b/drivers/staging/wlan-ng/p80211hdr.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211hdr.h
+/*
  *
  * Macros, types, and functions for handling 802.11 MAC headers
  *
diff --git a/drivers/staging/wlan-ng/p80211ioctl.h b/drivers/staging/wlan-ng/p80211ioctl.h
index ed65ac57adbe..bb1188cc25d7 100644
--- a/drivers/staging/wlan-ng/p80211ioctl.h
+++ b/drivers/staging/wlan-ng/p80211ioctl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211ioctl.h
+/*
  *
  * Declares constants and types for the p80211 ioctls
  *
diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index c045c08e1991..5033fffadfce 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211mgmt.h
+/*
  *
  * Macros, types, and functions to handle 802.11 mgmt frames
  *
diff --git a/drivers/staging/wlan-ng/p80211msg.h b/drivers/staging/wlan-ng/p80211msg.h
index 114066526df4..f68d8b7d5ad8 100644
--- a/drivers/staging/wlan-ng/p80211msg.h
+++ b/drivers/staging/wlan-ng/p80211msg.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211msg.h
+/*
  *
  * Macros, constants, types, and funcs for req and ind messages
  *
diff --git a/drivers/staging/wlan-ng/p80211netdev.h b/drivers/staging/wlan-ng/p80211netdev.h
index d48466d943b4..3b6d12665c9a 100644
--- a/drivers/staging/wlan-ng/p80211netdev.h
+++ b/drivers/staging/wlan-ng/p80211netdev.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211netdev.h
+/*
  *
  * WLAN net device structure and functions
  *
diff --git a/drivers/staging/wlan-ng/p80211req.c b/drivers/staging/wlan-ng/p80211req.c
index 9f5c1267d829..809cf3d480e9 100644
--- a/drivers/staging/wlan-ng/p80211req.c
+++ b/drivers/staging/wlan-ng/p80211req.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/p80211/p80211req.c
+/*
  *
  * Request/Indication/MacMgmt interface handling functions
  *
diff --git a/drivers/staging/wlan-ng/p80211req.h b/drivers/staging/wlan-ng/p80211req.h
index c04053f3b02b..bc45cd5f91e4 100644
--- a/drivers/staging/wlan-ng/p80211req.h
+++ b/drivers/staging/wlan-ng/p80211req.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* p80211req.h
+/*
  *
  * Request handling functions
  *
diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index 3dcdd022da61..6486612a8f31 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
 /*
- * p80211types.h
+ *
  *
  * Macros, constants, types, and funcs for p80211 data types
  *
diff --git a/drivers/staging/wlan-ng/p80211wep.c b/drivers/staging/wlan-ng/p80211wep.c
index 51d917c8cdc8..3ff7ee7011df 100644
--- a/drivers/staging/wlan-ng/p80211wep.c
+++ b/drivers/staging/wlan-ng/p80211wep.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/p80211/p80211wep.c
+/*
  *
  * WEP encode/decode for P80211.
  *
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 1bd36dc2b7ff..9030a8939a9b 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/prism2/driver/prism2mgmt.c
+/*
  *
  * Management request handler functions.
  *
diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 17bc1ee0d498..7132cec2d7eb 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1) */
-/* prism2mgmt.h
+/*
  *
  * Declares the mgmt command handler functions
  *
diff --git a/drivers/staging/wlan-ng/prism2mib.c b/drivers/staging/wlan-ng/prism2mib.c
index 875812a391c9..37654169c62f 100644
--- a/drivers/staging/wlan-ng/prism2mib.c
+++ b/drivers/staging/wlan-ng/prism2mib.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/prism2/driver/prism2mib.c
+/*
  *
  * Management request for mibset/mibget
  *
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index e6dcb687e7a1..0e0a7708bbd2 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MPL-1.1)
-/* src/prism2/driver/prism2sta.c
+/*
  *
  * Implements the station functionality for prism2
  *
-- 
2.31.1

