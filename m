Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2F431F87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhJRObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhJROa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:30:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC7C061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:28:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so41970024wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyYaNMyG0h2GRFSHh3MvaiQhHBrpmc1k1spDZIbhBKw=;
        b=0/NGh/p3sVcXxesecSYKBMn+eToUPj771KYfsNeQCDLhfvuEUJ5FP1n91Fc0PZIifD
         glWKqHP+V0kSU4kSqmrZPGYo96bTVrA70NoDVbsln11HONolpEu553ByvveFwRB8c/Fw
         bQwrsEvm+Qbx7sXQhU+2T6fDsNzNCMexYfeC/aJAxKoRWyuLI36YhQrS15aZv83JTxx1
         w6tTRbbqZ4QciTX8PjRykKnc1tBKLYm06iFTOjExWzDkvLrdfXvfpMh7+ZPZRMUDJLgC
         NmPVgavhPxE3MtmgK5I7VCgIIbjkVwiXqs8C/KrkrJ8wcsy6gus0sFGar9CncJpOHePM
         uDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyYaNMyG0h2GRFSHh3MvaiQhHBrpmc1k1spDZIbhBKw=;
        b=KUV5g7ADGU/iSo6+0uomAylni/LRwJn1QJWPCU5y+D//VCw0SvLltIl/Mcrj46UjTL
         Ea3R1rRbY1pvwxia1pRQbcd9IcFb35TCpQDPqJvZpzU9e3yMc9Og+kTNzygAh1it0MpX
         yrUpVgIWADcSSxU2M2Z53L5cTXd5meFJ7MMPQHGEjASMvhJIR0204GHL0ApomklhjZDI
         kaM1K/WJs9ynXXxSodsqk/OZn7sgVDDg+ZjeB73D6+BldR5k+wLMfPbnChz1Iq0gTwSG
         4+31mLZ38x3Hkob+KQOVKJ7hMqBwm0C8wTzKko4flLVW4WSgx/k/wqnG0lJxd89/Xh2w
         YaWQ==
X-Gm-Message-State: AOAM530slPn/ivSOG5idQAdEhdaticQXwPUcyS/d1wQsWPBhi11cisfN
        IX2o06rY9WAW3LOYimo6IBz36hX0Ml0pCA==
X-Google-Smtp-Source: ABdhPJyViJMpa/W4XVDOttFAuL4XjTh4Xpqfxmvfmp+8DIEc+cUbvjdyhyeeVlkoab278Zr8gTsD5w==
X-Received: by 2002:adf:a29c:: with SMTP id s28mr34700738wra.116.1634567324983;
        Mon, 18 Oct 2021 07:28:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:2dd7:d5eb:6e87:f924])
        by smtp.gmail.com with ESMTPSA id b3sm12908495wrp.52.2021.10.18.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 07:28:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tomba@kernel.org
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v6 0/9] drm/omap: Add virtual-planes support
Date:   Mon, 18 Oct 2021 16:28:33 +0200
Message-Id: <20211018142842.2511200-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; h=from:subject; bh=UU6BPOlg4iHte6Z0SQwKO9S7iu4F/v+orl4BrCXP76I=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhbYSDvJh2P7dCncuXx9XXB5XZq1TOiLt4NlmqYdL7 ZjqbziiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYW2EgwAKCRB33NvayMhJ0UZ3D/ 9IMt2RQ0aOt34ulcoQ3whtM/uULj4rGoYkjO8z6elwcZ1GMJlJMIPMPYSFffDsJMN7inPkjX2FLlhN 9FB+qHap9O4b4Yne5iHd7IFO97kn8z5vDH3NmOChUJB/mDmJ+ZLnEvxPZ1OwvIJuPc+14rrdPS2+hT GyF7OVExSePxnqmgOOSI+1hsm0oIQe8+dWF1xD78Tw2YUmbBfOrF5iLOvL2x1rfu+lb9ZqPDctiaO0 ckTDgwZINvQWk2BD2lKHgNc68Uvg7d5GiL2wGEJjk53XNTfn+932d0AQnG4yxAVujJAwIZzYW9Fqyl eQjjFuJ11R+BzXIJbWtTZfw3ehOtw1zm15MaHLOO331wO+08FqoJB8rlaEPlEcEAxjqOn7N8zQKdvQ O39d44UazaVdyf3omKzzQZmumTZ+RpkkmDfCoKguSkygj317BKTeP4k6NMVMvg1HZ+8uvB7PFrazya WM/MCfgagiwsrXZ3Q5jc8v5ZC4/ZdRIndefdyycRg3V4fH4NrdpVZulVE7yy0qHiqX15LJTTBo2XHP nhGmhOMp1jpkZHvkdB+EYPJjbs91puNu6DmWp1qnXcd5UJZonA4o15BARunAtlO+tfkDvzYcT1nLNm fCuGkQi+EwkcgXN/nEWNPI7J9SwvjtVmaBYjgIoaHwyTMuC7iDpHlheYTjVw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the follow-up the v4 patchset from Benoit Parrot at [1].

