Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A24338C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhCLMBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhCLMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:00:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l11so4656038wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEstJ8fSJSpfc6e8Q0vMn1tWonCjZtnzF+5445SF5Qs=;
        b=yXkq2KLAbC7KzixcJj2Z96/TbUF5rxrVRAuXgmyNmPkUsbt00yQDUAtePfvJpDGkBq
         Q9AdySyXNnOdzKSxPbO/ssZolk7JeniO5InutNFtUM0ERNxCG3ID43kJuDgkbMgNovEY
         mZGbxSn+fGUz3jnIQC08dXvh3eoNP8Z6850z4rizDVZe6I1LBkISACd5EbB0ag9zxyhN
         dWGf8DDFmDsEr94j30r1q5+PwHX7k1qnCnWBDhSMQV/EK7Tl8wcw1lvW/KarPTytmy1e
         kfZUWS9r00Ewl1SYyRqwDW+oxCD3VvLvvKc+eeezMk0NxU2zuKNEVYgeCcowcJVFaCzK
         LEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEstJ8fSJSpfc6e8Q0vMn1tWonCjZtnzF+5445SF5Qs=;
        b=rULoUYO8UVgTpB8rwlUIgj8oLPC74Fh3G52nXxN+qwWEFpcSiIWWVRHpsZoE2Oc8I/
         HZtSf/zKncwVgbkYYIdfFb5lYR+4tGdVr65NtkjBRgq+SJJ6LO0PbrTVTh5lGIcpMetg
         3M1CiSpK5cCN9B1UHVINaRI34nWv+24jFYuSPS3kpVnfGs0ITOIEQrESOkQ9K9MQX0oF
         QB/Q/S4jGxZ45TO7HP2b07ruIeXTT4gd5VAheE20BqF9QlP2rwImCHJ6k3aw7WK9BVqn
         Bwz8jBzOqaWosqGAiOlQnD43QuumkBLb3BfQQFvAxCtEEI71eP4Gk2eSjSWRH9/K+US+
         Vg4A==
X-Gm-Message-State: AOAM5300M3gqguE+UkcuM4X8tFc1fH235aNOLOViZYHMT8lj2ASB5sB8
        xFqWluuSdX1wOflrZbwDPniDAw==
X-Google-Smtp-Source: ABdhPJyEuMGLdAxtqH4eoe5V0wW+agxN2/wXtSMXWHisBysHzetmWiXSxFO1vt99WenOLTrCyQ4FaA==
X-Received: by 2002:a5d:4564:: with SMTP id a4mr13642592wrc.3.1615550432808;
        Fri, 12 Mar 2021 04:00:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h25sm2268315wml.32.2021.03.12.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:00:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 9/9] soundwire: qcom: wait for enumeration to be complete in probe
Date:   Fri, 12 Mar 2021 12:00:09 +0000
Message-Id: <20210312120009.22386-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
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

