Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C293F03E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhHRMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhHRMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:42:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31645C061764;
        Wed, 18 Aug 2021 05:41:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so1700937wmi.1;
        Wed, 18 Aug 2021 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdAGUCyYQ4noYy9BmzZUbXym0YMYKVh78nm2c4sCaNo=;
        b=QYgwx9dlaH3RyUx/fnHN4Y6omSMw5U3O0ah91g35q7jVcI4dHVdFaNlCAdci13bVeR
         suo33HFIYdKFnq4fJ4fe46eLIB0DEHfW0gQnunFK9UotHj+5C6KGF12/5QBzbiS3jZ2y
         SVCHPCM+ztoxWXAZEzGNQgqBpc58ZaKALwgm6IBzLYv6HDimXgIBNTwo//C71fOLZlAn
         nK2XD5wDJEFm7z1KFGODM6Cm2Dwk4eb8pq5hH05OTNlMSqKAH0lLMvYmJx+uU6orLu7x
         wUTLsYC51JHA00/WP57cFAUcyotGJsTNCjdZy2QSY24l4JotdNC4vwjc6WdVuXGB/aiw
         aNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdAGUCyYQ4noYy9BmzZUbXym0YMYKVh78nm2c4sCaNo=;
        b=lmYbCqA2JYBhM83/PhvrFBUPexWycku2FZPX21L+JDqChdtbWq+6tVrBgRY9G+lKyX
         EpfGdFIWDQTLPlU7CCt2XVtXtdHiy57Qu5yxZpXtSEYgeYGhxvssQTgPwQKazbtO1Vfx
         SzuRecNhuRhg1yKN1AbE3FUFhqz/WtHQDLnKhS1rJFSpdE2s4pE4COCtEbTFZX5hK7k9
         bCWjK9lgX6tgpNrxgfAiaPhAETCq2UjecoCvyxY1RulUUc9DQnxedHIoWLAy2ovPRkqd
         Qr1nEj3U2sELOxVQVTivoB+QD7+Fv0eIkP5L+r3peTz7suAT9Wginf6rToQ3SiwknWSV
         jdHA==
X-Gm-Message-State: AOAM532yZy07VgBIDfZFEpqWnjS4590OYt/I5fCBaRysWFfIkoQ+RAmd
        9CT01t2EUw+rIUarE6XWZYg=
X-Google-Smtp-Source: ABdhPJyZRhqaYkeCZQae/8p1e2NVcwuFX4TMTiDaEpXsViXU87cjD/bV2wjYHtpTMOTxNDHl4WsObQ==
X-Received: by 2002:a05:600c:4ba4:: with SMTP id e36mr8524581wmp.82.1629290491753;
        Wed, 18 Aug 2021 05:41:31 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id a11sm5720454wrq.6.2021.08.18.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:41:31 -0700 (PDT)
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
Subject: [PATCH 5/5] drm: omap: remove obsolete selection of OMAP2_DSS in config DRM_OMAP
Date:   Wed, 18 Aug 2021 14:41:14 +0200
Message-Id: <20210818124114.28545-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
References: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
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

