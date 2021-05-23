Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1894638DB90
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhEWPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEWPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 11:12:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3359C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 08:11:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 69so13354956plc.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdt2q1Fv5NZ4xBK6cTTDMKgNv//YDB/rHqwA+BbxN3o=;
        b=CC64Aoi7HyMmRbhbgMYtIWOA/VNoelBx5QkbCGqQQtU1uZ6FjS1wHa24m5xS76eB1u
         /iGcHFiJqvjrCY2mSJduDQzRhHeljgsqmrTZPcOJL5WuoDaIXNqvOSBkGzrVl3bxHASL
         Huy4+2MKwVMIhhDKyMLqQdit9CdissP9DHM+Xta4zqipaq2xKMrf6D65/DQs9S0kjK2b
         JzNiFlOcvRkpG0NjIERecTosQNssRuvciTL5zD5C4aIDj30SNW8LCL7TXqOSB9VQYebH
         Q0L7ZdeCMT1lq5g5H/gOVTIOUeVteEfBW90CxxldL7wHgJtiojDU5wsGR1irWL/oc6So
         Fi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdt2q1Fv5NZ4xBK6cTTDMKgNv//YDB/rHqwA+BbxN3o=;
        b=gFCcugAQkFtcCGBrOTJxskDCSqLmcsKSh9BA/vs4zptg+h+RArj8HcWkBOXpoPYSa+
         LIizZNea7akKJIrjkwR459SLyGLPKLTkeUaoXDges2WtfLam2pksXZwY+Fa5uXtgEf6a
         tbbiUVuaCi87PzGptNbMr2AFh4xUbctfwtWSLPVqap6oEqtuA+CSQYTT6sCMMuTbgq4n
         61XSjgEQpOIrTWMG4PD8CERgEc/K6uMAvLtGHdDM9VjjjpVWzdF94vt+8TGo+IR6KhNI
         Ygf39RbF5WgwxhF1NfYtixyfa8H55Yd3StCI9mfLvFklwsqIjuCDPK9T1XfWO0OfTh5y
         zIJA==
X-Gm-Message-State: AOAM5311f4OkT5wUasN8fHXfO8F9ULbiC0mFqO/bhJ7duDTPFHuf+qQN
        6hPYAybpHqfmStXYYUrN6ZE=
X-Google-Smtp-Source: ABdhPJz92/Q0CXLrWvHHEDuXPuMcUI7Yi4SmC8IAey7F41T6KqK6vvh/iURNtLuSlZ1PQ2PhSXyYsQ==
X-Received: by 2002:a17:90a:f85:: with SMTP id 5mr19993247pjz.64.1621782683859;
        Sun, 23 May 2021 08:11:23 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:4c18:f4c7:1973:665d:b2b5:b2a3])
        by smtp.gmail.com with ESMTPSA id 5sm8341219pfe.32.2021.05.23.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 08:11:23 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     lkundrak@v3.sk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH 1/2] char: pcmcia: scr24x_cs: Fix failure handling Handled failure cases of pcmcia_enable_device() and device_create()
Date:   Sun, 23 May 2021 20:41:10 +0530
Message-Id: <20210523151111.2968-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
 drivers/char/pcmcia/scr24x_cs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 47feb39..cad1990 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -233,6 +233,7 @@ static int scr24x_probe(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev;
 	int ret;
+       struct device *dev_ret;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -272,12 +273,20 @@ static int scr24x_probe(struct pcmcia_device *link)
 
 	ret = pcmcia_enable_device(link);
 	if (ret < 0) {
+	        cdev_del(&dev->c_dev);
 		pcmcia_disable_device(link);
 		goto err;
 	}
 
-	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
+	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
 		      NULL, "scr24x%d", dev->devno);
+        if (IS_ERR(dev_ret)) {
+                printk(KERN_ERR "device_create failed for %d\n",
+                               dev->devno);
+                cdev_del(&dev->c_dev);
+                pcmcia_disable_device(link);
+                goto err;
+       }
 
 	dev_info(&link->dev, "SCR24x Chip Card Interface\n");
 	return 0;
-- 
2.7.4

