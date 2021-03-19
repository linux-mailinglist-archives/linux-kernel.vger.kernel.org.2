Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFD341768
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhCSIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhCSIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40990C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hq27so8274351ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/33rrW6tAmVtxRYoiv0PK1lc5LAomei+z6FwtqsCisM=;
        b=T7L8hIGs4NLk/w7APaYDVvRcg3YuQAFMJ6VNnBtnkcgSafK23nyyVPEa6rAZ67DJa6
         pie6iammssw0VfjfNCtarEdfEjG4/U/n5u9AndJt0nPoS1aaj14s4oeZ4Mm8nVAPYNhF
         LWenRGRbEwS6ghyOL9m7rQnbW+Z6j9A4nqz2CMJYsHK7Uko4usWy0g03vRKHG8x2kKaF
         gVQA8ZliD3ZV5sE0fA9ypKCbfpjp2zKol0C01DZbjSGXr608SKX5AnAtdQz09PXvWxTD
         vzEUkxtsjdLRYM5gkzSBJ//Vd39nmkCvOJV8bUkQAlBGVLVXdJ443a6A4mX2jpRRD1da
         LFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/33rrW6tAmVtxRYoiv0PK1lc5LAomei+z6FwtqsCisM=;
        b=oByWJJyNRdpMIsDkT7DrMpZOnM6Di8V4l1wiTd+yajOF9bcBos38cdtx0fvuvCf+D7
         WaSVMj8xRbw+SULi97hhNg49a7APWB51T1F4Y9dosbY3DZ8YBKJizlrH/et9EL2GglNl
         UwgGWTYg0+jHK3xv6+eyLzqog5h6YPXKxAW3Gzx4104ivN0516r+vuND87sDxjKXYLo6
         eGqzHPTdLSpA5UK2hKGXJv1KHKC3giMzfWLsKIMlG+q9/6H2g35rcROsijhns+g1fN6S
         vda/AhWq1zNT9nNHhIAT1b/4rqbl9lvk5u6Ll/6UxqkNlFHnmbuzXIa6go5xHpVwVVrb
         T4IQ==
X-Gm-Message-State: AOAM533PfU36nsJPhB0gKnU2ZPN5tivFQYT36nwVL3E99ORFRA0KId8V
        1v38gYLuxz1q31RKTKJMCl9xrg==
X-Google-Smtp-Source: ABdhPJz4KtR18bMDuxRNEmf8p/BopcQ1r7GqooWJY89cgdQHi6TZvOcC58gMxtYYchvEDHkZqRUIDQ==
X-Received: by 2002:a17:906:71c3:: with SMTP id i3mr2938932ejk.391.1616142274996;
        Fri, 19 Mar 2021 01:24:34 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 03/19] drm/msm/dp/dp_display: Remove unused variable 'hpd'
Date:   Fri, 19 Mar 2021 08:24:12 +0000
Message-Id: <20210319082428.3294591-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/dp/dp_display.c: In function ‘dp_display_usbpd_attention_cb’:
 drivers/gpu/drm/msm/dp/dp_display.c:496:19: warning: variable ‘hpd’ set but not used [-Wunused-but-set-variable]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5a39da6e1eaf2..31bf2a40a9eb2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -493,7 +493,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 	int rc = 0;
 	u32 sink_request;
 	struct dp_display_private *dp;
-	struct dp_usbpd *hpd;
 
 	if (!dev) {
 		DRM_ERROR("invalid dev\n");
@@ -507,8 +506,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 		return -ENODEV;
 	}
 
-	hpd = dp->usbpd;
-
 	/* check for any test request issued by sink */
 	rc = dp_link_process_request(dp->link);
 	if (!rc) {
-- 
2.27.0

