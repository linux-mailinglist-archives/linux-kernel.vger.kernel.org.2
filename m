Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362C943E8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJ1TRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1TQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:16:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:14:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so28368272edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5ojLsCpfNAlUcTskJp6rsZY21B6sY/VX+UQ6ok+M4/Q=;
        b=Ra89hbLYPBAFTl59WQ8ccGq+LL9M97zhqQu6o2fov1KDfv8VEcb+ua2UHXjlIJnpRK
         YXttec5TD3cyUBX6LA8nScRZpdUWWyZhO1QXcunwWy1naf5eP6o/IbBHQ1DMlRnLumJe
         kygzyPHwlCJY9E2qLD1rClCF/dpf1QBEMnwOTHoFd1WcDk34jF8j3j2293lI0qYeOydG
         6JvOFKYivsNPkGzXNJuLNSq4RjNiiNW3Io0fqyZmZ/T87XF68IrPmfkz91sIqAy6CCMV
         +brQKy5EebKwa5+ZT80g9pr0amUsFDY2OiZz7sX38zpU0jPL+NqhILL8VJx6Xrfbp7Ua
         VnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5ojLsCpfNAlUcTskJp6rsZY21B6sY/VX+UQ6ok+M4/Q=;
        b=R/g5cMTZRaCA+FPvrBA59H/JlKQ4KBzlRIwY43koaopzv0i7Wwgi9CMxIZMvAxquER
         CaBm9VcpZ9LJs1uyz5RFNsSsVx35KQT/cJuZHc7JaJbQE0CgbtvkB3N/ne+DOMsN817O
         FcWgArj8Dwg2/5LMF7ozf3lahLORqxkpcYuAF0mAmLfrmD94/SbNTdQjcwg4FDFtcgO8
         g6DJwhpb5Y8Ygk3d+FRMb4vpNdBdDsLK4i+EFE/gAzEtb5hii0QyFIrzKyjG+1GfWt2i
         naZTqZi1BuKSaEFJxI8KPwiL5fjIYtQL1T3oFwUWDkJ9ikWE3CZ+g3gb096Ya7xWODtr
         GuEw==
X-Gm-Message-State: AOAM532ONO/lVP9w0KOgENq27TBSH3ojy2JqPqqjJDfSsio5lq2Xs5Z9
        uzcADZnJAuYSkiSCMwgZKZ5W/XImjGP7lT/anI85SI1cNW0=
X-Google-Smtp-Source: ABdhPJw4CjWJ8BjZkJLwt0AYD32zbQfBFtou0bzldpRHIyrs5wcDMJCuHN+jb8OQZvEJwjqTG8vixIcKZomTxJxoDl4=
X-Received: by 2002:a05:6402:26c1:: with SMTP id x1mr8544268edd.395.1635448470197;
 Thu, 28 Oct 2021 12:14:30 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Oct 2021 05:14:19 +1000
Message-ID: <CAPM=9tw2U8mu1H+yCg=eRvoWOJXu7FD81doH+qQhWt-yznRSbQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.15 final
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

Quiet but not too quiet, I blame Halloween. The first set of amdgpu
fixes missed last week, hence why this has a few more of them, it's
mostly display fixes for new GPUs and some debugfs OOB stuff. The i915
patches have one to remove a tracepoint possible issue before it's a
real problem, the others around cflush and display are cc'ed to stable
as well. Otherwise it's just a few misc fixes.

Dave.

drm-fixes-2021-10-29:
drm fixes for 5.15 final

MAINTAINERS:
- change the paths

ttm:
- Fix fence leak in ttm_transfered_destroy.

core:
- add GPD Win3 rotation quirk

i915:
- Remove unconditional clflushes
- Fix oops on boot due to sync state on disabled DP encoders
- Revert backend specific data added to tracepoints
- Remove useless and incorrect memory frequency calculation

panel:
- Add quirk for Aya Neo 2021

seltest:
- Reset property count for each drm damage selftest so full run will
work correctly.

