Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF53DE798
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhHCHwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbhHCHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:52:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4FEC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 00:52:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2682811pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C78rqkO5H0cI5SQIYJOnkvtQX5mSLMpX9nmGV+h+d0=;
        b=CrCYvKeXWn/9MlbvEOODHv74BIBGnWdBf9157dYfL+oomc5OucFsVFRxkp6EjL9Ftl
         TBSSDc66LGOiDZNyfRcgKI9Bl5xD1vr+scXdsYzSvVyouj7U0o2BRkJCkZmwU0KmE8wk
         HclX18gPT9VZXELl1+5SAuw4A8UgL4D7EEhFA9J0vqBR0l35BWmYDCloRIuHsDnQ/wXX
         6dZgKOkB7T1eP/jxP0BvqfaSgI5bMABef81gY14yULfJkhaRxwUcxB86evEgBzBwwDwT
         AifTTDIITRCY8177m6+Wsjh5plU/fejgOmmuKRJLDTXJmyHRzlPU3VSKaCsyiszBznVQ
         Sk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C78rqkO5H0cI5SQIYJOnkvtQX5mSLMpX9nmGV+h+d0=;
        b=sUYlTkaTAEGk9TnlAxgn57eZ6CPddVR4Vj2CSGS5PXKJFeBuvZ5IPXEWqs2W2t+loy
         peCFK6LUP5/dKXpnCzCrH2jwBR84dz8rTVq8pg0xVWQqLAw2ukV4tGaZPLUDLc1mMsdy
         eH0vd9ep3V6VbF4kc6NCbw1vZotDknIMMAIU6LBmLtkMbTo9sKTgqnMTS8TztZZBcI3X
         LpQx3EGEPa/2PwJ9geDbwGkopx3y7AbWGnl2ao9yEJ0IBbjpAP2UfL5IM5a0CPyiUWzK
         hthOK1zZzVe5jGPwY/6GdFTDEgTHdgM1Bwr/ojbf34/nRT9kjF1wP9j+cNHADhSDJpqp
         1Ncg==
X-Gm-Message-State: AOAM533ElBt4WizynDYYkSMakqd8SJYEq4uwq47o4W4I7Pcc9x9pzG4k
        HUJ6NXEwm9IUtavgpKgCvYs=
X-Google-Smtp-Source: ABdhPJy7mGE2N3lFwXc4DgpqLjYLCmBU7NSWeL46Mt6JyHS8DyLeGyqDo+kmo43CbgdSOWyMZH67wg==
X-Received: by 2002:a05:6a00:1515:b029:3bb:2d88:ef34 with SMTP id q21-20020a056a001515b02903bb2d88ef34mr10532613pfu.76.1627977137956;
        Tue, 03 Aug 2021 00:52:17 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.234])
        by smtp.gmail.com with ESMTPSA id o8sm1872888pjh.20.2021.08.03.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 00:52:17 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
Date:   Tue,  3 Aug 2021 15:51:59 +0800
Message-Id: <20210803075159.2823913-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fsl_ifc_ctrl_probe, if fsl_ifc_ctrl_init fails, we should free the
resources allocated by irq_of_parse_and_map.

Fix this by adjusting the error handling code.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/memory/fsl_ifc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index d062c2f8250f..391390dd3dcb 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -258,12 +258,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	/* get the nand machine irq */
 	fsl_ifc_ctrl_dev->nand_irq =
 			irq_of_parse_and_map(dev->dev.of_node, 1);
+	if (fsl_ifc_ctrl_dev->nand_irq == 0) {
+		dev_err(&dev->dev, "failed to get nand_irq resource for IFC\n");
+		ret = -ENODEV;
+		goto err_unmap_irq;
+	}
 
 	fsl_ifc_ctrl_dev->dev = &dev->dev;
 
 	ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
 	if (ret < 0)
-		goto err;
+		goto err_unmap_nandirq;
 
 	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
 
@@ -272,7 +277,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	if (ret != 0) {
 		dev_err(&dev->dev, "failed to install irq (%d)\n",
 			fsl_ifc_ctrl_dev->irq);
-		goto err_irq;
+		goto err_unmap_nandirq;
 	}
 
 	if (fsl_ifc_ctrl_dev->nand_irq) {
@@ -281,17 +286,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 		if (ret != 0) {
 			dev_err(&dev->dev, "failed to install irq (%d)\n",
 				fsl_ifc_ctrl_dev->nand_irq);
-			goto err_nandirq;
+			goto err_free_irq;
 		}
 	}
 
 	return 0;
 
-err_nandirq:
-	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
-	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
-err_irq:
+err_free_irq:
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
+err_unmap_nandirq:
+	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
+err_unmap_irq:
 	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
 err:
 	iounmap(fsl_ifc_ctrl_dev->gregs);
-- 
2.25.1

