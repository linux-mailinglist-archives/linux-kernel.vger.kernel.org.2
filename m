Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153E943BF45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhJ0CGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbhJ0CGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:06:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9C1C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:04:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id k29so817660qve.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8EX3z0PmgSLSoaGYAGZF7eObBwpILXqp8huU307IME=;
        b=Qrsyc+ohpF2siZtSmMi1YCLm6GxGzrPKiahppPPfqSASi5FB0z3pEJRxUiXcVbx6DR
         ysGGFVa0tOxD+Nclyhm6biH0NjzOlJ4y3cIWlew+slIMpm4zKw6juGvfejN2z0szd7Bo
         sotfLXixCgQ1XuUwq+O1157CMqlRW1SMQt+iCW2J6BydVqt4AbprRNo7QS4cwXfb21Di
         zsPeWR6edy+5vaYsj+zW1KPzKT5zhG9td8oh22fAH1zWQGMwPS/x/V4K/L2tuyLzHJ4h
         vFApcWvpP9dl7ZW5Zttb1yoEK9OoYmwqtT5QfEo/iDyDrH2GHnx6ROT8KlctzLII4vbo
         utaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8EX3z0PmgSLSoaGYAGZF7eObBwpILXqp8huU307IME=;
        b=6oMAzREh1FlIiPp4qLlAzFwQOT9Pq6iOfpRKJGyj1jRL/C7JCcKzjI4a0aYaTENdxg
         qngbyofOSWPSA93pN5tS1S7gjMepkNxgObUH1bQ0j6GiO6AEr5aQvSNeL5jjoBupqfPq
         w34X93mn/q4iNGM5X18+zjaTD1h8BlUlSNJKS5shTX3PLqNnPgtj05QHnNL1o2KWMR9O
         tQlrESQes7cgQ7I/VEMkk7cpCYDvGMT7OvvZA+tMw3Gw0Q4YLhinR4U8VdLeE4GYFmZG
         ZuO9SPhim0csE16J8xBFR/ZyA47K9U8YYHRHlSXwDx/iGc8+nZ69cGAp6uF0j5xhDJRs
         AfMg==
X-Gm-Message-State: AOAM533kU4IG325JoQT+L5OamSAU3OQoVBC6DMSI6r1H3EUk0QEchd7N
        8M9g4BpngB8Imzd5v9XWwbk=
X-Google-Smtp-Source: ABdhPJxVlyTrQW3mxBiQDNz0Lvsofh5wR4Ka60k9U9P0iS6Me6klaMMMPkWs+YedERxETtzRS48rWQ==
X-Received: by 2002:a05:6214:1ccb:: with SMTP id g11mr26661052qvd.64.1635300255952;
        Tue, 26 Oct 2021 19:04:15 -0700 (PDT)
Received: from atari.nover ([189.6.36.155])
        by smtp.gmail.com with ESMTPSA id m17sm12145838qtx.62.2021.10.26.19.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:04:15 -0700 (PDT)
From:   Wagner Popov dos Santos <wpopov@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     wpopov@gmail.com
Subject: [PATCH 2/2] jffs2: solving deadlock on sync function
Date:   Tue, 26 Oct 2021 23:03:39 -0300
Message-Id: <20211027020339.65303-2-wpopov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211027020339.65303-1-wpopov@gmail.com>
References: <20211027020339.65303-1-wpopov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correcting AB-BA deadlock in jffs2_fsync() involving alloc_sem
semaphore and inodes.

The function jffs2_fsync() can't lock the inode because some
process, or even the same process, that call the CG will acquire
alloc_sem semaphore and will try to acquire the inode if it is
inside the Erase Block that is marked to be processed.

Fixes: 02c24a82187d ("fs: push i_mutex and filemap_write_and_wait down into ->fsync() handlers")

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 7d8654a1472e..7f139704cb8d 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -39,10 +39,14 @@ int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	if (ret)
 		return ret;
 
-	inode_lock(inode);
-	/* Trigger GC to flush any pending writes for this inode */
+	/* Trigger GC to flush any pending writes for this inode
+	 *
+	 * We need to leave the inode unlocked to avoid a deadlock condition
+	 * because the function jffs2_garbage_collect_pass() can try to lock
+	 * the same inode if it is inside the erase block that GC is
+	 * processing.
+	 */
 	jffs2_flush_wbuf_gc(c, inode->i_ino);
-	inode_unlock(inode);
 
 	return 0;
 }
-- 
2.20.1

