Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08530366A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhDUMGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbhDUMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA0C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so63176935ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q07ykK1ULP/ibg/9n8NoWYiD7j6jQhiXQ7i84QPtE0Y=;
        b=GlEpzyx33lz2gU7/Cbybd7BmusmOb3nqZ5HKZrMSLaEymWqWB8Dlyn46d1wKW+COtJ
         vmDAxQloBKobz/H9kB+oX3FztRh0L4taHYosZPSEl5uncPiXP+fCNkVfOnQFDcoDmnDB
         uk53AfRTecstSOupxjGt9ch0kylNgcscHh2k38A5Th6h4udN78wHeToJzLvB0JEDltdU
         rnJyo39H9Vo0H6j3rSCorI1JUUh1DPwO3u2Lj3vILFK/XvL0Zn6nBap2CItrNcxKHCjt
         vVh13F0llFljsu3UPRCX8oICbcRecrAo7l+ekw+bANViX4OGjobvCTN7FhUxJMijGfXN
         2iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q07ykK1ULP/ibg/9n8NoWYiD7j6jQhiXQ7i84QPtE0Y=;
        b=jKNm1QfG1oe9jnidZaNN52T2Um28dNPaxf3stLCf4fBnaIDC73hv0VX6sezm9X55aQ
         EtAs3a5eFeK3RoTPofqo0BAEgRvvcwXZEnXfb22zv1AgZISiNzhclaXD23t3Pi4sgHrx
         ImqDi7VF0+rkfF+26UxvyGlttKmYla1oEMm/tjBShBnFYqakR+aWkfQOG10GrBtuOWyF
         gkpCWq6jA09n2S0KCRYVx2Zofy731PG0ojHEfspbN/UFbzC1R8RQgYY4Pr2Pg/VGvXA6
         lojAjBVatoWR9fyEKjEYxo2B259k3V5dTi2vDMRhlUd9DQVvhiwZKp2exKmiZ3l+NSwU
         HU/A==
X-Gm-Message-State: AOAM532Nck6jZ9gyJUmWeBrBKb5XtoMuZdOvO6TsTIeeuYpu/EO5SnSv
        NrqyN1KvU48oCmJeu9m+oVcUeQ==
X-Google-Smtp-Source: ABdhPJz8xMgQctTHmyAVj6SIEVsTVax+NgsmvHwYH7mxMv4oHBE1Oez6RhdvfJn20KsLb9jcdu37Ug==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr31355615eje.12.1619006738497;
        Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 2/5] ASoC: wcd934x: use the clock provider API
Date:   Wed, 21 Apr 2021 14:05:09 +0200
Message-Id: <20210421120512.413057-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers should use the clk_hw API

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/wcd934x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index cddc49bbb7f6..046874ef490e 100644
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
2.31.1

