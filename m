Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B283632B0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhDQXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhDQXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:49:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA32C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 16:49:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r9so47416673ejj.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UwrwiMr5+8D/40Mctvun36r5UE8676az6W/LOijCYUM=;
        b=OAoaPs/8g2B8juzXkGkt6eBfzJvdVhQUUGG05AlgQMh1Fm3I7hUoDK9+TbLGuHtnZU
         r914KfIS07oxLzqeNtnELxfwIUcv4+eIZhw3RqdPGYSV2+j6fPVsH+QM5tg322wXBBJc
         PIe3Q20kG/wjhRsf+SjygjRccodes7VMYrS17c5MSANC4AzVMMm2pjwWSep0rSluiV21
         F0u1+C7TUP/gkXYQ9DX75cOD16LgqU7Wg/2lYQ7Rk0pacCbIPAGn2tTdcj54DX9rd4ek
         NUe1GMFkmbK9f0Vd5w88mjs707Z1DqZmn2Yankexu7oJcF82QzTpASHEljthjlBstahb
         H/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UwrwiMr5+8D/40Mctvun36r5UE8676az6W/LOijCYUM=;
        b=t9hF1ixkphMZ5krPxmHa7DOGszH7if2ptxk0z3qfYmgrH2pZ/Cf/IH76FlYcDRibgZ
         KH39C1C/MMpCsDzkFXbgfElgSwjWW8tr/BrOcgg6VWK1R2oDSvxOIqdLle0XlK1DZ5I7
         6g1fVDxoPrB+pmGdhkfUsebp4WJkjyrMipjWqMFNKqYpYfX1cvxUFUFVziwcDYwbWqhT
         QGU1dsDUbGLRzYPKRrb6FasCSI8nDaNt/qatT6oSi39ta8uRPsSHPc51h3t5l9o+0dE8
         HpmZV/zPumEAgcX3GsdR3uJ6Y79PsYq3ROPyGYRY2Tl/++xfcAYQQrpNou7aMue9zjCA
         74qA==
X-Gm-Message-State: AOAM532hBHIKMFkHAT2GReyuqTjre4BYvWoNr96NdYMN3ov8hjXCMlzL
        xKubaUBuubYMqvzWRnhLoLeGjqSR5lNpd4nm3o8=
X-Google-Smtp-Source: ABdhPJzTCQOGftpcIbepBG1p5eawXb3hy4kNmZO9pwxkvWHyrSXEYZEJ7U2jdt0w4edzyZRmzMv/XwwPE8IjhQ7833o=
X-Received: by 2002:a17:906:7104:: with SMTP id x4mr14912323ejj.101.1618703347716;
 Sat, 17 Apr 2021 16:49:07 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 18 Apr 2021 09:48:56 +1000
Message-ID: <CAPM=9tzVDp7PB0Rv8+Lmi4Ervp8QRio6phvRy_H-oFUHe3phSA@mail.gmail.com>
Subject: [git pull] drm/vmwgfx fixes for 5.12-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Back from holidays and this was in the cracks (Zack forgot to cc
Daniel/lists), I've just piled it onto drm fixes.

It contains two regression fixes for vmwgfx, one due to a refactor
which meant locks were being used before initialisation, and the other
in fixing up some warnings from the core when destroying pinned
buffers.

Dave.

drm-fixes-2021-04-18:
drm/vmwgfx fixes for 5.12-rc7

vmwgfx:
- fixed unpinning before destruction
- lockdep init reordering
The following changes since commit 4d2e1288372ccc5ac60290bc10cace49c9bfa6d0:

  Merge tag 'drm-intel-fixes-2021-04-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-04-15
15:24:17 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-18

for you to fetch changes up to 796b556cbfdbe0d65b9793e63653ad24f9fa033c:

  Merge tag 'vmwgfx-fixes-2021-04-14' of
gitlab.freedesktop.org:zack/vmwgfx into drm-fixes (2021-04-18 09:27:00
+1000)

----------------------------------------------------------------
drm/vmwgfx fixes for 5.12-rc7

vmwgfx:
- fixed unpinning before destruction
- lockdep init reordering

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'vmwgfx-fixes-2021-04-14' of
gitlab.freedesktop.org:zack/vmwgfx into drm-fixes

Zack Rusin (3):
      drm/vmwgfx: Make sure we unpin no longer needed buffers
      drm/vmwgfx: Fix the lockdep breakage
      drm/vmwgfx: Make sure bo's are unpinned before putting them back

 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c |  4 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 17 ++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h     |  5 +----
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c     | 14 ++++++++++++++
 4 files changed, 27 insertions(+), 13 deletions(-)
