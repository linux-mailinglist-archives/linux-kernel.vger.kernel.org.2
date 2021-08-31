Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE933FC97B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhHaOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhHaOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A893C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g14so3901677ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwFBa6ID2CU7IVCJdpVesspkl7cQEPY7fvmjvIApmuo=;
        b=jwRI7kWHlrfPZQmfPHYGVlfBIptRF6mhDuUvY+UI9DiL97IYcWoL2lnxSM9O1MS4bf
         crxBlK90EylzTVK1eyMhTTtR8k6zthuLf8LEGXSQ3iZ+cL/UEiLjmAizSOCBZW8t8aQ7
         1nYhkbGEpnxcy0qZtIOnADopwFFMj1B0fjWOEKfk/+uU2GiEOY4c6U+gdy/1cLmwi1MF
         fasrMyXeXyexYn9qBijcwOir/tFySqMMSeWfS1h8O/8/sf+vqAZtzwzD7QBDdXnLJPRC
         k7EuRraSADK2xRQXmpmTpP6hbgNmcOg/+HdxbJq7s6kIDT3Bi6LjahtCUnBLp2jpph+y
         g2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwFBa6ID2CU7IVCJdpVesspkl7cQEPY7fvmjvIApmuo=;
        b=jhDmzOuRug36eXODuzEoVIx2a3pr6dHbJw+Q3pg0coOExukKksHw3M7nk673oihZQr
         5okytZXq93esDpTJAWRKkI4LZbkW/DSEIuxvq2Y735ZrrTTyGhk0sfKqncMW0bWN1mgo
         HBP3hkEZKsToBbgwG7wTQuUkRPwEI7b4PwqoQTot/0WS1oLDhjxvxkolbVlFCy/mRElX
         uJ2fyHva3Jz64Lk1AP4gtLtStufxNpRGsYsvOa4vip3CR8f7HgPTQp/auWbI/zWDWS+/
         Hxj4lZnxA81NRthwBfMjLiQTaTrjhZ1Gm9Hi3DktmRR7Ie6MOr9nerXDuLb0XCYKtu1G
         3Vgg==
X-Gm-Message-State: AOAM533cIJEYO65sBfuNUaP8ju7axtw98KHsicWsUEo4odVNw8Gcz1mq
        JRPWQ/8SbD/evhXBZbYJE1j0IJEzUoTDBg==
X-Google-Smtp-Source: ABdhPJwj6KQ23nDAa7hZXMw5ODJAaLZkmN3HDJ/2IdpkPYgNeKkHdOp2dV6Mdvp/DHpTwVdxQXky+w==
X-Received: by 2002:a2e:a363:: with SMTP id i3mr24971842ljn.56.1630419309740;
        Tue, 31 Aug 2021 07:15:09 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:09 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] fs/ntfs3: Remove unneeded header files from c files
Date:   Tue, 31 Aug 2021 17:14:34 +0300
Message-Id: <20210831141434.975175-8-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have lot of unnecessary headers in these files. Remove them so that
we help compiler a little bit.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/attrib.c   | 5 -----
 fs/ntfs3/attrlist.c | 3 ---
 fs/ntfs3/bitmap.c   | 3 ---
 fs/ntfs3/dir.c      | 3 ---
 fs/ntfs3/file.c     | 1 -
 fs/ntfs3/frecord.c  | 3 ---
 fs/ntfs3/fslog.c    | 4 ----
 fs/ntfs3/fsntfs.c   | 1 -
 fs/ntfs3/index.c    | 1 -
 fs/ntfs3/inode.c    | 2 --
 fs/ntfs3/namei.c    | 4 ----
 fs/ntfs3/record.c   | 3 ---
 fs/ntfs3/run.c      | 2 --
 fs/ntfs3/super.c    | 2 --
 fs/ntfs3/xattr.c    | 3 ---
 15 files changed, 40 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 4b285f704e62..b4290b4f996d 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -6,12 +6,7 @@
  * TODO: Merge attr_set_size/attr_data_get_block/attr_allocate_frame?
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/hash.h>
-#include <linux/nls.h>
-#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 32ca990af64b..4d1bb695e650 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -5,10 +5,7 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 06ae38adb8ad..01c639865132 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -10,12 +10,9 @@
  *
  */
 
-#include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 
-#include "debug.h"
 #include "ntfs.h"
 #include "ntfs_fs.h"
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 93f6d485564e..76697ec3c146 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -7,10 +7,7 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/iversion.h>
 #include <linux/nls.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 26346771d9dc..bf3b7b666423 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -13,7 +13,6 @@
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
 #include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 9d374827750b..50c185da8fbb 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -5,11 +5,8 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fiemap.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 #include <linux/vmalloc.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 6f6057129fdd..38235c1c60a2 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -6,12 +6,8 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/hash.h>
-#include <linux/nls.h>
 #include <linux/random.h>
-#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0edb95ed9717..3eec44671a71 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -8,7 +8,6 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 70ef59455b72..fec1e72206e8 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -8,7 +8,6 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index b86ec7dd731c..00ce4c40b3fc 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -5,10 +5,8 @@
  *
  */
 
-#include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/iversion.h>
 #include <linux/mpage.h>
 #include <linux/namei.h>
 #include <linux/nls.h>
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f79a399bd015..67cb541a5b12 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -5,11 +5,7 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/iversion.h>
-#include <linux/namei.h>
 #include <linux/nls.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index d48a5e6c5045..ff09ff2714fc 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -5,10 +5,7 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 26ed2b64345e..a8fec651f973 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -7,10 +7,8 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 2fbab8a931ee..1934c273ee1d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -23,12 +23,10 @@
  *
  */
 
-#include <linux/backing-dev.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
-#include <linux/iversion.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/nls.h>
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index b4c921e4bc1a..b84d15e8d3a2 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -5,10 +5,7 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/nls.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
-- 
2.25.1

