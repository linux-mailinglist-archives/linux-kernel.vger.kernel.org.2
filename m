Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315E351FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhDAT3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhDAT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:28:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BCC041B35
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:17:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so2845472wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=T/m4lKUAziO6UFKbfesqmH3d9/aSuNasUhAOfkJpO8Q=;
        b=saxzqydCuD3aqJ+43IK8URq45YFeSOluDsZSS2mlKWPcw5qfmAYBgU+wR44Iz4RvHP
         Bn3+MtAc6vJHf4cE/Oem1305wZfMrRpJQWITbuL3zt+F9fFBxe8ry5YtMgZnhPIzu7tY
         cgQddlmfoIHUWcd+oW3R8ErpPKu0f/r5+NicEjajTCKAvKys7hLVEc9DeNGJpZkjd43x
         tOOC6YrgGJYtglRy2JpTz//6GW6dSMt+hFKtzJD0vuGo7xq7f1LzVfg0Z4TYMDjEWa3I
         +MA5kzX3WiyOUOC9untxEb/yMG0d/Nb8zoEOjvrym/i/kuKndPgRHgBwkiTnAk2+4hD3
         DEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=T/m4lKUAziO6UFKbfesqmH3d9/aSuNasUhAOfkJpO8Q=;
        b=APr2BTxoG2Uh9l2QQjXrg3cBcjq9Y53Q9rmQPIbY/OJYJaVDsVyFOyJswTgqygfunK
         2e+kAO0jVDanKbpJlk6K8opyrxPj7nRrx/IR4iPYPr2sBhyMQSafw4EJIawYBPRkvmoR
         RfQSd4rMXrN3nBwYe0H/TAJFsrBHsir02mP2uxKXBXebPDI62IOArvegSSzpQZ9ZWQWR
         3orn2S5wIvrAPcIDUPQB5PEIGTzy5DGKXZGFz/NZk+HxqIBt89N/nvA5uDC+o5GApJIk
         VZCaCVk5RvGPx1CR/XclqAavpLsWl+dPsYNWKmLC+S7f8GaMb8v65REQPCaXCls2I3aS
         msng==
X-Gm-Message-State: AOAM533ILLngWaTA2X6mhUDNPhfvnSTkdi2po6s8jQd1+1Ch5tRBa5gY
        xvi45eAdGoF6OR3nDziAgM4ZAKEcvnVYC6JvaWa/2ynkHb4=
X-Google-Smtp-Source: ABdhPJxt8dStSHCHJlQD16rHwAORI2dmIgMlWsQFNDCTla2edhNZIvhMZpd6ied9uKU8Fe3XQvS85vw6pEe0XpWNQRU=
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr11253245wrw.289.1617304639409;
 Thu, 01 Apr 2021 12:17:19 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 2 Apr 2021 05:17:07 +1000
Message-ID: <CAPM=9tzgCsiCMpLy2g3dZCg97PZ-4HKgLWtfj2ZRk8o5LhqLyg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc6
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

Things have settled down in time for Easter, a random smattering of
small fixes across a few drivers. I'm guessing though there might be
some i915 and misc fixes out there I haven't gotten yet, but since
today is a public holiday here, I'm sending this early so I can have
the day off, I'll see if more requests come in and decide what to do
with them later.

Dave.

drm-fixes-2021-04-02:
drm fixes for 5.12-rc6

amdgpu:
- Polaris idle power fix
- VM fix
- Vangogh S3 fix
- Fixes for non-4K page sizes

amdkfd:
- dqm fence memory corruption fix

tegra:
- lockdep warning fix
- runtine PM reference fix
- display controller fix
- PLL Fix

imx:
- memory leak in error path fix
- LDB driver channel registration fix
- oob array warning in LDB driver

exynos
- unused header file removal
The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3=
:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-02

for you to fetch changes up to 6fdb8e5aba6a33fe5f1a0bd1bcf0cf2884437ead:

  Merge tag 'imx-drm-fixes-2021-04-01' of
git://git.pengutronix.de/git/pza/linux into drm-fixes (2021-04-02
04:53:16 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc6

amdgpu:
- Polaris idle power fix
- VM fix
- Vangogh S3 fix
- Fixes for non-4K page sizes

amdkfd:
- dqm fence memory corruption fix

tegra:
- lockdep warning fix
- runtine PM reference fix
- display controller fix
- PLL Fix

imx:
- memory leak in error path fix
- LDB driver channel registration fix
- oob array warning in LDB driver

exynos
- unused header file removal

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/vangogh: don't check for dpm in is_dpm_running when in sus=
pend

Arnd Bergmann (1):
      drm/imx: imx-ldb: fix out of bounds array access warning

Dave Airlie (4):
      Merge tag 'exynos-drm-fixes-for-v5.12-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes
      Merge tag 'amd-drm-fixes-5.12-2021-03-31' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm/tegra/for-5.12-rc6' of
ssh://git.freedesktop.org/git/tegra/linux into drm-fixes
      Merge tag 'imx-drm-fixes-2021-04-01' of
git://git.pengutronix.de/git/pza/linux into drm-fixes

Dmitry Osipenko (1):
      drm/tegra: dc: Don't set PLL clock to 0Hz

Evan Quan (1):
      drm/amd/pm: no need to force MCLK to highest when no display connecte=
d

Huacai Chen (1):
      drm/amdgpu: Set a suitable dev_info.gart_page_size

Liu Ying (1):
      drm/imx: imx-ldb: Register LDB channel1 when it is the only
channel to be used

Mikko Perttunen (1):
      gpu: host1x: Use different lock classes for each client

Nirmoy Das (1):
      drm/amdgpu: fix offset calculation in amdgpu_vm_bo_clear_mappings()

Pan Bian (1):
      drm/imx: fix memory leak when fails to init

Qu Huang (1):
      drm/amdkfd: dqm fence memory corruption

Thierry Reding (2):
      drm/tegra: dc: Restore coupling of display controllers
      drm/tegra: sor: Grab runtime PM reference across reset

Tian Tao (1):
      drm/exynos/decon5433: Remove the unused include statements

X=E2=84=B9 Ruoyao (1):
      drm/amdgpu: check alignment on CPU page for bo map

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 10 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  6 ++---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  8 +++---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  5 ++++
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |  1 -
 drivers/gpu/drm/imx/imx-drm-core.c                 |  2 +-
 drivers/gpu/drm/imx/imx-ldb.c                      | 12 ++++++++-
 drivers/gpu/drm/tegra/dc.c                         | 30 ++++++++++--------=
----
 drivers/gpu/drm/tegra/sor.c                        |  7 +++++
 drivers/gpu/host1x/bus.c                           | 10 +++++---
 include/linux/host1x.h                             |  9 ++++++-
 18 files changed, 72 insertions(+), 45 deletions(-)
