Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6763CC473
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGQQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:31:11 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:46525 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGQQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hMHAVT3FIryoflpAxS
        YqU4AtSFOocoMnlnWbF2KwP8E=; b=jAsb6MoTPynP1oEPb5GXBKo3IkGfL6WFb4
        FPFvyK5YkQ/iBJEeoROWMaNOQqQP0lZU8Iid8NjcNhmlwLhDkpTKGDYTg1ezHiiJ
        IhqH9PHFFnl7XZ7Wr/GCWN1M4Ndmc8/ShDhikRYIDsSGIPH4VEjc0mOfeMkhvGSl
        pLy2MeNww=
Received: from 192.168.137.133 (unknown [112.10.74.16])
        by smtp1 (Coremail) with SMTP id C8mowAB3Ol1S_fJg_DnxTA--.9273S3;
        Sat, 17 Jul 2021 23:55:03 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] dm io: fix comments to align with on-stack plugging
Date:   Sat, 17 Jul 2021 11:54:23 -0400
Message-Id: <1626537263-8752-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowAB3Ol1S_fJg_DnxTA--.9273S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UKFykZF4kZw45AFy5Jwb_yoWkAFX_Cr
        90qa97Wr1YkF13Kr43Gr4avr95KrZ7uF1xWF1UKa9xWa40vws0qr9rKrnxKr1UZayxCa98
        GFWkJ34rC3y09jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnKhF7UUUUU==
X-Originating-IP: [112.10.74.16]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbizhfSpF8RNK227wAAsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianting Tian <xianting.tian@linux.alibaba.com>

Ther is no unplugging timer now, on-stack io plugging is used:
	struct blk_plug plug;

	blk_start_plug(&plug);
	submit_batch_of_io();
	blk_finish_plug(&plug);

So remove the old comments for unplugging timer.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/md/dm-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2d3cda0..7dba193 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -528,11 +528,6 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 
 /*
  * New collapsed (a)synchronous interface.
- *
- * If the IO is asynchronous (i.e. it has notify.fn), you must either unplug
- * the queue with blk_unplug() some time later or set REQ_SYNC in
- * io_req->bi_opf. If you fail to do one of these, the IO will be submitted to
- * the disk after q->unplug_delay, which defaults to 3ms in blk-settings.c.
  */
 int dm_io(struct dm_io_request *io_req, unsigned num_regions,
 	  struct dm_io_region *where, unsigned long *sync_error_bits)
-- 
1.8.3.1

