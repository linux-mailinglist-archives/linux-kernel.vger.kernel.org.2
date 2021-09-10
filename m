Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF954065AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhIJCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 22:25:15 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:33028 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229628AbhIJCZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:25:14 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-03 (Coremail) with SMTP id rQCowADHznqtwTphvvIJAA--.9900S2;
        Fri, 10 Sep 2021 10:23:41 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-zoned: Remove needless request_queue NULL pointer checks
Date:   Fri, 10 Sep 2021 02:23:38 +0000
Message-Id: <20210910022338.22878-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowADHznqtwTphvvIJAA--.9900S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4fCry8Gr15Cw45Xw17GFg_yoW3KFc_Xr
        10v397Xrs5XFs8ur4qyFyUZ3Zavas7GF4IgFWIqasFgas3W3ZxArW3Wrn8urZrW3yUGr15
        Zr45urZxXr1xXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr
        0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8k-BtUUUUU==
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgkAA1z4j8R70gAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the NULL checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 block/blk-zoned.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1d0c76c18fc5..5160972a009a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -354,8 +354,6 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
 
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
@@ -412,8 +410,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
 
 	if (!blk_queue_is_zoned(q))
 		return -ENOTTY;
-- 
2.17.1

