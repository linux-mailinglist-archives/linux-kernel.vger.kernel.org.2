Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69743432F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJTB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhJTB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634695000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlRh4bGaTK/lgZByvXsIKeO+VwJfwEqF4xLSsZPtqEc=;
        b=GcAd7pDJ/NX/Sc0PDQdogY2mLQdn7MhwdiJ77rCeoShLI3TjyeJaiO1BVPhBZ31ZHhv/RP
        mNPBZ+xwoA6/wmuMGseb+GScpyuWWTdMbz123guILcyEOe+DU2cMdf5w90+jaaTEfhyMS5
        EgRWU4XU+gnchXlbyHYkeWfKVecsYF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-jadriz7UNSSmKHNwv2x9mw-1; Tue, 19 Oct 2021 21:56:37 -0400
X-MC-Unique: jadriz7UNSSmKHNwv2x9mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D6C010A8E00;
        Wed, 20 Oct 2021 01:56:36 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB78F19C79;
        Wed, 20 Oct 2021 01:56:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/4] zram: replace fsync_bdev with sync_blockdev
Date:   Wed, 20 Oct 2021 09:55:48 +0800
Message-Id: <20211020015548.2374568-5-ming.lei@redhat.com>
In-Reply-To: <20211020015548.2374568-1-ming.lei@redhat.com>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling fsync_bdev(), zram driver guarantees that the bdev won't be
opened by anyone, then there can't be one active fs/superblock over the
zram bdev, so replace fsync_bdev with sync_blockdev.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6078d1dae44a..563af3aa4f5e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1790,7 +1790,7 @@ static ssize_t reset_store(struct device *dev,
 	mutex_unlock(&bdev->bd_disk->open_mutex);
 
 	/* Make sure all the pending I/O are finished */
-	fsync_bdev(bdev);
+	sync_blockdev(bdev);
 	zram_reset_device(zram);
 
 	mutex_lock(&bdev->bd_disk->open_mutex);
@@ -1991,7 +1991,7 @@ static int zram_remove(struct zram *zram)
 		;
 	} else {
 		/* Make sure all the pending I/O are finished */
-		fsync_bdev(bdev);
+		sync_blockdev(bdev);
 		zram_reset_device(zram);
 	}
 
-- 
2.31.1

