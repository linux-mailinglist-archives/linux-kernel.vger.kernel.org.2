Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27113F74CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhHYMIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:08:52 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53760 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232681AbhHYMIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:08:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UloQ1wE_1629893278;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UloQ1wE_1629893278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Aug 2021 20:08:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] erofs: fix double free of 'copied'
Date:   Wed, 25 Aug 2021 20:07:57 +0800
Message-Id: <20210825120757.11034-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan reported a new smatch warning [1]
"fs/erofs/inode.c:210 erofs_read_inode() error: double free of 'copied'"

Due to new chunk-based format handling logic, the error path can be
called after kfree(copied).

Set "copied = NULL" after kfree(copied) to fix this.

[1] https://lore.kernel.org/r/202108251030.bELQozR7-lkp@intel.com
Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4408929bd6f5..31ac3a73b390 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -127,6 +127,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 			/* fill chunked inode summary info */
 			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
 		kfree(copied);
+		copied = NULL;
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
-- 
2.24.4

