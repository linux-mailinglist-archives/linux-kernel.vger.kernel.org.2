Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790F2436BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJUUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJUUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:10:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C6C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:08:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t16so5440418eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MDqUpbVsNviKYhdyjMdLAGXgGjoSgVSfH4fiu5hfdr4=;
        b=LFEUapAo6IwWyTdh+DKxPkDife2XnFI/gRQOEkR3vftOBsruU+ey/SO9G/JUkKVsvK
         N5Z3ANLcw27ePYAkePSlg6gtzHxN8fcEbhnBnX4Us50D38CfwUO3qavpWBtfFtgwR93Z
         lyjYRaqKRkl/FnvHGVHPMswB5zX2rdELj38Q7AkPxrgLalYD/OkwHR9AWshFbR3B8Bg3
         0SOrbOdjDcX0ss15WnHcKEqNAxEW/lE9LNk/eqkrQr6bpB4BdYA5lenBJBudwZoYm0VE
         JlD1bl7AhLMS0ff1UaLvreZFZuly5uEwk3oIcDLL/jsfYl7KA/OspiPBAlcScOkTjZWW
         kqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MDqUpbVsNviKYhdyjMdLAGXgGjoSgVSfH4fiu5hfdr4=;
        b=0I63l+c0Yr/xLo5ZCGJfqMNH4GxkbkaGgfpuny4avsqtzXxqtzwOXXM6LvfXo2TPTl
         c2Xy3OJhZpX7nYVyoqhHFV/XoZhX7TVj1jOG4mt+qbKNobQEGYB+Y4TMRGt9D0+JlIUk
         xEWCm0mR3+neMPWA0mSExdCbnjL1CevNeCkGhX9O7gsJIIauGxjpOff/sSJwWO7A/RDz
         4JIFKw2ptSBWa4futBrmhrlqcKjk7V1eOqJej07tWUAymCJFUGwGWW2raFfxVD8U71RL
         96RrHeh/OauA8AVjOSUQ8ALVnoH2CuvBUNfqRjRMw+K/A7VojMdRA4oV1/oPFJDWgPjd
         juQQ==
X-Gm-Message-State: AOAM532SGFICDESpnpv3h/p20h/EIJdrcWeE7ZLBG8rKkthxUoEHd3Qq
        F1GBHOdwwjEg/OTfSSuK+fTECa/Q6H5gTAzx9sI=
X-Google-Smtp-Source: ABdhPJxN7Nh1YekIv0OrV1MCQmSwGGTQnwRNlkKCDE0GB7Uaknrka26ZhPkZvVq+ODfvuGABfI47+8Ldj/hcWmyZIx8=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr10411503edx.90.1634846911658;
 Thu, 21 Oct 2021 13:08:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Oct 2021 06:08:20 +1000
Message-ID: <CAPM=9tzoEc2rNg9tObnmTnqhg_BEcKQiqgAgqAQOphJa1M760g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.15-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nothing too crazy at the end of the cycle, the kmb modesetting fixes
are probably a bit large but it's not a major driver, and its fixing
monitor doesn't turn on type problems. Otherwise it's just a few minor
patches, one ast regression revert, an msm power stability fix.

Dave.

drm-fixes-2021-10-22:
drm fixes for v5.15-rc7

ast:
- fix regression with connector detect

msm:
- fix power stability issue

msxfb:
- fix crash on unload

panel:
- sync fix

kmb:
- modesetting fixes
The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-22

for you to fetch changes up to 595cb5e0b832a3e100cbbdefef797b0c27bf725a:

  Revert "drm/ast: Add detect function support" (2021-10-22 05:52:12 +1000)

----------------------------------------------------------------
drm fixes for v5.15-rc7

ast:
- fix regression with connector detect

msm:
- fix power stability issue

msxfb:
- fix crash on unload

panel:
- sync fix

kmb:
- modesetting fixes

----------------------------------------------------------------
Anitha Chrisanthus (4):
      drm/kmb: Work around for higher system clock
      drm/kmb: Limit supported mode to 1080p
      drm/kmb: Corrected typo in handle_lcd_irq
      drm/kmb: Enable ADV bridge after modeset

Dan Johansen (1):
      drm/panel: ilitek-ili9881c: Fix sync for Feixin K101-IM2BYL02 panel

Dave Airlie (2):
      Merge tag 'drm-msm-fixes-2021-10-18' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2021-10-21-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Edmund Dea (2):
      drm/kmb: Remove clearing DPHY regs
      drm/kmb: Disable change of plane parameters

Kim Phillips (1):
      Revert "drm/ast: Add detect function support"

Marek Vasut (1):
      drm: mxsfb: Fix NULL pointer dereference crash on unload

Rob Clark (1):
      drm/msm/devfreq: Restrict idle clamping to a618 for now

 drivers/gpu/drm/ast/ast_mode.c                | 18 +----------
 drivers/gpu/drm/kmb/kmb_crtc.c                | 41 +++++++++++++++++++++++--
 drivers/gpu/drm/kmb/kmb_drv.c                 |  2 +-
 drivers/gpu/drm/kmb/kmb_drv.h                 | 10 ++++++-
 drivers/gpu/drm/kmb/kmb_dsi.c                 | 25 +++++++++-------
 drivers/gpu/drm/kmb/kmb_dsi.h                 |  2 +-
 drivers/gpu/drm/kmb/kmb_plane.c               | 43 ++++++++++++++++++++++++++-
 drivers/gpu/drm/kmb/kmb_plane.h               |  6 ++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  7 +++++
 drivers/gpu/drm/msm/msm_gpu.h                 |  4 +++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c         |  3 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  6 +++-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 ++++----
 13 files changed, 137 insertions(+), 42 deletions(-)
