Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4803912C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhEZItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhEZItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22321C061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso15025960wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OW7W47mIWK6yublPiEJWvFrVpFjoI7qTlEhI5W3sk3g=;
        b=Q4Dzbneel0DMkx+zXQm4rfhuirMiZW0kumIdYTlWN3Rc8ONEfmPsGv5nSTgmMJMzm1
         dDVTt75sX/MR1ZLRVZN3aTgKAPW2fjnN4y4HZQMD5UJnGpbzaGx3zX/TY54CwkTpN93z
         ci3EPh0fpBN429rFH3EWjtZm/y/XmxGjjvLf/rm6l1smQ/An5IKRNRN0RO/bZnXExJD2
         Yf/0VcrD5X5GZ/W8bFogzhmqOFHRKGj64yiSr/Eoafy5yJ46O/pFb3qzPGyq1W/bjEXy
         qmrYNwBKc95Gk6tvYCz8Wc6n8OynNac2iK09tru9kJoWyxDnZIIE4BOk/y7Fl7k7Mgti
         +IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW7W47mIWK6yublPiEJWvFrVpFjoI7qTlEhI5W3sk3g=;
        b=Ce9UTnu2etHFzKAU7WubEhkNaq2Jzsiv4X3HMloSfhSvtoeCqgmADL1KRVvZ3OX51Q
         npBZqegH39S2suD/bW9wdqmza8h/dI4z74x9K2YmB6BBdkUNJHPHXaqNjcPfdcb49IRf
         nGYNAXo3ehVt85PgI+Uqz8wob/GO1Yi8X6vz1QUsk9WiMMJ5nMQzgTIvAuJPOELiwR12
         PbiV/rd0KDCwNTXHHOURK3h2ql6lPHgdFJ9c+QXahX82+39TMZyRhnLZy7CKld/riv5h
         2U5jvPYJ5f8bvIBLCJLsQRWnbx/bc+eLR6q1Y3rKOpjOP1vD2l8XL+0049QyXRX5l9vM
         X7bQ==
X-Gm-Message-State: AOAM5308/H3NxmhlFt+H25DjXWGCHweL4ef5SGgV1vuQBT4tTdN2GD6C
        p9902XdpaYiwTvy39l7xzx225IMyqVIbcg==
X-Google-Smtp-Source: ABdhPJzKjOnP2FN9XbCVd5z8Nh671DlRl76pfsWhDUprJRbuK1oP+cI43ILSCrES9+8y0ekBcxVa9A==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr2223901wmi.75.1622018857723;
        Wed, 26 May 2021 01:47:37 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/34] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Provide function name 'vega20_init_smc_table()'
Date:   Wed, 26 May 2021 09:46:59 +0100
Message-Id: <20210526084726.552052-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:781: warning: expecting prototype for Initializes the SMC table and uploads it(). Prototype was for vega20_init_smc_table() instead

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index d3177a534fdf0..0791309586c58 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -772,7 +772,7 @@ static int vega20_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Initializes the SMC table and uploads it
+ * vega20_init_smc_table - Initializes the SMC table and uploads it
  *
  * @hwmgr:  the address of the powerplay hardware manager.
  * return:  always 0
-- 
2.31.1

