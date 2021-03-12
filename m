Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86F339343
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCLQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhCLQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260FC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:04 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so2178631pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6QBix4Xk7mXD3k02J6NEnaLX2tt4w4cfwoG6OuF1xs=;
        b=giiTC6LOrHmzbDHoMAWlZerTgjx0RGur9+eV8YUslHbUH97lzzNAmPacyIDi6HJt9E
         j7ZQXvozxg26YyjAn05q6UA49O2ExF0r3ktI4iAuTcCQH+iL1UbNJLwNLyV7rW9iXbCU
         jRsQaYt+tYt3kQyDqu4+2JD/BgRdKiHdNO7N/9viOevE9MgWpXl226Y/CG8+UsVI3mK5
         s8Rf4/2AS5uQKDRrV+RR1XJAKydJMuAxvnG2WVFlWQdeK9GqUAxw/jXuntLOZqJ1phyp
         wV2uRDP4I3DjAb0Y69sSz4wloX3qLqVyRBpwZSgFI2SehimK/Bx2BIhn1101XriaHZEl
         s42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6QBix4Xk7mXD3k02J6NEnaLX2tt4w4cfwoG6OuF1xs=;
        b=l6dY5xVReDhhcUypsRvyT2xEzzvfS7pN+5m8bTxpSo/fFm+o1pPWry454d6r1O5b0T
         zFYABOSMX9d7anTy6pptEjkbjdhB09K4+MOVGOjnStQhnnDzuYwYdTRDxHk7DLVksfU8
         66AhNjf7JS0NOGJBh2Ur0T6wrt8B+knqry7P689BLkYTOtsaINBp9lu8KfO0qumlEc91
         lQ0IfZh6kgmga1kFyiRxhKRiPFuKZ0VzLpVr0KzuM4c7NlCwuosS2iT+t5nfG0GKYQ9O
         I2zAdcn/WBKV06siNYP0BixZH1Ku65TB2o/iKzxh+h/5ycVlBgUF9r7DTm5ccqVpJTH6
         4bwQ==
X-Gm-Message-State: AOAM532WYPN1Rrf+KSynrnOOVSHAhL7YxZc5joLA++MjvRiAhANbtv28
        IatTOIdalOxz9lbVqb3X6+Q4RA==
X-Google-Smtp-Source: ABdhPJxKS8aMKxiB0EWPGc6UKVjLBhFQVzj1avFQEzLyCsSGbeJWol9zgT6O2uoILTELLnt5e4ji/g==
X-Received: by 2002:a62:1e46:0:b029:1f3:ad4f:9c6b with SMTP id e67-20020a621e460000b02901f3ad4f9c6bmr13436179pfe.64.1615566303604;
        Fri, 12 Mar 2021 08:25:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 07/17] remoteproc: stm32: Move memory parsing to rproc_ops
Date:   Fri, 12 Mar 2021 09:24:43 -0700
Message-Id: <20210312162453.1234145-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>

Some actions such as memory resources reallocation are needed when
trying to reattach a co-processor. Use the prepare() operation for
these actions.

Co-developed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++--
 drivers/remoteproc/stm32_rproc.c     | 27 ++++++---------------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index bf6f6d15b1c3..1d8bb588d996 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1582,10 +1582,17 @@ static int rproc_attach(struct rproc *rproc)
 		return ret;
 	}
 
+	/* Do anything that is needed to boot the remote processor */
+	ret = rproc_prepare_device(rproc);
+	if (ret) {
+		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
+		goto disable_iommu;
+	}
+
 	ret = rproc_set_rsc_table(rproc);
 	if (ret) {
 		dev_err(dev, "can't load resource table: %d\n", ret);
-		goto disable_iommu;
+		goto unprepare_device;
 	}
 
 	/* reset max_notifyid */
@@ -1602,7 +1609,7 @@ static int rproc_attach(struct rproc *rproc)
 	ret = rproc_handle_resources(rproc, rproc_loading_handlers);
 	if (ret) {
 		dev_err(dev, "Failed to process resources: %d\n", ret);
-		goto disable_iommu;
+		goto unprepare_device;
 	}
 
 	/* Allocate carveout resources associated to rproc */
@@ -1621,6 +1628,9 @@ static int rproc_attach(struct rproc *rproc)
 
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
+unprepare_device:
+	/* release HW resources if needed */
+	rproc_unprepare_device(rproc);
 disable_iommu:
 	rproc_disable_iommu(rproc);
 	return ret;
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index f647e565014b..3d45f51de4d0 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -207,16 +207,7 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, const unsigned char *name)
 	return -EINVAL;
 }
 
-static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
-					  const struct firmware *fw)
-{
-	if (rproc_elf_load_rsc_table(rproc, fw))
-		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
-
-	return 0;
-}
-
-static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
+static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev = rproc->dev.parent;
 	struct device_node *np = dev->of_node;
@@ -274,12 +265,10 @@ static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
 
 static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
-	int ret = stm32_rproc_parse_memory_regions(rproc);
-
-	if (ret)
-		return ret;
+	if (rproc_elf_load_rsc_table(rproc, fw))
+		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
 
-	return stm32_rproc_elf_load_rsc_table(rproc, fw);
+	return 0;
 }
 
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
@@ -614,6 +603,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 }
 
 static const struct rproc_ops st_rproc_ops = {
+	.prepare	= stm32_rproc_prepare,
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
 	.attach		= stm32_rproc_attach,
@@ -796,14 +786,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	if (state == M4_STATE_CRUN) {
+	if (state == M4_STATE_CRUN)
 		rproc->state = RPROC_DETACHED;
 
-		ret = stm32_rproc_parse_memory_regions(rproc);
-		if (ret)
-			goto free_resources;
-	}
-
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
 	if (!ddata->workqueue) {
-- 
2.25.1

