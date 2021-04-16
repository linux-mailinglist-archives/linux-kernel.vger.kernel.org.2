Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F653622D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbhDPOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbhDPOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so42485358ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQnjaWEPVzF4Yj7Y7yqsosTBBDqQ/sZsDTFNe0Jq4bY=;
        b=oCLqBdEQeBIV+juKLGkSxgdhLcddfY7D8sZ1UyNCHuX3TKd9mpvKturRJKN2Mm9fFv
         irFEttwHBDbPhPdY8WEnT4moT8TqjkIQEkFPxf22w1UWuDAOI/N1Bpr5xyxbVG0fcsL6
         AxKJ6N4GEy4y1At9rrYNSqhTlk+mGf8xzTF69Zq5oAQ47yrA2WAWMRi/BX5tYPTymdUG
         1Vd5sLlAqH6/Se7ns0lMw2T9D49Rb5jrGMeSp+d79DgGUtzVarzLgui+oAsjDsQQ3FwB
         82YFkN6ATYSWeClc7Q1q5NhEMvipeY65LTqc8KucrM6wg4ApzEjVyHp2uRBSEurLtcAn
         prPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQnjaWEPVzF4Yj7Y7yqsosTBBDqQ/sZsDTFNe0Jq4bY=;
        b=A2l3PitOsWHBHCzlaEsMVPFNg2Z90FyjInT9FZ9Q2+YvUe7E8jmJz0bIm10rShNXNT
         IGuZfqQ7WYovdyGG7BfChzKCaRsqTBWVqcZIY58U+PfohOcmqHpkV7XSW24Sxolhh1UD
         WnwgubwVx42uMTYMbLMMxES1XJvFlKIiUqQFqIKL1PT65WzcPlj2quWxhFg4lDzZNf4X
         BOk2wUCDxuxIlHpix8tzeQ/xhEZnI1wOsjn2Nmv9gIhkCjMrHSrp+IigdcDEr0n0Iliy
         0ish/0Fnv+83dvqlLoYe9fl2/SNjMCbx7jaoaRGbGflpkgxz2jAboWSOOTh9BuIW9rG9
         3o8w==
X-Gm-Message-State: AOAM533OLn14i+c+JAtb8HYlHXbxnTpYhRY8E94tP/X/L7LOFnbqRuhL
        8K3eNvDkp6Yviz9IOGmAe5ruXQ==
X-Google-Smtp-Source: ABdhPJxMuk1XJYwPNBTE/v3zFRwznAbi2YrRsmAVDjmKQaPrnHCPXntm0SNkuI02TuiJBEhazicSOA==
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr8119075ejm.130.1618583861433;
        Fri, 16 Apr 2021 07:37:41 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 10/40] drm/nouveau/dispnv50/disp: Remove unused variable 'ret' from function returning void
Date:   Fri, 16 Apr 2021 15:36:55 +0100
Message-Id: <20210416143725.2769053-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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
index 4801aafd9552b..351f954989530 100644
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

