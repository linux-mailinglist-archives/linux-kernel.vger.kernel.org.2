Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1F3ED2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhHPLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhHPLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:15:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:15:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1925339wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MypbfBd+8NzYvLq8nTK4OIM+Bwb5IR2a9QYE7TAun74=;
        b=vnT219uIiszmKrVIAUYdubgrTwJG3I6olt/Ws9boCTBLxLKTtA792tVCKp+rcAk1Ac
         tKonnyCTPO8Oq0HPLPdBRAcNq74/BVwSufa9wtfbukHisxhcx1UPV1/NqPObS/KuF3Xj
         zQwAQdTz2XwfIWk5Aheomy00R2VoSrOO6sz5xwGbCyvr84GQTrfzRbx3dWtAXWEukitp
         GE8qqsXAM7tlWXIsk37GeAyKsElY0DYhCfOgC0mj/3riv3oay7mb0fJpfpHqCv13t5jW
         txI2efJqcjB4ly7vtT3WmNT0qpsXaN5V/TyAubqcQ0YqHzvnVrbOuaxDzEBfV/KLjkEe
         ASrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MypbfBd+8NzYvLq8nTK4OIM+Bwb5IR2a9QYE7TAun74=;
        b=nHvTKdxsazj1hC8V3LnTGa/VJuMeRlH4vifBWHNC4axfln6ay5wtBRsHfypPBmDMmM
         HVbgHfZ4W+Y3wQe+GLmTUjUeXtzyw3ppWOISNaB0diFnP/POACwq7f2p15gtSKfKfGFf
         plgKWNUX0Wf/UZF9wmxF/w6WsiZ2MC4swDbt2RPYSXsjmS2YSt4ahBEnOqsyNCXgAPVJ
         YKvpIRq1+WkiT+86tELRkE3V0LdJfAuPiWSwrHip5fG25baxBtzO9gAfr8ijcI7wA1YD
         t1521a58xAUhdoo5vjNDPMgElYELKOFAGYnhrOTVXC4lgkF/NYYuhd8IFBQOiEgM9QDA
         fudw==
X-Gm-Message-State: AOAM530UIlMtr04SftqEeUydOqLWfLGm/sn4n5SGfp2sopLkHP7PEGvp
        AoRLF8vf56Mv0Cmh2VKcGTcwng==
X-Google-Smtp-Source: ABdhPJyV1EJFi/aPZ2cNitANdudEmTvHeqAh0HBnAYoRiE2CnapHO0QKkAubn9UPFzfY3Pn+ckEu3g==
X-Received: by 2002:a1c:5404:: with SMTP id i4mr14854665wmb.80.1629112504172;
        Mon, 16 Aug 2021 04:15:04 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:2e53:d7ab:82a:3b3d])
        by smtp.gmail.com with ESMTPSA id o14sm1459825wms.2.2021.08.16.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:15:03 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, xji@analogixsemi.com, pihsun@chromium.org,
        tzungbi@google.com, sam@ravnborg.org, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v1] drm/bridge: anx7625: Don't store unread return value
Date:   Mon, 16 Aug 2021 13:14:51 +0200
Message-Id: <20210816111451.1180895-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of sp_tx_rst_aux() is stored, but never read.
This happens in the context EDID communication already failing,
which means that this additional failure doesn't necessarily
convey any additional inforamation.

This means that we can safely avoid storing the value.

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 14d73fb1dd15b..3471785915c45 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -771,7 +771,7 @@ static int segments_edid_read(struct anx7625_data *ctx,
 		ret = sp_tx_aux_rd(ctx, 0xf1);
 
 		if (ret) {
-			ret = sp_tx_rst_aux(ctx);
+			sp_tx_rst_aux(ctx);
 			DRM_DEV_ERROR(dev, "segment read fail, reset!\n");
 		} else {
 			ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
-- 
2.30.2

