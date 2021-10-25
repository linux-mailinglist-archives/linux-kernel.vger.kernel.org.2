Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76C439D24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhJYRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhJYRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:11:33 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60664C061225
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:07:49 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id y145-20020a4a4597000000b002b7d49905acso3913978ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM0cPou9Yt3Ud6BL/XL+O772DGApdgc8zaM9N+mI1Aw=;
        b=wOW1uKfv35wx7ay7/EXrWat8asMllLTqON55vq3ZRfnefbC0dX0T04jeONk1+64HQ8
         OpoYU4vPno1TA9Im73pv9x4M5t5+TlKcL1Twiq4ECRybUTGK53HiERnZNhfLKPD1p5q9
         QPCtp8XLnNAw3SrwNEGMD8sDaaHbbHgY6WunmZ0koO62vWJWioGpvSLSYAE6YFMCd3h2
         3ceambUzY2wWVI0oFRPU0LZZInMMDRO1D6Qkg84P05d9mjdN6ysdKBhpmUM38FSeRV2/
         jTEZqHLwI8OVk75KL3jCHWIoBPBs19mCDiOM74eSf/ggu+IdgALuBNl4kTet5fmx0IXL
         C29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM0cPou9Yt3Ud6BL/XL+O772DGApdgc8zaM9N+mI1Aw=;
        b=H6x5njXi6ubcRwq6UrPbNLkoS/t0v7ECs2NX8/7/Ufo/Gaxy1Qx96B0Nf3BqyXLpqI
         udOhx9G71bKiZdM6Q9WcUlAIwY5u95Y6ByoA1lI0u8GLqEuSXlAKp8pJF6aevst8gYIE
         CedjQTn6gL+gKJN1dc1ls25Y+AQ0TMAfRjzOfmCbDto/o063waVrO+ikqlTrlrVks97q
         4ztExQfhvk2LalzraRpdoOgjANFFEyagOi8hl1dp3G2ta/sotMiyuYCgF+yuow5J2Zmg
         r9vN29JaFRPg8GAfp/b2M6yWSs6Hx27XNMde9dslsuVK8TqoY0cuX6N0O0aYHy/nRvul
         wNJw==
X-Gm-Message-State: AOAM5302iB7KzFbwdPjPtzd/FoGF8LDzL0r/mazCSg+h2DpUsTgqhoT+
        ioKrx5scVBIFMmC4Y0y4j2NTv6nWqHg/1yhN
X-Google-Smtp-Source: ABdhPJy7TkF/lMJfJ1Xivrb4nJ+9n0smvlbKluTV6cZf/ycixxWBxfTRT11LZ5PCfDcNtqDv1ltx8A==
X-Received: by 2002:a4a:e9f0:: with SMTP id w16mr13239349ooc.3.1635181668593;
        Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id q2sm3076003ooe.12.2021.10.25.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:07:48 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
Date:   Mon, 25 Oct 2021 10:09:24 -0700
Message-Id: <20211025170925.3096444-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi-register u16 write operation can use regmap_bulk_write()
instead of two separate regmap_write() calls.

It's uncertain if this has any effect on the actual updates of the
underlying registers, but this at least gives the hardware the
opportunity and saves us one transation on the bus.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6154bed0af5b..5b59d8dd3acd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -193,8 +193,9 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
 static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
 				   unsigned int reg, u16 val)
 {
-	regmap_write(pdata->regmap, reg, val & 0xFF);
-	regmap_write(pdata->regmap, reg + 1, val >> 8);
+	u8 buf[2] = { val & 0xff, val >> 8 };
+
+	regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
 }
 
 static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
-- 
2.29.2

