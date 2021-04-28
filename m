Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C287C36D175
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 06:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhD1E42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 00:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhD1E4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:56:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFDC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:55:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p2so28444148pgh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=VTFFF9OFqyw2YMLqAax+N1JMxY/fNr/W5AB4MeQ5uAC48RGc0An02b+Se479ddBizx
         XD/X1KjCcrsMtSQlNf2LW5waQiFV1rfGU+052WMVU0QQcBCnRqMhDXmhEWMSBSbhd1iI
         2p/YqB6CSg/fIreO6cajKo9N3kjiKV7dDgsHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5arbhYfGXT82qjQUTN0xccKMerRCIU7+UPVnm07W9Y=;
        b=qVn/93vZ05+i3aGtQMo6UB9MQrN2lqUVH1ZOrg2P6vtoWF9iB2QD6pcCBVgfBf3FUi
         MsDyXIo/BktNDg9dKzB5D+oZ8wieVEClnWaQeMVPAyARLj+flIbHKtUFcuTIafwnj8WI
         CpZq7qrSoAFCJ1e6afezGLOH2w6wnDkFcOqpTT9iQ61+oHKgSR1hnyvGPbVmnhWKQGrR
         4BollWinmkB3HQILPO1ia1+kY402XGS37q6b2gvLVoxnRu4zdydeZuPio5of/jV2Fc+t
         OofcUEawKuS8y1LRPFSRwPBUu5UEfDvbktGj5ivlB6LIsnxGjENHDx7I8SRGwV0lHL1Q
         w5cw==
X-Gm-Message-State: AOAM532f39GPMisx0htTEy7N3oogC8Xowlz2g/qUESu1D1U24piYiPNg
        Shw9tU0K2tm/WSIUqO3uuW1NOA==
X-Google-Smtp-Source: ABdhPJzGs2DXC6vNxlFEZ8RvRfGO4uOiE+lprziJ7+wryJ2YehvrOUkYJqxr2cPuDE5cVXFo3KiZsw==
X-Received: by 2002:a63:942:: with SMTP id 63mr25683673pgj.67.1619585740596;
        Tue, 27 Apr 2021 21:55:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:8076:36e5:2db0:967])
        by smtp.gmail.com with ESMTPSA id x13sm1193170pgf.13.2021.04.27.21.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 21:55:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 2/3] drm/mediatek: init panel orientation property
Date:   Wed, 28 Apr 2021 12:55:32 +0800
Message-Id: <20210428045533.564724-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428045533.564724-1-hsinyi@chromium.org>
References: <20210428045533.564724-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ae403c67cbd9..9da1fd649131 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -964,6 +964,13 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+
+	ret = drm_connector_init_panel_orientation_property(dsi->connector);
+	if (ret) {
+		DRM_ERROR("Unable to init panel orientation\n");
+		goto err_cleanup_encoder;
+	}
+
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.31.1.498.g6c1eba8ee3d-goog

