Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E539B017
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFDB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:57:27 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:43994 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDB50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:57:26 -0400
Received: by mail-ej1-f51.google.com with SMTP id ci15so12018892ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tc/qAItokwzgjvCvvsYDtFIf92L7YKjy17RuwLzgZN8=;
        b=JCgwGXqfazlPuJtac4/0352ECh+80WAszKHL8UI+2sZGR/L6V/NcA4oTBlvBogZxQ+
         mjXm0767Rc4MKUQ69kywDWDc0GPUjvgDmGyW647xT+mc1AWeQSgYRuHs0dsER2jqdlyW
         dSyJcyCVSGwdfGjPoPgNfqRA1yYcMLwZ3lJ4A4L7r7/PKqNT14wBeYseFCGR5S4fGHxe
         sPPf1Tmf8+aBut6z4lrZWdeHrtYZ+vf/sAzMhUdZTZWT66hjOZFGsE4JipFaSbWErUHe
         PiIpt8exRB+8meGvgSfp4+6quZ9h7Yw4YDMKjTQjV4N5y8mDBC0SUbbIVhiqe1+FGBGh
         VlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tc/qAItokwzgjvCvvsYDtFIf92L7YKjy17RuwLzgZN8=;
        b=sEhiPLbMezg0xVzBoYOEVKU5uNvPVJG0cQvkRjn0uav/W1Jv75x4fQLSjq1X5aEpwg
         7CVncgGEPj2gv8hII/7R8RHYSg1rE3jxo4QG5azRd0yEZKD+5fggA5uLA6M6+L5BbYh5
         1OaQkfKJbJJCl8wE7+izqBsd0JRY5tXy3NKPQfNz05Iynsk8CuOmZKNLtaE7OVAvP1U9
         69hTjWuyoj3XKgdS2a1M5pCEjn0SVRpyQOHceb4XY8GAcuQ1XmLXEgLM09Erufanwfb0
         u78Dnxasl/dqKxR2tNXIjmnTFcPjhXrOojSf0H1ns0kwa/08Ml9yp4VqsQjinqXO94V1
         7Bfg==
X-Gm-Message-State: AOAM532fTbb/++DyrSIJ4kNeRU2gw/WZl8+pzN9aahl7/8pNWaExAzy3
        Ma7MovndNDO1Yz7xnUtjr4tR3xvO7Dirh0RyRbM=
X-Google-Smtp-Source: ABdhPJx19ckfxijYnzHqF5dvdT8DiywQEIbBKXxgY1Xuk9poz/OvqcBSdpMDSCC0PHJJwNacx5ynJCcMsaaZacgoviE=
X-Received: by 2002:a17:906:264c:: with SMTP id i12mr1903476ejc.101.1622771679717;
 Thu, 03 Jun 2021 18:54:39 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 4 Jun 2021 11:54:28 +1000
Message-ID: <CAPM=9txo9kjV=iiFKVN5nS6aATwOD+dZ4RLZD7O6Ezya3tLAaA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Two big regression reverts in here, one for fbdev and one i915.
Otherwise it's mostly amdgpu display fixes, and tegra fixes.

Seems about right for rc5.

Dave.

drm-fixes-2021-06-04-1:
drm fixes for 5.13-rc5

fb:
- revert broken fb_defio patch

amdgpu:
- Display fixes
- FRU EEPROM error handling fix
- RAS fix
- PSP fix
- Releasing pinned BO fix

i915:
- Revert conversion to io_mapping_map_user() which lead to BUG_ON()
- Fix check for error valued returns in a selftest

tegra:
- SOR power domain race condition fix
- build warning fix
- runtime pm ref leak fix
- modifier fix
The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-04-1

for you to fetch changes up to 37e2f2e800dc6d65aa77f9d4dbc4512d841e2f0b:

  Merge tag 'drm/tegra/for-5.13-rc5' of
ssh://git.freedesktop.org/git/tegra/linux into drm-fixes (2021-06-04
10:23:57 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc5

fb:
- revert broken fb_defio patch

amdgpu:
- Display fixes
- FRU EEPROM error handling fix
- RAS fix
- PSP fix
- Releasing pinned BO fix

i915:
- Revert conversion to io_mapping_map_user() which lead to BUG_ON()
- Fix check for error valued returns in a selftest

tegra:
- SOR power domain race condition fix
- build warning fix
- runtime pm ref leak fix
- modifier fix

----------------------------------------------------------------
Asher Song (1):
      drm/amdgpu: add judgement for dc support

Bindu Ramamurthy (1):
      drm/amd/display: Allow bandwidth validation for 0 streams.

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2021-06-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-06-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.13-2021-06-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm/tegra/for-5.13-rc5' of
ssh://git.freedesktop.org/git/tegra/linux into drm-fixes

Dmitry Osipenko (1):
      drm/tegra: Correct DRM_FORMAT_MOD_NVIDIA_SECTOR_LAYOUT

Jiansong Chen (1):
      drm/amdgpu: refine amdgpu_fru_get_product_info

Luben Tuikov (1):
      drm/amdgpu: Don't query CE and UE errors

Lyude Paul (1):
      drm/tegra: Get ref for DP AUX channel, not its ddc adapter

Matthew Auld (1):
      Revert "i915: use io_mapping_map_user"

Matthew Wilcox (1):
      Revert "fb_defio: Remove custom address_space_operations"

Nathan Chancellor (1):
      drm/tegra: Fix shift overflow in tegra_shared_plane_atomic_update

Nicholas Kazlauskas (1):
      drm/amd/display: Fix GPU scaling regression by FS video support

Nirmoy Das (1):
      drm/amdgpu: make sure we unpin the UVD BO

Pavel Machek (CIP) (1):
      drm/tegra: sor: Do not leak runtime PM reference

Rodrigo Siqueira (1):
      drm/amd/display: Fix overlay validation by considering cursors

Roman Li (1):
      drm/amd/display: Fix potential memory leak in DMUB hw_init

Simon Ser (1):
      amd/display: convert DRM_DEBUG_ATOMIC to drm_dbg_atomic

Thierry Reding (3):
      gpu: host1x: Split up client initalization and registration
      drm/tegra: sor: Fully initialize SOR before registration
      drm/tegra: sor: Fix AUX device reference leak

Victor Zhao (1):
      drm/amd/amdgpu:save psp ring wptr to avoid attack

Zhihao Cheng (1):
      drm/i915/selftests: Fix return value check in live_breadcrumbs_smoketest()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            | 16 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     | 42 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |  3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 30 ++++++----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  2 +-
 drivers/gpu/drm/i915/Kconfig                       |  1 -
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  9 +--
 drivers/gpu/drm/i915/i915_drv.h                    |  3 +
 drivers/gpu/drm/i915/i915_mm.c                     | 44 ++++++++++++++
 drivers/gpu/drm/i915/selftests/i915_request.c      |  4 +-
 drivers/gpu/drm/tegra/drm.h                        |  2 +-
 drivers/gpu/drm/tegra/hub.c                        |  2 +-
 drivers/gpu/drm/tegra/sor.c                        | 70 +++++++++++++---------
 drivers/gpu/host1x/bus.c                           | 30 ++++++++--
 drivers/video/fbdev/core/fb_defio.c                | 35 +++++++++++
 drivers/video/fbdev/core/fbmem.c                   |  4 ++
 include/linux/fb.h                                 |  3 +
 include/linux/host1x.h                             | 30 ++++++++--
 22 files changed, 240 insertions(+), 99 deletions(-)
