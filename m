Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59F0330FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhCHNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhCHNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BFEC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so11530048wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXsQNCXUapXF20IWHIenhBSQ480XBxLPcOx8iPsHvUs=;
        b=Rd1zk2w9YzhMPxyi8nCdwEy1T1l1/k/MW2duY8f0HkMU7dz3vG0wu0amZs4x3SEoRp
         pwVBGeiWabU00t9Dvj0Z0KW6O2tBKwPGPLfuadP0p7Mg/taqWOj9P3Xu2s+j93lwnvcw
         KrkDTOL5Cv3litLwdv+MM4uJ8YR9dknPGefO7GJyq5lvC4VLtexdT2qS8fkt7w0+9IEj
         kWNWAkgNOglXIAlLc34LjRsfThYx4bX27bM8xVLghL3k3UCvs0lAnOdQvy7pc3Ow6Kgc
         eWDnJr5MTcmLVAp1pD/0y4EZoyU2mBDCRd1rm1gQS2L9ptOTt0iw4Jk4E0X60KhoreFQ
         OmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXsQNCXUapXF20IWHIenhBSQ480XBxLPcOx8iPsHvUs=;
        b=ecQ9oQa1DrQdD/LfzNn3pZTf4jbtppraMal+2F+kg8p2gaIi/LpcaLog+DItshuIYH
         Z9QsqZIoQJnuepI+KeQernDig4kIqvLMXH2BkoZ1sVCOmh1DQ8Ft9zyXueBrKlyza1Te
         DO7ZlA5P/jsDQ7aHDRGR7QdY2hfQJP8aVMq4CMZ0Eu83So6JRCWjOMPg0OJBkCIVc0wx
         v5iBno9H8SZIThxRsiugBLOPmwehOLpa0jhIOHHBBDJ2AvTEIfYEKgRZCvJBEQUqOgy3
         AwEKuAp65CBW1xpdZsdxlFvo6ccVn7+4rhMtoTR+uVlj64fSEQMTBvWrLmcXsijtzABu
         tJ7g==
X-Gm-Message-State: AOAM532nvHrraSqYSG6LKdUWQnOXNrp3RizMmlPlmwbogSkFFCOM5HIy
        3mjZnuA5ZFNmP8PUHMpMua2mwA==
X-Google-Smtp-Source: ABdhPJyGmakQk7A4faicPCFfSQQku7sOUvCrhMttiO6Hw9GvFWY6gs6QEikQEs2SdWNTke9zcRKQhw==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr22312853wrt.426.1615211415041;
        Mon, 08 Mar 2021 05:50:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 9/9] soundwire: qcom: wait for enumeration to be complete in probe
Date:   Mon,  8 Mar 2021 13:49:57 +0000
Message-Id: <20210308134957.16024-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3109ec6c33ac..578a392bfbee 100644
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
@@ -415,6 +416,7 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 			sdw_slave_add(bus, &id, NULL);
 	}
 
+	complete(&ctrl->enumeration);
 	return 0;
 }
 
@@ -1134,6 +1136,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctrl);
 	mutex_init(&ctrl->port_lock);
 	init_completion(&ctrl->broadcast);
+	init_completion(&ctrl->enumeration);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
@@ -1180,6 +1183,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	qcom_swrm_init(ctrl);
+	wait_for_completion_timeout(&ctrl->enumeration,
+				    msecs_to_jiffies(TIMEOUT_MS));
 	ret = qcom_swrm_register_dais(ctrl);
 	if (ret)
 		goto err_master_add;
-- 
2.21.0

