Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897513947AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhE1UCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhE1UCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:02:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:01:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a25so6122742edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XVXfZwPZFKcCSAJsJtKc65k2oF75TB0+EMNVC1jdGig=;
        b=CU6zf2IaEABOz1G19VE3RNZam4EkKciYmCtN+ndVfLGg2wppX2/fD8/TV3H4fRvxo4
         ElmDS/tfdm7ba/BQdQUf7onfK8SPNGDEqqHGG4KaZ5tCkotoR3vPNjfJBmspeCKc2JNH
         U0ZohQEoIxKU5pdqDQKPbKkZ7VU3sHpU7yKSodKXVW19mzEHlFXdhMex48ZqAGlWvet+
         4GS3EMUvlFUkfqTyFcsiiJkAlXlqzNRXigA4wYKs15G6bjW528Zf3TSIGU9dtGt5QZ+6
         /WHmNQsSYCeJyU0RifGM07pwaeiDj2hoI6mXC/ztm9N2g93bovSQ8jQ8IZjL0VHC49f9
         H3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XVXfZwPZFKcCSAJsJtKc65k2oF75TB0+EMNVC1jdGig=;
        b=ktgiaeO7ruSS1LCI1kFDg4i09XMKbnvRSaRIuz7XggacUWXrbqcGV6F9bLZ0n573cR
         AdOoLulfkG8LWbm5gMne0r8P5VbNpKLDJU4sjrMuWyLkAHXPhGEMy616J2uRs/+MunT1
         6ZyKY6kQ/axxtk3tzFjB8qY1Nkm/IzJCU8yEUbeSyeK6Q7/aR8s+93Np6QfLn8KTDN6E
         3M8JZvGlycO666mPcvbu7mmjzqNi56TKF6z6wcq/RuCl3HDoTzGLgPfoKV0YZSBdxirm
         IRWz8NA6dcKp85WOmfk2jcX6fvc474kh+tbuS2MnuxHV0PohN5izIUhZpCy8u5e7s00J
         sisg==
X-Gm-Message-State: AOAM533Kk1uGS/upgrJSmX7wVghGr16q8M2oqw255eBnVkGbMIV1NoEv
        6EN6Yu4Vqk4ho7GzT4ltcrHIyKLOfmS6MQ+9apGxaVNz0KI=
X-Google-Smtp-Source: ABdhPJxkQcDQjk8PB8knVzCjHloLShbgaSNhs3NRDqcJXlr/olLTrFrneV3xYixI6wvTwW3WAtXPo6JngghBeTTrH4c=
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr11857017eds.78.1622232060781;
 Fri, 28 May 2021 13:01:00 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 29 May 2021 06:00:49 +1000
Message-ID: <CAPM=9twKOn4j8-_gDfm_DsQv-96MA6Wv+76bURR6Tb34jkVMcQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Pretty quiet this week, couple of amdgpu, one i915, and a few misc otherwise.

Dave.

drm-fixes-2021-05-29:
drm fixes for 5.13-rc4

ttm:
- prevent irrelevant swapout

amdgpu:
- MultiGPU fan fix
- VCN powergating fixes

amdkfd:
- Fix SDMA register offset error

meson:
- fix shutdown crash

i915:
- Re-enable LTTPR non-transparent LT mode for DPCD_REV<1.4
The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-29

for you to fetch changes up to aeeb517368822e2b24231f5bd43a98ecdbe65d59:

  Merge tag 'drm-intel-fixes-2021-05-27' of
ssh://git.freedesktop.org/git/drm/drm-intel into drm-fixes (2021-05-28
13:28:18 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc4

ttm:
- prevent irrelevant swapout

amdgpu:
- MultiGPU fan fix
- VCN powergating fixes

amdkfd:
- Fix SDMA register offset error

meson:
- fix shutdown crash

i915:
- Re-enable LTTPR non-transparent LT mode for DPCD_REV<1.4

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.13-2021-05-26' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2021-05-27' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-05-27' of
ssh://git.freedesktop.org/git/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/pm: correct MGpuFanBoost setting

Imre Deak (1):
      drm/i915: Reenable LTTPR non-transparent LT mode for DPCD_REV<1.4

James Zhu (7):
      drm/amdgpu/vcn1: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.0: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.5: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn3: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg2.0: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg2.5: add cancel_delayed_work_sync before power gate
      drm/amdgpu/jpeg3: add cancel_delayed_work_sync before power gate

Kevin Wang (1):
      drm/amdkfd: correct sienna_cichlid SDMA RLC register offset error

Neil Armstrong (1):
      drm/meson: fix shutdown crash when component not probed

xinhui pan (1):
      drm/ttm: Skip swapout if ttm object is not populated

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   | 12 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  9 +++
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 71 ++++++++++------------
 drivers/gpu/drm/meson/meson_drv.c                  |  9 +--
 drivers/gpu/drm/ttm/ttm_device.c                   |  2 +-
 13 files changed, 81 insertions(+), 57 deletions(-)
