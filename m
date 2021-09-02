Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4F3FF0FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbhIBQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbhIBQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDEC0612E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l10so5483153lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+ujP72zE5mIa6mjcPx3K31BUPem18c3ppcTzUA+PFM=;
        b=I2PM4wzET84+uy6hRxB6RSBNGmmiF5yBPNBqeAoE0+3qXVgJijxRU/dV8kKQ1kzxft
         LTQ3ApIOybY1X8vNiDyz+3MwKv9wii9aYkq2ihm1nKz0LfA2nRm1YuCANFMxDrP8pbMJ
         ZPl3SVUjmEEKHqZrCwR0IRlcJSg7sw5ubMjbe005l575ILPWOrGvHITFT2NP+ejyy+1v
         3c2mL5VNtoDmJPeBdlaORqG3vjVFBPjVEWf/UGNMZ9KAgLx5DE+QCOhcZOwfSluwcIco
         OxfKlaj9+dkgguT8GRuKNNDncD2DzxjFeOd+Z+lD6d+K+lV2DcEbw7M0sLB0Li5BnTrD
         iIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+ujP72zE5mIa6mjcPx3K31BUPem18c3ppcTzUA+PFM=;
        b=O6yl77INbjaJY2gBcU+md+SGgp0peNgjOxgmra/rvLBYpFzuN0D/pJUc8bw7TGeOE/
         YWdmwtMIZkaOqIwJSuRLny/lGwrjIQPYfpJLoFgbgwRB/9meYiIiCFkJtgdsNtq/3Ihp
         VWqAVdT3KEnq42cAc1am73rzzA3RDzGQPJGVgv4rVOU/mDPx/NAXr7oBTuRDZWeyWqwj
         L3Q7Aw4EtAwrIxcST9qbDrXUUTdLa7mOSCjyZW4mOlzkGUSXgHEplXfNxe0VssGhLJ7G
         6Wq8LpcglPW2hHkWquVgB6QzPcgYFgdHq2SE1BbC6F/DVqo+cdouD1hKHzJypwEum9cw
         eBUQ==
X-Gm-Message-State: AOAM533lgkrhwC+rYcQGbtc8H3tuIkgugx7KE+oWExPWyRJa226EYn/Z
        DkAoPdYSE6b7WyrF5orGneLLCfY0ne8gAQ==
X-Google-Smtp-Source: ABdhPJxfnzeOXD2d5VlVp9iLDI1hn/KPlkZ8EHQ5z6I96wOBHY+x+ie/w+bDiL+5+Uhng+pRD8ITjg==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr2080720lfd.395.1630599347056;
        Thu, 02 Sep 2021 09:15:47 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:46 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] fs/ntfs3: Remove unneeded header files from c files
Date:   Thu,  2 Sep 2021 19:15:28 +0300
Message-Id: <20210902161528.6262-9-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
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
index 34c4cbf7e29b..456251210c1c 100644
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
index fa32399eb517..b9da527b96aa 100644
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
index 831501555009..a03584674fea 100644
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
index 89557d60a9b0..4aab7de1886e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -12,7 +12,6 @@
 #include <linux/compat.h>
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
-#include <linux/nls.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 938b12d56ca6..080264ced909 100644
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
index b5853aed0e25..6e7f9b72792b 100644
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
index 91e3743e1442..9232a7f410c6 100644
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
index 0daca9adc54c..affae36d0bc9 100644
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
index db2a5a4c38e4..b474aa352056 100644
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
index e58415d07132..1c475da4e19d 100644
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
index 103705c86772..861e35791506 100644
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
index dbecf095da59..cfacba61d41d 100644
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
index b15d532e4a17..7ec7e09031aa 100644
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

