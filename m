Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E220363D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhDSISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:18:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50486 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDSISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:18:42 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYP6i-0007yv-Pu
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 08:18:12 +0000
Received: by mail-ej1-f71.google.com with SMTP id bx15-20020a170906a1cfb029037415131f28so3380383ejb.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZdoK9AnFm+X6XIXiCrNrIs4gAmD/r+wn1T8dtom1To=;
        b=cV6Q/qLsOyTTFSfVUEna58zsQ3Z51Yz+nXZZe1zwxg0R/a6odiiOncXwlAd9eO0kOp
         Zu3FbHzyllQ1iuds36ciHFBQVqbol+/qCajAjFy/HwZadM9zshgAW1aT43r8wejVliit
         h6AtVNgw5BHE1yIl6TZudSF53ezLydk1iCxbpR4U/zOFmAK3k6MOrLkG33+C+89l97Hy
         E4ipdTTGZt8hIsSW/IGdkLHQ/F5ZboIVJ5mivCQi7FGCr3YU61bBVCf9q/u3Awql6+0G
         fUwMkZewiPDtjAOjbJsnCNe7FBQvjlvIdlrWTpMCsZFxAoI2k8KMDVwDInOrYhi7OSxC
         fUOA==
X-Gm-Message-State: AOAM532vjkvMERwEt30wRsVaOL24p79H+9wcmZNLH/JzHS7jzU0p/KqO
        lMpQ9pCnbpbaovYzzkclHd1b5zkjiqsVF5fuldd5JQvCFcgpv/bsokBnZmPGULmg9mTpnX2AEoq
        cYZDXbqZ74MvXb8uk0SXzJIlGXvlYkE2L0MNFbWj/hA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr23996823edv.44.1618820292208;
        Mon, 19 Apr 2021 01:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKM9EgTFnfB1iGFoLTEYoEK90BtoYW0DSj8m9Xd9XtAHIt9z9ELEjhNtx3pNycDFhIF7NUYA==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr23996809edv.44.1618820292058;
        Mon, 19 Apr 2021 01:18:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id u1sm12093563edv.90.2021.04.19.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:18:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] drm/gma500: correct kerneldoc
Date:   Mon, 19 Apr 2021 10:18:06 +0200
Message-Id: <20210419081807.68000-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc (remove wrong /** marker and adjust function name) to
fix W=1 warnings:

  drivers/gpu/drm/gma500/cdv_intel_lvds.c:27: warning:
    expecting prototype for LVDS I2C backlight control macros(). Prototype was for BRIGHTNESS_MAX_LEVEL() instead

  drivers/gpu/drm/gma500/intel_gmbus.c:386: warning:
    expecting prototype for intel_gmbus_setup(). Prototype was for gma_intel_setup_gmbus() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c | 2 +-
 drivers/gpu/drm/gma500/intel_gmbus.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 5bff7d9e3aa6..8a2219fcf9b4 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -21,7 +21,7 @@
 #include "psb_intel_drv.h"
 #include "psb_intel_reg.h"
 
-/**
+/*
  * LVDS I2C backlight control macros
  */
 #define BRIGHTNESS_MAX_LEVEL 100
diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index eb0924473a21..c17cbafa468a 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -379,7 +379,7 @@ static const struct i2c_algorithm gmbus_algorithm = {
 };
 
 /**
- * intel_gmbus_setup - instantiate all Intel i2c GMBuses
+ * gma_intel_setup_gmbus() - instantiate all Intel i2c GMBuses
  * @dev: DRM device
  */
 int gma_intel_setup_gmbus(struct drm_device *dev)
-- 
2.25.1

