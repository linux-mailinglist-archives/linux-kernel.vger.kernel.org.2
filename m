Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6133144BF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKJLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhKJLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:04:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5CC0797B1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n23so1916433pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHy9V66S/pA7pn8cr8IGIeTU+8YjPwSVmNZC5BhYoHI=;
        b=WQG1s1s8cOph5ZyoSZ+As27S7z1Mb0vQYxo5+bSM8b7qahCCsIyh+Wm4N9lGscmbaV
         ZjwJBjxmrsVJEF605MX3dJekG4y6yige39vqbzwRcU4LxBHV+gMii1RKNDbYLYS7xzIU
         dujSsJebAhIVMFDK2fEZ2e1/khAhMcrg8kXz+v6j5ANPdXwkOWW2WNrxJKeJwiQ7YN7u
         qig0Ff7HsE5QV4pvkYdK+p7o46uqKcSoMNr2kpMpUz1QxLFt1uABLSAwOpz0H2Q5rGVs
         T8fo/k7FBdapbxrGtap6QVgEwRHuKlKyYGdjKMV/Qm3MHbZGb/lNzZbQBYTACoXofNzZ
         y4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHy9V66S/pA7pn8cr8IGIeTU+8YjPwSVmNZC5BhYoHI=;
        b=sMrKCpl36QmUvQ904dNbM7t1OV2mO01LWMtfxKT6CyNwdlrqfxCPhG0Yv2k5kOds0b
         43bBXlN25sDv+jhMubeM3di7e4fs3vFP7Kh+QbKrd5jUQdGPRtgcU+foWMQrMkoZeowB
         d8iQW3n1ucTleRbWqa3S6cZu9LgkfMfYyBtpqbaRerv4zyheAmIJXTtfGCXqx2U5vNco
         k7oXSZZ9jznRzrFo2Ea7Zn2boC3gNnLcLwpBrITia7B0hYBy3Vh1YTgSXrgh1zlB4Pzt
         7JkobOMb4q+7BEbMNinrGP75DcSdBLqnJNVlnOhUmek0CupLy8MghQp6z8ntCSX6FUL+
         WFkg==
X-Gm-Message-State: AOAM530Er2mssXS6aEbZqJCh8J3XO4aZCxFy5zYvhhupM54/1riOzt7p
        //DTOYTYS+/N9oG+/ZK43oihMA==
X-Google-Smtp-Source: ABdhPJxgcJaeDFpzozA/We6k9UKxS2oED4M6Cq5Bqm6Zo+B/7/didqXSMVl0cv4t44fqgdFfM1uaMA==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr98550246pfk.20.1636542052446;
        Wed, 10 Nov 2021 03:00:52 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:52 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 14/22] crypto: qce: core: Add support to initialize interconnect path
Date:   Wed, 10 Nov 2021 16:29:14 +0530
Message-Id: <20211110105922.217895-15-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

Crypto engine on certain Snapdragon processors like sm8150, sm8250, sm8350
etc. requires interconnect path between the engine and memory to be
explicitly enabled and bandwidth set prior to any operations. Add support
in the qce core to enable the interconnect path appropriately.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Make header file inclusion alphabetical and use devm_of_icc_get()]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 34 +++++++++++++++++++++++++++-------
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index d3780be44a76..89d9c01ba009 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,8 @@
 #define QCE_MAJOR_VERSION5	0x05
 #define QCE_QUEUE_LENGTH	1
 
+#define QCE_DEFAULT_MEM_BANDWIDTH	393600
+
 static const struct qce_algo_ops *qce_ops[] = {
 #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
 	&skcipher_ops,
@@ -206,21 +209,35 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	qce->mem_path = devm_of_icc_get(qce->dev, "memory");
+	if (IS_ERR(qce->mem_path))
+		return PTR_ERR(qce->mem_path);
+
 	qce->core = devm_clk_get(qce->dev, "core");
-	if (IS_ERR(qce->core))
-		return PTR_ERR(qce->core);
+	if (IS_ERR(qce->core)) {
+		ret = PTR_ERR(qce->core);
+		goto err;
+	}
 
 	qce->iface = devm_clk_get(qce->dev, "iface");
-	if (IS_ERR(qce->iface))
-		return PTR_ERR(qce->iface);
+	if (IS_ERR(qce->iface)) {
+		ret = PTR_ERR(qce->iface);
+		goto err;
+	}
 
 	qce->bus = devm_clk_get(qce->dev, "bus");
-	if (IS_ERR(qce->bus))
-		return PTR_ERR(qce->bus);
+	if (IS_ERR(qce->bus)) {
+		ret = PTR_ERR(qce->bus);
+		goto err;
+	}
+
+	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
+	if (ret)
+		goto err;
 
 	ret = clk_prepare_enable(qce->core);
 	if (ret)
-		return ret;
+		goto err_mem_path_disable;
 
 	ret = clk_prepare_enable(qce->iface);
 	if (ret)
@@ -260,6 +277,9 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	clk_disable_unprepare(qce->iface);
 err_clks_core:
 	clk_disable_unprepare(qce->core);
+err_mem_path_disable:
+	icc_set_bw(qce->mem_path, 0, 0);
+err:
 	return ret;
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 085774cdf641..228fcd69ec51 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -35,6 +35,7 @@ struct qce_device {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *core, *iface, *bus;
+	struct icc_path *mem_path;
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
-- 
2.31.1