amdgpu:
- Fix two potential out of bounds writes in debugfs
- Fix revision handling for Yellow Carp
- Display fixes for Yellow Carp
- Display fixes for DCN 3.1
The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea=
:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-29

for you to fetch changes up to b112166a894db446f47a8c31781b037f28ac1721:

  MAINTAINERS: dri-devel is for all of drivers/gpu (2021-10-29 04:49:11 +10=
00)

----------------------------------------------------------------
drm fixes for 5.15 final

MAINTAINERS:
- change the paths

ttm:
- Fix fence leak in ttm_transfered_destroy.

core:
- add GPD Win3 rotation quirk

i915:
- Remove unconditional clflushes
- Fix oops on boot due to sync state on disabled DP encoders
- Revert backend specific data added to tracepoints
- Remove useless and incorrect memory frequence calculation

panel:
- Add quirk for Aya Neo 2021

seltest:
- Reset property count for each drm damage selftest so full run will
work correctly.

amdgpu:
- Fix two potential out of bounds writes in debugfs
- Fix revision handling for Yellow Carp
- Display fixes for Yellow Carp
- Display fixes for DCN 3.1

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: support B0&B1 external revision id for yellow carp

Bryant Mairs (1):
      drm: panel-orientation-quirks: Add quirk for Aya Neo 2021

Christian K=C3=B6nig (1):
      drm/ttm: fix memleak in ttm_transfered_destroy

Daniel Vetter (2):
      drm/i915/selftests: Properly reset mock object propers for each test
      MAINTAINERS: dri-devel is for all of drivers/gpu

Dave Airlie (5):
      Merge tag 'amd-drm-fixes-5.15-2021-10-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'amd-drm-fixes-5.15-2021-10-27' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2021-10-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-misc-fixes-2021-10-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-10-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Eric Yang (1):
      drm/amd/display: increase Z9 latency to workaround underflow in Z9

Imre Deak (1):
      drm/i915/dp: Skip the HW readout of DPCD on disabled encoders

Jake Wang (1):
      drm/amd/display: Moved dccg init to after bios golden init

Joonas Lahtinen (1):
      drm/i915: Revert 'guc_id' from i915_request tracepoint

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Remove memory frequency calculation

Mario (1):
      drm: panel-orientation-quirks: Add quirk for GPD Win3

Michael Strauss (1):
      drm/amd/display: Fallback to clocks which meet requested voltage on D=
CN31

Nicholas Kazlauskas (3):
      drm/amd/display: Fix prefetch bandwidth calculation for DCN3.1
      drm/amd/display: Require immediate flip support for DCN3.1 planes
      drm/amd/display: Fix deadlock when falling back to v2 from v3

Nikola Cornij (2):
      drm/amd/display: Limit display scaling to up to true 4k for DCN 3.1
      drm/amd/display: Increase watermark latencies for DCN3.1

Patrik Jakobsson (1):
      drm/amdgpu: Fix even more out of bound writes from debugfs

Thelford Williams (1):
      drm/amdgpu: fix out of bounds write

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Convert unconditional clflush to drm_clflush_virt_range()
      drm/i915: Catch yet another unconditioal clflush

 MAINTAINERS                                        |  3 +--
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 20 +++++++--------
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 29 +++++++++++++-----=
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |  7 +++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  | 13 +++++++---
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  6 ++---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |  2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  6 ++---
 drivers/gpu/drm/drm_panel_orientation_quirks.c     | 12 +++++++++
 drivers/gpu/drm/i915/display/intel_dp.c            |  3 +++
 drivers/gpu/drm/i915/gt/intel_timeline.c           |  4 +--
 drivers/gpu/drm/i915/i915_reg.h                    |  8 ------
 drivers/gpu/drm/i915/i915_trace.h                  |  7 ++---
 drivers/gpu/drm/i915/intel_dram.c                  | 30 ++----------------=
----
 drivers/gpu/drm/selftests/test-drm_damage_helper.c |  1 +
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  1 +
 17 files changed, 72 insertions(+), 82 deletions(-)
