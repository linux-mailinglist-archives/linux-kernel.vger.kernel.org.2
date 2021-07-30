Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B693DB086
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 03:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhG3BLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3BLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 21:11:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0FBC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 18:11:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j2so10632155edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Co/e7CAYLfOTocind5NVDXjDIOQtVq2jyYw3O7rdTr8=;
        b=s9DnSYlLMvRSOgTRK4n8dPto4nCKU3bkcDElqAOBclM3WQ0tqGx4ikv5KYe6hVlckk
         WXYZmhaJcKD3gC9oJ7o2H/MY+5WsTW5Ghj3EzK9MrA1UyyN64FFSavmt3u+p0/cZoDK0
         gDcCciPfyw+yu69Z49Ct5pOmGRcYRsJdPrpwLuRfqL4ySbcvaplsNIGFNb+RP/23hDWR
         pBQdXKsmvye9iaX3b5J7HGt4M8Dy8aTa2LzR8ib1awyHPqQh28LlZ3faf4j5IN/qzOgX
         jA30oQOaNQCWuwz6QL37DjdJWQUP8Y8M35HOy3r87Ut21q5FurwNQczwrInuEGTCgFcr
         MVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Co/e7CAYLfOTocind5NVDXjDIOQtVq2jyYw3O7rdTr8=;
        b=rAnFSHGIQN9w6A4p5oOBqnms+Nijm3JAto1zd0lwC1p7zSSe76p75MuCW3RHPhVeAn
         LsZnFksXTQq/AyxrJlx/LSB85SmSApWzNrE71H9NnnpKIt5HhWxJAGCQwBkPKVFniU6L
         In1gfB/QQy1dUFlB6hFZd2S2DeudS4skOwzsZK3qjwKKwX06LQbd7IZF+ypCpIoyKXOT
         rSMas49yIDqVKjAigHw/6KmVaVkSMv2laxcXosZ243DQ5D65DgHKW+CDnPJiXJdOIyI8
         EdMLkCFeT+HMaD1Vqvej60p17cWHSTfWz43CGTJeQxm1+PbwFCS8q8BfNf/VffY3yogu
         paKA==
X-Gm-Message-State: AOAM533XILQH0QOaouubQmNwGNjkNSFlkPC627cbUxW5GC9dchUmZrkd
        HA/k1+EgiX/gYXqbHKbEji1F7UwOeuN9SslCA7Jh4k0iEQ6E77wR
X-Google-Smtp-Source: ABdhPJxeCDic6qzBO9sZWJ8GzDfyisuRB9GISoF+UEocdUBoXSaKeYswP1TAynEpjIn6BlTXKiMIklLtyVYLhmWmmBY=
X-Received: by 2002:a05:6402:1289:: with SMTP id w9mr9290346edv.127.1627607498641;
 Thu, 29 Jul 2021 18:11:38 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 30 Jul 2021 11:11:27 +1000
Message-ID: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.14-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular drm fixes pull, seems about the right size, lots of small
fixes across the board, mostly amdgpu, but msm and i915 are in there
along with panel and ttm. There is an rc3 backmerge due to some
patches ending up in the gap between last and this week.

Dave.

drm-fixes-2021-07-30:
drm fixes for 5.14-rc4

amdgpu:
- Fix resource leak in an error path
- Avoid stack contents exposure in error path
- pmops check fix for S0ix vs S3
- DCN 2.1 display fixes
- DCN 2.0 display fix
- Backlight control fix for laptops with HDR panels
- Maintainers updates

i915:
- Fix vbt port mask
- Fix around reading the right DSC disable fuse in display_ver 10
- Split display version 9 and 10 in intel_setup_outputs

msm:
- iommu fault display fix
- misc dp compliance fixes
- dpu reg sizing fix

panel:
- Fix bpc for ytc700tlag_05_201c

ttm:
- debugfs init fixes
The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-07-30

for you to fetch changes up to d28e2568ac26fff351c846bf74ba6ca5dded733e:

  Merge tag 'amd-drm-fixes-5.14-2021-07-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-07-29
17:20:29 +1000)

----------------------------------------------------------------
drm fixes for 5.14-rc4

amdgpu:
- Fix resource leak in an error path
- Avoid stack contents exposure in error path
- pmops check fix for S0ix vs S3
- DCN 2.1 display fixes
- DCN 2.0 display fix
- Backlight control fix for laptops with HDR panels
- Maintainers updates

i915:
- Fix vbt port mask
- Fix around reading the right DSC disable fuse in display_ver 10
- Split display version 9 and 10 in intel_setup_outputs

msm:
- iommu fault display fix
- misc dp compliance fixes
- dpu reg sizing fix

panel:
- Fix bpc for ytc700tlag_05_201c

ttm:
- debugfs init fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/display: only enable aux backlight control for OLED panels

Bjorn Andersson (1):
      drm/msm/dp: Initialize the INTF_CONFIG register

Dale Zhao (1):
      drm/amd/display: ensure dentist display clock update finished in DCN20

Dave Airlie (4):
      Merge tag 'drm-msm-fixes-2021-07-27' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2021-07-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-07-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.14-2021-07-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Jagan Teki (1):
      drm/panel: panel-simple: Fix proper bpc for ytc700tlag_05_201c

Jason Ekstrand (1):
      drm/ttm: Initialize debugfs from ttm_global_init()

Jiri Kosina (2):
      drm/amdgpu: Fix resource leak on probe error path
      drm/amdgpu: Avoid printing of stack contents on firmware load error

Kuogee Hsieh (2):
      drm/msm/dp: use dp_ctrl_off_link_stream during PHY compliance test run
      drm/msm/dp: signal audio plugged change at dp_pm_resume

Lucas De Marchi (2):
      drm/i915: fix not reading DSC disable fuse in GLK
      drm/i915/display: split DISPLAY_VER 9 and 10 in intel_setup_outputs()

Pratik Vishwakarma (1):
      drm/amdgpu: Check pmops for desired suspend state

Rob Clark (1):
      drm/msm: Fix display fault handling

Robert Foss (1):
      drm/msm/dpu: Fix sm8250_mdp register length

Rodrigo Vivi (1):
      drm/i915/bios: Fix ports mask

Sean Paul (1):
      drm/msm/dp: Initialize dp->aux->drm_dev before registration

Simon Ser (1):
      maintainers: add bugs and chat URLs for amdgpu

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Victor Lu (2):
      drm/amd/display: Guard DST_Y_PREFETCH register overflow in DCN21
      drm/amd/display: Add missing DCN21 IP parameter

 MAINTAINERS                                              |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                 |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c               |  8 ++------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c                   |  7 +++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        |  4 ++--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c    |  1 +
 .../drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c   |  3 +++
 drivers/gpu/drm/i915/display/intel_bios.c                |  3 ++-
 drivers/gpu/drm/i915/display/intel_display.c             |  8 +++++++-
 drivers/gpu/drm/i915/intel_device_info.c                 |  9 +++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           |  2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c                      |  1 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                         |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                      |  5 +++++
 drivers/gpu/drm/msm/msm_iommu.c                          | 11 ++++++++++-
 drivers/gpu/drm/panel/panel-simple.c                     |  2 +-
 drivers/gpu/drm/ttm/ttm_device.c                         | 12 ++++++++++++
 drivers/gpu/drm/ttm/ttm_module.c                         | 16 ----------------
 19 files changed, 61 insertions(+), 40 deletions(-)
