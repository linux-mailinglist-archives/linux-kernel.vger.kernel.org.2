Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E1341772
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhCSIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhCSIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jy13so8256358ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D64SVMvmhdwuXpC8yQyBurTfGArjqR5f88yUwkGnjo=;
        b=ih+byn5SaHURLinLJy61nATTEUMe8vQzf+Wme4RNbiXwTCukEVwYWl9/LmLBd+gGPX
         BPV3gUINlkQOzYVHWsKkwSkuApoP6THu29KcuCPwPcErnWEkw2tbwQhW2kb963whlRR3
         /Glxz65+HP+jZ50lYrNkF54H+hWUEiiLgVmxiEu8qA7Oh/YrABFLd/en2VZNM7WD9mH4
         9noPJ30KTZDc9VlfmMCUVOp5v9grwMvx2bUOWxIWamPNPrPpKTD5ewqwy6Ch9HfJKX2J
         ZKtBbTVhHqxvIq0+cdw2sxsXWFpMcOCcZ2tcQ/j7eh3sxRxS2nt0K08u7zm6X/vgyYpK
         h9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D64SVMvmhdwuXpC8yQyBurTfGArjqR5f88yUwkGnjo=;
        b=TU4kFnuNisYzQ5a0oPXH0KMzG4ux8fqdS/DCsW/Yoo7Ijto2FZzbKZoybaosBGOgAf
         xYW0JS0mhSrvc7ocs0OWr8a4cDXJdu8Y90k9ldbwmQtWmRY1p8Azz635j1oJHRSH57fG
         1843sHNSU/6zrLKm9ZaJwGWKJQ11CzG3Zz09YSB5+N/DeFrfCLnTFgELt1AhjspiMWjJ
         Xj2Wg5g2gINwOIBVzbK19yPaoxxnBpb56pfkLF0uVHi8KkV2CNmx2mRXrXbIRKz2jDHU
         dcEPCnCsRFz7gC/yeUXEVXACfshhY6IOwgip6PbLUHSWM7fudwnsHD1uFz7T79YF7Og/
         /cmw==
X-Gm-Message-State: AOAM530dFhN7nRxaaG4/wWShusgOPuWUStvJGRoQztoAC7hrHjgvwJ92
        s2PlR8HPo9w07rOSXo+KOXASig==
X-Google-Smtp-Source: ABdhPJwBdmyDdjAgM3AbyrSm0+lZxfiSLPz6jfWiCHcbRtFoy2VbAFhzJc06XSjDVyDn/72ypUKr9Q==
X-Received: by 2002:a17:907:9870:: with SMTP id ko16mr2987441ejc.227.1616142284971;
        Fri, 19 Mar 2021 01:24:44 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 13/19] drm/nouveau/dispnv50/disp: Remove unused variable 'ret' from function returning void
Date:   Fri, 19 Mar 2021 08:24:22 +0000
Message-Id: <20210319082428.3294591-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
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

