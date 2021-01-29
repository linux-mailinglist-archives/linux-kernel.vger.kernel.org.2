Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4C308B48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhA2RRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhA2RP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so9618996wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKVhAq1odvX5k4QqQmcR5fEwLWOjCJBrc/+Qhn4yX/M=;
        b=dNDHzVUETtnOgxzmEXCUy0NirGwHeevPdtzfloQqaAgCRd7nVDNW7eUNCq61K7PRyD
         tHEo3gLJxCRNS3L/4Y9S+x3EZ+uQXYA5bGeH3MSIHYLqjSgx6dKwPfQ5gLlpy6OH/crx
         ZdHIzhZ5bC3ox/J1mY4KxyHZi8d2b/j/zZGX5/OlGatwVGIDsAFbldlOUHWvslCqlPLO
         UDycRweROr+HLel1S/X82axADRgAO+d0hVUlBjcmXoSVJpKS8rrAVabdNOtYti7f3CnM
         3UhM08pO2MMRRmHJZt4oF7cLK4LY2moQcXy7+y9NU52rAq/s+18NzyiQo9YdIBIhhNgN
         c4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKVhAq1odvX5k4QqQmcR5fEwLWOjCJBrc/+Qhn4yX/M=;
        b=dD+0nemqx+oWdtUvZA+kf+MQDoMrPAiH7R7Ey66gWwsW1KDu42ZHxmWEUQnY1cehif
         H1U3/yuCr9WPsZ2ITYNmyTgh1Jzzb4e983Mky9jEIfz7AeL1udjJ9mpHBtYuddmicOst
         pnN56dVzOJ1E1XWYXzlnypUVguHLRJihOjJ8r9ahBIXdOrw255ocwPfjWrGgR6xt4/n7
         YrHc2P0HtHvO6Rlp4RtQLr/Evx5gRtnz4H+S6KvVzPr8uSKgw0AONJBVUwRMYvk09xSe
         uMFs9+sCey7o/98typ/wkx/R5qS/2sZGM75cH1uvoAPqbtS1hCdOxZFIMJbGmUVHFsoT
         t55w==
X-Gm-Message-State: AOAM531GOf2rkZcOba0QGO5Dx3JVEYPP+35M2GTho+biotkZDBaCHkjU
        BDhCD+uaAcymIkWAJbZdoOdb+g==
X-Google-Smtp-Source: ABdhPJzWMlw5r1teZBMKfzAfXquDwk2Y1WjO2luFNWfR5aCQyNRWE1O3QM9p68U2IsUih8KQL/L1mA==
X-Received: by 2002:a05:6000:1362:: with SMTP id q2mr5625480wrz.341.1611940485193;
        Fri, 29 Jan 2021 09:14:45 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] nvmem: imx-iim: Use of_device_get_match_data()
Date:   Fri, 29 Jan 2021 17:14:27 +0000
Message-Id: <20210129171430.11328-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

The retrieval of driver data via of_device_get_match_data() can make
the code simpler.

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-iim.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 701704b87dc9..c86339a7f583 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -96,7 +96,6 @@ MODULE_DEVICE_TABLE(of, imx_iim_dt_ids);
 
 static int imx_iim_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct iim_priv *iim;
 	struct nvmem_device *nvmem;
@@ -111,11 +110,7 @@ static int imx_iim_probe(struct platform_device *pdev)
 	if (IS_ERR(iim->base))
 		return PTR_ERR(iim->base);
 
-	of_id = of_match_device(imx_iim_dt_ids, dev);
-	if (!of_id)
-		return -ENODEV;
-
-	drvdata = of_id->data;
+	drvdata = of_device_get_match_data(&pdev->dev);
 
 	iim->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iim->clk))
-- 
2.21.0

