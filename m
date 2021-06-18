Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF603AC4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhFRHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFRHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:17:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82665C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:14:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ji1so8124027ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E0SoMThWmExXzF5EbvKyjPfd/YPiucGrDsQng1mFduk=;
        b=PATDK3CAWfHyAm2itpJvl9i8Z2DKKunEb8Xc4FIYyrGMvm0t+vwrqD2Z4RchiNR+tD
         9oLeENVltFulbQjyEKgq7OKxJE0HF+NUnwcxR+Y6qu+y528s0USIBTF/kFyU2bcs5CHs
         68MQ4zeKM8jE23yaVv9I5qRa//WUw88e0bsQaonvvgu60PfarCvrxQy1gh8YoN3rydgS
         2woDYZSahk57Eya9hRtf13YGVl1r+ZZ0xC++6aSz1hN/D/Gc0HTG2KFqdQSIGHoMdRWs
         iT6FHLgyUnlBXqN29R0OXk+z0VhRkX5L8hDwr05Ju3oil+1VdFIMFuvFnp8O+sGjsUHn
         7lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E0SoMThWmExXzF5EbvKyjPfd/YPiucGrDsQng1mFduk=;
        b=cs8RZV+EXm38mBz8evWKw0L95YUj+PiHn1724XQmAPuydbL9swQur6VsXrWho9UHeD
         HK47DzcLmo7t15mkn+h+s+9wkFVrAKJm6hQqurzLbx/owjLL8wvAm5QWGmdAfHPtFZG9
         VilO347VIzxhcvM0BFQn9QGz8p6M0trNVPfOb19wM8VK2vv6uwc+NCGU4ZqH4pnUqBez
         hhmFBji+Jnf5DF1PPkmnYcyKLdQ9m0j62p/sHarIAR6dYYKAzpX9mCe/9SmR1GrwX8Cz
         CBNF0Qac4eqYU7KbkIR1+b2o71EIBR4jDapOMCmiTA7wwk/iT7Wt+kchCirFdE84XVPz
         L7+g==
X-Gm-Message-State: AOAM5326Zi3YrMJyxbAJw0hCDdR+OW4r6FpCM1/pfvppKcQos1sG7Zuv
        C6dKdfwnn830SmU+o5b68xpfx5+vbqEPENP5VHFOuKKuQ/0pdg==
X-Google-Smtp-Source: ABdhPJwRCq12s1+295PmMXlgcXctiEnAnFhf42DJxoB+LnuEkPGvIX8N4YXYitUsMPTVUZFDEebjwbBL3gV2x6Z2FOk=
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr9781311ejc.9.1624000495889;
 Fri, 18 Jun 2021 00:14:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Jun 2021 17:14:45 +1000
Message-ID: <CAPM=9txDgvo3Gu7bX_C9A4hAQJf+pGk+pMUR1bKg4EapEeqazQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Not much happening in fixes land this week only one PR for two amdgpu
powergating fixes was waiting for me, maybe something will show up
over the weekend, maybe not.

Dave.

drm-fixes-2021-06-18:
drm fixes for 5.13-rc7

amdgpu:
- GFX9 and 10 powergating fixes
The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-18

for you to fetch changes up to c55338d34cc2434d4ff9de89498f91171bd1f120:

  Merge tag 'amd-drm-fixes-5.13-2021-06-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-06-18
11:15:04 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc7

amdgpu:
- GFX9 and 10 powergating fixes

----------------------------------------------------------------
Dave Airlie (1):
      Merge tag 'amd-drm-fixes-5.13-2021-06-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Yifan Zhang (2):
      drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue.
      drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover
full doorbell.

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
