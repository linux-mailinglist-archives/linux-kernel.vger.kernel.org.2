Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF438CF42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEUUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEUUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:47:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:46:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s19so13520346pfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qc/OISeLg533se0Ov/+qOFnvI05ew7O5rEcNf/rVX1Y=;
        b=nC0UhFlm212CnyrWNvtpu6kE4mWwHySnKzDUPQtf26R7PkPF3sEaIawFgxiZDnjE5+
         XuCnVcokB8yonlU/uLTQRrsmuDfyHP3LsE6xgP46I7yj2qYekBw37sqpR1BXXO1wtp/5
         nD7wVwtKmtqaU23+De1xsc0EeoyHYNqvlPD0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qc/OISeLg533se0Ov/+qOFnvI05ew7O5rEcNf/rVX1Y=;
        b=LwOXwjmfbYpO+mexMHvt0GiMH0hhEFVIgqcLFXqQuBCACoPXSL7wsZJX9GL8mkqrYs
         Dc1EjSYy/7o1n0KAILxJk1xeVDfkhP2KGetBYooQudYShAw2Xw2HR6OHtc+H0e+7q9p3
         +J97A2x3auCx5gokFWnhq2v2w5iCiIgmhfQ7X07Rcpn7k6ko0jGqoi8pnEuOPRE71Xj+
         bofNy6KfmjptQ5zhmBwPkXoPgoC6DCF0UcsbMHBKTEizjMJWq9AcgpLF0DOWNGtpu8V0
         0GFQBN12SDinoUjbZr40qG5mSKF4veRBhgrOlr+o7punGJjF8oVMP6A6vdJw7Xun+b6X
         GOzQ==
X-Gm-Message-State: AOAM533Ar4G61Pe1/ae1gJkez4GiYHAz0ETLMfjdwPXRnCiiT9dj94x6
        qbFjaak9RDHJJSTR7M3Nlmj2ag==
X-Google-Smtp-Source: ABdhPJyuVEaAW1PGylYq3ioVKFB2/Cb+DhaAneOsAuDfXLhYsdtUdaTbycQanmvelf0UhoTAzWM3vg==
X-Received: by 2002:a63:ed41:: with SMTP id m1mr616385pgk.252.1621629960856;
        Fri, 21 May 2021 13:46:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:10e9:a6cd:727f:561e])
        by smtp.gmail.com with ESMTPSA id mv15sm4839635pjb.25.2021.05.21.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:46:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>, swboyd@chromium.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm: Use nvmem_cell_read_variable_le_u32() to read speed bin
Date:   Fri, 21 May 2021 13:45:50 -0700
Message-Id: <20210521134516.v2.1.Id496c6fea0cb92ff6ea8ef1faf5d468eb09465e3@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the newly-added nvmem_cell_read_variable_le_u32() to future
proof ourselves a little bit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The patch that this depends on is now in mainline so it can be merged
at will. I'm just sending this as a singleton patch to make it obvious
that there are no dependencies now.

Changes in v2:
- Rebased

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b4d8e1b01ee4..a07214157ad3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1403,10 +1403,10 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
 {
 	struct opp_table *opp_table;
 	u32 supp_hw = UINT_MAX;
-	u16 speedbin;
+	u32 speedbin;
 	int ret;
 
-	ret = nvmem_cell_read_u16(dev, "speed_bin", &speedbin);
+	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", &speedbin);
 	/*
 	 * -ENOENT means that the platform doesn't support speedbin which is
 	 * fine
@@ -1419,7 +1419,6 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
 			      ret);
 		goto done;
 	}
-	speedbin = le16_to_cpu(speedbin);
 
 	supp_hw = fuse_to_supp_hw(dev, revn, speedbin);
 
-- 
2.31.1.818.g46aad6cb9e-goog

