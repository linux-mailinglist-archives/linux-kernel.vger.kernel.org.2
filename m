Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFA405CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244589AbhIISLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbhIISLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED44C061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:10:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i28so4344058ljm.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNstURAnEwRQWJKpoRhMrXhV0IY6uV/pfL9IkEMgoq8=;
        b=O9HpcNgnLXjKu72laDJ5trRhVissy09oawT2w6m+FG2Ft01Pj1CZJBFWoPhpWiCq2i
         tZYhoiODW69DCoUKEdaypOr3Q50+WF8qocsVmSL1IbmX2XHs6s8av+NBQemxlG1hOK/3
         CMG+nQv1UQBbVX61Iqj1BLmCCGmmx0fhdcPjOXr9enpZJ0QTWEVFENnxjfb7TUUEoZZU
         S3sGjE5s63yaxWwzm/cx8xHXIrqgz+j3cpU+wb4jmS8PZ/YD7tOy1NnIXSvZhQ0VjnUn
         2TiJ/TG7YkAg3nRlcXPj+u+FSxQwePzCr95YojJJFRBuPWy4xfeDd2IOsoUSil+3YqDi
         Hnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNstURAnEwRQWJKpoRhMrXhV0IY6uV/pfL9IkEMgoq8=;
        b=bLEVWph/T6ki+bvqdUr3JBmal60zkJf7pujhWKcmXRy+8o71nibt2YCbbC9+spJKuG
         NZewnOKZ84pOpUqs2Q2t2kieUn4zBSK4OSw1QqOzdqzPLZ2+hSoU3ZuJ3p7PdL2RUvnj
         nDQMQ0Ncb6hp7hjCFj+TrrcwR+RakPOt1JgkH/h88yQWzCwub50a5Ez4wcHIRgJ2t+Sv
         2q7eYvlbE4bagOZMtQV7M1OE+LMWw9RikrK/Qusl5TbFtB/zHQgqrD4uXIatl0dpAGnI
         buvh3HshfN7bWcfAXZQN8s8YC89T8cmGjfUacYez/F9k9kkS75kQ+sR8hAZAtx7FtZHm
         VQ6w==
X-Gm-Message-State: AOAM531GCkXiFGs857k4KjnOYxsYEN2b5q27EzLwgKmJJ8oam64DK6UL
        t7D9yn2bIrivYRtNt+O/Pqs=
X-Google-Smtp-Source: ABdhPJyXJpPXfHBTuvCUwOH8tzpEb5kxGOxW6YCPPSJ2A/QU4wKFwazFhP9svlL5SQJC+LAwUrDIFg==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr929079ljh.91.1631211002977;
        Thu, 09 Sep 2021 11:10:02 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:10:02 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 08/11] fs/ntfs3: Remove tmp pointer bd_inode in fill_super
Date:   Thu,  9 Sep 2021 21:09:39 +0300
Message-Id: <20210909180942.8634-9-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop tmp pointer bd_inode because this is only used ones in fill_super.
Also we have so many initializing happening at the beginning that it is
already way too much to follow.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8022149f6b88..14cb90a4c133 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -877,7 +877,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
-	struct inode *bd_inode = bdev->bd_inode;
 	struct request_queue *rq = bdev_get_queue(bdev);
 	struct inode *inode;
 	struct ntfs_inode *ni;
@@ -920,7 +919,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Parse boot. */
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
-				  bd_inode->i_size);
+				  bdev->bd_inode->i_size);
 	if (err)
 		return err;
 
-- 
2.25.1

