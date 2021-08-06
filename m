Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782383E1FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhHFAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhHFAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 388B3606A5;
        Fri,  6 Aug 2021 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628208362;
        bh=ennyVryFxjJ44CHKwDR045QMMnx30QntbMpU60qL0wc=;
        h=From:To:Cc:Subject:Date:From;
        b=eJQRv5uf01Kz2UteAygihx3H8LSB615aI3AXXG1wGne8JUpQIanSXgVObEBfUzxrn
         ilb3QNB4o9c5OxshzVPi+BnjtSPrz8v2IzYvOOjv4qzRnYml/exn+koKm9lgdILQgC
         9TPKI2SZTNqEDdT3WKhrx9wuCnrx3Hiv4p6cJn395v8qJpECrSS1CGzzIN9BLdQeUu
         MS8y0f744fPo4uk7vopU80zrwTP7qfy1IPsDRGTkNNCUgO5VGE5ac74epDCxnNsnOq
         bG9bVxcNwq/MCIZNNgrIZKaRHr9R+MPe4KYpuwfrZ43LljzqMEQ1M6NWc7DHDTSmpS
         4kyv0MNZIsK+A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: avoid unneeded memory allocation in __add_ino_entry()
Date:   Fri,  6 Aug 2021 08:05:58 +0800
Message-Id: <20210806000558.40784-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__add_ino_entry() will allocate slab cache even if we have already
cached ino entry in radix tree, e.g. for case of multiple devices.

Let's check radix tree first under protection of rcu lock to see
whether we need to do slab allocation, it will mitigate memory
pressure from "f2fs_ino_entry" slab cache.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7f6745f4630e..5b6ddeae1107 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -465,16 +465,28 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 						unsigned int devidx, int type)
 {
 	struct inode_management *im = &sbi->im[type];
-	struct ino_entry *e, *tmp;
+	struct ino_entry *e = NULL, *new = NULL;
+
+	if (type == FLUSH_INO) {
+		rcu_read_lock();
+		e = radix_tree_lookup(&im->ino_root, ino);
+		rcu_read_unlock();
+	}
 
-	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
+retry:
+	if (!e)
+		new = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
 
 	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
 
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
-		e = tmp;
+		if (!new) {
+			spin_unlock(&im->ino_lock);
+			goto retry;
+		}
+		e = new;
 		if (unlikely(radix_tree_insert(&im->ino_root, ino, e)))
 			f2fs_bug_on(sbi, 1);
 
@@ -492,8 +504,8 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	spin_unlock(&im->ino_lock);
 	radix_tree_preload_end();
 
-	if (e != tmp)
-		kmem_cache_free(ino_entry_slab, tmp);
+	if (new && e != new)
+		kmem_cache_free(ino_entry_slab, new);
 }
 
 static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
-- 
2.22.1

