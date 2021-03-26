Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F134A20E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCZGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhCZGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:41:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ADDC0613B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ce10so6772124ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLx96J3P/z7SpklWGlSLOqViHHl5WXETT/eud7VOrQ4=;
        b=CKI6N9BxqTu7oc5cHbfAFTArbxQlLX407WNFxN/5fyZPddgwYnH+Lx7G6s8WXLxhnV
         /CNczXVcxGg3nppzl86S9e6pUrpRmZ9fX8fR4rxZy7HK+JKvzreZCCziTSNHQJJLBZso
         2Es5mqKlyhjOn8n9XSMcjkn/EvAidELHMetKLpURwr+s2PLg89DiRmh8UVaO/9u0/qfD
         NejsgeU4GDFCpDT0Y4yxy28zAx3WAo+Y1QH3nXCtbmxC46USX8s6l1KZd+QjRk3Zh9eI
         f4VVIyuu1LQI9714F09FCQbzSa474qAF1YTILTtc0s3qv2bHhBYI7qxUljqXSBGnC6kp
         ZMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLx96J3P/z7SpklWGlSLOqViHHl5WXETT/eud7VOrQ4=;
        b=iHghOFpH0R9/Y+RCjlUnP+pNU81G5CAufn1Vzvo2mDETUsBgxGR1lcDONgRoIxVWFa
         hLVMplh47c8+kforpMHIWGdq/J2LIMO8nMIVSy8D3l1H0JiB6rvZTPC+VhFnp1jloIuJ
         jhEs3/MSpbXYulFkdiUPLe9nZvQvJCGjVX7Hrvo+lPn2LQXKqCh80NdE+EI3Ie9E+ke1
         oU3ldo+2y6gciepEbqUU1a2iSL6cjHke4hG+hmz+1JkPnrLtDR2cv1pGqME63sAAMLnf
         +J495E3u0oBMkpjAVjTtYkV8BA2LRM10IHqBQNX3PdaYDIrDlXrteZXtYyt7XZbHRRJE
         7fiw==
X-Gm-Message-State: AOAM533rygRJk7ZAzMNbceaq8TIBOEPQeEiPaJFw6O82VKl+VO7ljAAR
        /ZTdFprn6fMCL44vIAN9x61oTA==
X-Google-Smtp-Source: ABdhPJwArwbmYX2WVpvAdXSWymAKUlKCWbcQVbY6eaqoujoHbsmPNTo3r6OZ7jXq/ljDTeTdhvlCLg==
X-Received: by 2002:a17:906:a44f:: with SMTP id cb15mr13350392ejb.420.1616740885771;
        Thu, 25 Mar 2021 23:41:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id ci22sm125325ejc.54.2021.03.25.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:41:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 9/9] soundwire: qcom: wait for enumeration to be complete in probe
Date:   Fri, 26 Mar 2021 06:39:44 +0000
Message-Id: <20210326063944.31683-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c6c923329b15..706d44200a36 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -123,6 +123,7 @@ struct qcom_swrm_ctrl {
 	struct regmap *regmap;
 	void __iomem *mmio;
 	struct completion broadcast;
+	struct completion enumeration;
 	struct work_struct slave_work;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
@@ -417,6 +418,7 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 		}
 	}
 
+	complete(&ctrl->enumeration);
 	return 0;
 }
 
@@ -1155,6 +1157,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctrl);
 	mutex_init(&ctrl->port_lock);
 	init_completion(&ctrl->broadcast);
+	init_completion(&ctrl->enumeration);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
@@ -1201,6 +1204,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	qcom_swrm_init(ctrl);
+	wait_for_completion_timeout(&ctrl->enumeration,
+				    msecs_to_jiffies(TIMEOUT_MS));
 	ret = qcom_swrm_register_dais(ctrl);
 	if (ret)
 		goto err_master_add;
-- 
2.21.0

