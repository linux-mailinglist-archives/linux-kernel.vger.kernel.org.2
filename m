Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44542421C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJECiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJECh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:37:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA460C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 19:36:09 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso24096136otb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GYY3fgaaeOEZFwlrXaNb8Km6kTmaOO7oRCYiPn9Rtw=;
        b=qQxkZKeNLS9TSHR3BlSX1ArGn+F4qj0wLMrriaL9e+NNs7BGuGFPd04emb85TkfPqs
         X5AgvVsDLajRGyM/ad3xXjCLnxemgsLZiSsaXyU8ZIF0MZ2f3paGBdn3qlHqBAWB6L1K
         L6B/pOj4UvESvrUkJkI5Tuq4Mfi7nWF3jlQA297TMkMYlWNoZuAiaUM70ZrRkq0twPWM
         1iPyV55ubu9/9JIibbHyGJy47zoRQT8OXWRlrVswfb9Rxz578tl+dzTTZMqOnPos8/5h
         +mBryetbbDvyQ744howTfEswI9PW1svgzLRTQZaC8LMS8BMG5xI+N4iw6ZA04Rjj5sTo
         mcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GYY3fgaaeOEZFwlrXaNb8Km6kTmaOO7oRCYiPn9Rtw=;
        b=UZ7dteQ+7HqqQOEWDwt2PSkjYVRoC2s9hwmt6KhCakoGWcUakt0PKIhhmp+woeQbVk
         Kx2NWS+B6d9SCZzh4wtJu/DAo6Tk+Yhaqd6nY6DNtpCHAerBYVRdNsPPvbvsxlkMlBWW
         DvF4mNfkT5HOnKn9dfbrnjNppU1lrpCHacS5A+gSpNunfymxEblT+xDgw1yiT0zj9Umy
         nbRmv1BIEHoKRKcWmoTpDnsd2R/T7Fcz1x6D7pQrseaRVq6dzogXP3TAygXBkBOH52tH
         PDsiDg1OJ3St5rdTY8cwNdhOcisomNWpglnvlYV32+X5LdOXiCZ8Gyqg91aKFl93ehmJ
         Akrg==
X-Gm-Message-State: AOAM531ZL5zoE7p+52DfuVKuEDeg+aTwfnZ5DwCGVRYx0Vbi+/zIQCgP
        ktqsCtkgd+rlcjmJ/6aII3cIGA==
X-Google-Smtp-Source: ABdhPJygR0UDTE4BCHMd53yNo4xPeVw33V9dkfjhe2wQn4fgUTpyYl/AR4nlydFZHzSlhUGbJGWU4A==
X-Received: by 2002:a9d:7307:: with SMTP id e7mr12316641otk.35.1633401369095;
        Mon, 04 Oct 2021 19:36:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i12sm3055329oik.50.2021.10.04.19.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 19:36:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sankeerth Billakanti <sbillaka@codeaurora.org>
Subject: [PATCH] drm/msm/dp: Shorten SETUP timeout
Date:   Mon,  4 Oct 2021 19:37:50 -0700
Message-Id: <20211005023750.2037631-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found in the middle of a patch from Sankeerth was the reduction of the
INIT_SETUP timeout from 10s to 100ms. Upon INIT_SETUP timeout the host
is initalized and HPD interrupt start to be serviced, so in the case of
eDP this reduction improves the user experience dramatically - i.e.
removes 9.9s of bland screen time at boot.

Suggested-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 21b9c1de4ecb..46d9f3eb6d13 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1438,7 +1438,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_display)
 
 	dp_hpd_event_setup(dp);
 
-	dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
+	dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 1);
 }
 
 void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
-- 
2.29.2

