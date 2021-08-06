Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB03E26A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbhHFJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbhHFJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:00:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC0C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:59:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m12so10100963wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rtoc+7Z/foE1K3KGTaM1857mmVoQLcMDEil+xFA6Hzc=;
        b=nOjaNug3Lc9B+EfO4iKKeRFkQRiJRuTnZKzgau2+IyaBpLnpaAYDRU88g45Tu6NfZa
         /62yGS2bX6biWfG16kffrI/2s812wXKXwW8WJSkDo1b12kJ8urHc6zT2Zk49ko0brOKW
         fMDYk4LBq2MtBwLVpngeaCjaiHv9eNp05NhbB4QPQX5cjEsjDwsJhAs2b55i86qntQJ5
         +7QRLSVY2WqCq28ZjhLf8pVh92lwJEVKBiWm944l5tHNYjb74HgudwfYdr/n9Pig+mm/
         unTqo/I4j8C3sk+lYPSsdwiVVePu/XyuG4xA0QFPyj7dVeYA6+Mjda0vc3NfEt+lmvit
         ISqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rtoc+7Z/foE1K3KGTaM1857mmVoQLcMDEil+xFA6Hzc=;
        b=gYhon6V/+CkwtF4bjOMhbNm3UevILYrzEu1VyZSmIAuAIaxdYAEQ6gE1cUWgTN4wef
         +tK+/8qYx/s2jy8KfTWYlH3X6KZeWZM866r3R7lwBK4oy7VGl1Qtk5Pjiszig/m78AqF
         blS+PkiGFrODP0ZDYLoLXlWnEjCF+pIl4MBo1LwXQQbTUnZ7u4E52gAB6B4TFKpnLNCZ
         tbCzHTCxpJx6KMWD24dTJoopO5lgYl0GBwcObLFmYFoURL3VN2GgSKk5rxJd8iYwD6d0
         +1jFdvNU8WOfay91mrskxz17IoA4DDKeLlTfnyEbh1RaHxOF9hW0qnk8dJP8nXuYP4qm
         Meww==
X-Gm-Message-State: AOAM530jT09zhD59hL4D0dobv1kdFHbxNHQtGE5vkUl9U3acOvsqc4f4
        i6WJl+hZ6kYqzpR8ese8ThNB3g==
X-Google-Smtp-Source: ABdhPJyRfzJP+EQtylIBAyy+2G3nFsEn20DdtAwcU6T/vCj9brSda53ciEsKlT0OGfXu3oa7xATUmA==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr9797914wrs.4.1628240393421;
        Fri, 06 Aug 2021 01:59:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x18sm8506144wrw.19.2021.08.06.01.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:59:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: qfprom: sc7280: Handle the additional power-domains vote
Date:   Fri,  6 Aug 2021 09:59:46 +0100
Message-Id: <20210806085947.22682-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
References: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

On sc7280, to reliably blow fuses, we need an additional vote
on max performance state of 'MX' power-domain.
Add support for power-domain performance state voting in the
driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index b0ca4c626466..c500d6235bf6 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -12,6 +12,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
@@ -142,6 +144,9 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
 	writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
 	writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
 
+	dev_pm_genpd_set_performance_state(priv->dev, 0);
+	pm_runtime_put(priv->dev);
+
 	/*
 	 * This may be a shared rail and may be able to run at a lower rate
 	 * when we're not blowing fuses.  At the moment, the regulator framework
@@ -212,6 +217,14 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 		goto err_clk_rate_set;
 	}
 
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		dev_err(priv->dev, "Failed to enable power-domain\n");
+		goto err_reg_enable;
+	}
+	dev_pm_genpd_set_performance_state(priv->dev, INT_MAX);
+
 	old->timer_val = readl(priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
 	old->accel_val = readl(priv->qfpconf + QFPROM_ACCEL_OFFSET);
 	writel(priv->soc_data->qfprom_blow_timer_value,
@@ -221,6 +234,8 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 
 	return 0;
 
+err_reg_enable:
+	regulator_disable(priv->vcc);
 err_clk_rate_set:
 	clk_set_rate(priv->secclk, old->clk_rate);
 err_clk_prepared:
@@ -320,6 +335,11 @@ static int qfprom_reg_read(void *context,
 	return 0;
 }
 
+static void qfprom_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
 static const struct qfprom_soc_data qfprom_7_8_data = {
 	.accel_value = 0xD10,
 	.qfprom_blow_timer_value = 25,
@@ -420,6 +440,11 @@ static int qfprom_probe(struct platform_device *pdev)
 			econfig.reg_write = qfprom_reg_write;
 	}
 
+	pm_runtime_enable(dev);
+	ret = devm_add_action_or_reset(dev, qfprom_runtime_disable, dev);
+	if (ret)
+		return ret;
+
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
-- 
2.21.0

