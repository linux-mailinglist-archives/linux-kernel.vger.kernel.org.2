Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4D458960
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhKVGox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhKVGos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:44:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17429C061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 22:41:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt5so13005672pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 22:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6luE0x1Txd3w3w56rJ0UKpQXDWDNrMSolAkksUQvV0=;
        b=YPovlI/7m21B6tofIcXvrA5HXrkiOxOWOKnWCkf7gazJevBwI9qHo52/W9QzkDsWPh
         svgkwzNuxt2vu7mJU6LYzUGNPFd2Xl8tBJr1FeretoOlHIsbwWXrZRaNQ37y24ZUttli
         Ehfbfy78vHLSaaRtmWjBx50wKIvxWcX273RhKg98+R5JGInPUDiPPKToukP1Qh+WCGrf
         7AiDdf+r6MtJ5R1okDBeYt8Bk5gb/xzNY2UgAT0rMbTzoPEDbz9JDvK/0EJl0TFPQIwG
         jNRkiEoRXaPiNFmBFZOEZbRkefNFwfNUbWSYkS1YSSzKSMdNjF8tyZLFWcYUNvto2Tm4
         Qwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6luE0x1Txd3w3w56rJ0UKpQXDWDNrMSolAkksUQvV0=;
        b=t6ua7jc+p13yJM2c4DFNEzc57hp5P66jP97eBRVH/OMRM2OhQ5gKElQ+AK4GOvHWRS
         6BLkAuqf/2xDfx9MeO9VRHWxMp9Op/w3QbMieEZBM1BsEx3an83Wki1JiVBGN4XLc/yx
         1uFCiCqkRLpb6fzWW99CQdLqPOXqnRTYAGt4Lh43AdjW8kUZC+MlCFqwpIAVN2w5gjpI
         8iN5gNXZgsfyS5cmXy6ZbJmonBvz2k/1bW8iwxHE4q3O6TtrNdGBLFiH+vSPLK3R1AWV
         qrKTO3hA/vItDWLtW+iGxQILM+dhXRwQwHkvyGySU4rZ8nBdOTIICfX12gwvKL3iTvZw
         mOEA==
X-Gm-Message-State: AOAM533si105pri+PpQdTNh7wLUr/223PL00SbfCN0LDEiAQaOLa1zcJ
        Cu6ovFNGHDvHesk5/3XN7adIbA==
X-Google-Smtp-Source: ABdhPJwTGOGQcC8UPl37F/VrxiCporykUGVd1cUX9tTfLcgzD63dKYMorXSxptvvgkyh1WhzRnkdPA==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr28274619pjb.5.1637563302669;
        Sun, 21 Nov 2021 22:41:42 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e13sm5395304pgb.8.2021.11.21.22.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 22:41:42 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] shmem: change shrinklist_lock form spinlock to mutex and move iput into it
Date:   Mon, 22 Nov 2021 14:41:26 +0800
Message-Id: <20211122064126.76734-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes commit 779750d20b93 ("shmem: split huge pages
beyond i_size under memory pressure").

iput out of sbinfo->shrinklist_lock will let shmem_evict_inode grab
and delete the inode, which will berak the consistency between
shrinklist_len and shrinklist. The simultaneous deletion of adjacent
elements in the local list "list" by shmem_unused_huge_shrink and
shmem_evict_inode will also break the list.

iput must in lock or after lock, but shrinklist_lock is a spinlock
which can not sleep and iput may sleep.[1]

Fix it by changing shrinklist_lock from spinlock to mutex and moving iput
into this lock.

[1]. Link: http://lkml.kernel.org/r/20170131093141.GA15899@node.shutemov.name
Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/shmem.c               | 16 +++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 166158b6e917..65804fd264d0 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -41,7 +41,7 @@ struct shmem_sb_info {
 	ino_t next_ino;		    /* The next per-sb inode number to use */
 	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
-	spinlock_t shrinklist_lock;   /* Protects shrinklist */
+	struct mutex shrinklist_mutex;/* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index 18f93c2d68f1..2165a28631c5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -559,7 +559,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	if (list_empty(&sbinfo->shrinklist))
 		return SHRINK_STOP;
 
-	spin_lock(&sbinfo->shrinklist_lock);
+	mutex_lock(&sbinfo->shrinklist_mutex);
 	list_for_each_safe(pos, next, &sbinfo->shrinklist) {
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
 
@@ -586,7 +586,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		if (!--batch)
 			break;
 	}
-	spin_unlock(&sbinfo->shrinklist_lock);
 
 	list_for_each_safe(pos, next, &to_remove) {
 		info = list_entry(pos, struct shmem_inode_info, shrinklist);
@@ -643,10 +642,9 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		iput(inode);
 	}
 
-	spin_lock(&sbinfo->shrinklist_lock);
 	list_splice_tail(&list, &sbinfo->shrinklist);
 	sbinfo->shrinklist_len -= removed;
-	spin_unlock(&sbinfo->shrinklist_lock);
+	mutex_unlock(&sbinfo->shrinklist_mutex);
 
 	return split;
 }
@@ -1137,12 +1135,12 @@ static void shmem_evict_inode(struct inode *inode)
 		inode->i_size = 0;
 		shmem_truncate_range(inode, 0, (loff_t)-1);
 		if (!list_empty(&info->shrinklist)) {
-			spin_lock(&sbinfo->shrinklist_lock);
+		    mutex_lock(&sbinfo->shrinklist_mutex);
 			if (!list_empty(&info->shrinklist)) {
 				list_del_init(&info->shrinklist);
 				sbinfo->shrinklist_len--;
 			}
-			spin_unlock(&sbinfo->shrinklist_lock);
+		    mutex_unlock(&sbinfo->shrinklist_mutex);
 		}
 		while (!list_empty(&info->swaplist)) {
 			/* Wait while shmem_unuse() is scanning this inode... */
@@ -1954,7 +1952,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		 * Part of the huge page is beyond i_size: subject
 		 * to shrink under memory pressure.
 		 */
-		spin_lock(&sbinfo->shrinklist_lock);
+		mutex_lock(&sbinfo->shrinklist_mutex);
 		/*
 		 * _careful to defend against unlocked access to
 		 * ->shrink_list in shmem_unused_huge_shrink()
@@ -1964,7 +1962,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 				      &sbinfo->shrinklist);
 			sbinfo->shrinklist_len++;
 		}
-		spin_unlock(&sbinfo->shrinklist_lock);
+		mutex_unlock(&sbinfo->shrinklist_mutex);
 	}
 
 	/*
@@ -3652,7 +3650,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	raw_spin_lock_init(&sbinfo->stat_lock);
 	if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
 		goto failed;
-	spin_lock_init(&sbinfo->shrinklist_lock);
+	mutex_init(&sbinfo->shrinklist_mutex);
 	INIT_LIST_HEAD(&sbinfo->shrinklist);
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-- 
2.20.1

