Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3203622C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbhDPOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbhDPOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x12so21711988ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=GNUjqZlY8Kl2oKWTYfDjRC6Bi0UwDOz5BY+3/90ITbTGw1I5bVp5jcRfIVnye3m01c
         kKgj+r7sRHsEVxsKvDb1rkMcG6VBXc7OO77OIzsm5gp6Tm5o2Ybm95bSPsNPZHfVhXm9
         cMNMakfEsGZetcMqpCCdCzyDW91IA/O39zSCluuZUY5k498jh2pjpHV1w6P/+/E05xDJ
         vEFCCgkpnKlrVRJZn78PRl0WH8z/MbKrGlQ8td805dEL6CrmR7l82UEHNh/D+wF1JAp6
         B6MQRW5C+hwPkYHtufL76OL6mw+Y0HEzW36Zhww+tOhU6Gdrdkg7YAzWeTMT9Sa6fCvO
         McHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=PHAmIFL1FGBIsJd0/8/ilBFIJD1CikVY1kE8h1yROV12YEgDLixWiAMXxXeB4WFWyn
         FqpVumHLnEAPrhFemXXY5I2+whNCOqPIJLUTJ0QXJfgjWYIs/J6Cw9EVKoJEtqcHhrPc
         UVzMBxr5f/aTe0k5IlUyNpocl7BMflEiAeYFTEzT+/FuH4LAGIvQXMt9+KX72AL1bBCe
         KbXf8+a0W9QBPWn/TpmTcVmpBqMVk0gI2gSq2l6a7Q5v5Y8vwRmolmIZoOO9OEA4hdFu
         1swaSkKsRuECs9voQOjSbrTDR+A4DZt3L4Fu2IXfl+dMBivs2jaVQ2LPUeZJsfc06SaH
         r4Fw==
X-Gm-Message-State: AOAM532dAEjra3IGq5cMVE7FYxMT8y2KUweaGzdih9AXEHy3lvcXYBvm
        mRTtEDvUXILZZCUiqSRQDwyxTg==
X-Google-Smtp-Source: ABdhPJzeAdNjaV86qp+Bo4JoUnmQHDmeRr10sFXjgLzJyl2WD/wK74u47FQmEv5jItHf1QrjTc45SA==
X-Received: by 2002:a17:906:cb1:: with SMTP id k17mr8539035ejh.307.1618583855594;
        Fri, 16 Apr 2021 07:37:35 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 05/40] drm/nouveau/nvkm/subdev/volt/gk20a: Demote non-conformant kernel-doc headers
Date:   Fri, 16 Apr 2021 15:36:50 +0100
Message-Id: <20210416143725.2769053-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:53: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'speedo' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'temp' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 's_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 't_scale' not described in 'gk20a_volt_get_cvb_t_voltage'
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:69: warning: Function parameter or member 'coef' not described in 'gk20a_volt_get_cvb_t_voltage'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
index 8c2faa9645111..ccac88da88648 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
@@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] = {
 	/* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
 };
 
-/**
+/*
  * cvb_mv = ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
  */
 static inline int
@@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, const struct cvb_coef *coef)
 	return mv;
 }
 
-/**
+/*
  * cvb_t_mv =
  * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
  * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
-- 
2.27.0

