Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766C43B5AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhF1IxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1IxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:53:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE99C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:50:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b3so20213139wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivMWyakmLeaYuI23t/O2pRde3mjJQDvPIshj9I2/bxk=;
        b=U5RttCDInB3rDob0B5Dcq6/Xyhvc9wz8sZ8N+wWaNMXZOvdChN7mX6a/FDT7jGGO5B
         Km08kaThC7gGa7Q83XjZak1i6z/RUGIPGFY6Et94LmQhCb/TH3SyeqANgL3dLiju9Gb0
         oSy9HN6XaHnxH34/zes1RTu2PV04E6PCf+iVrePfIvhosLHN4um3c6ZNYTUzQIJ8EOTR
         6VLle0zILlHPxBxIVW6mNzi7UdE4lqdQd/NkPjeOKZvE5y4huA81pvsVgRCU00UEsFow
         +NVfKlCppBxpRDEcNt9jpnTQ7XpYM9ZVZPcJESh+dYu/1GpjO6hLNa3Qs9nkbVwhsbj1
         EQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivMWyakmLeaYuI23t/O2pRde3mjJQDvPIshj9I2/bxk=;
        b=jCEh0Y2jgBVfgE3cCafAU57Tj1+6AQOJ+Y7ZdP4x4ga3Zo/Brk5rjus5gDY5mS2LBy
         Fc3KDIVDghDoH9YaaNx9sYnfJhFwUz0iBn9VKWB6mdH2TsEVQhw1csofSHS04PakHcXd
         piTIpMB3AKYk0ibFKGOYIktT0bCw85Flya3NPfEb14d1YefaiGjvjDhZF4UbXorRVcSW
         FmoVK2GRbCeSHQOIdsX8iw9k+BV3BhuvOQ4uzgRzAEyXb7YXAFt2Xqyp99XQ/Y1yGwDT
         lJe/t2pPxeFEdDZhutpFK42auRJ2UEFIG8ZvG7TlDJBk6UbDAIu3Im7PbNclJoevDxpp
         gaSw==
X-Gm-Message-State: AOAM533dbI+0cEoa724l8yIly7lauuUYyEPLXEXC675oMGEFgwLhBSW1
        mx02VggkuyPN/Shy+8CzIgJb/g==
X-Google-Smtp-Source: ABdhPJx5O2B7LqCOPQfcupkEEJVd6rGqE+bx5F0HEMmyXyLyhRTJwjgwPYZa2H8Ud0EveatM7tT/kQ==
X-Received: by 2002:adf:f384:: with SMTP id m4mr25707885wro.12.1624870253640;
        Mon, 28 Jun 2021 01:50:53 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:b773:c98e:f11:e83f])
        by smtp.gmail.com with ESMTPSA id j35sm7379565wms.7.2021.06.28.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:50:53 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, jonathan@marek.ca, dmitry.baryshkov@linaro.org,
        angelogioacchino.delregno@somainline.org, lee.jones@linaro.org,
        kalyan_t@codeaurora.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] drm/msm/dpu: Fix sm8250_mdp register length
Date:   Mon, 28 Jun 2021 10:50:33 +0200
Message-Id: <20210628085033.9905-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream dts lists this value as 0x494, and not
0x45c.

Fixes: af776a3e1c30 ("drm/msm/dpu: add SM8250 to hw catalog")
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 189f3533525c..5d30c7f33930 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -244,7 +244,7 @@ static const struct dpu_mdp_cfg sc7180_mdp[] = {
 static const struct dpu_mdp_cfg sm8250_mdp[] = {
 	{
 	.name = "top_0", .id = MDP_TOP,
-	.base = 0x0, .len = 0x45C,
+	.base = 0x0, .len = 0x494,
 	.features = 0,
 	.highest_bank_bit = 0x3, /* TODO: 2 for LP_DDR4 */
 	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
-- 
2.30.2

