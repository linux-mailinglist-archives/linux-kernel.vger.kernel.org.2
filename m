Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F038AEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbhETMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbhETMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD8C069140
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z130so9026205wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlibc4LyGipvg4obFAlhywPDGkR/RwOwB7qJgTWpEQk=;
        b=UA59QABmfviBFeZfpaAPoiLqz5qey6xTmF0t9hqA5QLsmKpXnUkVTCnx0qvs0zKJ8C
         z2bJ3m2Fw2kqMgDcGlAR5byvIHNNEz6vSBKq7OD8aL/kH5wFAaL7lQv3F/Ofen/BzpNu
         m6x/RTaH8fT5BM81ukjIZ2TODrhhdl9y6fuVJ/wf5dhUZwmo0v4gSn3cxh0XIOpdG59f
         aFYlwPkIfxVZZWi3DL/vzZCK0Y9G2Xn50Yecd7IskuY7X8P33ypXjiNExPQGdnISLlAS
         3j+DHnslT2hE+iZiS305JG439KEM8SnpG0/Mzb4KMi3RNvyxItyN73kDYJJBFipMjXhc
         BEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlibc4LyGipvg4obFAlhywPDGkR/RwOwB7qJgTWpEQk=;
        b=kYS11Yj8BUFtloB6GP0HEMF9ZQTwtBG2F08/mwj1hwSC+AdxUroLUQ5mCEQEQhPeXa
         JKGdlU2C6DzE52oVYM9W9+93GfJcAcpssBY8lbNheUMwRBlFYVcVmAvr0SDV7y5qz6Hu
         tSJ47MoTfjLA9XyMXCsm1L/XLqZ79AosUtU/K15XdKUhgohB9Cx4Oj3abj1QiTTcP50n
         XZf8o/U+Pu97IItAYUkfRqwa/UA5DfHSGDfEsgevd5/lrvFaW42Cm7mnk5w6vUnL1PAb
         l1s9Pnfhb68am8MsjTiOtFERGYKttsdDgVwfXeUOgzgl17XSD3nGwAftkOx1hlzt3hwP
         yckw==
X-Gm-Message-State: AOAM530dJWsENBSUA89zIwAH7aCpNNKjHcZ7EJe4L+FAZG2SPGJzHynm
        Owtlyp4wPl2oDj7t4j/mTohiSA==
X-Google-Smtp-Source: ABdhPJxZvMmhAPb64IZvUSM2V4g4sPvzwvUnAl0rdZIN85Pd0pFiszmlO95w7yWHvYH/+prqI7Rtkg==
X-Received: by 2002:a1c:5582:: with SMTP id j124mr3405666wmb.0.1621512202682;
        Thu, 20 May 2021 05:03:22 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/38] drm/amd/amdgpu/gfx_v9_4_2: Mark functions called by reference as static
Date:   Thu, 20 May 2021 13:02:40 +0100
Message-Id: <20210520120248.3464013-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1008:5: warning: no previous prototype for ‘gfx_v9_4_2_query_ras_error_count’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1054:6: warning: no previous prototype for ‘gfx_v9_4_2_reset_ras_error_count’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1063:5: warning: no previous prototype for ‘gfx_v9_4_2_ras_error_inject’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1133:6: warning: no previous prototype for ‘gfx_v9_4_2_query_ras_error_status’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1143:6: warning: no previous prototype for ‘gfx_v9_4_2_reset_ras_error_status’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c:1153:6: warning: no previous prototype for ‘gfx_v9_4_2_enable_watchdog_timer’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index dbad9ef002d59..87ec96a18a5dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1641,8 +1641,8 @@ static int gfx_v9_4_2_query_utc_edc_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
-				   void *ras_error_status)
+static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
+					    void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0;
@@ -1690,7 +1690,7 @@ static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
+static void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return;
@@ -1699,7 +1699,7 @@ void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 	gfx_v9_4_2_query_utc_edc_count(adev, NULL, NULL);
 }
 
-int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -1772,7 +1772,7 @@ static void gfx_v9_4_2_query_utc_err_status(struct amdgpu_device *adev)
 	}
 }
 
-void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
+static void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
 {
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return;
@@ -1782,7 +1782,7 @@ void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
 	gfx_v9_4_2_query_sq_timeout_status(adev);
 }
 
-void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev)
+static void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev)
 {
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return;
@@ -1792,7 +1792,7 @@ void gfx_v9_4_2_reset_ras_error_status(struct amdgpu_device *adev)
 	gfx_v9_4_2_reset_sq_timeout_status(adev);
 }
 
-void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
+static void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
 {
 	uint32_t i;
 	uint32_t data;
-- 
2.31.1

