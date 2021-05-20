Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290F38AEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhETMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242762AbhETMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B9C0564A8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t206so9046373wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8jZ4n5cOgv/UmZYK2xnz10jZVZgWxDdZjKqpW0gHh0=;
        b=aMQQ1xEnSvQD3ee9SKBfMAucjU1i0GuZYxyAm5Vr609ce3SciJolcr8Wax9ZulKXcv
         sD6nDCXLgKhHFZ3wGUAXLDEJiKCTAzW9c2uo6dYfwWtOXy1SElARM6AMnC1g8qnj0Kza
         2OYno/nCbkZcTT7bwnUWwKjRmnz8/lkO7uVOG7spMZDcB/uIjfsZ5lvMUPouUpWIkbwG
         Y3s9n+8FZMsy05uayaR3a2lTuhWknvSN1tarfhiYwfVnNLGjQqu8AIILv9wDj7HGZ9IR
         siuqyEEn6LuXh2udRCEITucyFfyhS4/070fI4zr86ciM5gokEaJC2UPZ+PnezrY2wqPW
         Mi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8jZ4n5cOgv/UmZYK2xnz10jZVZgWxDdZjKqpW0gHh0=;
        b=YmrT9c+d8LfahfRCYkYv2RJmg0TcPldbEqHP23ItF7iPlOKiLAckMdzQ9kyHdHf7NK
         eBSqXuB5LkMx4i23CUnXF2XuXQhW9j6FXVdFFvH/9pD07N7GYEQuNHAd+3OvPnN0abDF
         PGv6Vttw2zXO5jAgtJK1HFZyvkzC3oT9TYv4tkyhbiN7b8K0X30kOyDAygh33srRqOdg
         qWZFegl6GRuEenFOjjTO28tK+jc7CmATH81fe5g2yeXp/575rtCgi6PtMG42Zs1y5vQI
         zhbR5xKBjHrdVT/iM4d0xjsQLYE3yL0C1cG+ftdIOaHHJnAOPgVOeGvwOo3gyw6B50v6
         eFWA==
X-Gm-Message-State: AOAM531rAiYjcTTkD1MCUqHvFsUqsDktJvdocMpyow6vm50oLniP97zb
        XLKwyoh4HrycpFRhxqSTkFD22Q==
X-Google-Smtp-Source: ABdhPJwtd7ia5gEWJ4SgBvkOPQ07S3wwyvf3RqqiLAzZCZ9Xq+Y9fxcbvVZ2VmUqb5ZT5on4iZGK8g==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr3716125wmk.97.1621512200589;
        Thu, 20 May 2021 05:03:20 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 28/38] drm/msm/dp/dp_link: Fix some potential doc-rot
Date:   Thu, 20 May 2021 13:02:38 +0100
Message-Id: <20210520120248.3464013-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/dp/dp_link.c:374: warning: expecting prototype for dp_parse_video_pattern_params(). Prototype was for dp_link_parse_video_pattern_params() instead
 drivers/gpu/drm/msm/dp/dp_link.c:573: warning: expecting prototype for dp_parse_phy_test_params(). Prototype was for dp_link_parse_phy_test_params() instead
 drivers/gpu/drm/msm/dp/dp_link.c:975: warning: expecting prototype for dp_link_process_downstream_port_status_change(). Prototype was for dp_link_process_ds_port_status_change() instead

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_link.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index be986da78c4a5..1099604bd1c86 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -364,7 +364,7 @@ static int dp_link_parse_timing_params3(struct dp_link_private *link,
 }
 
 /**
- * dp_parse_video_pattern_params() - parses video pattern parameters from DPCD
+ * dp_link_parse_video_pattern_params() - parses video pattern parameters from DPCD
  * @link: Display Port Driver data
  *
  * Returns 0 if it successfully parses the video link pattern and the link
@@ -563,7 +563,7 @@ static int dp_link_parse_link_training_params(struct dp_link_private *link)
 }
 
 /**
- * dp_parse_phy_test_params() - parses the phy link parameters
+ * dp_link_parse_phy_test_params() - parses the phy link parameters
  * @link: Display Port Driver data
  *
  * Parses the DPCD (Byte 0x248) for the DP PHY link pattern that is being
@@ -961,7 +961,7 @@ static int dp_link_process_link_status_update(struct dp_link_private *link)
 }
 
 /**
- * dp_link_process_downstream_port_status_change() - process port status changes
+ * dp_link_process_ds_port_status_change() - process port status changes
  * @link: Display Port Driver data
  *
  * This function will handle downstream port updates that are initiated by
-- 
2.31.1

