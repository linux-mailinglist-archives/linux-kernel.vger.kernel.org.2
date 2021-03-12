Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0F3388B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCLJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:31:20 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:57440 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232950AbhCLJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:30:57 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-03 (Coremail) with SMTP id rQCowADX3w+7NEtgMHQCAA--.12706S2;
        Fri, 12 Mar 2021 17:30:35 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] w1: Remove extra brackets
Date:   Fri, 12 Mar 2021 09:30:33 +0000
Message-Id: <20210312093033.65390-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowADX3w+7NEtgMHQCAA--.12706S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw45Xw1UGrykXr17KFW7Jwb_yoWxurbE9r
        y8Wr97Xr4DGF4xA3ZxZF45ZFyqqrZ2qr1xu3Wxta4Sg343Zr9xXFW8Xr4UJas5Xw43CFn3
        GrykKrWfury3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcg4SUUUUU
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwcSA1z4j4xQ2AABsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra brackets.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/w1/w1_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index b3e1792d9c49..eee4b5b652f1 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -102,7 +102,7 @@ int w1_add_master_device(struct w1_bus_master *master)
 	    !(master->write_bit && master->read_bit) &&
 	    !(master->write_byte && master->read_byte && master->reset_bus)) {
 		pr_err("w1_add_master_device: invalid function set\n");
-		return(-EINVAL);
+		return -EINVAL;
 	}
 
 	/* Lock until the device is added (or not) to w1_masters. */
-- 
2.17.1

