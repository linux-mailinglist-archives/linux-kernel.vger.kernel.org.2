Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4A35ACD5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhDJLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhDJLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC84C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso4275027wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/A1ey0fLWzt4WfgOVIBJQ6OOA/NjG5WdKypO2QtjLjk=;
        b=cXylEKo+G+FGoGWw/Pc7EvcipCQMgdCwsCVSuOn0lNMElci4Uwgw6QgfFeBTzpxfv9
         EtSFvasQCMjEjVFW/9G2U7CsPYrf5PfziFhGF3dNFZMr3uMkU82tc6C1Wwbv7VA0KHc8
         ojOqmLZSFhtzbh6iDgmLFjhW/LiWXjoubdAIO0mu6YJGyBTKNHA8a0ldQsuPeAQrhqDN
         ozDkZ2wc/vJzx52g7FMIIU9DsjeYj/hlKPMGLvGLGNjPKrdUbdRQbNWuqfl2G08X56/L
         l2oehw6RUsJc9un73dH43V3lZTAbXU6OThn4MWGYBzBt2C5qKNd7ydWlTgpGS4bAYyk0
         KBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/A1ey0fLWzt4WfgOVIBJQ6OOA/NjG5WdKypO2QtjLjk=;
        b=CnUBQCkj6xmjG6TUgnJyJAvWHR2SxXCNzwF/WIRkMg4OVea6P4cf+jUojmiQC59H44
         PMB2XQlFXyHWPfbalzq6MXc/s2kAB2QZyZuDOaTRZkBZj+JEfe5n2w+ayXRkuMbhM6W8
         c6XoS+A4NN16gI02IDBPdWTwmXW2AwZSAnxWBCnHR/1eLLnb1pLIqAd+U+oaXzg+20T2
         9KZ8fyi0koH8g1XkvmXR5y9Rz79yL5DNclc6nLCQBu1s6MrSWZMHN25qp84hgVuNn6xC
         q6gJ8XxZf/zGS6k8g1YkK3+9Nud3rXoiisFIk50XQbmBMf58RBfhNXfWkv/29Y7EmN5K
         wAVg==
X-Gm-Message-State: AOAM532d33s+5vg0w+mEhCKX3Z9IUiF6psm2AmYjkIO3ISAOesMNXqei
        g02uI2EnzfdWnV5DeBEnZRQSWQ==
X-Google-Smtp-Source: ABdhPJxnYmdRljzrAfTykkmUmv8lKocSDXkd37oY600OclPmJY0gM661zX+6NBdKcwz/FMnSFZ4huA==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr255983wmb.145.1618053243628;
        Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/5] ASoC: wcd934x: use the clock provider API
Date:   Sat, 10 Apr 2021 13:13:53 +0200
Message-Id: <20210410111356.467340-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111356.467340-1-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers should use the clk_hw API

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/wcd934x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 5fe403307b72..ae3ea136a9f8 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2116,11 +2116,13 @@ static struct clk *wcd934x_register_mclk_output(struct wcd934x_codec *wcd)
 	wcd->hw.init = &init;
 
 	hw = &wcd->hw;
-	ret = clk_hw_register(wcd->dev->parent, hw);
+	ret = devm_clk_hw_register(wcd->dev->parent, hw);
 	if (ret)
 		return ERR_PTR(ret);
 
-	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return NULL;
 }
-- 
2.30.2

