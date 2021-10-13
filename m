Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48742BE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhJMLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhJMLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:00:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358EC06176E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x4so1541415pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9zfEpAFP/UtYO0y7HUDPjv1/m+Sw2jOFwXawa2AyNU=;
        b=U67yZi0auHCjjwva0sTdaEAXRnJdVLTB7DviAcEjVZZdjq75nxAZmhS1lVAqvVDcVc
         iAg8QW6jDb1uWLzCAJGkmDFWHxJFej3DnyHNoiBuIDNtSfdpjJFLtzB2QtUvomNkQLPn
         Wc41ka+mc9w/5sEHMAMrZSqMWIHzuS1j3UOQsiQx19OmF045HMV0OmMbXQ8bz7gHIJ7g
         g2D1AJMtkNtXt43lmUTXZYXeBVFRHRAE6DNe7eq9mm+gxCBC1iWIQnAcfdAMZK0eiYqa
         y4VrOb1qZ8kwrHOwlguRF3zoYriskjonKpGNBp4fi82gltB6phplWw9fRCOYNtAEsqP9
         RVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9zfEpAFP/UtYO0y7HUDPjv1/m+Sw2jOFwXawa2AyNU=;
        b=kF3XyYbA9XbRfTLQgOQ/HzhbzBvgpmxOjzNTWua8RRChJYwyUi1ccFb7GLx1t5EdkW
         ycWF+9TtB9easj4cPJdPMllVbj7FJIF+R04WXfnknKQxqYiSPgiUqjtvfcGEatUVgu3m
         WcTkng+yv0wtJq5maru4OZnQLDYBa/XRYpRH+yNoaeAjUSOtMBKr/LyMtT0jZB/yNPqT
         fbyTnwXTjYIeFDA1uK7yvUZymnxpml2wZyOj7n0TLApo3SgZKER69VoiYg/GB2poDyxX
         Bq/XWqXAJuLl97MgVAI0cuhLKes/S1TuCzRLLHkDz8swpodL03bIICYGW11JiXoFn8cE
         Ud+g==
X-Gm-Message-State: AOAM531MrE08TmrzRZ1GxB7N4mm53ucF2Nc+CJKtN3Ypd4GGPZdICg6Z
        E6iLadXddMVV8Gcr8X1sbYlhDQ==
X-Google-Smtp-Source: ABdhPJzSZkZzltA3PSyO7hPgqOJaFSQ05pPs1chCE33sM/8dCrpJsCOn1LvXGukyCQOeVX1J8lPekA==
X-Received: by 2002:a17:90a:df13:: with SMTP id gp19mr10540172pjb.151.1634122615608;
        Wed, 13 Oct 2021 03:56:55 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:56:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 13/20] dma: qcom: bam_dma: Add support to initialize interconnect path
Date:   Wed, 13 Oct 2021 16:25:34 +0530
Message-Id: <20211013105541.68045-14-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

BAM dma engine associated with certain hardware blocks could require
relevant interconnect pieces be initialized prior to the dma engine
initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
is passed on to the bam dma driver from dt via the "interconnects"
property.  Add support in bam_dma driver to check whether the interconnect
path is accessible/enabled prior to attempting driver intializations.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Make header file inclusion alphabetical]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8a77b428b52..fc84ef42507d 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/interconnect.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -392,6 +393,7 @@ struct bam_device {
 	const struct reg_offset_data *layout;
 
 	struct clk *bamclk;
+	struct icc_path *mem_path;
 	int irq;
 
 	/* dma start transaction tasklet */
@@ -1284,9 +1286,18 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Ensure that interconnects are initialized */
+	bdev->mem_path = of_icc_get(bdev->dev, "memory");
+
+	if (IS_ERR(bdev->mem_path)) {
+		ret = PTR_ERR(bdev->mem_path);
+		dev_err(bdev->dev, "failed to acquire icc path %d\n", ret);
+		goto err_disable_clk;
+	}
+
 	ret = bam_init(bdev);
 	if (ret)
-		goto err_disable_clk;
+		goto err_icc_path_put;
 
 	tasklet_setup(&bdev->task, dma_tasklet);
 
@@ -1371,6 +1382,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 		tasklet_kill(&bdev->channels[i].vc.task);
 err_tasklet_kill:
 	tasklet_kill(&bdev->task);
+err_icc_path_put:
+	icc_put(bdev->mem_path);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1406,6 +1419,7 @@ static int bam_dma_remove(struct platform_device *pdev)
 
 	tasklet_kill(&bdev->task);
 
+	icc_put(bdev->mem_path);
 	clk_disable_unprepare(bdev->bamclk);
 
 	return 0;
-- 
2.31.1

