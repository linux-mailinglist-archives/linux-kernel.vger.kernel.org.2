Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681A3E1BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbhHESvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbhHESu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:50:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FCAC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:50:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o5so11218359ejy.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2j8GypBg1lwZCMqPRAhi18yzlw9Dx0/0JNmaPl31yQU=;
        b=b1qrJ2Y8rC9hl0zvq833pleey9cWiSFC9YvFPyJEOA+ZtXN9LtLWJ1ecVsc4XzO2TR
         SB4PGR1wv3Nz4oC8TgvmygIqTDtvkFEDDOdITpiDo0YxXUzrcgziA+ExzIetkz0hH2EF
         3tRTaoQxNiyquFMUeWvgZU68E+MO9F9GnNviVDONNusnF8E7TpKiWlt36uKIxWkn98k4
         wxZOrJBw8SNNnNur95hMsuKw0OKs2LUubT0SfkaW7ZrQIT0Nt8ND08vjr4LosiPvJ6vy
         /JppNh8AEEpRUO+ICvx+wTiiubmXk8yettSIHw9v0oHD/z4rU1ccm+/qegPe3k+vhpCj
         TDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2j8GypBg1lwZCMqPRAhi18yzlw9Dx0/0JNmaPl31yQU=;
        b=NaG4qsPrtTXZD5eHQA9dVA2Vn7k8e9fd8GE6PZ21UgTrW6kUMB4XzJRxsMPULacMLZ
         TzHalSl0+bT5xAHOe61wzOM8optAUXfpfjB5yu8qjBomd9Nh0cR0gX0WsU4LBEpFEXZB
         Nrzo65MGLw+Tr3rW83ys3oqPSmeg++FJpupC/RlCybZCzJ09Je4QHJuwPprH1Qew5xiA
         mEvd2eWNMsM9o01q1gmxMuEEL1rRhpskUMfkooly+Back7WFrniSw+BwiV0LnTBsUH9y
         AToj9sBpQcEIk2Ym57wBFOkYoJ3dI/1TX8sBvXB/p/hWgeS7Qf7FZEjE0vLAHXW/jwnX
         wDuA==
X-Gm-Message-State: AOAM531Use2uf8MSJn7FQBU6iGuHUHn0QZNPGnSPSzQGT5oQ55qgT7/1
        YNJB8kPIB6z+8zpnDNpNIlv40Q==
X-Google-Smtp-Source: ABdhPJw4OLpxupfMIMMTfPKVgRF1XjDBpxCm/kQiKX3LlE7aoBDcPj+kpiO7pBD/o2tqdncs+FTecg==
X-Received: by 2002:a17:907:2096:: with SMTP id pv22mr6371552ejb.443.1628189442820;
        Thu, 05 Aug 2021 11:50:42 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:d36e:2c7:3619:687])
        by smtp.gmail.com with ESMTPSA id x42sm2716461edy.86.2021.08.05.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:50:42 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     ple@baylibre.com, narmstrong@baylibre.com, a.hajda@samsung.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1] drm: bridge: it66121: Check drm_bridge_attach retval
Date:   Thu,  5 Aug 2021 20:50:39 +0200
Message-Id: <20210805185039.402178-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of drm_bridge_attach() is ignored during
the it66121_bridge_attach() call, which is incorrect.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 7149ed40af83..2f2a09adb4bc 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -536,6 +536,8 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 
 	ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
+	if (ret)
+		return ret;
 
 	ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
 				IT66121_CLK_BANK_PWROFF_RCLK, 0);
-- 
2.30.2

