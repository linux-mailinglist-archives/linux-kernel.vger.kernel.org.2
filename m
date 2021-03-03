Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E054932BE56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385590AbhCCRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349314AbhCCNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D42C061356
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w7so5210295wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtDwwCGh7BV2jdAMFgyU0jxW3SadS1NJKEYSwbpKHII=;
        b=sRgB8t25PZ10NkKal1+Peihtxu3GBrpIEwtbkDw27UzpVFQ3vx8N1Mf2WTQ7ghbjVQ
         Xl76lwrOvw1fNHzen5mLV36KjI+ddlwXHlxOFhD0iqCJg9U/mdhCaSpzgc5ppVg7T+kA
         tAcDT+por1yZTddeRmmq1oEn72Qig/It4dAOaIhLvuW4PJFhrOa8jzeYlneKPloH7vKQ
         8EMprRzfE6UxTKOqziJbd+JBDsTyYgkr0ZdR7nvsGLCtsQTIBRql7VF76lFxSiwe6A0y
         Gociy9qIFajV/I1guI1glaRMFdlcm1bOgG2ONLUZ9H8DB4KHNtljK5w8/L5xkCFNKA2U
         hChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtDwwCGh7BV2jdAMFgyU0jxW3SadS1NJKEYSwbpKHII=;
        b=nJ/8osQXnnlbN2qU6E4VHZlRbVlfc9tJq5LrmFeNSkyRkp15C/qk6B3OIV/QLXb+W1
         O8QwRoH4ysCgIIVzW59bpTnraUF/5OXBCLy0NgRN2zkF7lOHa25rP5MnkRXhhsC1Bpz/
         uhjCQSHkGK1VF4dkNwSrth5jILGm1Rydf/NZjb2PSesgbbYC+ZYokJZp+KWLQJxtID/A
         9CnHZWcuOZkq9Z+sVaq1R9dbdmzKfXGmu/eEyNvxhJ+Hk0DWJvaDgKCm6x5z+Fs86SpH
         6yziJ/7JF031a51NwoSVuOpCQYT57Ovyz91C8c9M/rBSqB0snlXFoOABjVH4SXSH2jxO
         fbTQ==
X-Gm-Message-State: AOAM530AaYudWesqwbuPXd8NdW9RPwf/3pxV2nbZtlumOWC0m8ks8Z03
        r41RDDUG7v3WndWcS1wlTXDmpA==
X-Google-Smtp-Source: ABdhPJzkSWfUf5AtDHRBf8M7UDr5+MfhzhlBIZuFec+xGndDdtkpKDFTGPC1IOEXNzz1Uowj2875Lg==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr9078519wma.167.1614779011028;
        Wed, 03 Mar 2021 05:43:31 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 02/53] drm/nouveau/dispnv50/disp: Remove unused variable 'ret'
Date:   Wed,  3 Mar 2021 13:42:28 +0000
Message-Id: <20210303134319.3160762-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/nouveau/dispnv50/disp.c:1381:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 196612addfd61..c51efca82ac78 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1410,10 +1410,9 @@ nv50_mstm_prepare(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm prepare\n", mstm->outp->base.base.name);
-	ret = drm_dp_update_payload_part1(&mstm->mgr);
+	drm_dp_update_payload_part1(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.27.0

