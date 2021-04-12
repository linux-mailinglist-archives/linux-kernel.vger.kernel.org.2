Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB335C2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbhDLJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbhDLJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88401C061379
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s7so12076863wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b64pfOb+ESukFQpojWv0aNxV3D5E9ms1GDFWEsqil0U=;
        b=cUCTfH9cQ20lN0ASEY1CcKyAskerlXs7EVSJaa6aV9/KVocXxKC9+GyDoWrNIo/+Z6
         xinJzqXyxeW3D3CAEl7kmAQIl0+SFCe0ibs9Urg8AyOHMFU+E8L1wfOvAu319Atd7xv2
         H9wet+wscvVhrd40D2HQX2U9l3P9Y1QnEieLZdZdvGOdjEJd6vAC3u3OcC2NH1yqaFpu
         wPoBNr6F3CGOwT4rkkJQ3k3I7iKBP38HOBmpHCHl+NZpewk2S8wEyrQg4B/6I86x/qmv
         VRRXKBFZsQaPCgjwZfMM6FezSVukE4fYRjWwFFUWkBDxNqUk/JG6wNERV2ufIjHxFpfj
         wFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b64pfOb+ESukFQpojWv0aNxV3D5E9ms1GDFWEsqil0U=;
        b=myLygXhCSgcQO6K80cb/5eS8324oFYMB3i3NVRxGJh3e2E+p+HOq0/y7uffiDcsraC
         1WlNB8drKcuH5ULyiOFYfzpJ9G644qBrSpGX+7grbWuKFcLHZJJ71/U4kElJfRk1NXgH
         hwph6jGwX0f0CPjKDFxt1MVBY5BAgXeyR1CJNKwDt6vsm/mEZaQpPvfLzuWbA7/PTxMd
         AasWZOjeUv90ceQv5GSzDFJAC9k/DxSXJz3MQM3LWeKB9YXJQ3BTwCLkcshIgvsjPTh3
         QIJx+Ipxte1yG0lZulmM4ne9c6hhY4Fqg7HuHFeN+AZpsMubRUhMVieC/i5lyIvcp70H
         3JjQ==
X-Gm-Message-State: AOAM533O03UAcmRxuKkKU2V6bC4WIUbzC1PTJeeL3tLGrgQkinEDAGdp
        Nv9xMWMDxysYeQB55LU7y3WeTA==
X-Google-Smtp-Source: ABdhPJz96Ixh0rydLkGNtoMbTLcMl1V8ZHJ6OxRZb3g3eu/v9lSIxMYmfdeZLJ4ofiQecixqlveQKA==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr32037266wrz.62.1618220377138;
        Mon, 12 Apr 2021 02:39:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id r22sm14405902wmh.11.2021.04.12.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:39:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 3/5] gpu/drm: mediatek: hdmi: add check for CEA modes only
Date:   Mon, 12 Apr 2021 11:39:26 +0200
Message-Id: <20210412093928.3321194-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412093928.3321194-1-narmstrong@baylibre.com>
References: <20210412093928.3321194-1-narmstrong@baylibre.com>
MIME-Version: 1.0
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

