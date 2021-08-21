Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8601E3F37FD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhHUCJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHUCJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:09:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF3C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:08:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e3so2816635qth.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rmZq2jCxAvIhofkzACUjKttO0y4HbkUv8rY8k6EePI=;
        b=uZK0SHNBb/k1ROgKuOH0g24HQB7ulXr67Dq7Q+umzl6RdC0vL+Q5uedspbq/LL8vOq
         PG4M/kUYXWpF61g0jh4a3RNBNMo+8yGUu+wv0i+De7OMcKYv5AnFQPEnlDQ70oXYB7MH
         aeb8dQ0wzRbyyQdXelwmaf/AzfMqQTBLzeVVVPRFuTatrFLCdMKa8kzdvLlEtbvbfw/T
         63gCyEpll1pNNWEuIRrefSzYrXZgiY39lYTXAC0VK9o0A8yNonmB4v/LtawrJ7UGOENb
         cLEmvSdxRZkFAFuD+ykdvvRaagTQVJB4ZObt3mQoXx8bbMxfDmsHj8FNfKoYjz4ke0Tx
         x8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rmZq2jCxAvIhofkzACUjKttO0y4HbkUv8rY8k6EePI=;
        b=IPHqsh7jy7U7KIbVzsMNED8oKsyB/HeZehb/FexhJ4YA8LEj7+P6/8Vv5ppBDi5S16
         x0mqhgYqvQ+OhQOPlOUTVuzfAr6+6VWj3qFDHLfshzGlMOEtKuLKHH9w+IaGVMF4N38u
         WGM6v9tCedWVziuZYDWSL+/xj4oVfjdaY+0n4FMyGJ5QOeoM4MzgqweOAd8WwTDaMovy
         JtA5V1vuopBK4UJwAbqn8QNvL0Oaxr06/NwfsE9lSM21TpGLGmRT8t3O1BOTyJMzODVu
         wAT98e2i/3QjyJ9g5LEPYTT/cB1W6XL2RzzFBpb7mK1dOqSpHX5a/YYc9OzWkQsdd0xc
         kiQA==
X-Gm-Message-State: AOAM5302IPnSmDYal9NH+vDA40tUUWKk60u+HYpbe08ni8ExZcX5DOmj
        5PB9oza5cQHj6u/YHhu7Dyc=
X-Google-Smtp-Source: ABdhPJwCMnko/lPDWDq9yleBzmkHdqGBnR/meG6zUXRzZjSzTXmjUqKBv4DILXWIuJgX0J8DG+2P+Q==
X-Received: by 2002:ac8:5744:: with SMTP id 4mr20939078qtx.326.1629511737627;
        Fri, 20 Aug 2021 19:08:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g12sm3221652qtq.92.2021.08.20.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:08:57 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <luo.penghao@zte.com.cn>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Pan Xinhui <Xinhui.Pan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm: drop unneeded assignment in the fx_v6_0_enable_mgcg()
Date:   Fri, 20 Aug 2021 19:08:44 -0700
Message-Id: <20210821020844.26864-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo penghao <luo.penghao@zte.com.cn>

The first assignment is not used. In order to keep the code style
consistency of the whole file, the first 'data' assignment should be
deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:2608:10: warning:
Although the value storedto 'offset' is used in the enclosing expression,
the value is never actually read from 'offset'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 6a8dade..84a5f22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2605,7 +2605,7 @@ static void gfx_v6_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
 	u32 data, orig, tmp = 0;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
-		orig = data = RREG32(mmCGTS_SM_CTRL_REG);
+		orig = RREG32(mmCGTS_SM_CTRL_REG);
 		data = 0x96940200;
 		if (orig != data)
 			WREG32(mmCGTS_SM_CTRL_REG, data);
@@ -2617,7 +2617,7 @@ static void gfx_v6_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
 				WREG32(mmCP_MEM_SLP_CNTL, data);
 		}
 
-		orig = data = RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
+		orig = RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
 		data &= 0xffffffc0;
 		if (orig != data)
 			WREG32(mmRLC_CGTT_MGCG_OVERRIDE, data);
-- 
2.15.2


