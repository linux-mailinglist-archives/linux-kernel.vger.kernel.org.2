Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AA53A3A73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 05:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFKDpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 23:45:04 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:56292 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhFKDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 23:44:59 -0400
Received: by mail-wm1-f46.google.com with SMTP id g204so7273898wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=q2yPgNWHYEpx/FWzAFsvHpoQ6l31IyPbQbdMgDbUS4s=;
        b=u27RYF+imhKBPDtrcwZTpyFma+ZE8yH3/AT5AyGB4xU1EVJohTvem/LHwv7hXHckel
         tlDtT5XglqlSbw/CmROu97iAH6ZdMQ3JXPk/eAlfc508kmBiHePAKIA4OEcXSWdicSIs
         0Fn3X5GcFioV7WFASxZP5sEMK7X3qIIQvW06HUBHsNSswvK9S5sdz46bPpZK0rW/3NgO
         tkIWmJcJV4Rgp+I44ivCrBmVCmW2ypREsJnDPZ6eVADs6/4AXGJV3PO7aixDgFnaCceb
         A4YnJ7bYlOU7Fzl4MO5h8O5rYzkTAltOFy7bhVK5p80bkDe7nfgZgirq0uep2u/dzEVd
         dP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=q2yPgNWHYEpx/FWzAFsvHpoQ6l31IyPbQbdMgDbUS4s=;
        b=Z8sC0p0ntTHdq3v3Cc/9BSd9v1VGylyjvSZLR6r5AhAEadAULizMOe98JOkOqf1EgH
         pZ5TD1Izw2Q5KbDdZyDy6fatU08M7YXPIuq6UexjivPNwX75B83E31SausWabYwIpXh1
         KK5mqNR3wuyP+lHadmP4zDtiPrwjkwBs7XtN+jrgG5XzDRJ8pTpxGg1HLt9oc6oNBv1G
         4Z2EWau0cE1O3RS7s/gBtdHStUgiKhryIWr1RdjoBSnjmS1ML54NwXjWOeBQnoi4eBT3
         N1N2xQ8jtC9eRCEMZIZYh871TzJk1F51I2Y1/uqwIlAKeKvhb6yEEXKgzQJr4uq5G6dJ
         HXOA==
X-Gm-Message-State: AOAM531G9eHV0DXSgxEBBuU5NxQnoTT/YIkDtqdbS6tZQuDVPG3+NWoL
        WOnkCRXx+mhhap6I00F3I6r42umN4vea9166O5GgVNQ78dC6sw==
X-Google-Smtp-Source: ABdhPJwhYibss4y5MHrOztmN+KF9FCKTN2hw5cxQStByRMnbp/l2q42yScy9jqGl/KtnwCfoTIH/hxIkIs4WGHJ6JC4=
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr18069765wmf.23.1623382906060;
 Thu, 10 Jun 2021 20:41:46 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Jun 2021 13:41:34 +1000
Message-ID: <CAPM=9tyyyQ-0QkKquLX4q=7=pjGeRxhhP=z7rfLjEbX7mSrh5A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Another week of fixes, nothing too crazy, but a few all over the
place, two locking fixes in the core/ttm area, a couple of small
driver fixes (radeon, sun4i, mcde, vc4). Then msm and amdgpu have a
set of fixes each, mostly for smaller things, though the msm has a DSI
fix for a black screen. I haven't seen any intel fixes next week so
they may have a few that may or may not wait for next week.

Dave.

drm-fixes-2021-06-11:
drm fixes for 5.13-rc6

drm:
- auth locking fix

ttm:
- locking fix

amdgpu:
- Use kvzmalloc in amdgu_bo_create
- Use drm_dbg_kms for reporting failure to get a GEM FB
- Fix some register offsets for Sienna Cichlid
- Fix fall-through warning

radeon:
- memcpy_to/from_io fixes

msm:
- NULL ptr deref fix
- CP_PROTECT reg programming fix
- incorrect register shift fix
- DSI blank screen fix

sun4i:
- hdmi output probing fix

mcde:
- DSI pipeline calc fix

vc4:
- out of bounds fix
The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922=
:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-11

for you to fetch changes up to 7de5c0d70c779454785dd2431707df5b841eaeaf:

  Merge tag 'amd-drm-fixes-5.13-2021-06-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-06-11
11:17:10 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc6

drm:
- auth locking fix

ttm:
- locking fix

amdgpu:
- Use kvzmalloc in amdgu_bo_create
- Use drm_dbg_kms for reporting failure to get a GEM FB
- Fix some register offsets for Sienna Cichlid
- Fix fall-through warning

radeon:
- memcpy_to/from_io fixes

msm:
- NULL ptr deref fix
- CP_PROTECT reg programming fix
- incorrect register shift fix
- DSI blank screen fix

sun4i:
- hdmi output probing fix

mcde:
- DSI pipeline calc fix

vc4:
- out of bounds fix

----------------------------------------------------------------
Alexey Minnekhanov (1):
      drm/msm: Init mm_list before accessing it for use_vram path

Changfeng (1):
      drm/amdgpu: switch kzalloc to kvzalloc in amdgpu_bo_create

Chen Li (1):
      radeon: use memcpy_to/fromio for UVD fw upload

Christian K=C3=B6nig (1):
      drm/ttm: fix deref of bo->ttm without holding the lock v2

Dave Airlie (3):
      Merge tag 'drm-msm-fixes-2021-06-10' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2021-06-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.13-2021-06-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Desmond Cheong Zhi Xi (2):
      drm: Fix use-after-free read in drm_getunique()
      drm: Lock pointer access in drm_master_release()

Gustavo A. R. Silva (1):
      drm/amd/pm: Fix fall-through warning for Clang

Jonathan Marek (3):
      drm/msm/a6xx: update/fix CP_PROTECT initialization
      drm/msm/a6xx: fix incorrectly set uavflagprd_inv field for A650
      drm/msm/a6xx: avoid shadow NULL reference in failure path

Linus Walleij (1):
      drm/mcde: Fix off by 10^3 in calculation

Mark Rutland (1):
      drm/vc4: fix vc4_atomic_commit_tail() logic

Michel D=C3=A4nzer (1):
      drm/amdgpu: Use drm_dbg_kms for reporting failure to get a GEM FB

Rohit Khaire (1):
      drm/amdgpu: Fix incorrect register offsets for Sienna Cichlid

Saravana Kannan (1):
      drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device

Stephen Boyd (1):
      drm/msm/dsi: Stash away calculated vco frequency on recalc

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  26 +++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |   1 +
 drivers/gpu/drm/drm_auth.c                         |   3 +-
 drivers/gpu/drm/drm_ioctl.c                        |   9 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 155 +++++++++++++++--=
----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |   1 +
 drivers/gpu/drm/msm/msm_gem.c                      |   7 +
 drivers/gpu/drm/radeon/radeon_uvd.c                |   4 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  31 ++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |   5 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |  41 +++++-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   5 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   8 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |   2 +-
 19 files changed, 232 insertions(+), 79 deletions(-)
