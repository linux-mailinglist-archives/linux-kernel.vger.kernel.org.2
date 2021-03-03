Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71032BE6E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574014AbhCCRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444453AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F3C0611C3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d15so8498111wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D64SVMvmhdwuXpC8yQyBurTfGArjqR5f88yUwkGnjo=;
        b=PFvYLvLOQQyWQMQRv4QlSlNwCBMSEjOKXmCpUftQ+PvbDpgZOJKJWEzuCJ/uFmzDFT
         uGEpjSkOlZNv2tRYz7PFRV4iWltZDCbgb1FFE5BEUmtSbT0XQ8EnMYsuCBcmYL8V9En3
         1V8IKzlZVWlD9//2RJlxWN+ye9+ba1OnpWhjakABlRSfaGY6fSdvmD0scUf55SI8fba9
         Zu3Gk7arkZw39XPrAAOH6i6RInJWfI7pOUsy26ANUMBndF7AIzmvFRgdZ30pAmtKcbZb
         WtOtgpOrP8xBW1/Ii2jnB1Jy11P7zdZk5bjEoEcvU9EezBqTQ6m1frK5HvQLasK+erwD
         EnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D64SVMvmhdwuXpC8yQyBurTfGArjqR5f88yUwkGnjo=;
        b=AQ9Mc9Td8vJdiV1+Sfly++Vo4GECGKIy1eizDYJ88NVPMacpL+bwDYXxTFDKx8VYfo
         itDiVLGHjt9V+yqs9pX+FwWlOjVgUd9zSINiryb7MJTwYwOWbvZl7RB9J4lb3ieH/nrE
         b0k08LyQ8tF8W1YjzxeYM6c35sfFSkyTXFGAvrC2PZY4pcyzuAPyFMd/b5hGyrHWEw23
         iU5xutHlZ7JB2/1WbfIOn7XrlWfKLppk+EyDrPeT7oOxGTTM6dDX9uXrjP0iDl1O8WNf
         njjLhPnVi1Y8VFvVCSCAl5Y5twUKxWZ+zRC60b4NZCNMm1+dIVvFN7j0F/Jnli1Xn5rM
         hC9Q==
X-Gm-Message-State: AOAM533e/8Pm1e+/XkbbAfPhd09tjRcD9zJmIsGh/vowHVo0dMIAG8iq
        8vF4uZM8CACQisApeGG/r2+jMg==
X-Google-Smtp-Source: ABdhPJyPcj3Wwm2bRs4O0dM5WyZr7c0wcEd1Ru7yoUgsPiH2vfNsDtk3ue6LDrOHmw+mZStSZxT77A==
X-Received: by 2002:adf:ffc8:: with SMTP id x8mr16151717wrs.384.1614779027164;
        Wed, 03 Mar 2021 05:43:47 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 16/53] drm/nouveau/dispnv50/disp: Remove unused variable 'ret' from function returning void
Date:   Wed,  3 Mar 2021 13:42:42 +0000
Message-Id: <20210303134319.3160762-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c: In function ‘nv50_mstm_cleanup’:
 drivers/gpu/drm/nouveau/dispnv50/disp.c:1357:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index c51efca82ac78..828f48d5bdd4e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1386,12 +1386,11 @@ nv50_mstm_cleanup(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm cleanup\n", mstm->outp->base.base.name);
-	ret = drm_dp_check_act_status(&mstm->mgr);
+	drm_dp_check_act_status(&mstm->mgr);
 
-	ret = drm_dp_update_payload_part2(&mstm->mgr);
+	drm_dp_update_payload_part2(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.27.0

