Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD956416A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhIXDTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhIXDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:19:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:18:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c21so30177171edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CMQqIkvwp/0qGyW1Blu6mOY2iiopgNoaJkg6GhARr7c=;
        b=Z/92IUZunYXouB8yycJDrviFQIJjhE82uNqj4g/X+X1PIMihb4JFLMAhdhz1HTmxRl
         Heb6ioALbsWMhDOLhgGl767DMNnLlJt6wy6C07db5+ChDbyJMqFP7tdxZth9+Bncr+hg
         /grrGKAxkhJm2Y1xIFK9DzGm057jQOr/4Es/5R1hlRWGUVOT5IKvZTrwIPCkXwWpEX8c
         kpJUah7EvmV5kV44UHvL7VVfAI7YAydHJhyCWvtECh/ykeCCsqIbSn5+9sr8x3KaavY6
         9T+N9tCdnfZJf1rSDzxpeeA3R7U7SpDV4QOP1vWpb+Qj5Tay4yAzUfY3C1q4OpcE5dhI
         WslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CMQqIkvwp/0qGyW1Blu6mOY2iiopgNoaJkg6GhARr7c=;
        b=d6Qu02PJXNfgUYAwotao1L5LNuU4NL6JcfKYuujJoB/UGsagEBb7jKUksA7iFN6qcx
         GsazeYx7aoumESafqD6Oz15+0w+6aASZTo5eSol8Wcd09h2Bp83GefH2yURDjTaOxvNa
         aMF+FjBEFNwdsl8M68m2AdkcH9v1SGOclNPKTsx9ZpacP03HGIom3c/4moL6cnXBZjsE
         7dRfya+oVhxQ7o0eUGeiGmwembqZSXkq7JSwF4MVKoCfd8fPMnMkB9dkBtah4pWASZS1
         eVEAl2dvhKMFg0ZBUljBrI1Q9vcB/T+wKwPPRGn1eJGDJYPvgpZUNAcNI4YEhEL1QdtQ
         1sHQ==
X-Gm-Message-State: AOAM533QcaHVI7DpLB6lPfp/RBVCoxr2m+7P647z1kjzEc2hdd2ipRRp
        Ml4VrpVijU9E1Sikq6bBeNuzOQ4GafDsS3izr63d4wCxMqw=
X-Google-Smtp-Source: ABdhPJzPquP7nIvCEF5iQzVs4Va1x0GoxAO9I1S2nVbL6m8BLjM5iBfaop97x7jLdaJ5BjqynoZreUhFzo/XwZOCzU8=
X-Received: by 2002:a17:906:7847:: with SMTP id p7mr8518155ejm.335.1632453496131;
 Thu, 23 Sep 2021 20:18:16 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 Sep 2021 13:18:05 +1000
Message-ID: <CAPM=9twLyUfPDxjmJ_+s8G5-JmET36vvGpuWM2TBDNUqEowXDQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.15-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

quiet week this week, just some i915 and amd fixes, just getting ready
for my all nighter maintainer summit!

Dave.

drm-fixes-2021-09-24:
drm fixes for 5.15-rc3

i915:
- Fix ADL-P memory bandwidth parameters
- Fix memory corruption due to a double free
- Fix memory leak in DMC firmware handling

amdgpu:
- Update MAINTAINERS entry for powerplay
- Fix empty macros
- SI DPM fix

amdkfd:
- SVM fixes
- DMA mapping fix
The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-09-24

for you to fetch changes up to ef88d7a8a5c94d063311a5581d9a8f0c0e3a99cb:

  Merge tag 'drm-intel-fixes-2021-09-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-09-24
09:39:17 +1000)

----------------------------------------------------------------
drm fixes for 5.15-rc3

i915:
- Fix ADL-P memory bandwidth parameters
- Fix memory corruption due to a double free
- Fix memory leak in DMC firmware handling

amdgpu:
- Update MAINTAINERS entry for powerplay
- Fix empty macros
- SI DPM fix

amdkfd:
- SVM fixes
- DMA mapping fix

----------------------------------------------------------------
Alex Deucher (1):
      MAINTAINERS: fix up entry for AMD Powerplay

Arnd Bergmann (1):
      drm/amd/display: fix empty debug macros

Chris Wilson (1):
      drm/i915: Free all DMC payloads

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.15-2021-09-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-09-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Lijo Lazar (1):
      drm/amd/pm: Update intermediate power state for SI

Maarten Lankhorst (1):
      drm/i915: Move __i915_gem_free_object to ttm_bo_destroy

Philip Yang (4):
      drm/amdkfd: SVM map to gpus check vma boundary
      drm/amdkfd: fix dma mapping leaking warning
      drm/amdkfd: handle svm migrate init error
      drm/amdkfd: fix svm_migrate_fini warning

Radhakrishna Sripada (1):
      drm/i915: Update memory bandwidth parameters

 MAINTAINERS                                  |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c     | 16 +++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h     |  5 -----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c         | 24 +++++++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c |  4 ++--
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c    |  2 ++
 drivers/gpu/drm/i915/display/intel_bw.c      | 19 ++++++++++++++++---
 drivers/gpu/drm/i915/display/intel_dmc.c     |  5 ++++-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c      |  9 +++++----
 10 files changed, 57 insertions(+), 32 deletions(-)
