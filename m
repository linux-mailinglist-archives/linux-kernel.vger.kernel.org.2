Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7A3F1828
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbhHSLYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbhHSLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:23:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8CCC061764;
        Thu, 19 Aug 2021 04:23:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so8496339wro.12;
        Thu, 19 Aug 2021 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REhMgVT+6ZjXEXXRs/yP5w88X232Fgpi2cGGVzDaXxE=;
        b=FCtD7ltyWf3bpyNg5ZfOHC5FxFeGOP5a3gpqgR0ke4i/yDDEUenPouhSHdH9vqfOPN
         fhMIWL0W1o2h5w6n5EDUmO5hY0UXJiiAzrZK7aX4ZZGoWvWC6w7pW1vbY8KXLWkBwqLu
         HVE886JOmbB2Nl5cZRu6CP2iH11GrlP4H0UcGUTF0SRG/Xj7rfuLNHG1Q75qdF2iElT/
         c0+0X3K8YO3lhntVsRzhLiFCw0q/kwD22JneBZYLuO3VeF2UJI5Fm2hKQp6GqgZ1uyHl
         kQ7bM/IduESIr4fb5Rka8A1YUiOZ70ediQ5Sc3HBUL4DeNygbVWLh80qQMmvXEswoDdk
         0hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REhMgVT+6ZjXEXXRs/yP5w88X232Fgpi2cGGVzDaXxE=;
        b=j9360DyBL+FEI46yn6xnqFDcNFcTJwkxvG53FdYoqKwPJ210rXDH9Zl9VyWjwL54Sv
         FuO5E8+kyt2F2ooLwz8ToapotQs6ubgTiopAo1R1GFaRU0nZd6w6inALSAB2CZ/0QOAV
         nxYSaVg5VQDQrKNtLAIV6RrvtXX10QxgK6COf0bJB97Bwynh8depQVSdsBTopTyrLn8F
         T9L9oOEc7fexdsb51MeK8CdTxo0F5D5mYhtEDf5uTFqJt+1bBjPUmC8StrZOZvV9LJY+
         uJ8Q0aBIBF98xGB++rRZelq+YYO37+6iNWikVa5lysBu7/TZ8uAx1Mx0sIW2IENLfnV+
         kzJg==
X-Gm-Message-State: AOAM532OEofZ69wY/riu1sRwPO8mK8ELMJlMJqmlGKHAsAoGZPm81u5M
        BfiDtidNsL9fn0U7eM61G5c=
X-Google-Smtp-Source: ABdhPJyaHdxhTqOlTcWI8sTuvcompSykYd56hFn/HeiPFc2a40cOfBUyvMjZRb5YBRBK/Z0BCwYQcg==
X-Received: by 2002:a5d:6b92:: with SMTP id n18mr3277419wrx.343.1629372186181;
        Thu, 19 Aug 2021 04:23:06 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id r1sm2700388wrt.24.2021.08.19.04.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:23:05 -0700 (PDT)
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
Subject: [PATCH v2 3/5] drm: v3d: correct reference to config ARCH_BRCMSTB
Date:   Thu, 19 Aug 2021 13:22:51 +0200
Message-Id: <20210819112253.16484-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
References: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
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

