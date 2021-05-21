Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A938BD73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 06:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhEUEda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 00:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhEUEd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 00:33:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 21:32:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b17so21858206ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fRRN2j+zUDqRjHT4TAcsDeARx0qu+LG7VRjWdyrEsNM=;
        b=Xr4jDv+G+Hw/4TzbCGqJ4wzFxR33fURsliigUqicfOaw6tL3/mR7HkZLV79ruUQf0x
         hBpVKE1EwxH1CnJ934/PYVpTis/vORl2IdwIzqb59Y+N2OduMmK7d17wMgk5WZKlh100
         l58wRMZy3QlPMe1kpmVj+grOQ893pIvbRlhu/Exq/6M91Wr1w5Hnb2Yp3fXVz6IDLh7C
         UhUfooxoNMeSnvtQRKcByVvMbyr3I2caAAeovSscllWaNMGM3lhiWd1bYdGCn5rF9/7S
         CL28clrLmz37AQk4NCAJRUTlpjmp5xHGuUsv0YXHm+pY23Wz0qdgbyJVy6d37psy2SlP
         gBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fRRN2j+zUDqRjHT4TAcsDeARx0qu+LG7VRjWdyrEsNM=;
        b=gwnse7p/B3pFVCb17izFaXvOoAyzHK2AOagtRgnKlogcAIf/S5M3nntvWIn0ZTGqnp
         e2jDYGMQWplqtnAKGNVTvpeO4ziMBf5CWA7OKaKgIkC0D2N1pQSfFuEJjQwHeJc61Dr+
         gSu887Zo+A8lKPTiNPPnQ2m+qdDzfbCvgDgZ497lU1L0+d6EwsSLXyitFnvaxQHmul4G
         JPY8Qvt0i1mOAfmr6PQRq95oY1jAdt0n5rHpIG2nPM0TnIGhxvzQ59ivkNpHldvntV7x
         xEH59qi1j1kEf/1FnrUMvJL03JO3YZkuKqt4Lr5af/uB7+aA5rkgWYpsRTWCNx8UIK1R
         ylLg==
X-Gm-Message-State: AOAM533yJkRSaktBa1g939RuoQ5qLvJt2k8XOR8L/aGw5zJEdPgg05KG
        zwmZs8ZnL1w9qGzdN50bhr4J8vvCjSKVMeCmH6I=
X-Google-Smtp-Source: ABdhPJyWdIbNC162Hx3y2VpH55Xsheg8+/Ku+HEl6xQTE5eFCpXf9cvbjBzHRZsnN6DMSv743mU27gMqXw1BmCmgAJQ=
X-Received: by 2002:a50:fe94:: with SMTP id d20mr4982329edt.127.1621571524778;
 Thu, 20 May 2021 21:32:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 May 2021 14:31:53 +1000
Message-ID: <CAPM=9tzqfc9Xx9bpbp2fKKij=+YYGYG=pSzeVQG=H1pmZf0tBA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Usual collection, mostly amdgpu and some i915 regression fixes. I
nearly managed to hose my build/sign machine this week, but I
recovered it just in time, and I even got clang12 built.

Dave.

drm-fixes-2021-05-21-1:
drm fixes for 5.13-rc3

dma-buf:
- WARN fix

amdgpu:
- Fix downscaling ratio on DCN3.x
- Fix for non-4K pages
- PCO/RV compute hang fix
- Dongle fix
- Aldebaran codec query support
- Refcount leak fix
- Use after free fix
- Navi12 golden settings updates
- GPU reset fixes

radeon:
- Fix for imported BO handling

i915:
- Pin the L-shape quirked object as unshrinkable to fix crashes
- Disable HiZ Raw Stall Optimization on broken gen7 to fix glitches,
gfx corruption
- GVT: Move mdev attribute groups into kvmgt module to fix kconfig deps iss=
ue

exynos:
- Correct kerneldoc of fimd_shadow_protect_win function.
- Drop redundant error messages.
The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc=
:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-21-1

for you to fetch changes up to dd6ad0516ee38112321e99ce368fddd49ee3b9db:

  Merge tag 'amd-drm-fixes-5.13-2021-05-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-05-21
14:08:04 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc3

dma-buf:
- WARN fix

amdgpu:
- Fix downscaling ratio on DCN3.x
- Fix for non-4K pages
- PCO/RV compute hang fix
- Dongle fix
- Aldebaran codec query support
- Refcount leak fix
- Use after free fix
- Navi12 golden settings updates
- GPU reset fixes

radeon:
- Fix for imported BO handling

i915:
- Pin the L-shape quirked object as unshrinkable to fix crashes
- Disable HiZ Raw Stall Optimization on broken gen7 to fix glitches,
gfx corruption
- GVT: Move mdev attribute groups into kvmgt module to fix kconfig deps iss=
ue

exynos:
- Correct kerneldoc of fimd_shadow_protect_win function.
- Drop redundant error messages.

----------------------------------------------------------------
Changfeng (1):
      drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

Chris Park (1):
      drm/amd/display: Disconnect non-DP with no EDID

Chris Wilson (1):
      drm/i915/gem: Pin the L-shape quirked object as unshrinkable

Christian K=C3=B6nig (3):
      drm/radeon: use the dummy page for GART if needed
      drm/amdgpu: stop touching sched.ready in the backend
      dma-buf: fix unintended pin/unpin warnings

Dave Airlie (4):
      Merge tag 'exynos-drm-fixes-for-v5.13-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes
      Merge tag 'drm-misc-fixes-2021-05-20' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-05-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.13-2021-05-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Guchun Chen (2):
      drm/amdgpu: update gc golden setting for Navi12
      drm/amdgpu: update sdma golden setting for Navi12

James Zhu (1):
      drm/amdgpu: add video_codecs query support for aldebaran

Jani Nikula (1):
      Merge tag 'gvt-fixes-2021-05-19' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Jingwen Chen (1):
      drm/amd/amdgpu: fix refcount leak

Krzysztof Kozlowski (1):
      drm/exynos: correct exynos_drm_fimd kerneldoc

Lang Yu (1):
      drm/amd/amdgpu: fix a potential deadlock in gpu reset

Nikola Cornij (1):
      drm/amd/display: Use the correct max downscaling value for DCN3.x fam=
ily

Simon Rettberg (1):
      drm/i915/gt: Disable HiZ Raw Stall Optimization on broken gen7

Yi Li (1):
      drm/amdgpu: Fix GPU TLB update error when PAGE_SIZE > AMDGPU_PAGE_SIZ=
E

Zhen Lei (2):
      drm/exynos: Remove redundant error printing in exynos_dsi_probe()
      drm/exynos/decon5433: Remove redundant error printing in
exynos5433_decon_probe()

Zhenyu Wang (1):
      drm/i915/gvt: Move mdev attribute groups into kvmgt module

xinhui pan (1):
      drm/amdgpu: Fix a use-after-free

 drivers/dma-buf/dma-buf.c                          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   5 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  18 +++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   7 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   7 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   7 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   2 +-
 drivers/gpu/drm/i915/Kconfig                       |   1 -
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   2 +
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         |   5 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     | 124 +----------------=
----
 drivers/gpu/drm/i915/gvt/gvt.h                     |   3 -
 drivers/gpu/drm/i915/gvt/hypercall.h               |   2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   | 122 +++++++++++++++++=
+--
 drivers/gpu/drm/i915/gvt/mpt.h                     |   4 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  11 +-
 drivers/gpu/drm/radeon/radeon_gart.c               |   3 +-
 29 files changed, 191 insertions(+), 192 deletions(-)
