Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6053F0A07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHRROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:14:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:13:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so4612091wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=37MLSH9lYPS34IVx5EfZVMr+hGfCcZBIMSeL1QJmzSc=;
        b=PIOS5lfVqZQr2EIMeZA5ubQx6UB/nEqDdg+/fw3aomNSZcT13tMnYoz+UIqXBDb6hq
         LbjTjXYx9ei9CZ8QrgFcEPWwOCqQ3XtbtRBUdQippNZGFaTaiaKYECYt17KNOPsa68+S
         gxHxVI4lvJ95gY382yCB32K4aidQiVFAiYsbXsMajVYG23sN7gBFlTqgd8jhGyOUdLOr
         hi2R8zoeWiTFrxtNgMcs6x9eatE2RgySYXH58fGdKep1g1vJ00d6l9dXimjCNfFD2uWz
         h0CUUdmtIUsahSWQhSAUJmuB/Wq7GsujSUEYNvkCLzJgCTvTQgOxVrfxPQTx4RUvmMim
         kM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=37MLSH9lYPS34IVx5EfZVMr+hGfCcZBIMSeL1QJmzSc=;
        b=RrZYwzrrI26/Mliq1yIufsnesFW/MKbiakQq2cQipVSM+Ei3Auw5cwzZH/VIzqOLvM
         CgYi0nGD7vd2qXVFGvHkAKGxhMSDqXQRhEWfATYLaxaElu2F8HqHj+av5kZ/LU/RU0Gp
         Y7VszJyyr0k3jehFg6VJNTCRntJbx+9Wh53gYEpKD3kHuMe1uRUhZKWYk16K1X77/loh
         JpG81HQ3gNc7kwT1tuxxsSTqIgFxind51+1+1/IFQzsScavvJ5nV52bFCEz92xi+3479
         bmElQZy5JghBkdRTy1sCRnVRi0ffGvm2hKdB7yyhl0aKxxcymQu0HyAcWpyDYFQaFk4H
         u/1g==
X-Gm-Message-State: AOAM5308GAjR3nkFK8PT9NDLkjeqyLrtR7aLvTwzrEQ+C+gH9fHw8B5z
        ATjL3hc0cpbqyLteDdkfSIR9RQ==
X-Google-Smtp-Source: ABdhPJzsxd2Ntx4OU+VAYF773vl3++r8bqpD7vwRrNjiKzzNW5kM0njmz+jfbvPKwMDL77r0yEXqYg==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr11854422wru.45.1629306806404;
        Wed, 18 Aug 2021 10:13:26 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:a470:eb9f:53a5:20f8])
        by smtp.gmail.com with ESMTPSA id p3sm414825wrr.21.2021.08.18.10.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:13:25 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, xji@analogixsemi.com, pihsun@chromium.org,
        tzungbi@google.com, sam@ravnborg.org, hsinyi@chromium.org,
        drinkcat@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/bridge: anx7625: Propagate errors from sp_tx_edid_read()
Date:   Wed, 18 Aug 2021 19:13:18 +0200
Message-Id: <20210818171318.1848272-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818171318.1848272-1-robert.foss@linaro.org>
References: <20210818171318.1848272-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the sp_tx_edid_read() call the return value of sp_tx_edid_read()
is ignored, which could cause potential errors to go unhandled.

All errors which are returned by sp_tx_edid_read() are handled in
anx7625_get_edid().

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index ea414cd349b5c..abc8db77bfd36 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -845,8 +845,11 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 				if (g_edid_break == 1)
 					break;
 
-				segments_edid_read(ctx, count / 2,
-						   pblock_buf, offset);
+				ret = segments_edid_read(ctx, count / 2,
+							 pblock_buf, offset);
+				if (ret < 0)
+					return ret;
+
 				memcpy(&pedid_blocks_buf[edid_pos],
 				       pblock_buf,
 				       MAX_DPCD_BUFFER_SIZE);
@@ -863,8 +866,11 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 				if (g_edid_break == 1)
 					break;
 
-				segments_edid_read(ctx, count / 2,
-						   pblock_buf, offset);
+				ret = segments_edid_read(ctx, count / 2,
+							 pblock_buf, offset);
+				if (ret < 0)
+					return ret;
+
 				memcpy(&pedid_blocks_buf[edid_pos],
 				       pblock_buf,
 				       MAX_DPCD_BUFFER_SIZE);
-- 
2.30.2

