Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760035A763
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhDITq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhDITqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:46:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37713C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 12:46:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so10397169ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=00DmRMd0Ppqlj6NPfhWteKHJG+0eTjZ5Lw0FbYcqZWg=;
        b=pkS00Iq/wQKviqbuLMLppilzSlzEv+HlJhPDmiQGmXLhAmWY7fWUlKUTxq95gNFJOA
         xFW8exg0NiMjw1Ijes/kkILItqOPu+tXfyFZq3ybDuX9Z/VPooGL6zdMuziFlsNKGzNF
         BpIuaNqOCv0/yNua9z/rDXFJeYk1Eh1Cf11G4ZjHuw63RBcAh46oDAuBJKBQICUPRzpM
         1f8asSLlRuU/pgaLWVyWiXhmgVDeok31NkJDwCpJhbzOApexd+MYJl1ExMNQ2mZwJgzd
         RRplEn7DplwyM5DW+zTey1KhDkrbcYRzRA/L+u5QUYDpK6NpXJSTMcM9PKjtGakdD6ie
         wR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=00DmRMd0Ppqlj6NPfhWteKHJG+0eTjZ5Lw0FbYcqZWg=;
        b=UYyudUKSL9nWARX55206c+XIIGCrvgQoq7/wvbExLvHGoOMwDi40Jkhh0dqAZZRFIj
         9GQ/fvhVN2dfKxSjvFJVgDsPMUz2uJYOglDsKrITNTETkVrfZzaN6AzjVmWy4tHW6KLC
         ncNrK5pDr5NESM8H30WtFlGmKeiglD2NJQVDuDEpxL3zUc/jOhtRaH4BsCRy7yIzc88o
         Mlkuczc3jphRtLkIxZ+DqgyEMDcmj+C2JptjIRh+EsPVBHWMj4Lke2CJTAYQAvYvLseW
         TW6jaQUWThL/8EExU1UZpH68Wmzme1MkCHpNT8KxIiaLHLjWJcziRiuV97gkxPHrFsjg
         4uWQ==
X-Gm-Message-State: AOAM531NX3WXt6BO00lLpJtcTKjTm9UdzwTkGgVHz6rooXalzOL0DpSl
        CBFgp7bG3aZkqSimwZwhzidCoRjlRRAiX9qO7q+KwPUXHu4=
X-Google-Smtp-Source: ABdhPJw1QLWMZjdPXQ2gCQH271yG+cva4TDX/pYpqFbT7ICP3mLlVjj+P3dUxYswl1jiuS9nuJH2IAJK/Vm8NYqIScU=
X-Received: by 2002:a17:906:9b15:: with SMTP id eo21mr1621220ejc.237.1617997592848;
 Fri, 09 Apr 2021 12:46:32 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 10 Apr 2021 05:46:21 +1000
Message-ID: <CAPM=9tzEK7pEZ54TMCMc0yLto5QhnBjGE0X6X6Ca+N9EAc+U=w@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Was relatively quiet this week, but still a few pulls came in, pretty
much small fixes across the board, a couple of regression fixes in the
amdgpu/radeon code, msm has a few minor fixes across the board, a
panel regression fix also.

I'm out all next week, so Daniel will do any last minute fixes for the
final release, assuming things stick to schedule. I'll be back for the
merge window but might towards the end of the first week before I get
my MR lined up.

Dave.

drm-fixes-2021-04-10:
drm fixes for 5.12-rc7

amdgpu:
- DCN3 fix
- Fix CAC setting regression for TOPAZ
- Fix ttm regression

radeon:
- Fix ttm regression

msm:
- a5xx/a6xx timestamp fix
- microcode version check
- fail path fix
- block programming fix
- error removal fix.

i915:
- Fix invalid access to ACPI _DSM objects

xen:
- Fix use-after-free in xen.
- minor duplicate definition cleanup

vc4:
- Reduce fifo threshold on hvs4 to fix a fifo full error.
- minor redundant assignment cleanup

panel:
- Disable TE support for Droid4 and N950.
The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-10

for you to fetch changes up to bd119f471299c8692a00b2f5e9bba8e3b81c3466:

  Merge tag 'drm-intel-fixes-2021-04-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-04-10
05:18:35 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc7

amdgpu:
- DCN3 fix
- Fix CAC setting regression for TOPAZ
- Fix ttm regression

radeon:
- Fix ttm regression

msm:
- a5xx/a6xx timestamp fix
- microcode version check
- fail path fix
- block programming fix
- error removal fix.

i915:
- Fix invalid access to ACPI _DSM objects

xen:
- Fix use-after-free in xen.
- minor duplicate defintion cleanup

vc4:
- Reduce fifo threshold on hvs4 to fix a fifo full error.
- minor redunantant assignment cleanup

panel:
- Disable TE support for Droid4 and N950.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/smu7: fix CAC setting on TOPAZ

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-5.12-2021-04-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2021-04-02' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2021-04-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-04-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dmitry Baryshkov (1):
      drm/msm: a6xx: fix version check for the A650 SQE microcode

Dom Cobley (1):
      drm/vc4: crtc: Reduce PV fifo threshold on hvs4

John Stultz (1):
      drm/msm: Fix removal of valid error case when checking speed_bin

Kalyan Thota (1):
      drm/msm/disp/dpu1: program 3d_merge only if block is attached

Lv Yunlong (1):
      gpu/xen: Fix a use after free in xen_drm_drv_init

Maxime Ripard (1):
      drm/vc4: plane: Remove redundant assignment

Qingqing Zhuo (1):
      drm/amd/display: Add missing mask for DCN3

Rob Clark (1):
      drm/msm: Fix a5xx/a6xx timestamps

Sebastian Reichel (1):
      drm/panel: panel-dsi-cm: disable TE for now

Stephen Boyd (1):
      drm/msm: Set drvdata to NULL when msm_drm_init() fails

Takashi Iwai (1):
      drm/i915: Fix invalid access to ACPI _DSM objects

Wan Jiabing (1):
      drivers: gpu: drm: xen_drm_front_drm_info is declared twice

xinhui pan (2):
      drm/amdgpu: Fix size overflow
      drm/radeon: Fix size overflow

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h  |  1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  3 ++-
 drivers/gpu/drm/i915/display/intel_acpi.c          | 22 ++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 18 ++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  4 +++-
 drivers/gpu/drm/msm/msm_drv.c                      |  1 +
 drivers/gpu/drm/panel/panel-dsi-cm.c               | 12 +++++++++---
 drivers/gpu/drm/radeon/radeon_ttm.c                |  4 ++--
 drivers/gpu/drm/vc4/vc4_crtc.c                     | 17 +++++++++++++++++
 drivers/gpu/drm/vc4/vc4_plane.c                    |  1 -
 drivers/gpu/drm/xen/xen_drm_front.c                |  6 ++++--
 drivers/gpu/drm/xen/xen_drm_front_conn.h           |  1 -
 14 files changed, 74 insertions(+), 22 deletions(-)
