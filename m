Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C643F03DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhHRMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhHRMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:41:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B76C061764;
        Wed, 18 Aug 2021 05:41:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1689471wml.3;
        Wed, 18 Aug 2021 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PolFHl4BCa4E4HG380dOZoCiWwe/gYoL591bvSVGBo=;
        b=c1GxZdd+2+kkeJZ4syYgj51Zg98RTZjLY/Z4IwPBEdIzTt49XtuWKeCb1bcCrVU4oN
         Izk9NWmOwP7kkaXp/2Mn53YkQfR/7fHJVcp92ZTDesjLkyO/DRCwZPWJ/yByOLYJPR1+
         zm3svX0pIC64LD+lGZ/dry6ECz8aimrYj58KwAVIIrG/NcA68jPJnvyNefOs93CZBhJV
         XRtCybrx9SAedtP7wZC98ZPPZw/S3G7fWok4s3NPfPyIVxnVtcL1R8XkAMXU6YiC+k1r
         Cng2mo0cabsYhxGtZHOCTmTKdD8C4WsukMjHHdCZOaziFfCFM3uJVRmet9G6TQB/MB6H
         FsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PolFHl4BCa4E4HG380dOZoCiWwe/gYoL591bvSVGBo=;
        b=R3KbCJPeyfvtQ4dHnKg1jKWtItNs9bF7tReh4zg3caayguS7TtnxQSbATobaWz8rNQ
         /AyA4UZTVzJ+ZKWqKChzO8sLtS755mQOxrfsqzMqIldR5CWSGfdWz40edmwPHnVzhTXr
         fqTnV9wKbTYFN8l5QtKRMHCA0rS4aD3kP9cH+LL9QrlTg16cBK8+4dXytruER4OUDpsp
         DSlZe0uIYVwWpe6fCPJIMIN7CujTAU2G8x0bQPRcPuwFwJ/LtM5iXHzSxf6p/B1inJU/
         lUbjAEM1daJSA8deaiVLMS4c1sdsFBpTguFNpQrQH/BS3tBeXkslPOSP2BQaFCbTOXz3
         +PBg==
X-Gm-Message-State: AOAM532BcBmH30rloBNs5V+xK4WoiOt2Uecu1dhael7pYRqUZcVrmwyV
        YZJ29mlz17m8FTzWVmvufOY=
X-Google-Smtp-Source: ABdhPJyQ1VzwCaTRFpydCdrpCWhltvqmLieDWRpbd4w6l19jVmVkcZ/Q2gsXj0wLcwh21T24m+Fr8A==
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr8462745wmd.1.1629290481835;
        Wed, 18 Aug 2021 05:41:21 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id a11sm5720454wrq.6.2021.08.18.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:41:21 -0700 (PDT)
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/5] drm: amdgpu: remove obsolete reference to config CHASH
Date:   Wed, 18 Aug 2021 14:41:11 +0200
Message-Id: <20210818124114.28545-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
References: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
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

