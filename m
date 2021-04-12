Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE47A35C2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbhDLJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbhDLJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F567C06137B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so3157979wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emj6t0YnQ8kfODwk6pGcM/emMJNNvWG7eis4Ne6JndY=;
        b=Jpnjn9rXPzkPxXX9WoOJFeWyeK+Ple7SplSjETf1bgkKa00qCyCMZZHr89iasN12TP
         oxxcivC+ycem/57+p8Se9OmpW61Ci+2Lwf4CVHcNFuzmyMoJkQq3ZH4ovghZTO8pLOMq
         MUhnxCtrb85Fxyx4KOXAy1kmoALlk4B4/RN4i2PnbcW/j0xKu1fRmHvKYLT+RffbQoxc
         sdckkuOeCDhdDf/cMJRNDRqq93W1zI+VrTKEglTuYDA2TVQXBuil6HRCOuEsEsg798Np
         9IxE5NDgPI4riPu9xNC9v07n/ayBwsSg/UVLpmw72zWalk75Q8xqPjbjqbRrnD0En2ig
         dxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emj6t0YnQ8kfODwk6pGcM/emMJNNvWG7eis4Ne6JndY=;
        b=duCU5r3onG49DAlPeQKqUB7xMljWpbBjVbEUkcfjt8eRj9R837wpGeeP9sarXIODPz
         1F/Gh+c6KI1EX1yqVFKY/ma6e3Pm65U9RiUDqemoz4HCcXNC7xtbt2Vr3vZaueimSWih
         CGmLcEJ0jX7KO3ppMfHE43xY7jW9f4IaDGz94mQAY08aMaMFBvrtIN4cF4R+cjJd1KnY
         HhZA174lUkdvQGzE+6B2UE0crRPSYfZ/9CjhoSoQ53uGP8K29BOjkwXz68fQHxd/Bot8
         XKmx0Em6RcZWlKAddO0+oEfBZiSbOfYNlgOGl0bt8//d0vJ+vyADjTTOIQG1xoo7kLRV
         s56w==
X-Gm-Message-State: AOAM533tyvKGS/yaRcHkN7D58l8K+pMsNsyAgvkdxaEEezJh9ba57Fiu
        THEEwpDnJ+KAEcNOjM7/ywbeDg==
X-Google-Smtp-Source: ABdhPJxSRfTPtAOzbr7EGyj16vGGsghASbI4b9GyWVvNHffdVr713D7XedbHjc9AgjB8nY3Mw1qMtA==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr6745211wrn.262.1618220379586;
        Mon, 12 Apr 2021 02:39:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id r22sm14405902wmh.11.2021.04.12.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:39:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 5/5] gpu/drm: mediatek: hdmi: add MT8167 configuration
Date:   Mon, 12 Apr 2021 11:39:28 +0200
Message-Id: <20210412093928.3321194-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412093928.3321194-1-narmstrong@baylibre.com>
References: <20210412093928.3321194-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8167 SoC have a hard limit on the maximal supported HDMI TMDS clock,
and is not validated and supported for HDMI modes out of HDMI CEA modes,
so add a configuration entry linked to the MT8167 compatible.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index bc50d97f2553..c1651a83700d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1787,10 +1787,18 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
 	.tz_disabled = true,
 };
 
+static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
+	.max_mode_clock = 148500,
+	.cea_modes_only = true,
+};
+
 static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-hdmi",
 	  .data = &mtk_hdmi_conf_mt2701,
 	},
+	{ .compatible = "mediatek,mt8167-hdmi",
+	  .data = &mtk_hdmi_conf_mt8167,
+	},
 	{ .compatible = "mediatek,mt8173-hdmi",
 	},
 	{}
-- 
2.25.1

