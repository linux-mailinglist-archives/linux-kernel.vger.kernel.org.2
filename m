Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D609B3F7F25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhHYXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhHYXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:42:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B1C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id h133so1783551oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmkhJZgxUoBYEWfmUUPtlawWDiOOQTnvHmBTREcB0I8=;
        b=JyWNsF0Fao+n3iA7RF4tPiWMJ8n2MZ2mYJoFDYpVaqi9ikZqme6UoCEL5AL6XWV8+b
         7j87fGb8hvJLvdo6yIJZGnmE8E4AXI+nFHBd1vgw/ziftZGciRFPiNm6JyxoKk4XqR8R
         WZf76jy/wYt9SI4BubN6PAu11atHjFJc6O5BLQ/wS52aA2uWAtwaI3YInYvWOgACsamN
         lerEgJOmm6aVh2+Wsj1TQGiWtR6jEXRCBgn32lvkpTeYUci5pjr1cWJmIX6WHVJjzKoz
         j9cQiPlS9DuiiKiFzshN54SQEfYOJxDMmAKpOJLwvJXhgE/NrZVmiItvzv6iUdhqFKc8
         RcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmkhJZgxUoBYEWfmUUPtlawWDiOOQTnvHmBTREcB0I8=;
        b=LCAN8l0n3DHN0btoIPuT5cmUlwPjj6oYkvz9wAEf58PmtEYRpskHzMuta3BrTE7vaN
         tAJxPyb7AmLp/C73vwtEXXiFVUSEt6JifjDmlND/p7m+VrqoARJOl7286J7Y1TK1EJ2x
         rtKqFtXUKHAdVu05ygBsQt5Z2l0E9uFCGdG96WULbEOXIYHIzJYqMMWoPTSkB+KKPQso
         KQtKXhjMHgl+OQvNMl7YOPhQDARVEsnsmjLxH6UQk6J8x45ALqCfN9otO/ELUNziSlSk
         KbMMPD5EeDTFYf1/I4lBIOC9KVbBvWx6y7XZPTF/QTowTkvbHAvDkctaRpG/zX5LGJuW
         oSBw==
X-Gm-Message-State: AOAM531lLVh1gX5u4v2fc3bfOJ51iPRac2VZYztK4XjMHookoB/fxu62
        3qbUePBWR74L2jROW7SvwCq/mw==
X-Google-Smtp-Source: ABdhPJz6tjCEJEeOJPotO0Zqa9gAx16HRWTqIQ4PQRuPnenQfro7aG6soUq54MIbZLfLl+BS50n8vA==
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr418519oic.80.1629934885805;
        Wed, 25 Aug 2021 16:41:25 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g10sm267136oof.37.2021.08.25.16.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:41:25 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm/msm/dp: Add sc8180x DP controllers
Date:   Wed, 25 Aug 2021 16:42:33 -0700
Message-Id: <20210825234233.1721068-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
DP driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Squashed DP and eDP data, as there's no reason to keep them separate today

 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4a6132c18e57..c1307230dc47 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -128,8 +128,15 @@ static const struct msm_dp_config sc7180_dp_cfg = {
 	.num_dp = 1,
 };
 
+static const struct msm_dp_config sc8180x_dp_cfg = {
+	.io_start = { 0xae90000, 0xae98000, 0xae9a000 },
+	.num_dp = 3,
+};
+
 static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_cfg },
+	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_cfg },
+	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_cfg },
 	{}
 };
 
-- 
2.29.2

