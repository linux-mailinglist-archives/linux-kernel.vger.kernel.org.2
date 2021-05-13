Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A799E37FC54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhEMRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhEMRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:18:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B568AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k127so26212235qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WG0R1210n0jTNjQDS6goCg7eMSMJrn7+n/wli9p3uE=;
        b=a7WGuaOMXcdyVbHS1oMtsfrUeHQJr5oaOtSUSS8iouy29cPevPdc+8W0XA+vksHIDi
         Zm8VeBJ/2aa0zQSwnxPK1+lFXabRRW8S9gUyxrdsir0JPTGoQyYzItinXzZ+KFcV5T8V
         R5zFT4xsDcG6rP6fh2FWihojqgOORH6V6XzdU4GzV1bMfwrFJNRO9z949T22p6j/mCjy
         TSI5Ep0DnBYHasjwZHxKm2TePX171Y3CMollCPSJL6Z+E22bv/cMFYG2QQZNLBYO3FEw
         6pDUNzzqnQxdWqzSeu/QcRN6/2twVbIZLKnYg7A4f3HtegNlibW6a5cIauts/lLBcYr1
         yQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WG0R1210n0jTNjQDS6goCg7eMSMJrn7+n/wli9p3uE=;
        b=JTyXEgnV7MembrentG9hIX1Da4mm27K/eio0lEnFJC+Iy1brP/eImebacpmQP9Bukg
         xxoSDraaRlxmmXc/AIYnk8LTj3jRZQx4li3sKEfVpxRKVCi8gDZ3RKe1VACNrRmTkk0Q
         qO2yTVkJ1aqoaPGkFJgIZbId5lV8106tOVbHW/CGQ8HvmPx235n0mozbYwIZKTfKVqDj
         /CASMjb4ekmyeBq92t0Jovgr7OMPr5Pk0uQ9yTnFKBgfZrFT0GetGVp/PEAD9tNAY0fK
         4vsq/9KCf1BHKMDFXh2O9jF2MRQJgncH3+YhF6JjsYEakvI+cGIENDO8bcRLn333dtX/
         13iQ==
X-Gm-Message-State: AOAM533mc2IpJV9G7MqfE5++gpyi2PP4VLtKP0Rzuk57AIZJfykBY1aQ
        3qgTXGiZ/kxIYVU3fYqZ2ug28A==
X-Google-Smtp-Source: ABdhPJwp93NLEhRkl5ZJqxvch8hiavkKa9Ms6pYFfYpvTzCXyNoiML+6spdv3qCly1s5rKn3cnni9w==
X-Received: by 2002:a05:620a:1201:: with SMTP id u1mr40175153qkj.80.1620926257971;
        Thu, 13 May 2021 10:17:37 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:37 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Eric Anholt <eric@anholt.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/8] drm/msm/a6xx: fix incorrectly set uavflagprd_inv field for A650
Date:   Thu, 13 May 2021 13:13:58 -0400
Message-Id: <20210513171431.18632-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513171431.18632-1-jonathan@marek.ca>
References: <20210513171431.18632-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value was shifted in the wrong direction, resulting in the field always
being zero, which is incorrect for A650.

Fixes: d0bac4e9cd66 ("drm/msm/a6xx: set ubwc config for A640 and A650")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 727d111a413f..45a6a0fce7d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -489,7 +489,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		rgb565_predicator << 11 | amsbc << 4 | lower_bit << 1);
 	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, lower_bit << 1);
 	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL,
-		uavflagprd_inv >> 4 | lower_bit << 1);
+		uavflagprd_inv << 4 | lower_bit << 1);
 	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, lower_bit << 21);
 }
 
-- 
2.26.1

