Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231ED439088
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhJYHp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:45:56 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46276 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhJYHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:45:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UtZ.ZRi_1635147792;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UtZ.ZRi_1635147792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Oct 2021 15:43:27 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>, Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: don't trigger WARN() when decompression fails
Date:   Mon, 25 Oct 2021 15:43:11 +0800
Message-Id: <20211025074311.130395-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a WARNING [1] due to corrupted compressed data.

As Dmitry said, "If this is not a kernel bug, then the code should
not use WARN. WARN if for kernel bugs and is recognized as such by
all testing systems and humans."

[1] https://lore.kernel.org/r/000000000000b3586105cf0ff45e@google.com
Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a0786b95cdf9..bf37fc76b182 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -227,7 +227,6 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
 			  ret, rq->inputsize, inputmargin, rq->outputsize);
 
-		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-- 
2.24.4

