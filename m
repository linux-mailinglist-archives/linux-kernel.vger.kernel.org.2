Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BA3198F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBLEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLEGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:06:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB568C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:05:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o24so7933865wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rxL2ZdJbDHUrT389hOkONongD6kVNs5LVwbbqcPfTyE=;
        b=npFLVzHcGKoxIyZzsHrk69mDpjm8sU8n8/Rv7sPWvQf2I3LpGSzKxk34pPtQs9nqGR
         7sjUMzvKlqSTZLC/lWXp1Sxok+TsmhJePsfHISOn7u7UTQIFK0tZigNgA87OpjEzrnhE
         poMs7lzQAfOl01COEg/VKt234ZPFHlkXe7vsJ3YBT4z2e87X0JnJuXgN++QSiYZGxQYG
         elNORRQvTohwA57GU50KOW7DF+liD/3N9svM4Wu8Z0ReJ+NFjy2avnKotSC264E677dz
         V4I5TK6nuBAFWMeyW0wblIf6ZL9MKIEHi05ksUu9V/sRU7UXI17+fTe31J5MVMUY2L57
         iSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rxL2ZdJbDHUrT389hOkONongD6kVNs5LVwbbqcPfTyE=;
        b=AQAx7ryWHMPI7D194NjmOO60oq51kDznWddQPWG7JEt33Y5mWJ4FIcuQG6MR53v1L/
         YJW0iR1Pjo55cxUwXhpAsUFFzugKM0PHjdupKhhkintOPaDhWPFU6nj+184q+x8CyY8b
         jQ0jPfgcxMyUjmG+E0sNY+qhR0ksi9L7Znh41A/+yT84oTWdkhrpSUFZB5zBpALHj8C+
         AY/F4Len530oOFnHEbTo/T6CwpkKKynQMyUv75puowHyA4qxO8q2PJfLdh0UorhSmWDk
         VqXWI2ZxZuPNEIcnxSOXLF9dW41LfqGXMx8tVZKe1z9ssTi+HsdFBNcn8T9zx0X6dKvM
         vt+A==
X-Gm-Message-State: AOAM5339cPEw/GDXjLs5lEDHM+mDBQeeBk710fD7rLBTKF2kAVGrs5VO
        7+hQExasymhCe0Qq5pOkEka+OAceki4UrDGWl7E=
X-Google-Smtp-Source: ABdhPJxjQJ3LNkRy7ABJzzM0Rc/fsjycra7GaWI1GgHB44HpYhguqPFuIDZzHkLx6EJPh+LNiWzufL2T4begKdBPTcg=
X-Received: by 2002:a1c:8181:: with SMTP id c123mr875041wmd.23.1613102736770;
 Thu, 11 Feb 2021 20:05:36 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Feb 2021 14:05:24 +1000
Message-ID: <CAPM=9twZ1h_F96JjMxoWmGB55ju_X=67uvYoqZL8==zNkYtQ1w@mail.gmail.com>
Subject: 
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

Regular fixes for final, there is a ttm regression fix, dp-mst fix,
one amdgpu revert, two i915 fixes, and some misc fixes for sun4i,
xlnx, and vc4.

All pretty quiet and don't think we have any known outstanding regressions.

Dave.

drm-fixes-2021-02-12:
drm fixes for 5.11-rc8

ttm:
- page pool regression fix.

dp_mst:
- Don't report un-attached ports as connected

amdgpu:
- Blank screen fix

i915:
- Ensure Type-C FIA is powered when initializing
- Fix overlay frontbuffer tracking

sun4i:
- tcon1 sync polarity fix
- Always set HDMI clock rate
- Fix H6 HDMI PHY config
- Fix H6 max frequency

vc4:
- Fix buffer overflow

xlnx:
- Fix memory leak
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3=
:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-02-12

for you to fetch changes up to 551c81853d6d3ff016269d62612e7cd0a53104ab:

  Merge branch 'drm-misc-fixes' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2021-02-12
13:38:51 +1000)

----------------------------------------------------------------
drm fixes for 5.11-rc8

ttm:
- page pool regression fix.

dp_mst:
- Don't report un-attached ports as connected

amdgpu:
- Blank screen fix

i915:
- Ensure Type-C FIA is powered when initializing
- Fix overlay frontbuffer tracking

sun4i:
- tcon1 sync polarity fix
- Always set HDMI clock rate
- Fix H6 HDMI PHY config
- Fix H6 max frequency

vc4:
- Fix buffer overflow

xlnx:
- Fix memory leak

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amd/display: Update NV1x SR latency values"

Christian K=C3=B6nig (1):
      drm/ttm: make sure pool pages are cleared

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.11-2021-02-10' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-02-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-misc-fixes' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Imre Deak (2):
      drm/dp_mst: Don't report ports connected if nothing is attached to th=
em
      drm/i915/tgl+: Make sure TypeC FIA is powered up when initializing it

Jernej Skrabec (4):
      drm/sun4i: tcon: set sync polarity for tcon1 channel
      drm/sun4i: dw-hdmi: always set clock rate
      drm/sun4i: Fix H6 HDMI PHY configuration
      drm/sun4i: dw-hdmi: Fix max. frequency for H6

Maxime Ripard (1):
      drm/vc4: hvs: Fix buffer overflow with the dlist handling

Quanyang Wang (1):
      drm/xlnx: fix kmemleak by sending vblank_event in atomic_disable

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix overlay frontbuffer tracking

 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  4 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |  1 +
 drivers/gpu/drm/i915/display/intel_overlay.c       | 17 +++---
 drivers/gpu/drm/i915/display/intel_tc.c            | 67 ++++++++++++------=
----
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 25 ++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |  6 ++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              | 10 +---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |  1 -
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             | 26 +++------
 drivers/gpu/drm/ttm/ttm_pool.c                     | 10 ++++
 drivers/gpu/drm/vc4/vc4_plane.c                    | 18 ++++--
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 | 15 +++--
 12 files changed, 122 insertions(+), 78 deletions(-)
