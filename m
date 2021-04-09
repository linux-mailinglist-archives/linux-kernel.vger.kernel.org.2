Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6163593F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhDIEgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:36:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AD6C061760;
        Thu,  8 Apr 2021 21:35:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so4348231pjh.1;
        Thu, 08 Apr 2021 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k2mZEPIM2m0LlUJhlSgXYp3DVlSOR6FUSdDcttNdiJk=;
        b=L4i5CejlrQ4MIrpoYJ6j/XsTBtyHPK9R4bXy8nmrP6RkXy/rSxpkoXvg+5EmsRjx6E
         c87bhneuFLSRZszLj9Z5xzpVv4V9228h/BzT0oncvyfeQatdhrT17BPEueXNrWjnAcy/
         rjtSRKs46Nh3MwAElLJF220gJm3NQLNg7kmPbvBB5pWr3Mt52r+T8Ox9neuD7w2cVy/T
         yICudyvjd4c85z+dkpRbuL9BNc9MyyTiThJB/exGPsfHAeiHwsnvKSv6ksOMdWYllmud
         FVRSOy882JI4gGuzfL27Is3EA9ns9WA+OJK8uAcJdMI2bfnq+XTujlhfr6aEsKRxxB68
         Y1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k2mZEPIM2m0LlUJhlSgXYp3DVlSOR6FUSdDcttNdiJk=;
        b=LLKQy51HmZl+edqUw/nNbL76uhPrDPXMKaOiPEn1XvDxBpz5r98aol73XvRJqEdFOH
         9sKWrYc9lxYJzKsfGuiAajZUVccAaTEplUZZN8QQmEsOuaI66LtpyQn6DsVB1vSKe88h
         faEnoLPf5ClbTlXs02aRqLJd6v/4lV30W/A32djCBZT6Uq9KV6fbaGZlaCqbTGpHY4GU
         4ufPdSBWkzsZ68YJ/CQqaG00x8L/qCv6RPt65xfpuWJYbkOc8GW8ac5hjkSUxfoloJUY
         J6sDJ5UNNCbh/JXgP9fIsZ8hCHzbT9DE7oOPXQrwagsMn+iDmn5/FLv4G5gtGrEdbCUZ
         TV4g==
X-Gm-Message-State: AOAM530nWE8HfPJCxwzQVEhJklnClh2m4sIiJNm9haia/xUEa3877WcD
        6JHdKCWbQoGis5Qeg+WR3lB44AikspXceQ==
X-Google-Smtp-Source: ABdhPJyJy7mqk/iBtRKsD/bH4NZIkGRHMGOzQXsr0Imgl3JcSq8keRo9UVZ/wvuliZxw07ad6e64zA==
X-Received: by 2002:a17:902:ed15:b029:e8:fe5f:a28f with SMTP id b21-20020a170902ed15b02900e8fe5fa28fmr10976847pld.76.1617942956119;
        Thu, 08 Apr 2021 21:35:56 -0700 (PDT)
Received: from carrot.localdomain (i114-185-13-113.s42.a014.ap.plala.or.jp. [114.185.13.113])
        by smtp.gmail.com with ESMTPSA id p24sm800487pjz.14.2021.04.08.21.35.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Apr 2021 21:35:54 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: Fix typos in comments
Date:   Fri,  9 Apr 2021 13:35:51 +0900
Message-Id: <1617942951-14631-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Jialin <lujialin4@huawei.com>

numer -> number in fs/nilfs2/cpfile.c
Decription -> Description in fs/nilfs2/ioctl.c
isntance -> instance in fs/nilfs2/the_nilfs.c

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
Link: https://lore.kernel.org/r/20210409022519.176988-1-lujialin4@huawei.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/cpfile.c    | 2 +-
 fs/nilfs2/ioctl.c     | 4 ++--
 fs/nilfs2/the_nilfs.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 025fb082575a..ce144776b4ef 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -293,7 +293,7 @@ void nilfs_cpfile_put_checkpoint(struct inode *cpfile, __u64 cno,
  * nilfs_cpfile_delete_checkpoints - delete checkpoints
  * @cpfile: inode of checkpoint file
  * @start: start checkpoint number
- * @end: end checkpoint numer
+ * @end: end checkpoint number
  *
  * Description: nilfs_cpfile_delete_checkpoints() deletes the checkpoints in
  * the period from @start to @end, excluding @end itself. The checkpoints
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index b053b40315bf..d1db73030085 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1058,7 +1058,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
  * @inode: inode object
  * @argp: pointer on argument from userspace
  *
- * Decription: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
+ * Description: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
  * checks the arguments from userspace and calls nilfs_sufile_trim_fs, which
  * performs the actual trim operation.
  *
@@ -1100,7 +1100,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
  * @inode: inode object
  * @argp: pointer on argument from userspace
  *
- * Decription: nilfs_ioctl_set_alloc_range() function defines lower limit
+ * Description: nilfs_ioctl_set_alloc_range() function defines lower limit
  * of segments in bytes and upper limit of segments in bytes.
  * The NILFS_IOCTL_SET_ALLOC_RANGE is used by nilfs_resize utility.
  *
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 221a1cc597f0..8b7b01a380ce 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -195,7 +195,7 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
 /**
  * load_nilfs - load and recover the nilfs
  * @nilfs: the_nilfs structure to be released
- * @sb: super block isntance used to recover past segment
+ * @sb: super block instance used to recover past segment
  *
  * load_nilfs() searches and load the latest super root,
  * attaches the last segment, and does recovery if needed.
-- 
1.8.3.1

