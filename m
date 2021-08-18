Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005663F03D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhHRMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhHRMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:41:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5EC061764;
        Wed, 18 Aug 2021 05:41:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso4334015wmj.0;
        Wed, 18 Aug 2021 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZAPhX+VRT0+zIBhSL6SCOTLLnMplq+LWNcok53Ws3w=;
        b=onfEfOxQYoF+a8qU2x61VOBJrzjDHAstnxzW6zGSre5KbQdBOVly2I7x26Hl2lZNbp
         pQ4rKO4AxWQR1KjtXdb7p/CRqlG8kPScH6MCMZWXyww5UI2qbboFWfJqP6E4NCu97cw4
         Oo4gKbsyojmv/mu1wiy7qWGirW88V2ncIvrTXLVayf3qRR7QPLyF9158IBmBYQSkxYft
         i4w1xUFEGwpGYXcxkGWpOXXKtqm8hSEHtvm7T4Buf3bFEMFDyQy70D5wditE/oW/1hM4
         BCKco4zzy98f/ZBod4dlTsepd9D4/r+zJfnCBzxx+Px8XV1Zg4fGs3azs6Mj3qimHHsW
         X3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZAPhX+VRT0+zIBhSL6SCOTLLnMplq+LWNcok53Ws3w=;
        b=oYa4LroGPCkziVnEcF5jFDp27EbFhz3Xxv7dTOsTXMtuZo2E13AgUQX9g2wMFsBp73
         nVV7wiH5KEAYSmO1rRijdnz5oOystqclV9jKHo+Zn029d+eUJIS0g4loEI3hucXlkfRt
         CHW+UO+xzyxkaMMtRPxHo/G56pW1Gu3p9fabHIQMFFJt5XZVpELVN2uCwWs1QX7rgzm/
         ztIyfuIQwY5IgNbRm1ZN/FV44OfZB19sUnbDDRLNiIhhAJdwVyQvchjUou9E369Tt/8x
         vSRk+oOs6nkSrQrCy2dC83tXsFs5gKMKqBmZbuGfKh/W7xqWIy6R9q/5z093T9x2cJaD
         7Zqw==
X-Gm-Message-State: AOAM531kOyDlNKtXSno0nVhQu2mAH9VCcs4RvRci4aj/nHcMKHSbPVv1
        IiJr/oFhMUP37QjqU/GL8Ts=
X-Google-Smtp-Source: ABdhPJwMNKElc3mMVCtoj2HEUn6d5ePvfz81G1zAIxYIDk10lE9hSomFsNs711+ZPErCAs0lDCkW8w==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr8258237wmg.109.1629290475788;
        Wed, 18 Aug 2021 05:41:15 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id a11sm5720454wrq.6.2021.08.18.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:41:15 -0700 (PDT)
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
Subject: [PATCH 0/5] Kconfig symbol clean-up on gpu
Date:   Wed, 18 Aug 2021 14:41:09 +0200
Message-Id: <20210818124114.28545-1-lukas.bulwahn@gmail.com>
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

Best regards,

Lukas

Lukas Bulwahn (5):
  drm: rockchip: remove reference to non-existing config DRM_RGB
  drm: amdgpu: remove obsolete reference to config CHASH
  drm: v3d: correct reference to config ARCH_BRCMSTB
  drm: zte: remove obsolete DRM Support for ZTE SoCs
  drm: omap: remove obsolete selection of OMAP2_DSS in config DRM_OMAP

 drivers/gpu/drm/Kconfig              |   1 -
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
 22 files changed, 1 insertion(+), 3964 deletions(-)
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

