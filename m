Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A033F7F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhHYXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:42:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA94C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h133so1783316oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Dx5vF0RqdLQjKJyPbr0mwPJrCUoUq6AgUSDYu1xpnE=;
        b=e7Gva60om5ucDhwZOW154dizkM8QmCNpiJ/Qbr79PMm535sbqo6YqM+zRhkqrjfMXo
         KDci4/QsIf3DZVC2Nhufj3KE6G2Mdu7KVYB6rAGHkrKXrQXgpLKEPW0lZXrL1Xv6adVQ
         qUljemQJxfqBMTDwS8itfC0dAtkcAjygQAhY2FO8qbuhZc2cCuv1ze3MxI/azrfRXl8n
         gxVdbNf5raqo9a5nKrwO53lvhL3P+SsjNRgiQLkpuvL7oimlUIYHqBt0Q6Af7Knp5CZQ
         T0GYM6vZErrwUuIIFgOoIjheeXAcRAMBz2XaYqutgURo7G0PYFYGlCClSmmXNEYeSIic
         SJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Dx5vF0RqdLQjKJyPbr0mwPJrCUoUq6AgUSDYu1xpnE=;
        b=KZvywX9lMaknta0KtluFzqQrKBw80P4+zYBZU6xddcZuaDSKzaR9g2rMwakxlet/VI
         HXdN6e8ox6LUU+Ndm3Aso+SdRv0qRbjdEMtfiNEpuGwLCBhQjdgrSG7RTCb9mGqCGskp
         pMY1T+HtboNSBvC9YwcgCMSHI55JBYBNJzbllhi9DMYoK+0lrlHcuCYQn9v3RAgu3NBO
         O3flX1Zyk96LSjLVdYWmpgBicI4LXOhsn3iKEzXeQL/7RZTVaBqiF9+ZStorbe0n6DB4
         LSy6fQX27Cje140YSN3oBq5FT8m24cuF1d/VC9hVt2qQ3Wuu02zfMJ79w/IGCTZtxMct
         4iNQ==
X-Gm-Message-State: AOAM530Dkb9a5ge/2LjtqV7Tzim4St88mh8gE6fGC1Mm3BPqPlUUHnct
        2pG/Yg1NJUA3zgUXsqfBAzc1KA==
X-Google-Smtp-Source: ABdhPJw9zn3NtnBd0n8a1m0/bwKf1FTtVx1BLiPe2ubaNrtSNOf+Gyfx6CGQTdtFmU1GTT991d4YDQ==
X-Received: by 2002:a05:6808:10c8:: with SMTP id s8mr8954414ois.175.1629934880914;
        Wed, 25 Aug 2021 16:41:20 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g10sm267136oof.37.2021.08.25.16.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:41:20 -0700 (PDT)
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
Subject: [PATCH v2 0/5] drm/msm/dp: Support multiple DP instances and add sc8180x
Date:   Wed, 25 Aug 2021 16:42:28 -0700
Message-Id: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation supports a single DP instance and the DPU code will
only match it against INTF_DP instance 0. These patches extends this to allow
multiple DP instances and support for matching against DP instances beyond 0.

This is based on v4 of Dmitry's work on multiple DSI interfaces:
https://lore.kernel.org/linux-arm-msm/20210717124016.316020-1-dmitry.baryshkov@linaro.org/

With that in place add SC8180x DP and eDP controllers.

Bjorn Andersson (5):
  drm/msm/dp: Remove global g_dp_display variable
  drm/msm/dp: Modify prototype of encoder based API
  drm/msm/dp: Support up to 3 DP controllers
  dt-bindings: msm/dp: Add SC8180x compatibles
  drm/msm/dp: Add sc8180x DP controllers

 .../bindings/display/msm/dp-controller.yaml   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  23 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  60 ++++----
 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c           | 138 ++++++++++--------
 drivers/gpu/drm/msm/msm_drv.h                 |   2 +-
 6 files changed, 132 insertions(+), 101 deletions(-)

-- 
2.29.2

