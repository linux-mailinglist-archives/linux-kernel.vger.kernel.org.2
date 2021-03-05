Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F432DFC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCECua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCECu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:50:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E346C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:50:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so657201ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YGRfRIp1eWtsLxeR92yoH2sHmF6Y+KibUhiFCncOcNc=;
        b=Tb0/lwlNMXmR3v/fA6ngU4Ygz3suanV5D6nJTt3c03Mp5SquA2r/DxmWSJpG/VzxNS
         qbVbMLB+RahOne4qUuEFeddc+g3hTqtIq/k3bh+d3849PhQldrnpy6L8qOAwaFuqiwml
         AJqZTe6BkF0CMM6P+tbGCu+DMLJ977imGZmSU/5KrnKMFNC9wh3xCqBvWeQxLqeY4VYL
         2uxmOng5tE72mkmHPR3KAQ1JX7chi2zoILn2NkkG8iEnDUvpn0D3McgyLEKL6QLXTJlI
         Yk9WSU6hr+SM8kvDzRZVTq9TFBVikWjsFbkub07x7mW5Yw5K1rO+ex8hWxidZ4IYxsdL
         lUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YGRfRIp1eWtsLxeR92yoH2sHmF6Y+KibUhiFCncOcNc=;
        b=rl7pOINrfVOAXf++BLMW0KoXI9GBO8qfmUmf9DSQd5AVTZWejPYCB5GvXmCtLzbD7X
         G/i/gfK2RhBNpgeG3v1CB7RdIhCuB7glznrQM+FR/AW/gYnMybmrcaH1CS3dEt3DWrS/
         nrbxohucEnW87VCRIncIVs7kHp+Bv3Qk6UmhoXTURPe2Z7HM5DRwIWKFXrBwWPZa6xKX
         nzXi8oSDLIiL7Te13UOg/6cy+5hR1BuYDiizfVm5DXiGTa0+EM7sjFSWIpW/PsW7xFSQ
         GdUeNZ1s6Jd+EhpoboE0OWvOGeCeXpl93WTVDsmRxwft12lMQLGlb2GuIciTnKMlepfQ
         JHkQ==
X-Gm-Message-State: AOAM53368OWGOtO+Zvk7NVhiC23+IB+UpHmwzDMDk4CTiRy1aszHVU/p
        1VHJQg8XrnMGRcooSCKZGX2cUfCSitaq5fhm7nFVLlfGnxA=
X-Google-Smtp-Source: ABdhPJzk75s7U4TzmbLok5MFqP1CB3nJjhN1aRhMIInFffmBBqCRPE0uRwEtryEVXqbwac5itP5VPkxYlVO5ixbRaMI=
X-Received: by 2002:a17:906:81c9:: with SMTP id e9mr434637ejx.456.1614912627932;
 Thu, 04 Mar 2021 18:50:27 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 Mar 2021 12:50:16 +1000
Message-ID: <CAPM=9txjSRSZPBttCM9xnZj5_V5oJ0jAYf2PFuZgVyHaNBMo5Q@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

More may show up but this is what I have at this staged. These are
based on the commit in your tree where the swapfile issue is fixed,
and neither of the merged trees are in the bad area.

Otherwise just a single nouveau regression fix, and a bunch of amdgpu fixes.

Dave.

drm-fixes-2021-03-05:
drm fixes for 5.12-rc2

amdgpu:
- S0ix fix
- Handle new NV12 SKU
- Misc power fixes
- Display uninitialized value fix
- PCIE debugfs register access fix

nouveau:
- regression fix for gk104
The following changes since commit f69d02e37a85645aa90d18cacfff36dba370f797:

  Merge tag 'misc-5.12-2021-03-02' of git://git.kernel.dk/linux-block
(2021-03-02 18:18:17 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-05

for you to fetch changes up to a1f1054124936c717a64e47862e3d0d820f67a87:

  Merge tag 'amd-drm-fixes-5.12-2021-03-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-03-05
11:13:22 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc2

amdgpu:
- S0ix fix
- Handle new NV12 SKU
- Misc power fixes
- Display uninitialized value fix
- PCIE debugfs register access fix

nouveau:
- regression fix for gk104

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: Only check for S0ix if AMD_PMC is configured
      drm/amdgpu/pm: make unsupported power profile messages debug
      drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for disable
      drm/amdgpu: enable BACO runpm by default on sienna cichlid and
navy flounder

Asher.Song (1):
      drm/amdgpu:disable VCN for Navi12 SKU

Ben Skeggs (1):
      drm/nouveau/fifo/gk104-gp1xx: fix creation of sw class

Colin Ian King (1):
      drm/amd/display: fix the return of the uninitialized value in ret

Dave Airlie (2):
      Merge branch '00.00-inst' of git://github.com/skeggsb/linux into drm-fixes
      Merge tag 'amd-drm-fixes-5.12-2021-03-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address

Kevin Wang (1):
      drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu_regs_pcie

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                   |  2 --
 drivers/gpu/drm/amd/amdgpu/nv.c                           |  6 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c         |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c            | 15 ++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c           |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c          |  3 +++
 10 files changed, 29 insertions(+), 16 deletions(-)
