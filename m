Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D743FC977
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhHaOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhHaOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6917C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l10so4624509lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0VPE2oBIT4XXr0WSgIMYofrB1J1TyHP1ldvCdNXeu0=;
        b=hg60LYdDgiunYjiUgUnVQYc8wFxUswdeZmkPB7Pm51eOA1dO0HsNbnP0xxnnV1QmJD
         OTUz3vyXddjL4N2FmxkaTaYwiTfqeFeTQaYhf5Yq5bf5dQjF/d2lwhinEUZORB10W+Yk
         3NhzXldAbrhljQM/qky+5gAHSv6pn/engfcwslDjqREEmwle5TIWYMWUADbjBJHkWvgU
         n+UdMa/jdhR5dFoDnighDdUsnpU5eqaC0SqAKGmODkZfLaUkcJ8go5v4d7CEv+vG/9Gf
         LFWnZA/kth34vVzl0tWEtzL+Qqv3M5uhbxCnX0zbQ8y9cziiWyOJUgENKMh2ghI09DQr
         osqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0VPE2oBIT4XXr0WSgIMYofrB1J1TyHP1ldvCdNXeu0=;
        b=F6ULl6Hp9ofdxP+KomSrNvCqHBX8gHiXeGt2ue0Wm4dcFQkP04uLwTOFoCzzdx2h8u
         Ec9JmwJfgvOG99hhFHCiJS/9fQrgHRktwSjBoOWGuuEzXt3AZHbNRHXQZKmgUOhjcle+
         2pPvFRUaDwEXf5oUIX2ZmVf7EUwhTe+WEz5JWxcWFjuvBsnmhGtq9gqltQlHm3JAajDA
         IJZFfH0QmRdHyPpgCG/oN2NI4iW7lHqwt6SxevmNGqFgcX6IJoYUBNMePqpH2hOuuoMW
         yYRhfDs548oudYsJUCRzcx9QLe8lMkHOoCe9OiKuNONJiUd9mJKKofODvShYJOwgtN2/
         2dIw==
X-Gm-Message-State: AOAM532xfakR4gYTSAnagVpf3t8GULV1MHfi5rtAzFz/dcYb2Nunobe9
        Tb06U/qHcd78T97j4zkM/Ks=
X-Google-Smtp-Source: ABdhPJxOR4Bu9kUNy1lqLNEH+W9dQTfzr53uBIN5gQWmA77BMwSLjzTVnAJqq1k3i7WDJIu1h2Ly/g==
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr21242688lfn.400.1630419303631;
        Tue, 31 Aug 2021 07:15:03 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:03 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
Date:   Tue, 31 Aug 2021 17:14:29 +0300
Message-Id: <20210831141434.975175-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
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
index 64ef92e16363..a39055cf9822 100644
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

