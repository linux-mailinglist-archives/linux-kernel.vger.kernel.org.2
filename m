Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8C239ACF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFCVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:37:07 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34714 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFCVhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:37:06 -0400
Received: by mail-pl1-f181.google.com with SMTP id u9so3508585plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v69IgdsCsz5jimImcAi+uYt7NyzzrYQV4j0d1x35Qb4=;
        b=j57ZIddYXmGmwLkqtQ9Tr1A+7q44vtjezSJ3lNJG28oH229LuWK8nHz4+dVGFE6gfF
         LfW9Bd2mW/4TWU6gkLYp0SdH2B2RIXspgMTyYRocLDZvefVjXR32M3XGl1UKHdIKoRhK
         2wpGSTeqhNcXekmizuoUKkgt2Dq9yFeLGj1yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v69IgdsCsz5jimImcAi+uYt7NyzzrYQV4j0d1x35Qb4=;
        b=c+HbSFsQkMKt9UBQFWXBsZemnkm9UOfzriC6NuXNXYB/Aa9EWhF7CaGlmVLJ+DDBML
         XGtSJUuo246d/mQHbVK7URemP2ruNcfCwAUc2FnZZwMBq6oxEhFZkQeOO0MdyzgGrl+B
         KxbxGziT4g+Bwq/xRGKegaougumo62FUD0mR7XNKXb6RdkKMpxb73KL+1aSU5ft7pWcR
         YmovbcYaqc6CLEwan2Ui/ejptP++RTl0q+qfrmMqYQSCfYvcJkuuDtz5wOwoD87t6Bg/
         vkSKZUJGYIuTidft18z39PjCB4b+IyTdfvCmycMDdI9j3MStVQ8tzoQ2oYZZok+rgWJa
         kFrA==
X-Gm-Message-State: AOAM531ihwjdkmgRLH6oeTGC3NtjX0P7yxAf4xI8WD4PyyTKmgiSC4S8
        XZOpdSSe1KrYxyoBISAqbcYoyQ==
X-Google-Smtp-Source: ABdhPJxm3z6rl3LYpawQ1DMY11WlwMDFoHOpcLj1ncYiepIEqdQ8bfZyEKGIcP88QEmlEO5kmbR8qA==
X-Received: by 2002:a17:90a:16c2:: with SMTP id y2mr1288913pje.236.1622756055797;
        Thu, 03 Jun 2021 14:34:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w27sm31153pfq.117.2021.06.03.14.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:34:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh@kernel.org>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/pl111: Fix CONFIG_VEXPRESS_CONFIG depend
Date:   Thu,  3 Jun 2021 14:34:12 -0700
Message-Id: <20210603213412.3903724-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=e33cd5178dd1fb9ee613d19f11eaa8a3a6bf439b; i=JzCVqk4AxoptI1McgDI6xvfqqLZfjQGjP6zAZW/BX7U=; m=NnCY7lv5WU4H2RRYGez6H5ZSQQpm4Mnshp2N7en1Rto=; p=2rHhv7G5hVZmfAbXUOZZGK2mZ3ASktEg+2OlHMTQ0V8=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC5StQACgkQiXL039xtwCaQ4A//VkK 6m/frj+wBsE+WSZy5DUgyNCSP1GQQvnoak5D0m17047DU1n4VAK+BwQYgRZ50tC/UJHUImFcRLTdX u7du7tSizTOUD1EhUXEVQOIRLoRVIQRGM9gQ9Ssmt1Wc3EjkIMhw3uA2swJ791tKhpsfWLzQQLZ33 il8l6Gs1NkOJpxtq7rLQSZjzAMiW7MsAnXVRjY8tfBnH2ZO6Gjf4ZRpote/2jXhv0P3JFU9hWZYMH TiTrXzW8+spvpdxd1rrr/1NfQPMhUyZgz9vPDqHvZnyilGjNdGq2moML0HxRPfYWqDOPOACTp1iWC 4pWVvMpeSr9z5KMKp4RsyOd5QMhAr4pt87GOi8X3Fxwp9H5W9kVmFjvr8ho5sxc6ESMsxUA2IhZfa +hFgR7GXC7E8Wv4NdQaDJMkBbyH8IIjc9p/u7ruQ6KDDtsGOW2aqyD7baOvXS9ZSVx6Dps4no4VPP 1ZmZms9SS59qVR8MvrEiX+uzwUs8u35lGJhvArAwdQPUUU6EUMRjLFD3Sul58aYI14l98pW2+UPmR /wJOVAlOw7kiuc2Ta29oFEx8Sy0Ax+w9fJnneLawGgoogwSgtjufHcAm9bHaCpHLlQ7jnNDbkBaDw ZNHQ2l+xMRokhx2IJCibgYNuj49ClGRQMUOgQzZdUsmvNAwYXiPle7ysdApl+8Ms=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid randconfig build failures by requiring VEXPRESS_CONFIG either be
missing, built-in, or modular when pl111 is modular. Fixing this warning
when:

CONFIG_VEXPRESS_CONFIG=m
CONFIG_DRM_PL111=y

aarch64-linux-gnu-ld: drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_vexpress_clcd_init':
pl111_versatile.c:(.text+0x220): undefined reference to `devm_regmap_init_vexpress_config'

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202105300926.fX0MYySp-lkp@intel.com/
Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: avoid forcing VEXPRESS_CONFIG be enabled
v1: https://lore.kernel.org/lkml/20210602215252.695994-4-keescook@chromium.org
---
 drivers/gpu/drm/pl111/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
index 80f6748055e3..b84879ca430d 100644
--- a/drivers/gpu/drm/pl111/Kconfig
+++ b/drivers/gpu/drm/pl111/Kconfig
@@ -3,6 +3,7 @@ config DRM_PL111
 	tristate "DRM Support for PL111 CLCD Controller"
 	depends on DRM
 	depends on ARM || ARM64 || COMPILE_TEST
+	depends on !VEXPRESS_CONFIG || VEXPRESS_CONFIG=DRM
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
-- 
2.25.1

