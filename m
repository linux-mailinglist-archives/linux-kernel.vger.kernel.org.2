Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D536BEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhD0Eun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhD0Euj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:50:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32DDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:49:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so5105176pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xF3OHVoJNfqjglnjvTxLJPf73tywjjNrGA26Syn00bg=;
        b=aQkvabnsOYdSCbCI2Ahu8FMyIfugOfrAzX9FIMQJY9p2Czzu7GnXrtexTRQGyfcOXA
         zDUfD3J608v/yBPJ2tYvQStQjwqcURK8qXNGNtV4GnpwVVbXvHFDGHX/0e46PhgnQLJf
         wBihdkVOueiHhJkVMUT6VOim5Rl9dRrc7EZgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xF3OHVoJNfqjglnjvTxLJPf73tywjjNrGA26Syn00bg=;
        b=DJblrwnQoqvz0z829HM9Jd9KeuPlxPIrOKq3pCc56H4iLppXv5RI0fDS1mRI1nN71s
         Wkl29ZGf0WXiY39BVjOVlng8v9sMJaY7UK8N2SFD6MzOn5x7daqRbAG9KK4y8wHjX3j3
         iGPkG4Cx23kasHpRAmnI07inGymGjLpdu6t8H1sXf7rE1iPnke2CzbrV5oCzqxuoKFx6
         BSIVR5zfu7/IF0m40L5cQ2JbWl2e1sNfWMLjrwXjSACwi/Gdnmwok7UZZ4ZlTHdCgprL
         OTQKnubU2WzCFC3IAV0XGm1DvTjK71Z63e8RjucUo3GGUjeJdlHYySvOgU2uHo3OSNOz
         HdHA==
X-Gm-Message-State: AOAM532/YptL4cNL5N3ln2H7x4m5xSsCjPUWcWOdk4zMkbFCfcNjjDqc
        pmKb8S6tkQIl3k72AChPuRjB4g==
X-Google-Smtp-Source: ABdhPJwPPm4u4tg6YSG/bq6wlqozKqdTA0jRIW6pE9ln5m9hymH+OexWOCKpW5EL+vxYFzyZxE6Yrw==
X-Received: by 2002:a62:bd13:0:b029:25c:5ec4:c2f3 with SMTP id a19-20020a62bd130000b029025c5ec4c2f3mr20817479pff.35.1619498995453;
        Mon, 26 Apr 2021 21:49:55 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3984:c4f5:8612:6b3e])
        by smtp.gmail.com with ESMTPSA id c125sm1151517pfa.74.2021.04.26.21.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 21:49:55 -0700 (PDT)
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
Subject: [PATCH v3 2/3] drm/mediatek: init panel orientation property
Date:   Tue, 27 Apr 2021 12:49:47 +0800
Message-Id: <20210427044948.12596-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427044948.12596-1-hsinyi@chromium.org>
References: <20210427044948.12596-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init panel orientation property after connector is initialized. Let the
panel driver decides the orientation value later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ae403c67cbd9..0bd27872f2a4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -964,6 +964,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
+	drm_connector_init_panel_orientation_property(dsi->connector);
 	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
 
 	return 0;
-- 
2.31.1.498.g6c1eba8ee3d-goog

