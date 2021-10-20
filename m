Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD85434327
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJTB6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhJTB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634694977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1oEtaJKDPh3Y7ob5t2269utmHBPdM5EX8o/2XMz544=;
        b=XFngEllWU5Mp45iMYmm8r0UO6iGT+GlY499obFvX+sRKdsb3XeDTOXb94qdKdZBQb8zyGV
        aVXfTGQV/YmssQuWRUGdr4tFHhqBTcqsC7svFZK0Buao44SzQr1Hec7DgluYgT2DvAQ+zB
        +/ej6oWC8oMpZSrprog20YAGKMckt4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-owE6K1epNZKoiNujNgVuhQ-1; Tue, 19 Oct 2021 21:56:14 -0400
X-MC-Unique: owE6K1epNZKoiNujNgVuhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427EA362F8;
        Wed, 20 Oct 2021 01:56:13 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A578A60657;
        Wed, 20 Oct 2021 01:56:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/4] zram: fix race between zram_reset_device() and disksize_store()
Date:   Wed, 20 Oct 2021 09:55:45 +0800
Message-Id: <20211020015548.2374568-2-ming.lei@redhat.com>
In-Reply-To: <20211020015548.2374568-1-ming.lei@redhat.com>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ->init_lock is released in zram_reset_device(), disksize_store()
can come in and try to allocate meta, but zram_reset_device() is freeing
free meta, so cause races.

Link: https://lore.kernel.org/linux-block/20210927163805.808907-1-mcgrof@kernel.org/T/#mc617f865a3fa2778e40f317ddf48f6447c20c073
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a68297fb51a2..25d781dc5fef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1704,12 +1704,13 @@ static void zram_reset_device(struct zram *zram)
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
-	up_write(&zram->init_lock);
 	/* I/O operation under all of CPU are done so let's free */
 	zram_meta_free(zram, disksize);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	zcomp_destroy(comp);
 	reset_bdev(zram);
+
+	up_write(&zram->init_lock);
 }
 
 static ssize_t disksize_store(struct device *dev,
-- 
2.31.1

