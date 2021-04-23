Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B16368BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhDWDxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWDxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:53:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE88C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:52:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d21so35830776edv.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AsQS2+WKWTfo1Jt7nW4OhF01pRbwMoQdzfJIXlY/3JE=;
        b=aEUrJRPr2CPm0gyMjMpJzsHaKhYyHhYeb/Cswp/opvqq+XH72jpl3dHSAP/SmCh9Qv
         CemRSb/oq0FwHDAcUoqY2GTOmwCE2geQNbwCHy8Wdn16Hv2gx2IvsVjkYuGMUhoVxidS
         p3uS9NsJMYShQLCnNQ+Koo2ZC7xgR0bJjRali0A6lft0xV/rZxDxIMorMO7uFBz4tsEm
         Th6GIeUxa9DgyB2XxpXOabM9VBUWvGkjlGVCRukWAVXEY7KLyAYGtn+al5srkJQ0EQhc
         W0QR2dYmzNF44+D8+6Yjm1uvy3Kn02Vw3fuXqEGTrFXozFYIZPOJQ2akf6tZ3wP4GaLu
         Y58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AsQS2+WKWTfo1Jt7nW4OhF01pRbwMoQdzfJIXlY/3JE=;
        b=Yhlz7UNo2Nw0uSm2njmbH2FOAtbNKfLZGgpBEY10wLmZH4eoxzOEN/Tvwm+OyED/T7
         /pczMdgkjxUvO5MFfQRoKNr5+Jkdry5a1fsmQUsnLiqw7mvDGH2May/bZv3kaI2J6sUY
         9HnM3PAxbPVyy4i3SZwes0SQbAA2v9lmwb0Ftix6cSFEbBOU8EC7dRs5/5PO+zKGq5oZ
         Z9pv0QHC+I7zo5NShZ0g0UGAqh3PlQ+TIBvoE1VfdrOnrZ1PeG1Juvq+HASnGGpMUT6F
         G1qN2my3CJE3ghtV6hP9exppnJ8LXUGDHzcj/g0pV+s/G6jkaJ3eNeocS9JvuhqO7My8
         uf6A==
X-Gm-Message-State: AOAM531nKionS+rD8v9TNrXMygQVbkQq0idpUCNnzzkQ3Y4KQoBRc6Os
        1rTIqKLpl06m9p1eqKnsSVjiMSZCaBK0fkPtR84=
X-Google-Smtp-Source: ABdhPJyS3WSdMIZNgtRyHDciXIkP+vYLJyfArCej6T4gFVnL9UyqYnz3fiSbyNB1bw4RQthfqVa90ovzzv16Vv4BCvg=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr2037305edd.78.1619149960146;
 Thu, 22 Apr 2021 20:52:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Apr 2021 13:52:29 +1000
Message-ID: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just some small i915 and amdgpu fixes this week, Should be all until
you open the merge window.

Regards,
Dave.

drm-fixes-2021-04-23:
drm fixes for 5.12 final

amdgpu:
- Fix gpuvm page table update issue
- Modifier fixes
- Register fix for dimgrey cavefish

i915:
- GVT's BDW regression fix for cmd parser
- Fix modesetting in case of unexpected AUX timeouts
The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-23

for you to fetch changes up to aca38735ae624b93c71c055b68d5802b8f356ea5:

  Merge tag 'drm-intel-fixes-2021-04-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-04-23
12:18:21 +1000)

----------------------------------------------------------------
drm fixes for 5.12 final

amdgpu:
- Fix gpuvm page table update issue
- Modifier fixes
- Register fix for dimgrey cavefish

i915:
- GVT's BDW regression fix for cmd parser
- Fix modesetting in case of unexpected AUX timeouts

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.12-2021-04-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-04-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Imre Deak (1):
      drm/i915: Fix modesetting in case of unexpected AUX timeouts

Jiansong Chen (1):
      drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey_cavefish

Philip Yang (1):
      drm/amdgpu: reserve fence slot to update page table

Qingqing Zhuo (1):
      drm/amd/display: Update modifier list for gfx10_3

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2021-04-20' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Simon Ser (1):
      amd/display: allow non-linear multi-planar formats

Zhenyu Wang (1):
      drm/i915/gvt: Fix BDW command parser regression

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 15 ++++++---------
 drivers/gpu/drm/i915/display/intel_dp_link_training.c |  3 ++-
 drivers/gpu/drm/i915/gvt/cmd_parser.c                 | 19 +++++++++++++------
 5 files changed, 30 insertions(+), 19 deletions(-)
