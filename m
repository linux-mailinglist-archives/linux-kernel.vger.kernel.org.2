Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D7344CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhCVRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCVRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:11:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E308BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:11:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so10936330pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o+rQOUxD6ns2rafwTLx1FeOmKC6/rz2dWQIZ1qXVO2g=;
        b=P06Qb3YQCSLVPYX6Nr5a46z3wuOI8LCkOcQXeBERoJ6Mupnb05RgMv+tJ9/trhYFlH
         uX0bH0l57lVR8x4iAW1t3Hg6gTYrNQQgdICjO7qCGHpCOTA2mrwIqgOnS7sbrnNva/2M
         1OzXombe//QOnzqOp6QB9NWh8HucwiR52vwgJQix/Gk+0oBmZOVv8zvucEI9RgDrzqWT
         FC3rgaRp9/iXUTcFVnvz4/ijPrdTcV4jrXDrqlZMcTzqbfT+rEqp+wKMdSnThVONb62f
         fJValpxedDDzMwPmngI/AVUSVoo5HcU0HW14EVbpu6+5gjOyRs3t1QGob7yYbgo9Ke93
         zzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o+rQOUxD6ns2rafwTLx1FeOmKC6/rz2dWQIZ1qXVO2g=;
        b=giRIenWYop8Y/GHXNr2kGPacLG3CnJPGre2SxeCM5exLzozN/sqiURakqU6X2nnf/M
         TEMIz1hZVUT8cOCJ2ite4VN4yEhrn8RxibvjuHWmDQUjH6ZxBsTjUce3c/ZphEWmr1U3
         DqQoKoHglQVsVgFb3LOCd8Zb/dULbI5ElNB1PO2ytLwUhZ/PLlAXOL6EkLAFLw2nAGrV
         5XDZJ+2Gu7oGUudLSJ1uFxD+6OsNWq4IsEWWNbz9SzOX456no1Yf2i0pkumfNpd+yctj
         m7Jm5XQcX3/py7NYL+dTcXW9PBQcutPg9p8nFfcvIDFaV8qjvq6dNJP3diRRL1DVFATE
         FYmA==
X-Gm-Message-State: AOAM5312b641lA3BQxm9/cclT5VToMkK5+VvKKc4FELABwtVH4bcpo8U
        vcnSZBwsgvF2EfkVCcI16ag=
X-Google-Smtp-Source: ABdhPJwocaqQy8EUvKQL4IXXZB9gIfgFzHdd7Y4RpAjwBP01S/HxhrKYC5l3MR+j0HnKsNspxhd1FQ==
X-Received: by 2002:a17:90a:a481:: with SMTP id z1mr55015pjp.161.1616433101337;
        Mon, 22 Mar 2021 10:11:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:2d32:3b1b:5d5:13d8])
        by smtp.googlemail.com with ESMTPSA id x7sm14599013pfp.23.2021.03.22.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:11:40 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     anton@tuxera.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: [PATCH v2] ntfs: fix incorrect kernel-doc comment syntax in files
Date:   Mon, 22 Mar 2021 22:41:31 +0530
Message-Id: <20210322171131.14347-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKXUXMxU_7YBqyEeip5kpN5LpYmtR0MFF4QbdtOebxJHC1pkTA@mail.gmail.com>
References: <CAKXUXMxU_7YBqyEeip5kpN5LpYmtR0MFF4QbdtOebxJHC1pkTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in fs/ntfs which follow this syntax, but the
content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'),
which causes unexpected warnings from kernel-doc.

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

Also fix enum documentation format at "ntfs_compression_constants", in
fs/ntfs/compress.c, by prefixing 'enum' keyword to the comment
description.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
- prefix 'enum' keyword at "ntfs_compression_constants - enum of constants used in the compression code" comment in fs/ntfs/compress.c
- modify comment message correspondingly

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
index d2f9d6a0ee32..e4e7587e8f7b 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * compress.c - NTFS kernel compressed attributes handling.
  *		Part of the Linux-NTFS project.
  *
@@ -19,7 +19,7 @@
 #include "ntfs.h"
 
 /**
- * ntfs_compression_constants - enum of constants used in the compression code
+ * enum ntfs_compression_constants - enum of constants used in the compression code
  */
 typedef enum {
 	/* Token types and access mask. */
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

