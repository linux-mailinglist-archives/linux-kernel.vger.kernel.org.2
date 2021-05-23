Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4838DC99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhEWTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhEWTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:32:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06287C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 12:30:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso9288296pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paUfgzLUbsz6l/mTSSNvDWh8QlY7aHUXVf8/E0i6FjE=;
        b=RLP2r59ybrj+K9lroTzV0IWWxklFIuRjfUsUi/4po2zG9w4I4ZKHS14EMTQO6NaT0q
         /3pZCJ/u4yU/BFG0whwY+tzkzTG2ZaKZlciwH6JXmf8HyZySR4gTZZNCaDB/uFIBmnHV
         FsVlE4RlQAyyTXQaEgvwPno+Rotc5KVg2iEgnezEAfp2Jy5MfntDRBUMFzz9StmWxDgT
         t6mDyIQ5RiVVfETEMhOHf/WHxBB/PVhleww9+6HDOo2gNsfs+xtpvI9ydQqnrzlRaOuP
         zx26TzctFEtR5Ly9A3E227l6rcFeBFer5vajzX8GL/1PfqlaJCAp88/AOzOoBvsKikAh
         gkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paUfgzLUbsz6l/mTSSNvDWh8QlY7aHUXVf8/E0i6FjE=;
        b=QfcddNXzghp6VIEz00ZvjbSsLgbcfCiQlizyfyhiOiOG2qpvVGu/MJ7JSHqUd1oWfG
         TQSfRODzmJPGMV6EDP4kkDVvQG4YXIN3NUl/Pa2QM4GqUKl75BsNN4v/ufstYC8gEdal
         qKjU2XhTKU2Wb3qq+0OQ3/eN7G3GurWl6/uc89UyjVDD791btiQR8cKCiW9Nz7egG4He
         ihUdmoL2O+26PTdtf1aUqGT/nIImgixYEBfu1eQZEP6+4H76MtaUz/d5DU3FZsl5hMks
         VSnzohZT6Pc4eisB3qi6iC8/Ze5oMnGnjGjLWDFZ+L4bmllWnNi7NBRQBsAbxVdoU3Gb
         8IcA==
X-Gm-Message-State: AOAM533P4QsznNceOxflpEv07HuT73AwQHZVVnXiUehH1a19fKtRSbZb
        /sgoYC8xT6yRA2vtQkB17ZijeCOFKbCLWU4xs4U=
X-Google-Smtp-Source: ABdhPJzByeNHZ6KgVelbKjlQu5mx6kvalv/nNSC+xHM7o9Cpm7XLq2IZMVu0f3zQjtZ8y+REW6PNYQ==
X-Received: by 2002:a17:902:7c8a:b029:e6:f010:a4f4 with SMTP id y10-20020a1709027c8ab02900e6f010a4f4mr21755924pll.17.1621798254225;
        Sun, 23 May 2021 12:30:54 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:4c18:f4c7:dc37:2dd:3064:28d9])
        by smtp.gmail.com with ESMTPSA id ci2sm8427370pjb.56.2021.05.23.12.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 12:30:53 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH 1/2] char: pcmcia: cm4000_cs: Fix failure handling Handled failure cases of device_create()
Date:   Mon, 24 May 2021 01:00:28 +0530
Message-Id: <20210523193029.3178-1-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 89681f0..d6f5598 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1783,6 +1783,7 @@ static int cm4000_probe(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev;
 	int i, ret;
+	struct device *dev_ret;
 
 	for (i = 0; i < CM4000_MAX_DEV; i++)
 		if (dev_table[i] == NULL)
@@ -1814,8 +1815,15 @@ static int cm4000_probe(struct pcmcia_device *link)
 		return ret;
 	}
 
-	device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
-
+	dev_ret = device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
+        if (IS_ERR(dev_ret)) {
+               	printk(KERN_ERR "device_create failed for %d\n",
+                       	       i);
+		cm4000_release(link);
+                dev_table[i] = NULL;
+		kfree(dev);
+		return -ENODEV;
+	}
 	return 0;
 }
 
-- 
2.7.4

