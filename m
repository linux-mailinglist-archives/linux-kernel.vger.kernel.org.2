Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19D418321
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbhIYPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbhIYPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 11:16:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA04C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:15:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v19so9069934pjh.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY9sgbTUvkxsjcYnLJV5t93hH0nIcAUbzz0yfrBN0MQ=;
        b=CB4QhYPC8e5fNi1+bj11EcWaG+7E34pQJXz+TgjcVqgY84141w9kD+qRRfMT2OukIX
         g8LFgno8h9YgAUK0bWUMBaDmi8j8NVzxc6yNUwER8XLfZivaSoHOIXI7xtne+q1sRsrV
         bP7Y2w9abkGmIgYsG9CsHoemDHqe+t9zrxy8Z+sKo3Ygg0NY5na57Grz5nd1sotK6XB7
         woKG2pXF/1PWVKylPTv7YCd4YL4dq5Z1uvn00pge5x9/E7uUrB6JMpMDUtb/D1p9pyjQ
         psJ8IJgMDll1E6E/qabRQj3/oA0X4UTsWfqBhgbiqupE1nvjkBfeDoXsn8EBOnKh/xkW
         21lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY9sgbTUvkxsjcYnLJV5t93hH0nIcAUbzz0yfrBN0MQ=;
        b=7Se8EysNdtcP3jq2Viu+wqP1f74hOYVIA3FQgql/pVnigxsx8RernNBX+WKlHQrUns
         F5j79/w8+RM2SbVgHK+AMb/DfUDpwxdQDZ0JzqkdHIN2QudgcExBRdpyJS/dMgn3x7UV
         8XVQ20Sq3R2CduuhXnv7BgnAQk3q6IH6jZbu/ndalL7SblXBu8akqkllQhIE+841A0HG
         NKuv3QoEVmyQLk4csueQC9jZW/cqlsNLPcOTvXOgcL1d4vgaQy+pST/yWX+PU6LSEgeq
         yiX2pcyER8EF6sjKHfuHwIcfshYnSGa+XgXNjlPMrzgcLsur32C+qFmc8nrscx8Ye1hF
         iTLg==
X-Gm-Message-State: AOAM530AMdr3Ludt528j7JHwaaHSRVWgcwJA7Cbt8sBhhDB2EgnS2zcK
        h8a+AMbg1w5IVsr5v0Sel4Y=
X-Google-Smtp-Source: ABdhPJz3CN2rfcefFg3McJkUU/vdDrSeILbf/iWUlQBRFAYOaSyuXRXkSXmKCFAdNcxacVPZDXjAlA==
X-Received: by 2002:a17:90a:4e:: with SMTP id 14mr8701156pjb.180.1632582901878;
        Sat, 25 Sep 2021 08:15:01 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.gmail.com with ESMTPSA id l142sm12668098pfd.87.2021.09.25.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 08:15:01 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar Kushwaha <prabhakar@freescale.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
Date:   Sat, 25 Sep 2021 23:14:32 +0800
Message-Id: <20210925151434.8170-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling code of fsl_ifc_ctrl_probe is problematic. When
fsl_ifc_ctrl_init fails or request_irq of fsl_ifc_ctrl_dev->irq fails,
it forgets to free the irq and nand_irq. Meanwhile, if request_irq of
fsl_ifc_ctrl_dev->nand_irq fails, it will still free nand_irq even if
the request_irq is not successful.

Fix this by refactoring the error handling code

Fixes: d2ae2e20fbdd ("driver/memory:Move Freescale IFC driver to a common driver")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: remove the check of nand_irq; add fixes tag;
 drivers/memory/fsl_ifc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index d062c2f8250f..75a8c38df939 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -263,7 +263,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 
 	ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
 	if (ret < 0)
-		goto err;
+		goto err_unmap_nandirq;
 
 	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
 
@@ -272,7 +272,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	if (ret != 0) {
 		dev_err(&dev->dev, "failed to install irq (%d)\n",
 			fsl_ifc_ctrl_dev->irq);
-		goto err_irq;
+		goto err_unmap_nandirq;
 	}
 
 	if (fsl_ifc_ctrl_dev->nand_irq) {
@@ -281,17 +281,16 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
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
 	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
 err:
 	iounmap(fsl_ifc_ctrl_dev->gregs);
-- 
2.25.1

