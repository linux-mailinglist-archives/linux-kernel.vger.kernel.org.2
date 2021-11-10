Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8245244CB84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhKJWEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKJWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:04:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25EC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:01:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so16245330edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=t+/UxYIfl5RatBgf88GxHq3c/1lj+QC9CslttZQE2n0=;
        b=XePFhcDjf3veMupWj7qjbE9wuUf3H4+tNwcrf0MbU0VUm57qTMNYVGECFwTky+mHLZ
         Nh5bqq+BSowfxER55HHjvsG5gdKkVOmCUJtgE7iBkc10TSxVr9RF5TtF3Dpk1akuzgNL
         XOga0xLUGS/aA2/3hnZ21RxEs6CG7K0RE/M8R3j5bPQaY3SfM+oba/IRUYBYS3/Xd+N8
         i9omVj/yUn4mc7E7Hibcg5N4JfUn8PEySd9J6qnbI/SbalQjg2L5dSGDvyI49dsmRzF/
         fKkUZkrAfXsqiefewSF0B+5bkWMuPhzZC6T/Koor2lE5g0NEapIR/vAfBD0+38+9Jrlh
         HZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t+/UxYIfl5RatBgf88GxHq3c/1lj+QC9CslttZQE2n0=;
        b=cAVEO1dTRDcCnwG1WIDJnIMn87GJB64Fm4map5ggE/Jtdntv1AIYuoAFNkYFpWZUqX
         AchYIkidGtxquMZo+MD1pWxKIhROHteMSgN2EX6/lXo7DP/3ssPE0egCBWK5Q2oIuUZ5
         U0n9oRN0WLMsY/Kq78fqXzx1OeyF6Oo7MQ9EGRr+w41E07Lp4dHI/BUyPN7VCzoVo1+2
         NHVlKtMsbDZmC5Mng/AG8kSreqmRatBYjWgi1k/6Na6Bn1aRt3F9vbK8BDx1lKfca3Yr
         hDFPIaDclOj4eY/f72qAIHdQAw4UlYp5oZHqD2VGj6acl/L/6Clr98plbjZO59Tx0C5B
         6gJA==
X-Gm-Message-State: AOAM53028dOWXsqb259wgDfetRY7+SCxsJaotNNOWpEILndKJeiJLSum
        XsHp1xANWJeBHgmIsXEvyJ4=
X-Google-Smtp-Source: ABdhPJxK6/yGLmroAFvSRxu6YnEA1gPQtfldNnHq8g+RxJwx1YotyOTZJszNtxJtlfSHtau5GzW3pg==
X-Received: by 2002:a05:6402:4255:: with SMTP id g21mr3129340edb.256.1636581689660;
        Wed, 10 Nov 2021 14:01:29 -0800 (PST)
Received: from localhost.localdomain (37.212.broadband9.iol.cz. [90.176.212.37])
        by smtp.gmail.com with ESMTPSA id m9sm408476eje.102.2021.11.10.14.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 14:01:29 -0800 (PST)
From:   Jiri Vanek <jirivanek1@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiri Vanek <jirivanek1@gmail.com>
Subject: [PATCH] drm/bridge/tc358775: Fix for dual-link LVDS
Date:   Wed, 10 Nov 2021 23:00:50 +0100
Message-Id: <20211110220050.2854-1-jirivanek1@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed wrong register shift for single/dual link LVDS output.

Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>
---
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..1d6ec1baeff2 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
 }
 
 #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
-#define TC358775_LVCFG_LVDLINK__SHIFT                        0
+#define TC358775_LVCFG_LVDLINK__SHIFT                        1
 static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
 {
 	return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
-- 
2.30.2

