Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6119145B270
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 04:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhKXDL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 22:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhKXDL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:11:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D52AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:08:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt5so1272364pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJIlVSm4kdXw1HcnWU7JtUf5lJt2ddDWCqPeuyOQhaw=;
        b=qvJzKt2TUtYGyWHjg0+J5Wv3m1ho7STmmiJ/F3Us1JmDwnJRLYEoEa1bfkQ4aDt9CM
         ouwk+ff9d5JA0c6BzAGvHSc8vLVvBdfaJNpIgzxRRbqDNuSF2RxAPd2fFGhXFEDYG7v9
         e0cr77xIbVl9a+QlpUXpRQGqYeZfygGVFwML3PolS3ClmCKcVZ8x2MLcyHtfKCa3ACML
         nAYlRPujxUaWn1NA4RHcintVGfIWSvuiU8H7eWzhIkwEf0lzmMNl23cfiF/Y3kuYQHcw
         1yOMxWXWONmx7DnzO9mYLgye+Unx4DPFUl3nhSaXeQQfI2VVbwFlbylX8eyoP2OPy3Si
         qx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cJIlVSm4kdXw1HcnWU7JtUf5lJt2ddDWCqPeuyOQhaw=;
        b=oI49q1Hk10/lzsRuk8EPT8PhFW47e0ZTvG1iM6bG6zTP0vzA6zM96uK+PKizlyJ45Q
         Vmev6fM8m/x1/7fmSTJA0jSRiYbUzB+hJULz9jFyonuETmm3swE+8b7esYQ4ma9AIiWP
         clbcGDaxfQTv8dHg0xwSeChRl7bYHzm1FQODM9BBOD/sM8tnb0LdK37hNm7GmEDdQ6zE
         mlBwDG7wuz3ZJuaOo7a3it+S6Kvp60NDbiYTeS1JKVuzWwR92TIYEl95yUG2jiNTSt4P
         iYC4dMVFsW6aFR+N97xnBmSAfT9sa8TG7Ic52ivlwSSAOv6I7d53kCsIEZkBYULSCRXn
         M9PQ==
X-Gm-Message-State: AOAM5301ONWkjxYk6fvqS4+sn1mqToRJd8oxRwhJ69Mz+R2oX+XzweyH
        ho3lSpxB7QysG4SucwMPVxR6RA==
X-Google-Smtp-Source: ABdhPJy81qLTOM3ntxtLMHuVVgiBCvlpxLrZugq94Ydh6ENuVs2ezlI6PjI9AzK6nJhRrz9PBsXv7g==
X-Received: by 2002:a17:903:2306:b0:142:123a:24ec with SMTP id d6-20020a170903230600b00142123a24ecmr13865567plh.21.1637723329457;
        Tue, 23 Nov 2021 19:08:49 -0800 (PST)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id i67sm14113113pfg.189.2021.11.23.19.08.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 19:08:48 -0800 (PST)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     songmuchun@bytedance.com, Gang Li <ligang.bdlg@bytedance.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] shmem: move spinlock to the front of iput
Date:   Wed, 24 Nov 2021 11:08:39 +0800
Message-Id: <20211124030840.88455-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a data race in commit 779750d20b93 ("shmem: split huge pages
beyond i_size under memory pressure").

Call Trace 1:
 shmem_unused_huge_shrink+0x3ae/0x410
 ? __list_lru_walk_one.isra.5+0x33/0x160
 super_cache_scan+0x17c/0x190
 shrink_slab.part.55+0x1ef/0x3f0
 shrink_node+0x10e/0x330
 kswapd+0x380/0x740
 kthread+0xfc/0x130
 ? mem_cgroup_shrink_node+0x170/0x170
 ? kthread_create_on_node+0x70/0x70
 ret_from_fork+0x1f/0x30

Call Trace 2:
 shmem_evict_inode+0xd8/0x190
 evict+0xbe/0x1c0
 do_unlinkat+0x137/0x330
 do_syscall_64+0x76/0x120
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

iput out of sbinfo->shrinklist_lock will let shmem_evict_inode grab
and delete the inode, which will berak the consistency between
shrinklist_len and shrinklist. The simultaneous deletion of adjacent
elements in the local list "list" by shmem_unused_huge_shrink and
shmem_evict_inode will also break the list.

Fix it by moving shrinklist_lock to the front of iput.

Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---

Changes in v2:
- Move spinlock to the front of iput instead of changing lock type
  since iput will call evict which may cause deadlock by requesting
  shrinklist_lock.
- Add call trace in commit message.

v1: https://lore.kernel.org/lkml/20211122064126.76734-1-ligang.bdlg@bytedance.com/

---
 mm/shmem.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9023103ee7d8..2f70a16fc588 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -569,7 +569,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		/* inode is about to be evicted */
 		if (!inode) {
 			list_del_init(&info->shrinklist);
-			removed++;
 			goto next;
 		}
 
@@ -577,15 +576,16 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		if (round_up(inode->i_size, PAGE_SIZE) ==
 				round_up(inode->i_size, HPAGE_PMD_SIZE)) {
 			list_move(&info->shrinklist, &to_remove);
-			removed++;
 			goto next;
 		}
 
 		list_move(&info->shrinklist, &list);
 next:
+		removed++;
 		if (!--batch)
 			break;
 	}
+	sbinfo->shrinklist_len -= removed;
 	spin_unlock(&sbinfo->shrinklist_lock);
 
 	list_for_each_safe(pos, next, &to_remove) {
@@ -602,7 +602,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		inode = &info->vfs_inode;
 
 		if (nr_to_split && split >= nr_to_split)
-			goto leave;
+			goto move_back;
 
 		page = find_get_page(inode->i_mapping,
 				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
@@ -616,38 +616,38 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		}
 
 		/*
-		 * Leave the inode on the list if we failed to lock
-		 * the page at this time.
+		 * Move the inode on the list back to shrinklist if we failed
+		 * to lock the page at this time.
 		 *
 		 * Waiting for the lock may lead to deadlock in the
 		 * reclaim path.
 		 */
 		if (!trylock_page(page)) {
 			put_page(page);
-			goto leave;
+			goto move_back;
 		}
 
 		ret = split_huge_page(page);
 		unlock_page(page);
 		put_page(page);
 
-		/* If split failed leave the inode on the list */
+		/* If split failed move the inode on the list back to shrinklist */
 		if (ret)
-			goto leave;
+			goto move_back;
 
 		split++;
 drop:
 		list_del_init(&info->shrinklist);
-		removed++;
-leave:
+		goto put;
+move_back:
+		spin_lock(&sbinfo->shrinklist_lock);
+		list_move(pos, &sbinfo->shrinklist);
+		sbinfo->shrinklist_len++;
+		spin_unlock(&sbinfo->shrinklist_lock);
+put:
 		iput(inode);
 	}
 
-	spin_lock(&sbinfo->shrinklist_lock);
-	list_splice_tail(&list, &sbinfo->shrinklist);
-	sbinfo->shrinklist_len -= removed;
-	spin_unlock(&sbinfo->shrinklist_lock);
-
 	return split;
 }
 
-- 
2.20.1

