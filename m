Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1A341733
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhCSIR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:17:26 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:53864 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234215AbhCSIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:16:54 -0400
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-01 (Coremail) with SMTP id qwCowAAX2Y3fXVRgKSkYAA--.10056S2;
        Fri, 19 Mar 2021 16:16:31 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm cache: remove needless request_queue NULL pointer checks
Date:   Fri, 19 Mar 2021 08:16:28 +0000
Message-Id: <20210319081628.17117-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAAX2Y3fXVRgKSkYAA--.10056S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5XrWkXF1fZrWrAFy3twb_yoW3CrgEgw
        1ruF9Fgrs5WF1a9r15AF15Z39YvFyvqF1IvF4IgFW3KF97uwn3Gryj9Fn8Gr4Uuay8Cw17
        Cr43Was7Ar4xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jFlksUUUUU=
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQcFA102aBMo8AAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ff9ea323816d ("block, bdi: an active gendisk always has a
request_queue associated with it") the request_queue pointer returned
from bdev_get_queue() shall never be NULL.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/md/dm-cache-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 541c45027cc8..6ab01ff25747 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3387,7 +3387,7 @@ static bool origin_dev_supports_discard(struct block_device *origin_bdev)
 {
 	struct request_queue *q = bdev_get_queue(origin_bdev);
 
-	return q && blk_queue_discard(q);
+	return blk_queue_discard(q);
 }
 
 /*
-- 
2.17.1