This patch series adds virtual-plane support to omapdrm driver to allow the use
of display wider than 2048 pixels.

In order to do so we introduce the concept of hw_overlay which can then be
dynamically allocated to a plane. When the requested output width exceed what
be supported by one overlay a second is then allocated if possible to handle
display wider then 2048.

This series replaces an earlier series which was DT based and using statically
allocated resources.

This implementation is inspired from the work done in msm/disp/mdp5
driver.

Changes since v5 at [2]:
- Patch 1: renamed width/height_fp to max_width/height
- Patch 2: no changes
- Patch 3: removed possible_crtcs stuff,
	added cleanup on failure to allocate,
	removed name in omap_plane struct & plane_id_to_name in omap_plane.c,
	switched all omap_plane->name to plane->name or omap_plane->id
- Patch 4: aligned omap_plane_atomic_duplicate_state the the crtc style
- Patch 5: removed glob_obj_lock & reformated global state declaration in omap_drv.h
- Patch 6: moved drm_atomic_helper_check_plane_state() from atomic_check() in separate commit,
	removed zpos change, updated debug messages to be useful,
	renamed omap_overlay_disable() to omap_overlay_update_state(),
	added useful comments for omap_overlay_assign() & omap_overlay_update_state(),
	simplified omap_overlay_assign() & omap_overlay_update_state() for actual use-cases,
	refactored omap_plane_atomic_check() changes to be cleaner & simpler
- Patch 7: no changes (except possible_crtcs print removal)
- Patch 8: Reformated omap_plane_atomic_check() & omap_overlay_assign() changes to match previous patches layout 

Changes since v4 at [1]:
- rebased on v5.15-rc2
- adapted to drm_atomic_get_new/old_plane_state()
- tested on Beagle-x15
- checked for non-regression on Beagle-x15
- removed unused "state" variable in omap_global_state

[1] https://lore.kernel.org/all/20181012201703.29065-1-bparrot@ti.com/
[2] https://lore.kernel.org/all/20210923070701.145377-1-narmstrong@baylibre.com/

Benoit Parrot (8):
  drm/omap: Add ability to check if requested plane modes can be
    supported
  drm/omap: Add ovl checking funcs to dispc_ops
  drm/omap: introduce omap_hw_overlay
  drm/omap: omap_plane: subclass drm_plane_state
  drm/omap: Add global state as a private atomic object
  drm/omap: dynamically assign hw overlays to planes
  drm/omap: add plane_atomic_print_state support
  drm/omap: Add a 'right overlay' to plane state

Neil Armstrong (1):
  drm/omap: add sanity plane state check

 drivers/gpu/drm/omapdrm/Makefile       |   1 +
 drivers/gpu/drm/omapdrm/dss/dispc.c    |  31 ++-
 drivers/gpu/drm/omapdrm/dss/dss.h      |   5 +
 drivers/gpu/drm/omapdrm/omap_drv.c     | 189 ++++++++++++-
 drivers/gpu/drm/omapdrm/omap_drv.h     |  24 ++
 drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++-
 drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
 drivers/gpu/drm/omapdrm/omap_overlay.c | 212 +++++++++++++++
 drivers/gpu/drm/omapdrm/omap_overlay.h |  35 +++
 drivers/gpu/drm/omapdrm/omap_plane.c   | 354 +++++++++++++++++++++----
 drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
 11 files changed, 830 insertions(+), 59 deletions(-)
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.25.1

