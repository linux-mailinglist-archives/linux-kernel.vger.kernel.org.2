Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589FE40091D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351073AbhIDBhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 21:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350869AbhIDBgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFCC0617A8;
        Fri,  3 Sep 2021 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FdGB7r/+MH6CVRDebnTYZstZWp3M+pSCw3Ya01FZoLE=; b=prkugwxYEcqadvDrjWLnKrctb+
        Ya5TPerYfmSa+Pw60WX4hCQJAPsm3XHcLhLBnh9F+dtTZcyOQgmhSz56zKk+TfF9NxbhCCr14l+AD
        1HNfrt1/YpOLERUV3+vcaJKe6vTMp507E6FB8QghLAFd3I0lSU6NK/B2tiyl/5ZJHRXgj3wZNGUTb
        HgoWJKIHFAmA5vYImRcBotOg1qz0I4robOCFbQkrblbHl3vYZLksJtX/lB++udl5AMnyR+DcTZFcD
        kEu/0hmM85qiCIRfmMUEaneSpUHVbcEmikyImHyT870rBNy+hw6FnvlNaXsLg95/InjeykQu74ncU
        iFlnciDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbN-NX; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/14] block/ataflop: use the blk_cleanup_disk() helper
Date:   Fri,  3 Sep 2021 18:35:33 -0700
Message-Id: <20210904013536.3181237-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper to replace two lines with one.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..6a865d42b1fd 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2076,8 +2076,7 @@ static int __init atari_floppy_init (void)
 
 err:
 	while (--i >= 0) {
-		blk_cleanup_queue(unit[i].disk[0]->queue);
-		put_disk(unit[i].disk[0]);
+		blk_cleanup_disk(unit[i].disk[0]);
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
 
@@ -2135,8 +2134,7 @@ static void __exit atari_floppy_exit(void)
 			if (!unit[i].disk[type])
 				continue;
 			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_queue(unit[i].disk[type]->queue);
-			put_disk(unit[i].disk[type]);
+			blk_cleanup_disk(unit[i].disk[type]);
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
-- 
2.30.2

