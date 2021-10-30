Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17C440A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhJ3RL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJ3RL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:11:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C97C061714
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 10:08:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m21so12938946pgu.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+W1GMLw6C5reaVE/Y3pI1gn/PZ+dci603n52uqzIAc=;
        b=K6IFILSEntzkjF4zAJE53lfbxpsnnRNjTX18tiLglLxJt0GORz7bgiSEoN5mAxVgsh
         mGFKli7c6RMXqSX9ifPiVEt2g7fVDBii20SQgVDzVo4LR3co8CO0nNOsWbIk2ue/DqJO
         qUXF3lMtss5oMddUcgBFo0PkgV8queNnOxfeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+W1GMLw6C5reaVE/Y3pI1gn/PZ+dci603n52uqzIAc=;
        b=L+YHDRPdVr0QK98Tk2ky9E3SJEBkkUTOboiWpqVPRGZZj+BIgZ9V7edM8OhmgtebN8
         uo6nYwB7OK1zMmEiX+zcCwzK8K1aFN73QwESGYbDTrStaqxoh8LBC/o8vMiQtxd6mUzP
         Rz9a2tgoqkXGVoliBsS6Zvo32vJyUMSu2RSJzQ9ygLZfAq9ShI/bNPSaNcxRgzZUi3bF
         Rm71VSqzeihDgwDUPziDPCRficC4AdGC4R3BVs0Uz3g61jrjx+ASeiv/8sNH1xJm9Rk4
         68IQsmPzczNCKd16fUlOx9te46pSl5zm0JEsSpxI/KrQC24vXTK24XzFm9YSTB0y9xL3
         lnNg==
X-Gm-Message-State: AOAM533vBqccocJgjjnrNWAJrZzbnxnhFjWpFPMYtOQ2zwBSpYA6vlNt
        9QSdEnDxn+DwFLjiyO5+oAqMXhyUp0PM1g==
X-Google-Smtp-Source: ABdhPJwSmUoGp7LXb7jUr28+7PBB+QkgoTQGz8UyV8ymunRt9JTMHBCp+cX19W4PjQ1KMU+pSedPog==
X-Received: by 2002:a63:ce0a:: with SMTP id y10mr13812030pgf.133.1635613735258;
        Sat, 30 Oct 2021 10:08:55 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:f63c:4559:725c:b6da])
        by smtp.gmail.com with ESMTPSA id i7sm8565390pgk.85.2021.10.30.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 10:08:54 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org, robdclark@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bernard Zhao <bernard@vivo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: set default num_data_lanes
Date:   Sat, 30 Oct 2021 10:08:50 -0700
Message-Id: <20211030100812.1.I6cd9af36b723fed277d34539d3b2ba4ca233ad2d@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "data_lanes" property of the dsi output endpoint is missing in
the DT, num_data_lanes would be 0 by default, which could cause
dsi_host_attach() to fail if dsi->lanes is set to a non-zero value
by the bridge driver.

According to the binding document of msm dsi controller, the
input/output endpoint of the controller is expected to have 4 lanes.
So let's set num_data_lanes to 4 by default.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index c86b5090fae6..a32eb33dfc14 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1696,6 +1696,8 @@ static int dsi_host_parse_lane_data(struct msm_dsi_host *msm_host,
 	if (!prop) {
 		DRM_DEV_DEBUG(dev,
 			"failed to find data lane mapping, using default\n");
+		/* Set the number of date lanes to 4 by default. */
+		msm_host->num_data_lanes = 4;
 		return 0;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

