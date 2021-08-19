Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D573F1826
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhHSLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbhHSLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:23:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8AC061757;
        Thu, 19 Aug 2021 04:23:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f5so8494496wrm.13;
        Thu, 19 Aug 2021 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PolFHl4BCa4E4HG380dOZoCiWwe/gYoL591bvSVGBo=;
        b=MUGcj75NEruHQKoBHz6y3OzpZz+BnR4yeHn9iw9hVQF+5QKA22Ax4jGzhSCjKWQZmU
         JCqJWdm0fJ1TpTcsxzq8ODuzKQfBnu4bjP5VmU3wQ0+eY3+s8Kmhl1Fnh/ybmxE9WZv6
         yRvy5pqgh+gByvZQAlcEpBSmos89dHhWFWuShAAk+8V5QBLUuMfBwhqFVYsRa4V5bKoG
         eW1bqhoTLvLFhqlUQqaevytmmneBtdL22N380k2YWHP2/zgPp4TefhOOYuSaYS7AM33H
         4FZ6Q+8xREiYgbE1O6W2ClldA55GyAq+ar2DZDLfmNjrbPFdjPhQiCln5P96FwMxLyKm
         Q7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PolFHl4BCa4E4HG380dOZoCiWwe/gYoL591bvSVGBo=;
        b=sRPHxCkVYvvn7HIEm+6bDBhuyatcAuKFMl5q8jUC8evMhu4+MDRQ59y/DuwwkW1z6l
         FyQiphNEOC/puVWh3GNXwFUksOvloBomre3bCHm3cjzrU8TfRZwxt8weq/L5fqDBtCWf
         cEzXxABpiSF7uTACutOW2ovaPJBpM4qI6fBA26b/DhDNMoPPdDUdd9IcSdMLJOJ/poMz
         sKLKdIpbmYPLhnNPyeG3OfkAictCACDBzhtSfuWn6uGpS01unozvBdVgGiqi7/yteCvt
         nIMUR4PlE12jEgiQC8Kw5ZlBST+33Z6VJt3LKrFJktg1O5EpWSB++VpAun/9t0jjgTtL
         gTTg==
X-Gm-Message-State: AOAM533Dnidcz1LegBMmul1PpsuWJRdLmA5UXE/jQ95z+eIvTBlYctI3
        9XXPSGtvfxBNBdiKLnc4vx0=
X-Google-Smtp-Source: ABdhPJz8CDAX5l4BP2wfFbZ6AML0Lin/n32NRpAJOPfTlU/1JgLGC2q8ibTlyRKz9oat+Y1Iv8DnGQ==
X-Received: by 2002:adf:f288:: with SMTP id k8mr3162716wro.350.1629372184426;
        Thu, 19 Aug 2021 04:23:04 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id r1sm2700388wrt.24.2021.08.19.04.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:23:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 2/5] drm: amdgpu: remove obsolete reference to config CHASH
Date:   Thu, 19 Aug 2021 13:22:50 +0200
Message-Id: <20210819112253.16484-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
References: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 04ed8459f334 ("drm/amdgpu: remove chash") removes the chash
architecture and its corresponding config CHASH.

There is still a reference to CHASH in the config DRM_AMDGPU in
./drivers/gpu/drm/Kconfig.

Remove this obsolete reference to config CHASH.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f3bc90baca61..8fc40317f2b7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -257,7 +257,6 @@ config DRM_AMDGPU
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select INTERVAL_TREE
-	select CHASH
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
 
-- 
2.26.2

