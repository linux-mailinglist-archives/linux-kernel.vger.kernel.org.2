Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D33F1829
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhHSLYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbhHSLXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:23:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C1C0613D9;
        Thu, 19 Aug 2021 04:23:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z9so8513672wrh.10;
        Thu, 19 Aug 2021 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdAGUCyYQ4noYy9BmzZUbXym0YMYKVh78nm2c4sCaNo=;
        b=dh0h2hzZb2yroUpq/SL+knwkJ21CNnxU/3mS7j6DNE7Y2XImBRQOxf0N0hBLYWNCzT
         ffd8uBCBYXnuFu61ChDmzfYshuGB2BFxSbB0Y4M+JE/21wxCUsxQtSS9jBkeoj9xjwUy
         VXSZxmMRTuoqIUSOkDLjT/NqApdoMI5s7YXUgkR0HinZS5eRWOD1Dhva+0hy2miSuRf3
         gSjc62iWfD1MZMHgyw8T7V09Pd8V0M0QBAbog2hiDoxlTY0MqReCsnGHQT8YCo9UvHGc
         0Ej6DOcy0aewKCnzR085IyLr3xXNKkoKaWertz6jsUDOKnfcN+369p911UROvaIuIvyH
         5yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdAGUCyYQ4noYy9BmzZUbXym0YMYKVh78nm2c4sCaNo=;
        b=BhuujzQ52Ozpd8D9m2JWZexGx1uIL+wJufXw70YCeuD+i/pyuc5M+h/ekzYpbxV3Ke
         bW5rCc9zYnK9qRxsNvCcGK9JK9oN0v3W+YE1wHDBEu521xJWFG1ddCmhZxupoqs/jvJa
         c+GczYbT6rJ+OPree040/km6YBFaQtfgQU+W2zxjcGR9IgGv2oIvf93cBQ1uGgqNikeY
         SsKK+V5BgjFQW+iS/YWcP8SFJTpHWEBNnyrPeC1pRD2kbKCa1bLgwARm2FeWn4Pdpxfj
         pQkpiMs8VbdL55K5wVX8Crqtu+bZQeYxRVn8uVovV3LAL3kj5jnlma6tuPPYHHBPhV5P
         OGvA==
X-Gm-Message-State: AOAM531T1Nm2PJKncBciM1ufSd/0Nh4BmGyyoDBOD8ZB8BRzL5SF0C++
        mf+F/6o8YYZG6goJJMdgWqQ=
X-Google-Smtp-Source: ABdhPJz+nHXkVSWGA9lE/VQL6I22gEojvvk17S+GegjyVvKGMS14tNYNEWxpb3EtYyN5IiPOsZL4Kw==
X-Received: by 2002:adf:e889:: with SMTP id d9mr3103968wrm.223.1629372189558;
        Thu, 19 Aug 2021 04:23:09 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id r1sm2700388wrt.24.2021.08.19.04.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:23:09 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm: omap: remove obsolete selection of OMAP2_DSS in config DRM_OMAP
Date:   Thu, 19 Aug 2021 13:22:53 +0200
Message-Id: <20210819112253.16484-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
References: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 55b68fb856b5 ("drm/omap: squash omapdrm sub-modules into one")
removes the config OMAP2_DSS in ./drivers/gpu/drm/omapdrm/dss/Kconfig,
while moving the other configs into./drivers/gpu/drm/omapdrm/Kconfig, but
misses to remove an obsolete selection of OMAP2_DSS in config DRM_OMAP.

Hence, ./scripts/checkkconfigsymbols.py warns:

OMAP2_DSS
Referencing files: drivers/gpu/drm/omapdrm/Kconfig

Remove this reference in an obsolete selection.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/omapdrm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
index e7281da5bc6a..d6e4df291d6f 100644
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -3,7 +3,6 @@ config DRM_OMAP
 	tristate "OMAP DRM"
 	depends on DRM
 	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
-	select OMAP2_DSS
 	select DRM_KMS_HELPER
 	select VIDEOMODE_HELPERS
 	select HDMI
-- 
2.26.2

