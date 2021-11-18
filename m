Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DB456383
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhKRTdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKRTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:33:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:30:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso6657464pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a6XNUBiSVXYL8JcjB4TIIHPE7C73L1S2r2kenMwpgs=;
        b=ARw6JlgSc4uSQsvSy1AnLry+K0GYe8gJVXoEpwzdAFt1kYqveGSebR3VEHsCXYIgeM
         EyBMLlDwdWgFQJZiiRF2Bpjc38O1LCR0/W7JMMPclLANOq+dTu81Qg29RS1DvydwmI0H
         0/lorw5B28mzpOf7PH6OvINy1pWy7XEvZWAa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a6XNUBiSVXYL8JcjB4TIIHPE7C73L1S2r2kenMwpgs=;
        b=WQ23WTIPV1WWqpXvFk5DDZ+M7aHu2xDMShrSSOorCvrLf+nv6NoabxQyO9LZT9Rl1q
         vLvImt+RbZP2jMAkJSvimrWXDsz9gVXHNF8NPYLUHUBwE7PBDCGIpydPonY4BbIo/9PI
         qCUsy0zMmy5Od5RNapZzZ+zehnVPIoJD1YYdZ3WqwgRE7GF7dVfz7yM66EOIN7lCESJK
         lkR0YTaobqx/FEOq3AaHkuACVeBf+7MciqIJf72qVQw35vqutZjOs3W1W4bl/DTBxPm5
         0S0aeDKACjrDo1JIuDpXhV8P1FrAhYBHcvpC/GxK2nTAssjlZxhDPNY05VwNgMiU4ICJ
         Gtog==
X-Gm-Message-State: AOAM533vWKnHm9JAY88Z0GxQsaAGrliy7k6de05H1NvDz+orpgNjf9+c
        9emmPxB2qVOOpUpy4SsbL1yaMg==
X-Google-Smtp-Source: ABdhPJzBkr1Ks3Z0c9CYiyRMhPuG5ANntyNBtjJZWW0AEGpAFbPYkMIeoCEBkkh8iMPZKET/xO8cKw==
X-Received: by 2002:a17:902:8a93:b0:142:30fe:dd20 with SMTP id p19-20020a1709028a9300b0014230fedd20mr68641445plo.29.1637263811954;
        Thu, 18 Nov 2021 11:30:11 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:4cf0:1835:2db:b2b8])
        by smtp.gmail.com with ESMTPSA id mg17sm343789pjb.17.2021.11.18.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:30:11 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
Subject: [PATCH v2] drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()
Date:   Fri, 19 Nov 2021 03:30:02 +0800
Message-Id: <20211118193002.407168-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

edid_read() was assumed to return 0 on success. After
7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
the function will return > 0 for successful case, representing the i2c
read bytes. Otherwise -EIO on failure cases. Update the g_edid_break
break condition accordingly.

Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
v2: Fix type error.
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 1a871f6b6822ee..3a18f1dabcfd51 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -795,7 +795,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 	int count, blocks_num;
 	u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
 	u8 i, j;
-	u8 g_edid_break = 0;
+	int g_edid_break = 0;
 	int ret;
 	struct device *dev = &ctx->client->dev;
 
@@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
 				g_edid_break = edid_read(ctx, offset,
 							 pblock_buf);
 
-				if (g_edid_break)
+				if (g_edid_break < 0)
 					break;
 
 				memcpy(&pedid_blocks_buf[offset],
-- 
2.34.0.rc2.393.gf8c9666880-goog

