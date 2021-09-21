Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9528413571
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhIUOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:37:18 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59282 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233716AbhIUOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:37:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Up8yjG5_1632234933;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Up8yjG5_1632234933)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Sep 2021 22:35:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: clean up erofs_map_blocks tracepoints
Date:   Tue, 21 Sep 2021 22:35:31 +0800
Message-Id: <20210921143531.81356-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210921143531.81356-1-hsiangkao@linux.alibaba.com>
References: <20210921143531.81356-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new type of chunk-based files is introduced, there is no
need to leave flatmode tracepoints. Rename to erofs_map_blocks.

Add the missing FIEMAP tracepoint map flag as well.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c              | 31 ++++++++++++++-----------------
 include/trace/events/erofs.h |  7 ++++---
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9db8297..020c3e0 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -26,14 +26,11 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 				     struct erofs_map_blocks *map,
 				     int flags)
 {
-	int err = 0;
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_inode *vi = EROFS_I(inode);
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
-	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
-
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 	lastblk = nblocks - tailendpacking;
 
@@ -57,8 +54,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 				  "inline data cross block boundary @ nid %llu",
 				  vi->nid);
 			DBG_BUGON(1);
-			err = -EFSCORRUPTED;
-			goto err_out;
+			return -EFSCORRUPTED;
 		}
 
 		map->m_flags |= EROFS_MAP_META;
@@ -67,14 +63,10 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
 			  vi->nid, inode->i_size, map->m_la);
 		DBG_BUGON(1);
-		err = -EIO;
-		goto err_out;
+		return -EIO;
 	}
-
 	map->m_llen = map->m_plen;
-err_out:
-	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
-	return err;
+	return 0;
 }
 
 static int erofs_map_blocks(struct inode *inode,
@@ -89,6 +81,7 @@ static int erofs_map_blocks(struct inode *inode,
 	erofs_off_t pos;
 	int err = 0;
 
+	trace_erofs_map_blocks_enter(inode, map, flags);
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
@@ -96,8 +89,10 @@ static int erofs_map_blocks(struct inode *inode,
 		goto out;
 	}
 
-	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
-		return erofs_map_blocks_flatmode(inode, map, flags);
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
+		err = erofs_map_blocks_flatmode(inode, map, flags);
+		goto out;
+	}
 
 	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(*idx);			/* chunk index */
@@ -109,9 +104,10 @@ static int erofs_map_blocks(struct inode *inode,
 		    vi->xattr_isize, unit) + unit * chunknr;
 
 	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto out;
+	}
 	map->m_la = chunknr << vi->chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
 			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
@@ -147,11 +143,12 @@ static int erofs_map_blocks(struct inode *inode,
 		map->m_flags = EROFS_MAP_MAPPED;
 		break;
 	}
+	map->m_llen = map->m_plen;
 out_unlock:
 	unlock_page(page);
 	put_page(page);
 out:
-	map->m_llen = map->m_plen;
+	trace_erofs_map_blocks_exit(inode, map, flags, 0);
 	return err;
 }
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index db4f2ce..5c91edd 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -19,7 +19,8 @@
 		{ 1,		"DIR" })
 
 #define show_map_flags(flags) __print_flags(flags, "|",	\
-	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
+	{ EROFS_GET_BLOCKS_RAW,	"RAW" },		\
+	{ EROFS_GET_BLOCKS_FIEMAP, "FIEMAP" })
 
 #define show_mflags(flags) __print_flags(flags, "",	\
 	{ EROFS_MAP_MAPPED,	"M" },			\
@@ -169,7 +170,7 @@
 		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
 );
 
-DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
+DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned flags),
 
@@ -221,7 +222,7 @@
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
+DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned flags, int ret),
 
-- 
1.8.3.1

