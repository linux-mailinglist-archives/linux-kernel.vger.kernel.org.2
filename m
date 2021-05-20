Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA938AECC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhETMpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbhETMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A28C0611AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c14so15601913wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5nWdjb90GI2+TAkol2s0H4fVYowwMJxaadOSn6QcUY=;
        b=ECdngyCPXxuV8WED0vFl1Q/XPm49F6DBoppaIbs0HIcfo5XtnDejjHk8tkEzG01VqR
         VynFew87U48BK6UQOUZvX4hik/sKntYuwWjWHhskelw1Lwng6CXVxmjvJYLoh+5gDvFG
         wZTZ6uyJVOIYmg5bUoF2U8S961FxPN9UgvmdvJLprgOh2wDY45n4COM+p2y3GhU/jQ5e
         fukfyAfIzGVH+1KeEWfy8NFfvHqqUApjYjRh5l/GAxWnQZy//rm1pWAWrRvc6MU7kTp6
         MRfqdYUMvpTXpajmj7WC3yZ05xkBqOBCP8CpzfWBkas8+GiV1H07tv6mi3oyarOfc3hP
         4w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5nWdjb90GI2+TAkol2s0H4fVYowwMJxaadOSn6QcUY=;
        b=V2vYVfJIcfPH1H5uFubuoNtBuXBuqDS/JhVVAdWM5ejk6eAEfZKJ15iGT1JNPy8PJx
         b+tqWe44qK981Rn1MHUswHZIuEzwrsx2kwt2O9sizW1enrpqmyDhk3+uAN8B9GAmxd2H
         e5e2F0y5xs0fmwjy053Bwmhgh+rGbX+u+f6msE4gX13cZOS5Ky1S+EwL0bPepJjt75HF
         w0UT3iFc0U+3MC/O7Rm7VXbUnVrn51N8PApNrPybSXdR4tmX7ZpWwpLiPFJVDie9gBud
         mnJhhqkXJeurnXRDeeH3GK8vMUtogNQrj1ZKcgLQZRKLjTwayuONkC0RpEwHLPo87kNf
         B/Gw==
X-Gm-Message-State: AOAM531+vOZFapFE8Zfq2dQZMLsrM0OfFQMUzfywHOvwgbM3nTfcY9Fs
        aOUQDLGor2H3/5MXo1CbteDd+Q==
X-Google-Smtp-Source: ABdhPJww8GIvcXXddF95MhisGycsLVA2OrrF8dm6FBwFHsH6HeJ8zlz3Bhe5xFrg/og+j4rKvcXOHA==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr4003474wrq.92.1621512187365;
        Thu, 20 May 2021 05:03:07 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 15/38] drm/msm/disp/dpu1/dpu_encoder_phys_cmd: Remove unused variable 'cmd_enc'
Date:   Thu, 20 May 2021 13:02:25 +0100
Message-Id: <20210520120248.3464013-16-lee.jones@linaro.org>
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

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c: In function ‘dpu_encoder_phys_cmd_wait_for_commit_done’:
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c:688:31: warning: variable ‘cmd_enc’ set but not used [-Wunused-but-set-variable]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index b2be39b9144e4..088900841bf8b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -685,10 +685,6 @@ static int dpu_encoder_phys_cmd_wait_for_tx_complete(
 static int dpu_encoder_phys_cmd_wait_for_commit_done(
 		struct dpu_encoder_phys *phys_enc)
 {
-	struct dpu_encoder_phys_cmd *cmd_enc;
-
-	cmd_enc = to_dpu_encoder_phys_cmd(phys_enc);
-
 	/* only required for master controller */
 	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
 		return 0;
-- 
2.31.1

