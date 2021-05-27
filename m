Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0C7393658
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhE0TgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhE0TgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:36:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D01C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so684344pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/zLrNyoUcV41DvGV+DpRUh9xWE6DdaF74fL5jK7EPE=;
        b=uwQDC9fSHIA5mdjetEWSdcJM/VlozOh0bU370Z5PtD+orKhYSQShM0EYeZ8kTd8zbF
         1S0caYvtBqJW8HpdM8G1PlycWqF66z27+hxta29y0hkT7ZiE0Y53rQFshJeFgbsfBKNo
         vq7TxVqBYK9VSkh+Ey+N1pKHkCbuzemdhqFHjrWMuM7d3JC9ibAE20UdtkGb9u8JcMM1
         9P70vEF44Vq+Xxt8RPYji/bGvjQWgl69QenwD0kWDSrC3aepMQdLkBX1Eg2bN+hrKB6J
         ir6rUTfXwBIeXsG6TkaHBORkkWrMpXE8OpKiDSn90rkCR07ZZKYBlAY0IOG202rApled
         WXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/zLrNyoUcV41DvGV+DpRUh9xWE6DdaF74fL5jK7EPE=;
        b=IX0KY4oY7A7K7MK1aRTXpN0TZFKw2s9fkX5Ycq4wggfFiwVJyKu21F2wpcjTvTSo9C
         guXtZs7SmFw+wDyCscK43Zrbm/WNbBh2sbhPwNwF5EqJ3AAflQJX7u3+SKAaR8SDUFI/
         /LbmWrTZ5RGr1+iEyghuWK2CrpJLqYoZG+vSUzGCZ5qt187KSNHiBb7o0k8QBBoCD/Q0
         ePWaFI2k1Se7++jqs19Bez2X8gyGLVUMPFNeH2hrngf9qd0D0AJN6OoBzXVofXoymPx0
         NxLwwgMLkC+g2AA5SD1rRnhDdZ6D/zkjfIr1tY1mHd8pmS6k5camNNzrnfHeGnTQIMOU
         Kjkg==
X-Gm-Message-State: AOAM530fz3qqD/dm9ejUQ7eejTsnjRl0WbNjxbos80I8lirJga8R748m
        OXI/h9CESpOMXAa401Pe13Q=
X-Google-Smtp-Source: ABdhPJzGZCp8q6/Yxk1m0z8jOYuqi+b5MntFe4mCoi2MDmFAt8C+GJAG+i5pCxKEdEtxB4lVKiR+zA==
X-Received: by 2002:a62:34c7:0:b029:28e:addf:f17a with SMTP id b190-20020a6234c70000b029028eaddff17amr31611pfa.62.1622144083437;
        Thu, 27 May 2021 12:34:43 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2381:b5a9:2c37:cdf5:a1b0:c566])
        by smtp.gmail.com with ESMTPSA id k186sm2402380pgk.82.2021.05.27.12.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:34:43 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     lkundrak@v3.sk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH V4] char: pcmcia: scr24x_cs: Fix failure handling of device_create()
Date:   Fri, 28 May 2021 01:04:29 +0530
Message-Id: <20210527193429.696-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Ignored error in device_create() and pcmcia_enable_device()
this patch implements proper error handling.

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V3 -> V4: Added label and moved the cleanup code
V2 -> V3: Added description, Changelog and removed whitespace error
V1 -> V2: Split the patch into two parts and addressed review comments
---
 drivers/char/pcmcia/scr24x_cs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 47feb39af34c..ba84b4dd13d3 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -233,6 +233,7 @@ static int scr24x_probe(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev;
 	int ret;
+	struct device *dev_ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -271,22 +272,28 @@ static int scr24x_probe(struct pcmcia_device *link)
 		goto err;
 
 	ret = pcmcia_enable_device(link);
-	if (ret < 0) {
-		pcmcia_disable_device(link);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_device;
 
-	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
+	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
 		      NULL, "scr24x%d", dev->devno);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n",
+			dev->devno);
+		goto err_device;
+	}
 
 	dev_info(&link->dev, "SCR24x Chip Card Interface\n");
 	return 0;
 
+err_device:
+	pcmcia_disable_device(link);
+	cdev_del(&dev->c_dev);
 err:
 	if (dev->devno < SCR24X_DEVS)
 		clear_bit(dev->devno, scr24x_minors);
 	kfree (dev);
-	return ret;
+	return -ENODEV;
 }
 
 static void scr24x_remove(struct pcmcia_device *link)
-- 
2.17.1

