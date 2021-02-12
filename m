Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C841319982
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 06:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLFWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 00:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLFWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 00:22:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:21:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v7so9361564eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=y7nisrS3slztw05efKZSiiT4QAGyRq7lEBDg3AjV2Is=;
        b=pk+8zyPjingFZSCd9/PGKungold785BclOnmbLoVMZUHkhl4AVKo53J/KB/jKs7934
         43VLhehx39QmmU7UeFEgvagz/E0JXNSaTWECUL3iQueDEXZQ/WuJOz7tQyZWzAo3QiV1
         rABWzhw36f9WGv1uq/usyEzvv8RzRnoGUzJWg0VlgjxzGlmeHqGf0kDwBKtJmkdQAvS0
         Mlu1WU//Nspxlvl6N/OjKQkPSkcpG+cxrrfS++VUjpvFK/lrZ+z//4BkAiCtnPRN8Krh
         4Ac3K9GPyVOLtj7va9eV9IZ9NtrcEoHQNtMwUTa5Wgmoi3LTk9pzW4or3i+FBvX40GGF
         Z+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=y7nisrS3slztw05efKZSiiT4QAGyRq7lEBDg3AjV2Is=;
        b=jUw2cC5Qnl8eYT9Lm4rXmD7kpB/caeVICUIsmoKasYtSApICQbz0coUqJYaQPms8gI
         8dHK1gETBXIBXQC7CyWtZ16Uj4gwdf3oH4OzmAJv+Z6QeSt8INN/uYBa8lVS+D//wmBq
         wr42I5JdFdUF8abRZveslz3oKkwrNEajvdeGr9aJ7hcBBEE+fjM4dT+0pgazcmKxiKCe
         sTFoSoLUSzfmVBh2Ka392oMg0gphxw3sy7wZEXobTCCjf503EpzHJ8rtCDh1xebKvkzi
         ZVEEI/bkJPYenmjzYGEOSyDQBcTNCKTFFikHMv/W79i0WxYHjV7isT+v5vaLn79W5mJk
         R+iw==
X-Gm-Message-State: AOAM533Agibn5L7YZRhWUt2tSTx74M4uJ8lYjC/N1+AUWwx6eQc9iAQ5
        CuD9iyXShTn/g9mZ0YrdgWXfkG4dRuLhDZCz044=
X-Google-Smtp-Source: ABdhPJydRleu4Fi+tqpKqqHCMi9CV5hHYI+6tlLSCZbldCZoclHith8iIAgpBYk0In5/HikHvJypJlQdbxn6nWWiIo0=
X-Received: by 2002:a50:9dcd:: with SMTP id l13mr1597472edk.220.1613107262891;
 Thu, 11 Feb 2021 21:21:02 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Feb 2021 15:20:52 +1000
Message-ID: <CAPM=9tyT7BXCT-CKZed4F+CP4Anpgb4X4LBHv4mxcvLzMwBcQA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resent with a subject this time)
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
