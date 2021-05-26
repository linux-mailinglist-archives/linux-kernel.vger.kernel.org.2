Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F218A3912B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhEZItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhEZItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C640C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so222734wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h62MLZglSk0AGZD9SfFQbGL1zDMVzymMNWcO9Y1i7ro=;
        b=c+dra2tqymbByrR6z2HiTHLfe9C2WgmOkQAwerg+mh5Ku0VofhpS6ze9r0mRMdT1pk
         YPNN+MYXY5re7Ot54h7F2ty2q32Sv75cj5GX/2/udd1GJAjJTOgt+3/dSe/MLXPMWPl2
         79kgXxCnDF5ZKW1dH0L/lEg9OFx06n3g+u+YjgGfwVTnYE5aIkCM/BJekPtCJwt7TJFf
         UKK+hgv0O3YfuIdIFq4/zxCy+xAxUwKGRUNce7rYim6Bq3v5nE5e594ckrg9YD4zogQb
         8pFVbMQwj1XN42ZhS9sIPolY4RYcrLfJBsZ5HNutOaZhToK4wA5Gj/BH3hoTn+nGoQcd
         g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h62MLZglSk0AGZD9SfFQbGL1zDMVzymMNWcO9Y1i7ro=;
        b=P5CaEpTlTv522QiK2ID12nQTrzt8e9PaVh4zBT3utBlfeqeLvw4uwoJqL0NGLiuEfy
         6ucqdTO7sHt8bQNANjgiV/timhpvFBt/Yr/YKSg6qmQ1O9rjp2UMV99CiSJfaZAtxsgb
         /Z0SFTJ/gHyJs7vyS1ZYZZLxUXN595g/+/u8tku0dHsTdcT/puHjFBxgMol/0mjdUYRB
         AG+pZw59DhFVqq30m/pXMJ0z0B1WY9coYpHM45BlosmKGcxLSZriIoY+a2YI47vLXAp3
         l0IQMGcT6R4KWZi3l7DbEbosTydffkI7i4r7K3gkuT16Zr1R6U6yad76+Ljqp1KX+HPP
         wnhg==
X-Gm-Message-State: AOAM531/k5iCOUkwjXEqe3GA9VyQBtBRfbAOXEaKZBgb+ATvh+fCkyWg
        eT0BdVvri/8Xz9VszTUCfww4EA==
X-Google-Smtp-Source: ABdhPJw+uQTXVXFfDBd2HbpSytC1GfBuCnOmnN40kPlHJDAiFY1wY/yMqneN9R+wdvUhT7IzjT+Vfg==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr31780393wrt.137.1622018852634;
        Wed, 26 May 2021 01:47:32 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/34] drm/amd/pm/swsmu/smu13/aldebaran_ppt: Remove unused variable 'ret'
Date:   Wed, 26 May 2021 09:46:54 +0100
Message-Id: <20210526084726.552052-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c: In function ‘aldebaran_is_dpm_running’:
 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:1260:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d6ce665baaf3b..d077e211017a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1368,10 +1368,9 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
-	int ret = 0;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
-	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	smu_cmn_get_enabled_mask(smu, feature_mask, 2);
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 					  ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
-- 
2.31.1

