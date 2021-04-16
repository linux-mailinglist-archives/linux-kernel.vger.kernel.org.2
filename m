Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5F3622BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbhDPOiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbhDPOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:37:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EADC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so42445130ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EV1/WI0XFtiI+21vP83s/uEYxGv7mm0ay0nKpA5C64=;
        b=rAeQAepkPGd8RRBrjx7A0S/HNVWkMJN3LZ/HO3Uq44xiLqTZo99xBiIHSI8h8smrSk
         D3mN1W8ok0u9i/hZqpr9qPfK+TWzr+JKdNXL11/7hckcjzWm2CD0pF2PkHCIuMuVwHZl
         ry3u1F55TjgPmXuMC9/hAuIhzbRcI8iIBBP8OXP2o69Jd8OLahC9JXoKetjacP4mVMz1
         qKKosfQYMv2DmgONKYJuqQcIyQbG8jg5gsLFkyG6nF9W68YlSe1cSyyZKQBYGf/ecePU
         RO/CIZBwdMAwcBcO1pvVKhUKVHGHAwO4ilcjB0Cz56Sp2Plru6Xux8BWWlwHvlI/y3/s
         WuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EV1/WI0XFtiI+21vP83s/uEYxGv7mm0ay0nKpA5C64=;
        b=fOM3wLodiIadDzlYTfZvRi1OyWo1KJxqg7CzTJXJAFnwOF6uBA8s10iBZSrf9mNzzA
         dbzQKFDorNswYTIjAgMBawMutgh7a5CSSplWvUJ5UXgzw8LD+RnSkhCbKtpwSBfXgr/x
         PdxfAGTYhZwNIhIN4Ldw7JaQoKVx6AjN/NO1pKn+aaOiSQtKLQUaAXrONjBO2BL9QH8b
         R8tpOIQoAf/On3pAmTUaRTYso2FT9vePX90FX4EbDUbjn2eX3RBx4ZuzIHorBYCVgyYD
         V0yEpiFxuZYhVqms7iBnavusMLFespyrFzG/IGoHdTQzLT4f5BROtmQhVnaQVItqykqf
         +lUg==
X-Gm-Message-State: AOAM530rzYMiH9mkUz6jHxUCSpRbxOmsPClApNTJOKCQTfszhnE9dUpz
        ThDGLfEaJikeGSIOj/uzwDY+TLUWzN2PEw==
X-Google-Smtp-Source: ABdhPJwB92Bysnaf6kcMoQ5pu+E9BrfDp1ehXDbDO0zVh0cfFbH0Cvf/Q1ZdxIV9Fo1L3lY/2BG9bg==
X-Received: by 2002:a17:906:704a:: with SMTP id r10mr8736436ejj.312.1618583852460;
        Fri, 16 Apr 2021 07:37:32 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 02/40] drm/nouveau/dispnv50/disp: Remove unused variable 'ret'
Date:   Fri, 16 Apr 2021 15:36:47 +0100
Message-Id: <20210416143725.2769053-3-lee.jones@linaro.org>
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
index 1c9c0cdf85dbc..4801aafd9552b 100644
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

