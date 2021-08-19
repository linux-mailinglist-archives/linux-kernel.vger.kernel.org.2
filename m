Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704493F181C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhHSLXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhHSLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:23:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14141C061757;
        Thu, 19 Aug 2021 04:23:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k29so8545730wrd.7;
        Thu, 19 Aug 2021 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjTJOgCdzC+bVFkjZUwWVYccWLPGIUqJi3/PQBH4ta8=;
        b=jvA4K6Nv3O6kYGKlKKtJGIAiE+/5+sWVSiNC/50CPrzaMgOumHT1yIYGK/zVFjlC0c
         n9c3wStWlgUUjQkFM2lhvjzh2Z0JLXquPnD0J+CeOeeyeGZ+XcTI9zbK2t9QkoRjcpdK
         q/w9kUc6gnDYpQ0LosSXKiSiDPBN8VodkDmKrBof9nOpqq8T1eAd/H7OazdUclgeAnJO
         O/IFe2IyH5hZB1Yl3bHxNeqCiY/IRoDT0T5VIwRJIrpmwdXS7CGeQ5fmWEhd1JUFD1RD
         pT9WGq2bj53qg2SZxZ5s68eRU7AGlbuRCUff5OOFjwWBpJYw6AORMYLJPTTnqpj05lBC
         xVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjTJOgCdzC+bVFkjZUwWVYccWLPGIUqJi3/PQBH4ta8=;
        b=ZgXiASpoC03NKJ+pAD+VSRpk9+b5l3TTaiN0AqDasHp/Auv3ONolEc0eV0aM03WTs8
         6mTZhWf0dmE8HSOqLMD5HUHHjmXy+t36W2GOkycgQTWf5wHbBV4vPb3Nvqi0OWPliW+a
         0b0gfQ24La0fJEJBOQC+wJNtcCvMnY/sCyX+hfN15362fi6Kh+WjvLw3xouGnVIsRniQ
         +p/YEgmkOljZX6PBjroY+VJz3RUVhX3C+4woz4fJZEZMJuv2NmYvhAgUXTFzkBVIGb6M
         BXPQDSXTf7SYsbSveR8K9dxwmyznOmNsbEd8T+AhXpRUcEIfbO3sXvE2gSB1BISDNqaj
         BcdA==
X-Gm-Message-State: AOAM530DstLM5mbBtykL2ZX54+WoL5OPC10sLuozK0+xM+kkM/nd+0us
        K73V1iugTCZ1tz+GwHsyx1w=
X-Google-Smtp-Source: ABdhPJzkLVRzWMM2qILDBAW8Loz1YtMs6+zELMJEWlLoRoCVJ82OjYvdpz/rYq8FkdoDfigz+ey/yA==
X-Received: by 2002:adf:ba01:: with SMTP id o1mr3215167wrg.419.1629372179251;
        Thu, 19 Aug 2021 04:22:59 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id r1sm2700388wrt.24.2021.08.19.04.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 04:22:58 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Kconfig symbol clean-up on gpu
Date:   Thu, 19 Aug 2021 13:22:48 +0200
Message-Id: <20210819112253.16484-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear DRM maintainers,

The script ./scripts/checkkconfigsymbols.py warns on invalid references to
Kconfig symbols (often, minor typos, name confusions or outdated references).

This patch series addresses all issues reported by ./scripts/checkkconfigsymbols.py
in ./drivers/gpu/ for Kconfig and Makefile files. Issues in the Kconfig and
Makefile files indicate some shortcomings in the overall build definitions, and
often are true actionable issues to address.

These issues can be identified and filtered by:

  ./scripts/checkkconfigsymbols.py | grep -E "drivers/gpu/.*(Kconfig|Makefile)" -B 1 -A 1

After applying this patch series on linux-next (next-20210817), the command
above yields just one further issues to address:

DRM_AMD_DC_DCE11_0
Referencing files: drivers/gpu/drm/amd/display/dc/dce100/Makefile

  Conclusion: No action required.
  Rationale:
    drivers/gpu/drm/amd/display/dc/dce100/Makefile refers to
    DRM_AMD_DC_DCE11_0 in a comment, after an "ifdef 0".


