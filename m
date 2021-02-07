Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0C31232B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBGJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:24:39 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43642 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhBGJYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:24:22 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf_KRsR9gYrgHAA--.10006S2;
        Sun, 07 Feb 2021 17:23:29 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangyouling@loongson.cn
Subject: [PATCH] staging: fix ignoring return value warning
Date:   Sun,  7 Feb 2021 17:23:28 +0800
Message-Id: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf_KRsR9gYrgHAA--.10006S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4kKw4DZw4DKw1DGFyfZwb_yoW8CF4fpa
        yxAa4Ykry2yF4Uu3yUAF1xZ3Z8ua4xK3y8Cayqyw1F9ryrJa4Svry5tFyUKr4rJr93KF4r
        tFW7ZF4UZay8WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwSdDUUUU
        U==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below ignoring return value warning for device_reset.

drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
of function declared with 'warn_unused_result' attribute [-Wunused-result]
        device_reset(&pdev->dev);
        ^~~~~~~~~~~~ ~~~~~~~~~~
drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
of function declared with 'warn_unused_result' attribute [-Wunused-result]
        device_reset(&pdev->dev);
        ^~~~~~~~~~~~ ~~~~~~~~~~

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c    | 6 +++++-
 drivers/staging/ralink-gdma/ralink-gdma.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index bc4bb43..d4ffa52 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -682,7 +682,11 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reset device\n");
+		return ret;
+	}
 
 	dd = &hsdma->ddev;
 	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 655df31..df99c47 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -833,7 +833,11 @@ static int gdma_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reset device\n");
+		return ret;
+	}
 
 	dd = &dma_dev->ddev;
 	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
-- 
2.1.0

