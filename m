Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5ED40F3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhIQIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:22:55 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:56230 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230296AbhIQIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:22:55 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-05 (Coremail) with SMTP id zQCowABnR6D5T0Rhu_XRAA--.4840S2;
        Fri, 17 Sep 2021 16:21:14 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/swapfile: Remove needless request_queue NULL pointer check
Date:   Fri, 17 Sep 2021 08:21:11 +0000
Message-Id: <20210917082111.33923-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABnR6D5T0Rhu_XRAA--.4840S2
X-Coremail-Antispam: 1UD129KBjvdXoWrJFWUWw1ftFWruw1fuw4kJFb_yoWxXFcEvr
        y0v3ykKrs5Xr13ur13CFyUZasYqFs2qF1xZFWfWFZIqayUGw13JrWDKr98GFW3Z3yjkr1r
        Cws0kasxJwsrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6xkF7I0En7xvr7AKxVWUJV
        W8JwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0E
        wIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2jXdUU
        UUU
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgkHA1z4j9xOIgAAsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the null check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22d10f713848..42027d213fd2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3118,7 +3118,7 @@ static bool swap_discardable(struct swap_info_struct *si)
 {
 	struct request_queue *q = bdev_get_queue(si->bdev);
 
-	if (!q || !blk_queue_discard(q))
+	if (!blk_queue_discard(q))
 		return false;
 
 	return true;
-- 
2.17.1

