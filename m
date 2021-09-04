Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779140091B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbhIDBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 21:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhIDBgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 21:36:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB4C0613C1;
        Fri,  3 Sep 2021 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=12aNYf4JHxFW0Gi214P/st+WALXaltwzcvDZhKyLh8I=; b=FPOWeGVKUS/k/kr28P8eDjlGn4
        MI6u+YFqxLqfFYrzGzkc6Hp9+AzRx7OtMbOa9eaR/vFBMLoa4ynlM0ajK5yF8R2QySie2qLp7YRpJ
        x+OofyYmUMmUzM7ICnvhwqvarL16VSHHzJhw2A5ccjMRuqFerfjqwm+cjcJSOmEM5AQod+pEKfXY/
        XyStaO+gduFSMC6m/1uNRGP8V8GmRdzvfus/1kFCLkVwlXNImlQzks/gRgmHewdMYTQ2H2DjaxhiV
        uh9oD2RI9oD6ARt4xJhxyfluq78Ff/5XlhGLTy8QLeer/a0JZa9DSSUd90laus9N4CdtWd6cy5M8y
        M4WnDIzQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbF-IG; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/14] swim: simplify using blk_cleanup_disk() on swim_remove()
Date:   Fri,  3 Sep 2021 18:35:29 -0700
Message-Id: <20210904013536.3181237-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify swim_remove() by using one call instead of two,
just as other drivers do. Use that pattern.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 7ccc8d2a41bc..f085ea982bb7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -911,9 +911,8 @@ static int swim_remove(struct platform_device *dev)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
-		blk_cleanup_queue(swd->unit[drive].disk->queue);
+		blk_cleanup_disk(swd->unit[drive].disk);
 		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
-		put_disk(swd->unit[drive].disk);
 	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
2.30.2

