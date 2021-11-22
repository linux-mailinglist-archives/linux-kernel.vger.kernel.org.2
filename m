Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70988458AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhKVIzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbhKVIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:54:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:51:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso14697313pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 00:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=id7DvGBlJbwLopapF2TpliiENdQPCEGHhQVDE16kcTQ=;
        b=EAZI0wPdj3knFzcPW3LSYAQ0WHN5WhGMZbqkWoW8vezQFokI8pMj8xP3UyHq2NrGnq
         JjmH28ffIP6DsQheMFUnQX5YvY/LQQR4BO1u1kxrVVedsIv2l6Z4FigpzYYuqdPpIxWk
         K1/NywLd+YT+imiWI8toE5dnnKYGtQeuqhHRkea1kbUbGVbgELfrgZ2uu4GLTb+9Csv7
         GEMi27SKVqY4aBZCrY/dDHTMasCw6xI4KjLaleE+htramhUZdas/KmkAmnjWNgCzgWVt
         /KxXvOByLTlGgELfQwFPBQaiAKOp4aEGD2vRtiHKScG6TzgS1p4lG8B5DaRhEBbT4uRf
         kNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=id7DvGBlJbwLopapF2TpliiENdQPCEGHhQVDE16kcTQ=;
        b=F5vlol/65jzxylFumv3OxGEMBRpQt+gZ9nYXYYXdtH0oiP9B3Rh0eucNnRjM4oAJxH
         Bx7mPTvTRIYWobtVZ17UAFqT4D8zwAKVM6qTf7j6k8ddtYKmQ3GupcH1uATXYp6yFLJF
         O3Lg5O/hPK03LrfJPekM1k4KV17C3ypOPrP8Y2atD/p5wiOyYkWPXI+O8rcyFWfnp9+h
         hESPBwzwQAMhm/JqM8MIkGge+RsVI+s4QTii2KY/0hHStCSZWJtoBx/MyPxX1gYHrMfU
         jm0yVOswsZd6EB74hAuP9H92BxmDqlCizEcXzGFE9Z8QXUaD9m4Zv3LkpOD3O7kDdsND
         HQvA==
X-Gm-Message-State: AOAM5319ZyOP16jTDhouSxuAzZCC5+cILsbhBb1jFqUhsHD/iWlhh3JI
        gZaGMXwJJOKjXpcStHAY+p8ONIaJ7hY4+A==
X-Google-Smtp-Source: ABdhPJx0YnBOO8/J3RZOYcMLP+bDF9zW49ZizO+TRxKDr0w0lumlQ0fvzqOej9aAiVe3mgkKwCHwqg==
X-Received: by 2002:a17:903:18d:b0:142:8ab:d11f with SMTP id z13-20020a170903018d00b0014208abd11fmr105269868plg.47.1637571104505;
        Mon, 22 Nov 2021 00:51:44 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f8sm8445582pfv.135.2021.11.22.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:51:44 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 4/6] interconnect: icc-rpm: Support child NoC device probe
Date:   Mon, 22 Nov 2021 16:51:21 +0800
Message-Id: <20211122085123.21049-5-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122085123.21049-1-shawn.guo@linaro.org>
References: <20211122085123.21049-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As shown in downstream DT[1], the System NoC of QCM2290 is modelled
using 4 fab/noc devices: sys_noc + qup_virt + mmnrt_virt + mmrt_virt.
Among those 3 virtual devices, qup is owned by RPM and has no regmap
resource, while mmnrt and mmrt are owned by AP and share the same
regmap as sys_noc.  So it's logical to represent these virtual devices
as child nodes of sys_noc in DT, so that such configuration can be
supported with a couple of changes on qnoc_probe():

- If there are child nodes, populate them.
- If the device descriptor has .regmap_cfg but there is no IOMEM
  resource for the device, use parent's regmap.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/scuba-bus.dtsi

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 22a98c0b29af..2dfa79ba27bd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -347,8 +347,13 @@ int qnoc_probe(struct platform_device *pdev)
 		void __iomem *mmio;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
+		if (!res) {
+			/* Try parent's regmap */
+			qp->regmap = dev_get_regmap(dev->parent, NULL);
+			if (qp->regmap)
+				goto regmap_done;
 			return -ENODEV;
+		}
 
 		mmio = devm_ioremap_resource(dev, res);
 
@@ -364,6 +369,7 @@ int qnoc_probe(struct platform_device *pdev)
 		}
 	}
 
+regmap_done:
 	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
@@ -409,6 +415,10 @@ int qnoc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qp);
 
+	/* Populate child NoC devices if any */
+	if (of_get_child_count(dev->of_node) > 0)
+		return of_platform_populate(dev->of_node, NULL, NULL, dev);
+
 	return 0;
 err:
 	icc_nodes_remove(provider);
-- 
2.17.1

