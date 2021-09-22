Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69841458C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhIVJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:53:25 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37285 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234233AbhIVJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:53:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UpDev3j_1632304305;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UpDev3j_1632304305)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 17:51:52 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix misbehavior of unsupported chunk format check
Date:   Wed, 22 Sep 2021 17:51:41 +0800
Message-Id: <20210922095141.233938-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unsupported chunk format should be checked with
"if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL)"

Found when checking with 4k-byte blockmap (although currently mkfs
uses inode chunk indexes format by default.)

Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 31ac3a7..a552399 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -176,7 +176,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 	}
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
-		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
+		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err(inode->i_sb,
 				  "unsupported chunk format %x of nid %llu",
 				  vi->chunkformat, vi->nid);
-- 
1.8.3.1