Please pick this patch series into your drm-next tree.

Note that patch "drm: amdgpu: remove obsolete reference to config CHASH"
was already picked and applied by Alex Deucher.


Best regards,

Lukas

v1 -> v2:
  - adjusted sources in drivers/gpu/drm/Kconfig
    for drm: zte: remove obsolete DRM Support for ZTE SoCs
    after report by kernel test robot
  - removed Tomi from recipient list as email is unreachable.

Lukas Bulwahn (5):
  drm: rockchip: remove reference to non-existing config DRM_RGB
  drm: amdgpu: remove obsolete reference to config CHASH
  drm: v3d: correct reference to config ARCH_BRCMSTB
  drm: zte: remove obsolete DRM Support for ZTE SoCs
  drm: omap: remove obsolete selection of OMAP2_DSS in config DRM_OMAP

 drivers/gpu/drm/Kconfig              |   3 -
 drivers/gpu/drm/Makefile             |   1 -
 drivers/gpu/drm/omapdrm/Kconfig      |   1 -
 drivers/gpu/drm/rockchip/Kconfig     |   1 -
 drivers/gpu/drm/v3d/Kconfig          |   2 +-
 drivers/gpu/drm/zte/Kconfig          |  10 -
 drivers/gpu/drm/zte/Makefile         |  10 -
 drivers/gpu/drm/zte/zx_common_regs.h |  28 -
 drivers/gpu/drm/zte/zx_drm_drv.c     | 184 ------
 drivers/gpu/drm/zte/zx_drm_drv.h     |  34 -
 drivers/gpu/drm/zte/zx_hdmi.c        | 760 ----------------------
 drivers/gpu/drm/zte/zx_hdmi_regs.h   |  66 --
 drivers/gpu/drm/zte/zx_plane.c       | 537 ----------------
 drivers/gpu/drm/zte/zx_plane.h       |  26 -
 drivers/gpu/drm/zte/zx_plane_regs.h  | 120 ----
 drivers/gpu/drm/zte/zx_tvenc.c       | 400 ------------
 drivers/gpu/drm/zte/zx_tvenc_regs.h  |  27 -
 drivers/gpu/drm/zte/zx_vga.c         | 527 ---------------
 drivers/gpu/drm/zte/zx_vga_regs.h    |  33 -
 drivers/gpu/drm/zte/zx_vou.c         | 921 ---------------------------
 drivers/gpu/drm/zte/zx_vou.h         |  64 --
 drivers/gpu/drm/zte/zx_vou_regs.h    | 212 ------
 22 files changed, 1 insertion(+), 3966 deletions(-)
 delete mode 100644 drivers/gpu/drm/zte/Kconfig
 delete mode 100644 drivers/gpu/drm/zte/Makefile
 delete mode 100644 drivers/gpu/drm/zte/zx_common_regs.h
 delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.c
 delete mode 100644 drivers/gpu/drm/zte/zx_drm_drv.h
 delete mode 100644 drivers/gpu/drm/zte/zx_hdmi.c
 delete mode 100644 drivers/gpu/drm/zte/zx_hdmi_regs.h
 delete mode 100644 drivers/gpu/drm/zte/zx_plane.c
 delete mode 100644 drivers/gpu/drm/zte/zx_plane.h
 delete mode 100644 drivers/gpu/drm/zte/zx_plane_regs.h
 delete mode 100644 drivers/gpu/drm/zte/zx_tvenc.c
 delete mode 100644 drivers/gpu/drm/zte/zx_tvenc_regs.h
 delete mode 100644 drivers/gpu/drm/zte/zx_vga.c
 delete mode 100644 drivers/gpu/drm/zte/zx_vga_regs.h
 delete mode 100644 drivers/gpu/drm/zte/zx_vou.c
 delete mode 100644 drivers/gpu/drm/zte/zx_vou.h
 delete mode 100644 drivers/gpu/drm/zte/zx_vou_regs.h

-- 
2.26.2

