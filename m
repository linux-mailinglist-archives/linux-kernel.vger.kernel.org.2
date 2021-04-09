Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB6359827
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhDIInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhDIIna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:43:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9AC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 01:43:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a6so4784117wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxAVnkvMBucxc7nVmzkehM55ix3ppr1nutixxEdT8mc=;
        b=hzi/nQIm8IbBk14mZiIsufRcM2Cw+6f99hud3p8ZpsCLObKl7z1S650qtmxg5CMtaD
         RIJ9RjLF8E7L1KpF7o/zuDQmpn7JKmqEcVY8fYIbiGHqEeQfDKW1ZBx3l/ijasZ+aJ4x
         b7Am0q/FC5+lKR4GLkRYGODR4ffE+C25mAOiBDtkerPcyM5yBctoW94hYBre/MJfelFz
         UNlUxeKGJ8qtQwcaoofpFf5zZ2iWx0y9MOzAXUJhG6pMomlWGcKkXGYXHAASPDtCJeMd
         M01f4oOBLkQX5TTVD+MmLwWEALjMO9ylf6sRR6ZLXO7BRvyH2YX6+PCmfXrsjF2zyLYI
         rgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxAVnkvMBucxc7nVmzkehM55ix3ppr1nutixxEdT8mc=;
        b=qdniQxLLrLjIH+sfvz5V6rh2WAFLwwtMWx52Xg0GHOGi7u2z8Ygu2BjUFMHrf8MQNv
         9m/pgnQJd9e0RnclNefaEv+m+hGX51VXZ2Us9MqiJvryD8M0WoRz9ZXx18U8flpPb50U
         lFvROfKlkZ5UMlqazYmcFNkljO99Pc8S6W3MwniamNU8qAC6yARsQUbfSQEEskSsaU2I
         ynXDU7nqAkbmeyp9rVPxprZPfg4VV5ZJmJoXfSn5RqsMDvtKiOJ00MPjaJ60mc85XUiD
         rhphyYxm9g+M6mnNdqZO8K4cOiZOJ3BLYLRanEB2pPm9O4LS36OOKuhlPu8xpuH235Ot
         hwPA==
X-Gm-Message-State: AOAM531AfAWkuomBwuCSnyk/DmV7bMe7g+5xJqHNQ3nq+3gVgvI6HoVy
        G6T+R1sTh35Mb56h3VgCZ0R66Q==
X-Google-Smtp-Source: ABdhPJyH5BhpUZCaFcVaAl1X3duZCpaxmI4fJOW8UUTkeb23ThLiMR1Qt0/IhBcS9m7rAYQjbh655A==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr15986534wrt.289.1617957795526;
        Fri, 09 Apr 2021 01:43:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d6f1:3413:d06b:d6a2])
        by smtp.gmail.com with ESMTPSA id w7sm3545504wro.43.2021.04.09.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:43:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] gpu/drm: mediatek: hdmi: check for valid modes on MT8167
Date:   Fri,  9 Apr 2021 10:43:08 +0200
Message-Id: <20210409084308.481185-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8167, only CEA modes and anything using a clock below 148500 is
supported for HDMI. This change adds some checks to make sure the
video format is OK for MT8167.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 8ee55f9e2954..991e2e935b93 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -148,6 +148,8 @@ struct hdmi_audio_param {
 
 struct mtk_hdmi_conf {
 	bool tz_disabled;
+	unsigned long max_mode_clock;
+	bool cea_modes_only;
 };
 
 struct mtk_hdmi {
@@ -1259,6 +1261,13 @@ static int mtk_hdmi_conn_mode_valid(struct drm_connector *conn,
 			return MODE_BAD;
 	}
 
+	if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
+		return MODE_BAD;
+
+	if (hdmi->conf->max_mode_clock &&
+	    mode->clock > hdmi->conf->max_mode_clock)
+		return MODE_CLOCK_HIGH;
+
 	if (mode->clock < 27000)
 		return MODE_CLOCK_LOW;
 	if (mode->clock > 297000)
@@ -1810,10 +1819,18 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
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

