Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CF30DB9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhBCNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBCNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:46:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E494C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 05:45:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i187so33368551lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJ9DM6PdGtNUfSAd2slUQiJAIPkbwKKdmEnN7FGvrZ0=;
        b=uEVfZB7kBiGmlTSskPgYFqfoHOxEhUBg8168XNp7rg75oBqZfETuJQEtcgidrVIlN5
         bonOCowzB2l3esZ/9K+5hC//AzRA+W1w+rAAfgi0RMytY+ZAWSsgMRQQOILg8BnVNT/U
         fSPU5DbKq0R7X3oLkDeUpOg5fbxHaC4mhUAaMPzMaHwLE8KGruNb956KmZDEMLKJsh5I
         WyWtbFIDBbtIG4R/KYfR08QZcK3BeUKLpVOKzJ3uV+PGCvyKmB9rX/yCjU4yl36X5gW5
         feDK3wyTc4oqFsZv+c3Z97PQplmkIQmrz4klyafuD7r032vZAOaPQ1bCBiURWnjmA99F
         nHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJ9DM6PdGtNUfSAd2slUQiJAIPkbwKKdmEnN7FGvrZ0=;
        b=ti7p2SzeAhCMHp9T+7eiLebrk9uDJw2bvCK/Q1sLVmnW7JcQe3Mr/DOpetYIvX4TDe
         OGuCjZBK2RVS66Fh78qZXQJ3l6wIMIOJEtOLbp01CTB6x5/T+qtSK0SudWNG2D/Ui892
         SfEGV8D5O9qXcgToTFgbcqrSI4v7EiQb5lLl6zJ0uIa4Q4HLKV7RMXQEkhqtJPMwv3rN
         SVExGBHGPL74lTjIZUYjsdGYRcEkjt+VvxHJtJ+KvsjRa7bqO43GvI/1Gct6sU23s2yc
         Cv7Pysoz9o2KG4RIQiRnGN1dcLECLVj4pF8hgvWJp0muHU2aOVbARaet8ZDanZKJGGQa
         bCww==
X-Gm-Message-State: AOAM5324LVwKHn8GgMwm6LPGvMAYONnFNUQFl/Y/VVQwhhvx0YhyXGUw
        a1DtB6kWeEhBSQxpIa8AJns=
X-Google-Smtp-Source: ABdhPJzNmUt6lvyWzU0a8N3U8TptpiCzpMbFmkGWvjwRZ7uHY06HaSUbj8k8PxSYm7/KzTlLPQc2/A==
X-Received: by 2002:a19:ad03:: with SMTP id t3mr1812604lfc.358.1612359918784;
        Wed, 03 Feb 2021 05:45:18 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id p10sm259216lji.137.2021.02.03.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 05:45:18 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     lkp@intel.com
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        snovitoll@gmail.com,
        syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/squashfs: restrict length of xattr_ids in read_xattr_id_table
Date:   Wed,  3 Feb 2021 19:45:16 +0600
Message-Id: <20210203134516.1697931-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202102032044.wrsk1CfP-lkp@intel.com>
References: <202102032044.wrsk1CfP-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PATCH v2 fixed return -ENOMEM as error pointer.

>syzbot found WARNING in squashfs_read_table [1] when length of xattr_ids
>exceeds KMALLOC_MAX_SIZE in squashfs_read_table() for kmalloc().
>
>For other squashfs tables, currently such as boundary is checked with
>another table's boundaries. Xattr table is the last one, so there is
>no defined limit. But to avoid order >= MAX_ORDER warning condition,
>we should restrict SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids) to
>KMALLOC_MAX_SIZE, and it gives 1024 pages in squashfs_read_table via
>(length + PAGE_SIZE - 1) >> PAGE_SHIFT.
>
>[1]
>Call Trace:
> alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
> alloc_pages include/linux/gfp.h:547 [inline]
> kmalloc_order+0x2e/0xb0 mm/slab_common.c:916
> kmalloc_order_trace+0x14/0x120 mm/slab_common.c:932
> kmalloc include/linux/slab.h:559 [inline]
> squashfs_read_table+0x43/0x1e0 fs/squashfs/cache.c:413
> squashfs_read_xattr_id_table+0x191/0x220 fs/squashfs/xattr_id.c:81

Reported-by: syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 fs/squashfs/xattr_id.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index d99e08464554..2462876c66c4 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -78,5 +78,8 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 start,
 
 	TRACE("In read_xattr_index_table, length %d\n", len);
 
+	if (len > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-ENOMEM);
+
 	return squashfs_read_table(sb, start + sizeof(*id_table), len);
 }
-- 
2.25.1

