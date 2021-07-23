Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1943D30EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhGVX6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbhGVX63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F4DF60EB0;
        Fri, 23 Jul 2021 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627000743;
        bh=w6d0ememMNzqQ4orGdbf+c+bf4YvhmCQiSDhVd0wOPE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=QWMyIIVxshyVup1WnAZgZ+tsIDbD9ynjCil6HSJLnp5sXmjLV/W1GLbr+L0jJOyd5
         NHoHRGdW3skI+hVTQVAt0KqeeMOkjhtFnkUNx4HoEYwgI6//6l/DEeV/0YAWAiVYR9
         A9VG8/q5Jf/F4M+XVr5q3a+UoLFwrkmbeKA8KVwNGfNbettttcTOKgchm3JJDBLafP
         ys4B+8TYNWpgl4+m9K7dJ0kC8rDe35UnK/clOBk9qoBkqViXj6M29Ekw1hrOg8Yau3
         3pwAGAea7v4K9i8HaEP8HxkLQKHB9ZTkmuT4Jb7xakyCYKk8PEpRMWr4I23plB0rD1
         PGFDGQb0l4NEw==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't sleep while grabing
 nat_tree_lock
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210722014149.525166-1-jaegeuk@kernel.org>
 <YPmufPvn9FJXfcip@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ff0e3bdf-d5e4-8709-6d6b-c8d36b57b828@kernel.org>
Date:   Fri, 23 Jul 2021 08:39:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPmufPvn9FJXfcip@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/23 1:44, Jaegeuk Kim wrote:
> This tries to fix priority inversion in the below condition resulting in
> long checkpoint delay.
> 
> f2fs_get_node_info()
>   - nat_tree_lock
>    -> sleep to grab journal_rwsem by contention
> 
>                                       checkpoint
>                                       - waiting for nat_tree_lock
> 
> In order to let checkpoint go, let's release nat_tree_lock, if there's a
> journal_rwsem contention.

Write lock of nat_tree_lock is held from many places, how about just
retrying unlock/lock only if checkpoint() is flushing nat blocks?

---
  fs/f2fs/f2fs.h | 1 +
  fs/f2fs/node.c | 8 ++++++--
  2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ad8f99d7235f..05f41a15fda4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -877,6 +877,7 @@ struct f2fs_nm_info {
  	spinlock_t nat_list_lock;	/* protect clean nat entry list */
  	unsigned int nat_cnt[MAX_NAT_STATE]; /* the # of cached nat entries */
  	unsigned int nat_blocks;	/* # of nat blocks */
+	bool flushing_nat;		/* indicate checkpoint() is flushing nat blocks */

  	/* free node ids management */
  	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c60ba4179bb2..2caa171a68f8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -569,7 +569,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
  	 * This sem is on the critical path on the checkpoint requiring the above
  	 * nat_tree_lock. Therefore, we should retry, if we failed to grab here.
  	 */
-	if (!down_read_trylock(&curseg->journal_rwsem)) {
+	if (!down_read_trylock(&curseg->journal_rwsem) && nm_i->flushing_nat) {
  		up_read(&nm_i->nat_tree_lock);
  		goto retry;
  	}
@@ -2981,6 +2981,8 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
  	LIST_HEAD(sets);
  	int err = 0;

+	nm_i->flushing_nat = true;
+
  	/*
  	 * during unmount, let's flush nat_bits before checking
  	 * nat_cnt[DIRTY_NAT].
@@ -2992,7 +2994,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
  	}

  	if (!nm_i->nat_cnt[DIRTY_NAT])
-		return 0;
+		goto out;

  	down_write(&nm_i->nat_tree_lock);

@@ -3026,6 +3028,8 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
  	up_write(&nm_i->nat_tree_lock);
  	/* Allow dirty nats by node block allocation in write_begin */

+out:
+	nm_i->flushing_nat = false;
  	return err;
  }

-- 
2.22.1


