Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6443411CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhCSAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhCSAxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:53:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A75C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:53:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u9so6907913ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=S62dHTtCQlIfJI/mhZhC3VouKv424+X6c3HcczHvRZo=;
        b=Q7dgNseLCIoNGFW0I3O8d7KFa3aLYBgV2gYyeeEjCgsKbbF6rMRVWz8I5k5GslEeVB
         inDohtaIg/fLnL7S27y3qmY34k2zhTItF2p1zpLQFVLbUcRP4pWcs5CcMZUBkHadqi/d
         xLiB3Hzxi1o37sLqULtUSPAK+BznD12u81Urb0otDSakwrdzcdzQT3I8Grtf0TL/q/Uk
         8zu56lub+rcZk+8xbnIyWYInO6AYstjcVTYgPi9QAUK9qIUqtWY/GjGL4TvJZfQ86Nnw
         QmCYr1x7nLCMIvh+9s41Iob+LRkR7d1+N0ItUc8d+J3pDNSBOZVHDVJ22ymeooI5gEWH
         6UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=S62dHTtCQlIfJI/mhZhC3VouKv424+X6c3HcczHvRZo=;
        b=KUfnGGkS/0mKKZUE8jpon7/lAn5gyQhDk1E/rEg8zdMLXgXgK3lUfk1Tuha8EBq4xI
         3CNn1uFHctpZNjCymnWavy2X91BefaVn9no4QTMeGNCSVsaKDSvCPXbGt5pxgLXPE3G/
         C6w0vUIZECRxP9xKpQMl0/EFvE7P2YE7e+yfw817A+J7Egbf5Eh13FVbiENHsU7RgmR7
         yBeowvAVTisfGKFk1ZxpDd1CBtb0mPiLfg4JsaNXkqgJwSGwoVAKlWtoYMKG8Lpei7Af
         WzZ8900q7s5mZFL/sQyxaykRCo9CebfbKVE4kk6bv0vq97SV/ZJVkZ5LGGKfORW5MWUI
         EfvA==
X-Gm-Message-State: AOAM532I26lhr9H7rTmeXHohN7u5kKouET4+J6cbU2ZfUMKWSrdUTk85
        CnXIo+2A9Pr/fTRlbRyTvvd3zwfeR9Myqb3Cjjwrgkao2a4=
X-Google-Smtp-Source: ABdhPJxFaCT2uu2jYhd7se0srF/T16JC5LCzYNImCWKMWewHYgy9AjWy4bOzb1le4RcDwfqg2dGNoZFMU4BItTJXAAA=
X-Received: by 2002:a17:907:7249:: with SMTP id ds9mr1481050ejc.9.1616115221138;
 Thu, 18 Mar 2021 17:53:41 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Mar 2021 10:53:29 +1000
Message-ID: <CAPM=9tzyh8Qeo4Sc_VHApCKRt8pBT4nW_20VYOv1TJkKmwm8ew@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular fixes pull, pretty small set of fixes, a couple of i915 and
amdgpu, one ttm, one nouveau and one omap. Probably smaller than usual
for this time, so we'll see if something pops up next week or if this
will continue to stay small.

Dave.

drm-fixes-2021-03-19:
drm fixes for 5.12-rc4

ttm:
- Make ttm_bo_unpin() not wraparound on too many unpins.

omap:
- Fix coccicheck warning in omap.

amdgpu:
- DCN 3.0 gamma fixes
- DCN 2.1 corrupt screen fix

i915:
- Workaround async flip + VT-d frame corruption on HSW/BDW
- Fix NMI watchdog crash due to uninitialized OA buffer use on gen12+

nouveau:
- workaround oops with bo syncing
The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0=
:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-19

for you to fetch changes up to e94c55b8e0a0bbe9a026250cf31e2fa45957d776:

  nouveau: Skip unvailable ttm page entries (2021-03-19 10:38:31 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc4

ttm:
- Make ttm_bo_unpin() not wraparound on too many unpins.

omap:
- Fix coccicheck warning in omap.

amdgpu:
- DCN 3.0 gamma fixes
- DCN 2.1 corrupt screen fix

i915:
- Workaround async flip + VT-d frame corruption on HSW/BDW
- Fix NMI watchdog crash due to uninitialized OA buffer use on gen12+

nouveau:
- workaround oops with bo syncing

----------------------------------------------------------------
Calvin Hou (1):
      drm/amd/display: Correct algorithm for reversed gamma

Christian K=C3=B6nig (1):
      drm/ttm: make ttm_bo_unpin more defensive

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-03-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.12-2021-03-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-03-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dillon Varone (1):
      drm/amd/display: Remove MPC gamut remap logic for DCN30

Junlin Yang (1):
      drm/omap: dsi: fix unsigned expression compared with zero

Sung Lee (1):
      drm/amd/display: Copy over soc values before bounding box creation

Tobias Klausmann (1):
      nouveau: Skip unvailable ttm page entries

Umesh Nerlige Ramappa (1):
      i915/perf: Start hrtimer only if sampling the OA buffer

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Workaround async flip + VT-d corruption on HSW/BDW

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 34 ++----------------=
----
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  5 ++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 26 ++++++++++++-----
 drivers/gpu/drm/i915/i915_perf.c                   | 13 ++++-----
 drivers/gpu/drm/i915/i915_reg.h                    | 23 ++++++++++++++-
 drivers/gpu/drm/i915/intel_pm.c                    | 16 +++++++++-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  8 +++++
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  7 +++--
 include/drm/ttm/ttm_bo_api.h                       |  6 ++--
 9 files changed, 83 insertions(+), 55 deletions(-)
