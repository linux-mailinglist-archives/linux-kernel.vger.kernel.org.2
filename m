Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07853D4BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 06:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGYDqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 23:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhGYDqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 23:46:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52238C061798
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:26:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso6498437oth.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lr0HLKbGMfhvgQzbBYGum6ThIOLWrTxgc/XRrqS7TI=;
        b=T4ZvBinIYvzQj0wWKnaURygYFC2E8hXmRZ1ZtD4KlsPvtaZ0cFoZfK0iRpA8KWTzLF
         CIbCxifoBvbYOZVB97EkjwgnLgzyC+SwnJKlzG0JDrqag/Ri8ZAO1YgIe0MInyV0rBBQ
         AgO5NCpTP1bTaBjQUienFQi8F9Tdqt9Zqoup4M7jy/4tNtdQ4x6dZw2ZGjcmVGdm2gzU
         ZAEx8G3ft3CUzTeoUHLzsJZEcqxrcD2Fa5M4Ia8Pz2QS8D3I1Bwm3U6M1t/TrbtLEMZ9
         2V2i+KpfabqUX5eh9vinXE8LjV//GvsaLvmISWVyFnpalEri1aC4/JXOD5nAVQQRr3Q8
         JqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lr0HLKbGMfhvgQzbBYGum6ThIOLWrTxgc/XRrqS7TI=;
        b=kmDj4p3prTrYF6x+vUmYtkU6v0sP4SOy97vk+6dksTFnBo62//x3ZL4GO6EP/vcs/E
         1F1YHIlJtQNdJz3PsWcs8n9gy2/OChOpwjlSnyh3wjufz0k875J6U1fd+q1u6lVZ2mcv
         atVsKk/AOWoDuw8IpMOCN2NBDdkSAW2n9KvJr3nIzWC8UofWd2Z0DbzLzrdV8u+1U6uB
         4CuyR8adpHexEaMih5ZINc6Vi7GY/5GCDOUzcYnuR4ix1zkpKvfRquah8QNLLJlRGLVi
         Yvr3QogNtikTrvrYIGGFvbiWD8I+PcF2TWl2kxu4aUH86fZIxTVAibmAJ2fnM2A2fsr1
         J5sw==
X-Gm-Message-State: AOAM530kPgtlXSvX+StCS4coMXE3VGgXhmp6lNGhyHxn8NOffXXLTptH
        Ct+sCt1phg4p0LquCIUtE3KukQ==
X-Google-Smtp-Source: ABdhPJwzlSIVW2aW5cAHty03J7MuoqU0oXzGi7uz1brYzycm4HpPSCcTzEv7utPTS/ArSjZlgLegPw==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr8032327otb.281.1627187189689;
        Sat, 24 Jul 2021 21:26:29 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t144sm6986200oih.57.2021.07.24.21.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 21:26:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/msm/dp: Add sc8180x DP controllers
Date:   Sat, 24 Jul 2021 21:24:36 -0700
Message-Id: <20210725042436.3967173-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210725042436.3967173-1-bjorn.andersson@linaro.org>
References: <20210725042436.3967173-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
DP driver.

Link: https://lore.kernel.org/linux-arm-msm/20210511042043.592802-5-bjorn.andersson@linaro.org/
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 92b7646a1bb7..c26805cfcdd1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -129,8 +129,20 @@ static const struct msm_dp_config sc7180_dp_cfg = {
 	.num_dp = 1,
 };
 
+static const struct msm_dp_config sc8180x_dp_cfg = {
+	.io_start = { 0xae90000, 0xae98000, 0 },
+	.num_dp = 3,
+};
+
+static const struct msm_dp_config sc8180x_edp_cfg = {
+	.io_start = { 0, 0, 0xae9a000 },
+	.num_dp = 3,
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
+	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
+	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_edp_cfg },
 	{}
 };
 
-- 
2.29.2

