Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0210134EAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhC3OsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhC3Ork (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:47:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97363C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so18545732edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44ifFplI0M1D1DckCDMMSyPyGzm+QYpn2WgKJJ6m1Dc=;
        b=xLCLDpHM9R/bUfHs+E17waH6zoZ8VtDejQLi78o+qu4KVyZQ332UT2krsuSGNdexNt
         +ly5XQBwsj77bQCy0TWWDlNTw4A9SAUKu4UNdwyKjLlRWCoCacskUHQpqibGDqy3KPCL
         //OhpwpNB3m7XUr5i1lbSRKKnlyXb6juD3w1YhtFq/4u5XZSXG3aFR1nzbcwObGFhICp
         vf2g2ifUvwA6LfMP8ZqLBR2NhhnKOp4UHson/zsj6OmeycRmU8goEpIzmc0ZoqPEAPJ7
         2j6P2ci+4SfCa1MrSTKg/LOayyMw8DpI7WbbXtNOPkC4FgY8Lo2638XHPOVubTO116Pe
         /iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44ifFplI0M1D1DckCDMMSyPyGzm+QYpn2WgKJJ6m1Dc=;
        b=ds913Zi8efX+cHHoLSq0J9ccQ+r6RLLKlFCLNnnf9P6qxviugr71iCgBxyrcG5EtQK
         e5tYthZPD6dAKGL++tmPCI1J+NuzmL9qo7k2JCQ06iUmO4BXsCSJi55EbIFw6OqF9SLI
         gRxDmQZLiPgwDxVJmS8o3G1fEWpFgfEW56ZgxHYX3lInkygh1rDgcXNooQS/0j8PnbEz
         kkEB8ZRwa+zSwINHNFrTnv4yue8gTY64bp1+zdSy0VoFoZWqRJkslY0kKtkRi0z1Eje8
         7gRKy6AwgXb72TgoMwmX0HzW2fCrTAyNm8YqmgtkRdx9NDmQ1gWWtoIYVJoYOb0Zaw1D
         dr2A==
X-Gm-Message-State: AOAM530lLBudSnxzncQL46CnOu3izWCrL1ITygLiU9mHczaZgle0OzkW
        YnojO+9rY41lqDstI5kb8wD7qw==
X-Google-Smtp-Source: ABdhPJydYKTT0xNGpntDhEjCxVY2s37yLs5j3/HkPPrHJHQy4qZkzwKejpF7qzV2B3zYQK95kdtVLA==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr33926624edc.109.1617115659363;
        Tue, 30 Mar 2021 07:47:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n16sm11520383edr.42.2021.03.30.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 07:47:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 9/9] soundwire: qcom: wait for enumeration to be complete in probe
Date:   Tue, 30 Mar 2021 15:47:19 +0100
Message-Id: <20210330144719.13284-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
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
index b1dbaf8263e5..b08ecb9b418c 100644
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
@@ -418,6 +419,7 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 		}
 	}
 
+	complete(&ctrl->enumeration);
 	return 0;
 }
 
@@ -1139,6 +1141,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctrl);
 	mutex_init(&ctrl->port_lock);
 	init_completion(&ctrl->broadcast);
+	init_completion(&ctrl->enumeration);
 
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
@@ -1185,6 +1188,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	}
 
 	qcom_swrm_init(ctrl);
+	wait_for_completion_timeout(&ctrl->enumeration,
+				    msecs_to_jiffies(TIMEOUT_MS));
 	ret = qcom_swrm_register_dais(ctrl);
 	if (ret)
 		goto err_master_add;
-- 
2.21.0

