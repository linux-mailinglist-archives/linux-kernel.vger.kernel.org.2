Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AC3F03D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhHRMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhHRMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:41:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57417C061764;
        Wed, 18 Aug 2021 05:41:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f13-20020a1c6a0d000000b002e6fd0b0b3fso2669043wmc.3;
        Wed, 18 Aug 2021 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKHb4NbS7zSt/cAMTh5zeYF+NOqO7vbF0bCJdamG5w8=;
        b=ja/16Vr9ki6o1rA6ri6QHlVCzMftWzn+OYFQapVIpbv257k3j7V/fjkHafTOT0nGvf
         i6LABOswPGff+2sGLiMXYL+ApmjSBkeyENpajzTX60EcQBA+92QWzWvYnt8rwSuZLWmy
         qCZTc2tlCyn8x9qxTf9znRysZ0LpPAHS/wzxql08x5bEGnbAfvBq6lnIkD8LcmpQntez
         nlzC2m9JvqCuRiVd4RB3t689UDLbFPGMEZfwOJ4Q8sTmducPGwC8J2yE2c9zUT6YFxc1
         xyzoEacrxeRt2pKRV+58wzHQKK0wJkivPxWsrpGWZ7AH0CGbvpavv6t2LADyXhHzX9WQ
         8UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKHb4NbS7zSt/cAMTh5zeYF+NOqO7vbF0bCJdamG5w8=;
        b=A3yyX6/EQFeAtCt0Kh4Rwk0L/Woi8RKry5qLcMLVh2IlUKF73BzF60TcfpETkOtOwk
         CcH0jn3ikSAACelJlKhDmj9YRgkVx5HVX8f5Iweob35iJgXlhGYVYXyMV16+VErg5Ez4
         V4RtBn57zUKuE6q8PzqNJ8LXWZHRWETU83h1ylrHKjbA7FEN1b40302t+JIKMZNgfDrE
         BPb738ImIr1TfWsifh6OhItu4ACq52uFIQYqRZ3HT7S59WDXREKJ6eIGVxNx+y8gQ0W/
         x5kdlhkKANq/Ass1hJSQ/GjraUjxsXn7TL4NxriwGqVQumtJyMdwaPJFPqq0hkHUneLz
         Ouvw==
X-Gm-Message-State: AOAM5300z/ATYXr2wbSx5w1e3i+u34/j3k3O3WSZ+ukWTrw5yv8g1uv9
        Ks0UbQGDZIWaOGs5CC1n3oE=
X-Google-Smtp-Source: ABdhPJw7gq+uZcEL/myC5985B59dRsdZKI1OrUOlw2agxfZ4Cwb3rYGc90xQ/81U/eABQrJtLqfQFg==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr8334657wma.8.1629290478949;
        Wed, 18 Aug 2021 05:41:18 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id a11sm5720454wrq.6.2021.08.18.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:41:18 -0700 (PDT)
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
Subject: [PATCH 1/5] drm: rockchip: remove reference to non-existing config DRM_RGB
Date:   Wed, 18 Aug 2021 14:41:10 +0200
Message-Id: <20210818124114.28545-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
References: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1f0f01515172 ("drm/rockchip: Add support for Rockchip Soc RGB
output interface") accidently adds to select the non-existing config
DRM_RGB in ./drivers/gpu/drm/rockchip/Kconfig.

Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:

DRM_RGB
Referencing files: drivers/gpu/drm/rockchip/Kconfig

So, remove the reference to the non-existing config DRM_RGB.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 558f1b58bd69..9f1ecefc3933 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -9,7 +9,6 @@ config DRM_ROCKCHIP
 	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
 	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
 	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
-	select DRM_RGB if ROCKCHIP_RGB
 	select GENERIC_PHY if ROCKCHIP_DW_MIPI_DSI
 	select GENERIC_PHY_MIPI_DPHY if ROCKCHIP_DW_MIPI_DSI
 	select SND_SOC_HDMI_CODEC if ROCKCHIP_CDN_DP && SND_SOC
-- 
2.26.2

