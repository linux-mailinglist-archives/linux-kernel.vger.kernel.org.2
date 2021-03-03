Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4832BE65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385673AbhCCRVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355334AbhCCNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE0C061222
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h98so23716209wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=N3q181yJisryPIByDaizfjLwDLbgVp2sSUSlV1VTGiJIerqGb19KH2SBPvAKguZifR
         I/iBsFNFweL2WQUEyLnk4hzJijHleRbyOOxWWFxboGtV6plw4vkLLVhRVDF0qymFFDqh
         w8gomQnPFF0fUFn87WrNRwqG9HWCghz9iplUle3MXnVjy2mHL6Y3m3Ae4i+B2jY23gZp
         zpMdZFt4R3rikBkgzyz/bOQklHbTOzqFE8FKqLCfx6LT7FdVi9UQS0PBAAmWEXMQr+cv
         hdTuBN3aQssflEmx5QR+Wmnna7UAkSRvdCRqviYtZRMjwHvmJrflxvVf/+lNtZxIyDrY
         ZlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5sJeJ74F8ymxQq/7xf9FhHZmcrAt5y0yMPNHooyiic=;
        b=fK3zS45kvXzsWagnQHuBhcD43T5DXsECUg3ndbZsKy6YFKkYb9/rquWJPvW8r0Ca26
         Kcux0ozotcXj3Z3m+Jl4gn+MhqG49zRVM7YPRzwBEFwB9V+50gKn5cxg00Iz37UgXq/l
         C/Nv7o8KCOqrNg6mt5KmoSGzl50kU70xLWZnVBECtus1JrA7REfnHNTpzG6aTQOIe+/V
         G/JttENOa9xJNg1pwIdaed05j3dzeR/j8FAWgG6GysjXexbgZ/tLbVGqxvpEb5yl00tV
         NoHjcUe92h4uVUKgMbonMxwPohaqKBh0IlkFRKN3Atg4VgFrGAZ2JkSS10+++T0fu17N
         WfJA==
X-Gm-Message-State: AOAM531+mfrvuVdSeCvC+3yeqDFec+1o18c/GmSDm9R7GiDRZEfDlkaf
        0zL4/lEnyYAwn/CXTQNcGGZCDw==
X-Google-Smtp-Source: ABdhPJwi4JvCkBousamcRU/iub7Snug2xhsNyhh47wRAiEEVp0mD51d0zPloNpxfNF3p6PXkuyD4wg==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr22817085wrp.106.1614779015699;
        Wed, 03 Mar 2021 05:43:35 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 06/53] drm/nouveau/nvkm/subdev/volt/gk20a: Demote non-conformant kernel-doc headers
Date:   Wed,  3 Mar 2021 13:42:32 +0000
Message-Id: <20210303134319.3160762-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

