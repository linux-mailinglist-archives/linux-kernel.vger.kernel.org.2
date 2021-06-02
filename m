Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4A398D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFBOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:10 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51149 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhFBOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:03 -0400
Received: by mail-wm1-f45.google.com with SMTP id m18so1474876wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5nWdjb90GI2+TAkol2s0H4fVYowwMJxaadOSn6QcUY=;
        b=Mvgy55stlZuNX/pokvA4s4eyoSRztkqXdXTq93eU6mE/xvlBmNc8uYDIiGRMyggvQJ
         WFdXndyYicCkt2+CVRKGFMv3tWSYrppRxEGKlJy2MV5Y0BiRj1STB3e0XzkDdtXq179W
         cyZ4rGihQFnmuKwfP3Owt6u6vT6bLHRizWuyCP87fA0RvwKHEXseeUXI3octRriaPato
         uV9sgPOs+T01YQtYa0u5ZQSjCTRgSgZZ0Gfcf9D68E9d0uYEclaTQFgituOGvBDGyBN+
         EHTlUC9jhGzAbnHuQlgLrzOVgyxJFK7vIy6/YzDPSxPBj41ZXvek9/DTXIqyh22B5NxP
         C7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5nWdjb90GI2+TAkol2s0H4fVYowwMJxaadOSn6QcUY=;
        b=oOKYC1oYBltvQs52hP4EGf/I6tUPFBMi5TQLZIzj/+caX/VYu0RaSdDTOVJdtQqg6C
         XmKiUBahJmVwGUof7JyuAlcS8L3+ScU9i9R4Tiv3l1C6U3oD6sr1o60PMKvnXRI+b6Ff
         8DoQiugF+/fzlOtKQx29VRiGiniqSwtUkkNthGe00OvTApscnjuTj5Tiiesi05yv97eW
         AsrJ5PypyQzGQPnnt5dZfZ992C6ZAu01lbNipxG5JnCFs7mK37f8FZ5Dk5mdmE75mLWG
         dhJhkeHKr9RJBPbHQWGG9i2IFJqTVXA/Ri40yZfvQN96iLLS34xwH2rnb1FnQy6VB1iq
         nc+g==
X-Gm-Message-State: AOAM533785DJI9x/QAKFJmEHEcQe9HJI57iBURmbPARySLqsFKbtyFMi
        Hw/O0VzJhlIL2asW0uDkZ8YJAQ==
X-Google-Smtp-Source: ABdhPJwTGEyQyNzzbXkQyWal5cJWfFdoQqndQ5+cIRX0cKjf8RHVhiiu/dgMTmXmYfZgRMx5PjqE0A==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr5533686wmh.69.1622644399228;
        Wed, 02 Jun 2021 07:33:19 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [RESEND 09/26] drm/msm/disp/dpu1/dpu_encoder_phys_cmd: Remove unused variable 'cmd_enc'
Date:   Wed,  2 Jun 2021 15:32:43 +0100
Message-Id: <20210602143300.2330146-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

