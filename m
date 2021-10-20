Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0043432C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJTB6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhJTB6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634694993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=freyuG48ucRP6h2e8+iworwUl5TwR3fT12ETkCRsZlI=;
        b=LOTJuC2O5gM6OykfzwtnZKBilojM9VnmY2vax+qHN9z+VKVt42Z7nJ9x6zrX8YYNFRAAlM
        tsJBVRlma7a+YPsKrWIU5jBVI9xiSn57mBfhxWdKSR57664kXOPB9nhe4e65Qx2lLKvHR0
        /S7uwsLU80Uqydxci5/C5tqssYk+dOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-mcfFYADuMQicWSea3cNWvg-1; Tue, 19 Oct 2021 21:56:30 -0400
X-MC-Unique: mcfFYADuMQicWSea3cNWvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E31362FD;
        Wed, 20 Oct 2021 01:56:29 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5FEA6A8F5;
        Wed, 20 Oct 2021 01:56:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] zram: avoid race between zram_remove and disksize_store
Date:   Wed, 20 Oct 2021 09:55:47 +0800
Message-Id: <20211020015548.2374568-4-ming.lei@redhat.com>
In-Reply-To: <20211020015548.2374568-1-ming.lei@redhat.com>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After resetting device in zram_remove(), disksize_store still may come and
allocate resources again before deleting gendisk, fix the race by resetting
zram after del_gendisk() returns. At that time, disksize_store can't come
any more.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8883de7aa3d7..6078d1dae44a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2002,6 +2002,13 @@ static int zram_remove(struct zram *zram)
 	/* del_gendisk drains pending reset_store */
 	WARN_ON_ONCE(claimed && zram->claim);
 
+	/*
+	 * disksize store may come between zram_reset_device and del_gendisk, so
+	 * run the last reset for avoiding leak anything allocated in
+	 * disksize_store().
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
-- 
2.31.1

