Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165EC3F03DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHRMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhHRMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:42:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED34C061764;
        Wed, 18 Aug 2021 05:41:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so3461936wms.1;
        Wed, 18 Aug 2021 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REhMgVT+6ZjXEXXRs/yP5w88X232Fgpi2cGGVzDaXxE=;
        b=AdNRdIv77OE3YAdMkK2k6amx6PN8Ganr5o8QZM+19FIK6391iIU8yVSNCBUdp527hp
         4iGc0rBpFLJg8fw+C62V7NW1pxlL7O4a3r0TEqppoBxEPD4Pu5Z6ytnAGbol2UnsI/Wr
         vS5q54Zp69IB/88rn0zq8NOTbDUmFN1ns0oe5daUrJXIpKc0qDWOjrq+xCytz3le/3eX
         tiSOZRWS0maQC6YR/CfoWE1ytIJ2nnpsv/faO4q9BzpzeZ1wjTPdkwZB4Amj5Akc6r4O
         u5EpOe5I2ibte9oHuOPMCLKZ1+WBpDBGszOhkO/5x4yr2EJi6repnf0SjYsRMQI6tHuJ
         AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REhMgVT+6ZjXEXXRs/yP5w88X232Fgpi2cGGVzDaXxE=;
        b=kYHzZf5qGALTWGv0xwvTR7B0HoY78PSIIKCliRcyBBH0mUURqr2M/OWQNu/UWK281R
         Kwc8HSaW5IQR1s5csOPNHbU36Yy8QzI76E3cn+rZlX2hRyqQwsHx73JGwkS1CrlZH6MQ
         qd90d6zRySrUeM1B0G1ibFZmr+Nx2Zbqt2Dka9JXOvmyq1TxfnDAonE5D+QQMB2/HaZt
         Lse61W8PE+A5SrAuIcsnb8Mv9bqsD5jWshJSq0nCXy4CAS0QcEdVsv0DRwcEgZt2LVG7
         Z3fIbn/kye5YdSMdmLNAd4WF4Hb+vtkP82P8FDyetpIm5w3VxTSIz47iwi1GrnZdR8ga
         ZRlQ==
X-Gm-Message-State: AOAM531MXdikv3rdyAqec0vbk2sTRnG5BFuh9rQ3azspIUkm6MY8wWTw
        IQu+h35zggPm65s2r2xyewY=
X-Google-Smtp-Source: ABdhPJyLjuqtTOZTR24aWisJ8tiRhVF/w2xm59RHeKTRwyZmJd/LAAzH/sJIPkjeU3aMqeJSdVDmGQ==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr8099425wml.124.1629290486739;
        Wed, 18 Aug 2021 05:41:26 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id a11sm5720454wrq.6.2021.08.18.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:41:26 -0700 (PDT)
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
Subject: [PATCH 3/5] drm: v3d: correct reference to config ARCH_BRCMSTB
Date:   Wed, 18 Aug 2021 14:41:12 +0200
Message-Id: <20210818124114.28545-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
References: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D
V3.x+") adds the config DRM_V3D, which depends on "ARCH_BCMSTB".

Although, a bit confusing: all Broadcom architectures in
./arch/arm/mach-bcm/Kconfig have the prefix "ARCH_BCM", except for
ARCH_BRCMSTB, i.e., the config for Broadcom BCM7XXX based boards.

So, correct the reference ARCH_BCMSTB to the intended ARCH_BRCMSTB.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/v3d/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
index 9a5c44606337..e973ec487484 100644
--- a/drivers/gpu/drm/v3d/Kconfig
+++ b/drivers/gpu/drm/v3d/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_V3D
 	tristate "Broadcom V3D 3.x and newer"
-	depends on ARCH_BCM || ARCH_BCMSTB || COMPILE_TEST
+	depends on ARCH_BCM || ARCH_BRCMSTB || COMPILE_TEST
 	depends on DRM
 	depends on COMMON_CLK
 	depends on MMU
-- 
2.26.2

