Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A522363C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhDSHeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbhDSHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:33:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A040C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so7826063wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b64pfOb+ESukFQpojWv0aNxV3D5E9ms1GDFWEsqil0U=;
        b=NxXHEJGDikQ8Z9gwWWHAZBvLF63JKD5m8/wy4XbGV9oVmxbhPmetFs9Zze9uKo5IvS
         5JhQ+0QPB1uRqGrBXSffE4M7SeW7jT22k2wLOA6dVlE9Eu7Qh/BmPgtRbmM538F2UXRD
         4V3RYJypYSCUvBrFtHrNMGByj+KEiShw7rJIWXaT1CD84l+ThS4Q0lBJdyLYLtv9UlQp
         +oHWfLbbZ0MpprqDTw855tChXKLgJIOxq0+I7DZXYXepgNb+Kq1ODHpddxomIUze1S7p
         4YlOyCnqgUmh/Fga0kgUHF2bdk4QQBQwbJDtyPDbqAS23jUBP8eCO2LSLGU2bNR485Va
         f8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b64pfOb+ESukFQpojWv0aNxV3D5E9ms1GDFWEsqil0U=;
        b=DZRV/QvvRifiK8SUiVFze1TJWA3da657gOaaUISJ1LMQc2JBLEbUXoAhLAMzYbLK3L
         ODjF9Qe/A8A2CoqQ0fGxGFeZe9nhQCF6c7a6IISN5ucdom9O20WfwhcZBSG773XtrmH2
         teSm5+M2Nqlsl1bhOVcL2Jo2jMqiu3JGp09ZX3Uup+4wxV5cwRHrcx32P/0vcHomF73s
         VrZV5TIPgBWYiYFDLbzbZIuYxOTU+pcA9+y2DLkhQnjlYLzKu/clicgwBCuLBfEicr1m
         OQ2WHl/28sIRcRcDdD1ud62G7bOS6ZFG7x0qMW0GpJoHptBBa3gJhs5YOaSpL70U/k1W
         l/pQ==
X-Gm-Message-State: AOAM530f6ckgWsX7j4xnzxsibMFaBKImmuWnc3awtU/3Lv2OwQFKOXOx
        UAVT7YRxt6C1q1jvYLKMC05wqA==
X-Google-Smtp-Source: ABdhPJw0d7BQTNzJ5es+sguom1+qdvQWC5lAGSwxNOAjaTAytr4cn3xUUFf2qM4dVwLHnn7ppXDrDg==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr20761875wmj.2.1618817583230;
        Mon, 19 Apr 2021 00:33:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id y125sm5492311wmy.34.2021.04.19.00.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:33:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3 3/5] gpu/drm: mediatek: hdmi: add check for CEA modes only
Date:   Mon, 19 Apr 2021 09:32:42 +0200
Message-Id: <20210419073244.2678688-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073244.2678688-1-narmstrong@baylibre.com>
References: <20210419073244.2678688-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=8hZCU8l60f4io5DjF0ScarfKg+RXuxNEKXbnKgyzEvU=; m=p9m3qQg9ro9SNdO45JuikwvmDNAXyAV1Ql4r4DZfEGY=; p=3uqgx9h0NLat9GhpnH/7lHx4Omxj//rcVoYK6CVuKP0=; g=19421281216f8c01edb5b08ac035741d73dddc53
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB9MgwACgkQd9zb2sjISdFStg/7Bfk iMsl/JsD8ylGFg39AeUNYyCs6C4eUkyDyeEhc22g66p2B11Zff/gIQ24FSdUu38vmW6pQm0zlw8h6 bUoAA45N3tGtxKBJbsJg3rj8tU9AyajQjTbHTMXslGiMEk/8T6WOti7jedTAv1yB2jKbwEyMyGqfD vB6gC6m8TBs877WfOIbnGq/z7Kj+JY9TrIsPu/4CoidUSDGXSvewYpfO01CtNDRqHPnxO03ep7Wgl XcvVp4y7+BnxpiD06evJzQEmoBGpITlAnJQVKWePqM0qB9jCGet2rLlrpe+QMX38kSMmnVRkT2FLd vVcO3cr2DyiHTugOcFZGdY4Prf/Mwd+fZ5F73EEGFH9KGBwm8b5PnmhlzX40/OROWEVZjpJUQtcl9 nbwb80rprYYQbo84X9gLJMn1ZeafTScj+nkzVkZc9IFFRiEKHovgoRcAM9sawmJ6fbIh+w29XTZ3X LNABEzq4WsLoT5tDsp5zJ6elpRgj2qzPwLrgZTAtH5CwPYMEVBYZBTgeFPBl/r/qaecngE5hyNq2b ovTVqV5d0ip55pZGxXINUGt1WAG4W5yqCKHeOl5V+Qw5L284AlhBykZCwCgbH2jid4gEvfIRLEeJk o28EAt6n9FDaUxCv3hXXaLCpRwdaBcER8KtE0hORVvjcpEEGbx+47CNddJ9S9YJM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs like the MT8167 are not validated and supported for HDMI modes
out of HDMI CEA modes, so add a configuration boolean to filter out
non-CEA modes.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index dea46d66e712..0539262e69d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -148,6 +148,7 @@ struct hdmi_audio_param {
 
 struct mtk_hdmi_conf {
 	bool tz_disabled;
+	bool cea_modes_only;
 };
 
 struct mtk_hdmi {
@@ -1222,6 +1223,9 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 			return MODE_BAD;
 	}
 
+	if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
+		return MODE_BAD;
+
 	if (mode->clock < 27000)
 		return MODE_CLOCK_LOW;
 	if (mode->clock > 297000)
-- 
2.25.1

