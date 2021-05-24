Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7E38F604
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhEXXEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhEXXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:04:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E043C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:02:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h12so3225597plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJy+5l9i0w2g3iVe8Ym9baqKPjPo7B+zGbavCbvgRTw=;
        b=IR5ZXFzWfPHdKcPhnEBlozE+RXLAfVKbFEKoJYOKeH+eRZ0CrnmaW2jD4NT+I7rko3
         ge/p1uAqBVT0kFXIYXi60oG34ciyUIFBTpZRqbEB148UVMhk7SKT2cZxT51ExXgGNCdf
         yc0TXKHUrh8xfCklGPTnxf8HDJd3ecSEkF63piQE/+D+ssE+NEHVh6NkjIAZHVG/Uaqy
         XtXwtvohUN1DHAmmkALnaDDnl3jo9/CqcC5CRJtkMVRr3CEU2HFTeWGPV8tOEaVF/LVE
         TEBbkPkotFWuPxTfdRIV3AbcV/V6JOJC7QKmDLZ/VldXo7xyqF+uDjF0z8bYko5fEuik
         qB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJy+5l9i0w2g3iVe8Ym9baqKPjPo7B+zGbavCbvgRTw=;
        b=UaYfAn9lTHs8NE5rWrUHos8ts3BHWu7pjsdK883LogaF53OpdUGLT+uVNI9ntYbNDb
         xk0RNlp4ps12FHIu2WdOGV9+2+kftty+5dxmsPCzW/CGCh4cSL57w61iTHQju7AClPow
         QHRs2mJzrn7Okoo6MNOo+vw7u2bdXIHhHQaiH4i18R/h6TsGvp1ZgqLj375bFtYnh74k
         nzmR0khI6LJb8FxeA33kR8ZQPesnIIaBszqUIzzsFKB7SL4z5hhvOqiaECU2E2VUqKg/
         X1nTIYtsEWcMvkIN4EHCIsJbb/rYahP/9V5epLTJSWZT7tuu4npDpNZ9wyuIWSPDscnM
         rBBA==
X-Gm-Message-State: AOAM530TgtfE3oMbbz3x8/yAAQUHcaUnN8Obxm6LFSMtB83//9eDlsj0
        t4H8YalVse5xuExIf2/fUTU=
X-Google-Smtp-Source: ABdhPJzZ63YyZR94CHYmVxFLc30bYOZwmwPIF+C/f/2lhlmwzPunI9pcxwFLR78/QdiUCQU6NiXoTw==
X-Received: by 2002:a17:902:a5c9:b029:f7:9f7e:aa2f with SMTP id t9-20020a170902a5c9b02900f79f7eaa2fmr17080105plq.54.1621897363780;
        Mon, 24 May 2021 16:02:43 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2309:9691:60bf:7a61:5dc3:9ca1])
        by smtp.gmail.com with ESMTPSA id p23sm408970pja.12.2021.05.24.16.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:02:43 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH v2 1/2] char: pcmcia: cm4000_cs: Fix failure handling
Date:   Tue, 25 May 2021 04:32:34 +0530
Message-Id: <20210524230235.571-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Handled failure cases of device_create()

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V1 -> V2: Added description and changelog
---
 drivers/char/pcmcia/cm4000_cs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f07bc78..1ed4eac6b8ef 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1783,6 +1783,7 @@ static int cm4000_probe(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev;
 	int i, ret;
+	struct device *dev_ret;
 
 	for (i = 0; i < CM4000_MAX_DEV; i++)
 		if (dev_table[i] == NULL)
@@ -1814,8 +1815,14 @@ static int cm4000_probe(struct pcmcia_device *link)
 		return ret;
 	}
 
-	device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
-
+	dev_ret = device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n", i);
+		cm4000_release(link);
+		dev_table[i] = NULL;
+		kfree(dev);
+		return -ENODEV;
+	}
 	return 0;
 }
 
-- 
2.7.4

