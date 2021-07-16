Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7946C3CB679
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhGPLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 07:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhGPLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:00:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA4C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:57:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7922564wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKfdywkweNu6uAoYJAmHaJ4+OWe5ozT0lTBOuOqLOpk=;
        b=T7pf4GIN3ivs7j02IxO84YPTxsw8V9EprKQUh/Y4IwBAHSAfUKLWU/NqEk95tiWbZY
         OnimKdU4CDwbdDGbAqORSddxkGQYpAWuQyKACSKb2rpKfL7E0pPR8rlPdgZdGlERsRZE
         XYqYhEVLOzpjDgKm/gixOU4gipZrMY+hnUvTUEov8gnEAMh2mILYynTkEblFYu5Kl0nf
         2wsQwIJdfHDXPjVssNNi4mwP2616m8EutLwRE9gcXnJQnIspvMy5N2g5hSDKam8SWGD4
         Wv+EJACq+7QoAHgUrCjNFp6Fw1GZ+altBl5rGqTsV6wE8qfYqWypyhXuXKZ0YpJX7kHJ
         VpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKfdywkweNu6uAoYJAmHaJ4+OWe5ozT0lTBOuOqLOpk=;
        b=dYPECuE/cGJrZ8Fwu6LvQPyHt9P86j1YleqEfdX3YWqZUH33jGVm1a1lQ+h0Nqxc8c
         bPrSaamXirR/g58o8Rr7/AFVuIdEWamMz6jbtSZJq+B4YP5aZgqzyqvjx1b71V+RC+cn
         i9YUyr7l5gZFWuWd9TSdpgBJQ0BgDovCrZVn86ST67S4AfjRCj30ijp1AoTptEjJn9B0
         dVbRD9z4aNKkoY8Iqf/D4vndOnruvdfUQbWC3mMBWcOC6Jo0ZrF3AJCIydm+vo9SrhaG
         bsueboVgxJ0WzKPQcaWr4BLhaaZqc2gFTqv1VWt97t0/3tGpNrxkxqEO0C1WFpL1kURU
         uR7g==
X-Gm-Message-State: AOAM533J8S5CNVwj2yeJPeHro15uLUSEu1vrhHhRf7rYZEB43+XAr/Ut
        JRcnDig5txkeeVUrBg2YJa9Txw==
X-Google-Smtp-Source: ABdhPJzxkpMf6KBdAjhUrcl5RQIJVBosDs5BsQjMLHASK4sk5AjML/Nk4ijSXXVHgkiYsa2EzOD6rA==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr9562287wmq.145.1626433057920;
        Fri, 16 Jul 2021 03:57:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h130sm464544wmh.1.2021.07.16.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:57:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd938x: setup irq during component bind
Date:   Fri, 16 Jul 2021 11:57:35 +0100
Message-Id: <20210716105735.6073-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire registers are only accessable after sdw components are succesfully
binded. Setup irqs at that point instead of doing at probe.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e32810902383..e5795cd964f7 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3314,13 +3314,6 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			     (WCD938X_DIGITAL_INTR_LEVEL_0 + i), 0);
 	}
 
-	ret = wcd938x_irq_init(wcd938x, component->dev);
-	if (ret) {
-		dev_err(component->dev, "%s: IRQ init failed: %d\n",
-			__func__, ret);
-		return ret;
-	}
-
 	wcd938x->hphr_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
 						       WCD938X_IRQ_HPHR_PDM_WD_INT);
 	wcd938x->hphl_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
@@ -3550,7 +3543,6 @@ static int wcd938x_bind(struct device *dev)
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
-	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
 
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
@@ -3559,7 +3551,6 @@ static int wcd938x_bind(struct device *dev)
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
-	wcd938x->sdw_priv[AIF1_CAP]->slave_irq = wcd938x->virq;
 	wcd938x->tx_sdw_dev = dev_to_sdw_dev(wcd938x->txdev);
 	if (!wcd938x->tx_sdw_dev) {
 		dev_err(dev, "could not get txslave with matching of dev\n");
@@ -3592,6 +3583,15 @@ static int wcd938x_bind(struct device *dev)
 		return PTR_ERR(wcd938x->regmap);
 	}
 
+	ret = wcd938x_irq_init(wcd938x, dev);
+	if (ret) {
+		dev_err(dev, "%s: IRQ init failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
+	wcd938x->sdw_priv[AIF1_CAP]->slave_irq = wcd938x->virq;
+
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
-- 
2.21.0

