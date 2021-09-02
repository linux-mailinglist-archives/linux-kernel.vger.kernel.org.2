Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFB3FF0F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbhIBQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346183AbhIBQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BBCC061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t19so5435015lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NUPPlGVIg641VNyfch/SHNe6LbpC9+97GZHbHZOmtE=;
        b=Cq+HKI5t8ztXnwTUmcz4mW9vC0YduW5fwIgc0kdk9QUDxWUmsC6PLN1oZCffa+olD8
         HpZ1UMCK+nynKzJ1ZYVyOifjOY7o8zFHCx7oNJvxtlNm2vUwNGQ3Fu8XFGv6SlvBl1pd
         nNdyA/9AJ4GkK8mlbveF84WlxrdtDESJvnygt4wJ1WozIDpIwpyyUiXfr7c1e2RXwKeU
         /7V74FXxmdD5Da/oQkuTORasoahkdmkQsYNMMVxzweL1umTT2g1mCxEc8UEHGcKHvUxC
         Qck5GwusZnEgd6pF8lPUYlvjl/9hWm9nDoInBSq6E9rzqCKXvaFnMrCOeSBOG0wW60sf
         kXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NUPPlGVIg641VNyfch/SHNe6LbpC9+97GZHbHZOmtE=;
        b=auhX+TcAwiY4vU91c2+pkGAZP0IRhiEwvRJAuZgqPe6J66KwLIF1HX/gz/uKxb0M2S
         5gxua7SkTIz3uKhK6Y7TdgXbKuVMiOQkvWhxXFbUSvRfBdeFedV/H0jwo8USc1JbaTsJ
         v2Wo3FIvuaz1Q8OasYKSAQBEh4sQzky8rKXjwQHAL6KF/1dofzRfBpE/EMyDL2VM6O4m
         UBSTach0x3Kjg/pi9436IWmhA6aj9vPUStfPlNVv5qcjrvUFAFzUXe63nq2g6ivIyF/O
         HjVE8VAJTmIHni/kozDnBl3VKgFl+TFztjo4Gax4/JDqSq6vLovpnAHhN6uCVcMmw49t
         GF1g==
X-Gm-Message-State: AOAM531PzCEgT6dkUAdu5dkerpfWcLyvKuImvUgdGVmbYt36FhYiQCJ+
        hKRU6oiNydtpz+c4uoK3fL4=
X-Google-Smtp-Source: ABdhPJzy6EaEVYid/M8U/5VQgJ1TsS/F2nsU3a/HOPy81/PniZ9z8ig2LirjbACmRYLgTbtDAKeevg==
X-Received: by 2002:a05:6512:dc:: with SMTP id c28mr3178424lfp.251.1630599339663;
        Thu, 02 Sep 2021 09:15:39 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:39 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
Date:   Thu,  2 Sep 2021 19:15:23 +0300
Message-Id: <20210902161528.6262-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not have headers at all in this file. We should have them so that
not every .c file needs to include all of the stuff which this file need
for building. This way we can remove some headers from other files and
get better picture what is needed. This can save some compilation time.
And this can help if we sometimes want to separate this one big header.

Also use forward declarations for structs and enums when it not included
straight with include and it is used in function declarations input.
This will prevent possible compiler warning:
  xxx declared inside parameter list will not be visible
  outside of this definition or declaration

Here is list which I made when parsing this. There is not necessarily
all example from this header file, but this just proofs we need it.

<linux/blkdev.h> SECTOR_SHIFT
<linux/buffer_head.h> sb_bread(), put_bh
<linux/cleancache.h> put_page()
<linux/fs.h> struct inode (Just struct ntfs_inode need it)
<linux/highmem.h> kunmap(), kmap()
<linux/kernel.h> cpu_to_leXX() ALIGN
<linux/mm.h> kvfree()
<linux/mutex.h> struct mutex, mutex_(un/try)lock()
<linux/page-flags.h> PageError()
<linux/pagemap.h> read_mapping_page()
<linux/rbtree.h> struct rb_root
<linux/rwsem.h> struct rw_semaphore
<linux/slab.h> krfree(), kzalloc()
<linux/string.h> memset()
<linux/time64.h> struct timespec64
<linux/types.h> uXX, __leXX
<linux/uidgid.h> kuid_t, kgid_t
<asm/div64.h> do_div()
<asm/page.h> PAGE_SIZE

"debug.h" ntfs_err() (Just one entry. Maybe we can drop this)
"ntfs.h" Do you even ask?

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/ntfs_fs.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 97e682ebcfb9..149d60e29728 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -9,6 +9,37 @@
 #ifndef _LINUX_NTFS3_NTFS_FS_H
 #define _LINUX_NTFS3_NTFS_FS_H
 
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/cleancache.h>
+#include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/page-flags.h>
+#include <linux/pagemap.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/time64.h>
+#include <linux/types.h>
+#include <linux/uidgid.h>
+#include <asm/div64.h>
+#include <asm/page.h>
+
+#include "debug.h"
+#include "ntfs.h"
+
+struct dentry;
+struct fiemap_extent_info;
+struct user_namespace;
+struct page;
+struct writeback_control;
+enum utf16_endian;
+
+
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
-- 
2.25.1

