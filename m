Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE935C2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbhDLJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbhDLJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA251C06137A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 12so12199907wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4YDvpAD1UGIZmGY7ATXAVL5J0kUewQGcgvVMVoEerk=;
        b=eUPqdTia5iFGBnU+yibNZFt8DEHCfvTTXCKdGvWosxt5hgzyijv+ZMjBvmmVh+K3nc
         cGluFdswEu4BADOWi0qosoBXasU4r3Hh9F3dM9yr/hgCKNx0zicuRBFeaG8TG6n4ZXA5
         6XPp/YIIWQ3GlSSDFT2A7Uq1RIUT/3D1hHcxKj07dlfX3YuAZ5SaIz4ng87sRS0HSEu4
         54/HVMBdy6xi93Dxe3nnTwg+8AMcfE8/BhJEFuX44v4QL5YQk8ILOEfKJKl0hSfAaO5d
         +x48W2GH7x97MA8qr7wFbIohjIu+MzmMMH8xwiT+ag8EVdw0KLW7SfZDKQiNjj2U7NV9
         ucog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4YDvpAD1UGIZmGY7ATXAVL5J0kUewQGcgvVMVoEerk=;
        b=V7ZVKhQ/kkG2TwoPKVPssVXfT1e2VaFyO+A8nIFvWAYSncnF+W6cnvK6Cqm7VSWWCx
         ut0KYVyC/et0nAuSUHce82VHnzSXEuZjL5VRK3JzCK28xJYjFQev+MYmC8E51iMn7J5k
         U1go3LA0uGX6s3Mai+VfvdL433SBA4wEBnuGIFjIJVQotxnEkc5QwXq5kx5h7lbJPgFr
         7AFvD0AgHQ1pFSH2oHq441/zCla47yGASjgWKIc1tId/d++c3TnFw0gbXm7817gbjnP8
         GEpV1zLgYOSFoxnSb46D3aecTOEfjJuG7NAja48gnxnk1C4VC1qy6pXX8p7f7V0i+++g
         S2XA==
X-Gm-Message-State: AOAM5309cq/8itnWXUHMacrGjWMWrkCNvF53j2TMrai9Sfnui4uCqmuy
        Ij9AVwVajvxOAsS8s8EzUd2ZIQ==
X-Google-Smtp-Source: ABdhPJxigmfZSCdDY1wqLPhfhhfh2s9j7fmTwvG4DM80AXXv5sUawdrPx6YzpUHMmhfQo3YB3ijV/Q==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr30640128wrs.94.1618220378404;
        Mon, 12 Apr 2021 02:39:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id r22sm14405902wmh.11.2021.04.12.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:39:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 4/5] gpu/drm: mediatek: hdmi: add optional limit on maximal HDMI mode clock
Date:   Mon, 12 Apr 2021 11:39:27 +0200
Message-Id: <20210412093928.3321194-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412093928.3321194-1-narmstrong@baylibre.com>
References: <20210412093928.3321194-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs like the MT8167 have a hard limit on the maximal supported HDMI TMDS
clock, so add a configuration value to filter out those modes.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 0539262e69d3..bc50d97f2553 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -149,6 +149,7 @@ struct hdmi_audio_param {
 struct mtk_hdmi_conf {
 	bool tz_disabled;
 	bool cea_modes_only;
+	unsigned long max_mode_clock;
 };
 
 struct mtk_hdmi {
@@ -1226,6 +1227,10 @@ static int mtk_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 	if (hdmi->conf->cea_modes_only && !drm_match_cea_mode(mode))
 		return MODE_BAD;
 
+	if (hdmi->conf->max_mode_clock &&
+	    mode->clock > hdmi->conf->max_mode_clock)
+		return MODE_CLOCK_HIGH;
+
 	if (mode->clock < 27000)
 		return MODE_CLOCK_LOW;
 	if (mode->clock > 297000)
-- 
2.25.1

