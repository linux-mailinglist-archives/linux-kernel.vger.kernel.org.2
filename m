Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB533C2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhCOQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhCOQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:57:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26255C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:57:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so9069380wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gA35ua4Yb5kX/gYxKzQIpMpiocNgTXC/pKSapK7rZJo=;
        b=D+RkpBUZvmx2ksCWz/nuPCkQks6oZo5RNsym556b8uzRQERFm2Km0gQB96/n5mO/nL
         XvAih+bknAm8O2nbaQvc8g5BYvk+hE2TDeKhlhf9rZH3n77WHWFzF4mUBttPZu34s2aK
         tdmjEVI13eH4SWbH4rtQy2IWpZ0XuumM5VH5tBpylqgtMS9iCl4F5b4C9Va0taLfDLVa
         YcmGNnOHLJS6kr2YGxgHQlMtUFfH6pZ61nXmZWzlmaZuu2TGex0eEd1q9m/Rh1/Iy4Yl
         SsFURVQHig3gX4JF/WhaSrIcxU3V6gkN8qc54qCtUVomZd29YKHv2+ytE9onqvjT35hr
         nCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gA35ua4Yb5kX/gYxKzQIpMpiocNgTXC/pKSapK7rZJo=;
        b=qbHPiW/A6h4eFFavKh+NyewJePiq1kTZ7XlR7eJE/ETwpdzAQUeMgBF7biBXj0R6al
         WBEnVaeoQIoNgVrpx37nw3LIC3FrPeh9k0yIhJGuTSmSP/uUFLrpoxj9vSyyEuJrt9cA
         Rgy/MSPdThPt1OFxp6YKyQzl5HkCJ/9o76YjO8XdgEZr45cFxE7BtRf1rD9XjP2+Hozs
         +C/vZ5g8Zx+zlVsMu5OYk5an9epy4ZrkdCB5DRHIjz6N8iVd0Wm/YW8NSf2/1KPHi1+K
         3aUKe6jGiizsNs5348He+aRnX0YY2Ft+3DS03lMbiN5I7QVmi3/DqP7bBP++r9/TMTTu
         WjLA==
X-Gm-Message-State: AOAM532Uue5Evczlbe06ItVR5YRKLDjf2qy3vtl7q4osZKAapTuSlYiG
        ocfl4i7QKWAOENdtw6darB0+Ow==
X-Google-Smtp-Source: ABdhPJxRes1KXiUtFYzyJmPqYvE0hS2ibaUnRcVamO96i5/EH7joHzxqesr8UwYW9dvBa4itDTaALg==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr611460wrx.236.1615827418929;
        Mon, 15 Mar 2021 09:56:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 5/5] ASoC: codecs: wsa881x: add static port map support
Date:   Mon, 15 Mar 2021 16:56:50 +0000
Message-Id: <20210315165650.13392-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two instances of WSA881x(Speaker Right, Speaker Left) ports
are statically mapped to master ports. Allow the driver to parse
those mappings from device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index db87e07b11c9..b3568aec0cd0 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1093,6 +1093,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
 	struct wsa881x_priv *wsa881x;
+	struct device *dev = &pdev->dev;
 
 	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
 	if (!wsa881x)
@@ -1105,6 +1106,12 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return PTR_ERR(wsa881x->sd_n);
 	}
 
+	/* valid port numbers on this codec starts from 1, so skip 0th index */
+	if (of_property_read_u32_array(dev->of_node, "qcom,port-mapping",
+				       &pdev->m_port_map[1],
+				       WSA881X_MAX_SWR_PORTS))
+		dev_info(dev, "Static Port mapping not specified\n");
+
 	dev_set_drvdata(&pdev->dev, wsa881x);
 	wsa881x->slave = pdev;
 	wsa881x->dev = &pdev->dev;
-- 
2.21.0

