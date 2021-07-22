Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D133D1C04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhGVCFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhGVCFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:05:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:46:18 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id b18-20020a0568303112b02904cf73f54f4bso1023985ots.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuEoL0cflmj88ic5E/HBFbgKYO0ZjMr2HcVskHGb4+8=;
        b=gTWxU6v2EWpdjHWSdRsk7wGshB7EBoTxmSV8TDRq2yPSI+1sk7E66j1/hwyjO4OvR1
         ERJYkBJc9Dy8API/rXeZ+l4O6oiASLlyq07LRhhazsHoV+RZPzB1EP2osUPlOKuTxtro
         tsFgityqP73QzS4/Hp56+85gZF9n7sb3eGg9VoHjmF616Yi/u2Bg5wkfZ0cVrwkyb+1+
         qRC9l9PhkTMIRd8JVck0BGGsS2UojXzmzZ7pGR8s6EnAUm/4lPqVA69zwov42viY5jbN
         fO4SlDvt8c6ZkomLyW2cf93psDPozgx8QWP5ynKKkoZpwrY9e7uSlpxofWPei1rnnNsJ
         u4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuEoL0cflmj88ic5E/HBFbgKYO0ZjMr2HcVskHGb4+8=;
        b=fAV87HLHZhoZNAMBHX2KLgIcN1aQ2jXDjrFO60P3B+Oe6izSCIFMYzIYl6ovnjOeAl
         peaCXWr86hV0mLUFMXfNjVL9PuykTgOpcpcDg+/4zB9nGaGeYB3CWK4awLLNz4quNyUZ
         2mOTqKqShht4vsFSMt5V0ySW02BklBRPQnS8NuoZvXTLis09h1wzaFH7HVaxbOm/6f+q
         +71nk0s5kubJdR51cljEAg/rFrdV36JZtPfRyek0OornGLVm+F6kXTXtGWs6cO5Dalmy
         rPZvm3mL1zt4A8V6O0A6LZWdnO80VJutJmyvmUC/zyhOkbhq/cAQiZH6uXFy6TgV2RW/
         YGxQ==
X-Gm-Message-State: AOAM530B7nb6iqXoVVrzKtXVEAQD2vPbEbqVBDvtz4BlTM/ukdgAH+A+
        2qkoTXxjt1yHH99dKQLmNvgeIQ==
X-Google-Smtp-Source: ABdhPJzn5vDJKXScBg/5Zax5IQIFFmirfICOQE36McKeLi23Vbz6GYsDN43N0AUPf+NSyaLxhLNgXQ==
X-Received: by 2002:a05:6830:1b6b:: with SMTP id d11mr27389811ote.234.1626921977560;
        Wed, 21 Jul 2021 19:46:17 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x16sm390098ooj.1.2021.07.21.19.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:46:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Vara Reddy <varar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Initialize the INTF_CONFIG register
Date:   Wed, 21 Jul 2021 19:44:34 -0700
Message-Id: <20210722024434.3313167-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bootloaders set the widebus enable bit in the INTF_CONFIG register,
but configuration of widebus isn't yet supported ensure that the
register has a known value, with widebus disabled.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 23458b0ddc37..37cb1102a0ca 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -747,6 +747,7 @@ int dp_catalog_panel_timing_cfg(struct dp_catalog *dp_catalog)
 	dp_write_link(catalog, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY,
 				dp_catalog->width_blanking);
 	dp_write_link(catalog, REG_DP_ACTIVE_HOR_VER, dp_catalog->dp_active);
+	dp_write_p0(catalog, MMSS_DP_INTF_CONFIG, 0);
 	return 0;
 }
 
-- 
2.29.2

