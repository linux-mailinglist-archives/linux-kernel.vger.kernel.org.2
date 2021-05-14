Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08638020A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 04:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhENCgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 22:36:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 19:34:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a25so8959063edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qLkpZ5mHZqNRCJyPF42saSN+H4CFvyq10lBWfFLuvPE=;
        b=qfApGizmMCBFfNj3S/x3lA2EtPQ+rEMMvnuAdcGibe3UkP7oTdy+NbQNHpPdxlK64b
         P8kCeHYcfuP9ameQeQl5GQniCmny2Y/pBI1s4NPNzcZ1gQVwo8o9IKNhYbnUfu4z5NBL
         5DMONjHhUW5kEUyxKCK/bnyGnJkR9D2yGbRhgrJQHV8tVVCgg/VA9CXqwq9hzC+HdJwK
         d+t6OJywE4YqotjbPN16k/QN5E4FtmrZC7wbqW8ZIZGDRqVj6O41CszpIeHW5+LJ9nMC
         muB7Xy0xcERPjjpLhX653Fm+fs4s9kHtVMvWdEMWagRNrhkhrns6sLhV+2lGQhcOA0g3
         TrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qLkpZ5mHZqNRCJyPF42saSN+H4CFvyq10lBWfFLuvPE=;
        b=kL5cOUkfJah/t6palnp9grWcMFFA+KAJIYFNvXw2LhIceP+DTrCtps8GtiYjcE6lQK
         ex7kRHypRaySpsXpuH7qqIrXI4G9yzkbEHmngkiLTA388b/c9rgnY7YnQeTBPN2ncake
         HsxnGDIcj+CqsiK9joI3rf2lmzaf/8wu1anaHrIKZy2/3aQTBDfb3nGjiQOjnqFGGByU
         QSD9WLixJ9cM6qjNIdSYlwOa6KCsL5/Ox2PdW2l9T9cZPXbf0SIQiX8mjd9ZuOxNbRdX
         1UEAaH7+oKPgLNWey92A6F4rmdlbyAyFN7STa0mX3VR1/01zzGX68FUB+UO4btNhrEJX
         3MoQ==
X-Gm-Message-State: AOAM530vPuQVmY9jQfwIftI4qhmFLcCvqh2s9uMl6yb4uqnl3ASu+mb/
        JdUK98mlgYLzFIB/xl+23KojtNN84oasMOX8ImU=
X-Google-Smtp-Source: ABdhPJxHNSbSqdxxl04VURLOlxdorRW3HueXOAdt+EbpmiGJeb3lbzhgwYmWlozr+DZTRmbCBotoHoTMB32iXxROzmM=
X-Received: by 2002:a05:6402:1115:: with SMTP id u21mr53290701edv.383.1620959689370;
 Thu, 13 May 2021 19:34:49 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 14 May 2021 12:34:38 +1000
Message-ID: <CAPM=9tyXjogjugi55XdAQd-ucMCk=ohDXS+vqdiaMk_aCL6aHQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just realised I got the tag header wrong, these are the rc2 fixes. Not
much here, mostly amdgpu fixes, with a couple of radeon, and a
cosmetic vc4. Two MAINTAINER file updates also.

Dave.

drm-fixes-2021-05-14:
drm fixes for 5.13-rc1

two MAINTAINERS updates.

amdgpu:
- Fixes for flexible array conversions
- Fix sysfs attribute init
- Harvesting fixes
- VCN CG/PG fixes for Picasso

radeon:
- Fixes for flexible array conversions
- Fix for flickering on Oland with multiple 4K displays

vc4:
- drop unused function
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-14

for you to fetch changes up to 08f0cfbf739a5086995f0779bbcb607163128a9a:

  Merge tag 'amd-drm-fixes-5.13-2021-05-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-05-14
09:20:04 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc1

two MAINTAINERS updates.

amdgpu:
- Fixes for flexible array conversions
- Fix sysfs attribute init
- Harvesting fixes
- VCN CG/PG fixes for Picasso

radeon:
- Fixes for flexible array conversions
- Fix for flickering on Oland with multiple 4K displays

vc4:
- drop an used function

----------------------------------------------------------------
Daniel Vetter (1):
      MAINTAINERS: Update address for Emma Anholt

Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2021-05-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.13-2021-05-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Ward (1):
      drm/amd/display: Initialize attribute for hdcp_srm sysfs file

Gustavo A. R. Silva (3):
      drm/radeon/ni_dpm: Fix booting bug
      drm/radeon/si_dpm: Fix SMU power state load
      drm/amd/pm: Fix out-of-bounds bug

Jernej Skrabec (1):
      MAINTAINERS: Update my e-mail

Jiapeng Chong (1):
      drm/vc4: remove unused function

Kai-Heng Feng (1):
      drm/radeon/dpm: Disable sclk switching on Oland when two 4K 60Hz
monitors are connected

Likun GAO (1):
      drm/amdgpu: add judgement when add ip blocks (v2)

Likun Gao (1):
      drm/amdgpu: update the method for harvest IP for specific SKU

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Sathishkumar S (2):
      drm/amdgpu: set vcn mgcg flag for picasso
      drm/amdgpu: update vcn1.0 Non-DPG suspend sequence

xinhui pan (1):
      drm/ttm: Do not add non-system domain BO into swap list

 .mailmap                                           |   1 +
 MAINTAINERS                                        |  18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  28 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  38 +++--
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  13 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h           |   6 +
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 174 ++++++++++----------
 drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h    |  34 ++--
 drivers/gpu/drm/radeon/ni_dpm.c                    | 144 ++++++++---------
 drivers/gpu/drm/radeon/nislands_smc.h              |  34 ++--
 drivers/gpu/drm/radeon/radeon.h                    |   1 +
 drivers/gpu/drm/radeon/radeon_pm.c                 |   8 +
 drivers/gpu/drm/radeon/si_dpm.c                    | 177 +++++++++++----------
 drivers/gpu/drm/radeon/sislands_smc.h              |  34 ++--
 drivers/gpu/drm/vc4/vc4_vec.c                      |   6 -
 20 files changed, 419 insertions(+), 318 deletions(-)
