Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C71342E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhCTQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCTQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:29:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB10C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 09:29:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k24so5770202pgl.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=adNz31gWLDJnKipBeS3psUT6pbf5Zn26UZ0xNc92lTo=;
        b=TNpz7CbfJPuFdmN4VA992lMaDYNJykgyhtqf/5uhRP2+eduMul71GumqKkoUNwFjh4
         SEyiKB1bIn2GbTYdGLLL3knNSZN8HhvAEXlRsTsJDYQEdeNJmb8FhJI6jXLY7SC1yraH
         NtBeDCVHu38Z1vemyDnE31S7cF+aaUgdYpfFH34+6W7HWkK/HOir6uGtQZCJrW9G8VAu
         /tG/umOGx8LEzZFIDKvk59axJjk/liW2PW/z0gGSPPiKTC1z0NVXWgv17o0meZNsH0i8
         T6/VB1yOlk0/5MvAuyqwmcrsztqXpEsKu0v61dGwoIkbrNmuu18AzYsmRgEoVSvGcbvd
         nBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=adNz31gWLDJnKipBeS3psUT6pbf5Zn26UZ0xNc92lTo=;
        b=QpSPdeBzmyLsEwYFAIvdZ+eajLVQEWYuqzhEjH2Sn2RJJt2YFMk/kQ2+FTi7XBWCJ/
         GVjP2P7a8ab2XLLNjPLyXdLZ03aE2oWToEhNX5zBQC11YX4TdEmnZOif0uw0v85fz6id
         cm9+LVQ5DRUYNQd65vz6SFh/u7Jg/YNJ/50sde27xI///Qbko03TxZCsA93L1972PS0q
         PkudptiCGi6eakrTY/OVzz9pxmhJI2+As7/azKQtU1T5xZYL0bsTfKLAVUiCRHuOfeF9
         masuaiDhp4nrLRVt/WkvX1vXixsqIrF0WRjQq/pkp1gvaKUXTxmGwXQ62Ufi/FEThEKg
         4Ntw==
X-Gm-Message-State: AOAM530lKkTiDJj8s2qIwip9oJPgpVdWqXcMeqVjWd5sC9HoL+Ip5g1t
        wEJhr5STFND3iqVsNzu+imM=
X-Google-Smtp-Source: ABdhPJwhFZI6DBOYuVPsCROsir8j232Inr//PlcZIV9IdgideHzoqzYTiofrr6egsD7vPMo8bVQh1Q==
X-Received: by 2002:a63:356:: with SMTP id 83mr419552pgd.344.1616257792925;
        Sat, 20 Mar 2021 09:29:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:1ce8:18d9:6e3d:8c29])
        by smtp.googlemail.com with ESMTPSA id 2sm8740919pfi.116.2021.03.20.09.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 09:29:52 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     anton@tuxera.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: [PATCH] ntfs: fix incorrect kernel-doc comment syntax in files
Date:   Sat, 20 Mar 2021 21:59:39 +0530
Message-Id: <20210320162939.32707-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in fs/ntfs which follow this syntax, but the
content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in the header for
fs/ntfs/attrib.c, causes these unexpected warnings by kernel-doc:
"warning: Incorrect use of kernel-doc format:  * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode"
"warning: Function parameter or member 'ni' not described in 'ntfs_map_runlist_nolock'"
"warning: Function parameter or member 'vcn' not described in 'ntfs_map_runlist_nolock'"
"warning: Function parameter or member 'ctx' not described in 'ntfs_map_runlist_nolock'"
"warning: expecting prototype for c(). Prototype was for ntfs_map_runlist_nolock() instead"

Similarly for other files too.

Provide a simple fix by replacing such occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210319

 fs/ntfs/aops.c     | 2 +-
 fs/ntfs/aops.h     | 2 +-
 fs/ntfs/attrib.c   | 2 +-
 fs/ntfs/compress.c | 8 ++++----
 fs/ntfs/dir.c      | 4 ++--
 fs/ntfs/inode.c    | 2 +-
 fs/ntfs/mft.c      | 2 +-
 fs/ntfs/runlist.c  | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad2..1024cdec136a 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * aops.c - NTFS kernel address space operations and page cache handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
index f0962d46bd67..2dcd46befdff 100644
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * aops.h - Defines for NTFS kernel address space operations and page cache
  *	    handling.  Part of the Linux-NTFS project.
  *
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d563abc3e136..2911c04a33e0 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index d2f9d6a0ee32..014dbd079ad5 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * compress.c - NTFS kernel compressed attributes handling.
  *		Part of the Linux-NTFS project.
  *
@@ -18,7 +18,7 @@
 #include "debug.h"
 #include "ntfs.h"
 
-/**
+/*
  * ntfs_compression_constants - enum of constants used in the compression code
  */
 typedef enum {
@@ -41,12 +41,12 @@ typedef enum {
 	NTFS_MAX_CB_SIZE	= 64 * 1024,
 } ntfs_compression_constants;
 
-/**
+/*
  * ntfs_compression_buffer - one buffer for the decompression engine
  */
 static u8 *ntfs_compression_buffer;
 
-/**
+/*
  * ntfs_cb_lock - spinlock which protects ntfs_compression_buffer
  */
 static DEFINE_SPINLOCK(ntfs_cb_lock);
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index cd96083a12c8..518c3a21a556 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
@@ -17,7 +17,7 @@
 #include "debug.h"
 #include "ntfs.h"
 
-/**
+/*
  * The little endian Unicode string $I30 as a global constant.
  */
 ntfschar I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f5c058b3192c..4277d0fd7d88 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * inode.c - NTFS kernel inode handling.
  *
  * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 0d62cd5bb7f8..d197d402933a 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 97932fb5179c..0d448e9881f7 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
-- 
2.17.1

