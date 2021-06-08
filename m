Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879639FDAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhFHRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhFHRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:31:52 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD53C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:29:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id w9so11197824qvi.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWdUHYABGQBcW7qRBGmaQ5V1B5iD59ixtAUGymm7Ips=;
        b=mglUamcHTUrXGpi+HCG4/zPyEt9p5+jjSw5pKHrNurnvu3bcDgrxFYpXjKpGggjJx6
         6RPbSO9qTt4hBl8Ye2MyxoOuaimqaREYHCv37Q2Jt/ib859AAHLd7rrJdo80ASyeDVpc
         HfcLSx5eelQ2wIx4QjIgEuf311i8Y+V27Z9Mpx7oFtmMxnmArhSYFKA7IzVCh70pyHg7
         0lFZvEfQOTwhI0JuVf5kWIeKUI3DQogAWbyIS2EXPUbOOnnFrDgXbkbHvynIx38IW7uy
         nSXrwk9lJL+OIl3dv95Sp7NUZ3sxSODWklHH1vdxOzZzYZtuWxE+QDOynawVlLFxO7ZQ
         9Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWdUHYABGQBcW7qRBGmaQ5V1B5iD59ixtAUGymm7Ips=;
        b=AFNz2t7VAuoFSop4yUHEKBxJOZF67ixYFdp4uolDvi+utahwFhBp1DG2mlg6A1r5Ec
         cYYTiH2dkSj/jrk8rqFWE9o0rTWAVrgTUFw7LlRGLXif+6s38XcZK0bS4+tU+8BbRQJg
         EeSZZzzRWThssHdqj4igYpzFMyMyIxxekKFyza6prjg/CAxq34idcJ+jF2d0J1BOmJUy
         XP7trLTJEoruPCsTJLpFwmxBEFCjpLqFnLyIyt3VOWD1zzOESG/UHC2D+YZ9p81Pkk+r
         B6FtBQtA56/lRHnJzYZ5JNea8a/dGDgiW6tgAoKLugTaP9XdiWmZYfb7UZbnq7wDyFHq
         UF2w==
X-Gm-Message-State: AOAM530yoqti8hAZgcxwbGs62QiZoQpRohqUY5PxboGRY6yJdCZ7PSJ3
        9djHrh5j+FGEG7miAaVq7LYZgw==
X-Google-Smtp-Source: ABdhPJwPXyMpb5YGJUaGlRRkmOL/YvWlumWst7ROm74Bh2SYd/HotIbTV3dBNM9mXCb4dj9OoNzMQA==
X-Received: by 2002:a0c:d809:: with SMTP id h9mr1194440qvj.47.1623173398195;
        Tue, 08 Jun 2021 10:29:58 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id d10sm9482983qke.47.2021.06.08.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:29:57 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Eric Anholt <eric@anholt.net>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rob Clark <robdclark@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH v3 0/5] drm/msm/a6xx: add support for Adreno 660 GPU
Date:   Tue,  8 Jun 2021 13:27:43 -0400
Message-Id: <20210608172808.11803-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Adreno 660 to the drm/msm driver. Very similar to A650
on the kernel side.

v2:
 - added AOP PDC path for a650 and use it for a660 too
 - fix UBWC config for a650 (also affects a660)
 - add CP_PROTECT update, and corresponding a660 settings in A660 patch

v3:
 - removed patches already picked up by robclark
 - added patches for missing PC_DBG_ECO_CNTL/GMU_CX_FALNEXT_INTF settings
 - changed a660_protect to exclude CP_PERFCTR_CP_SEL
 - removed 635 id from adreno_is_a650_family
 - squashed a660 patches

Jonathan Marek (5):
  drm/msm: remove unused icc_path/ocmem_icc_path
  drm/msm/a6xx: use AOP-initialized PDC for a650
  drm/msm/a6xx: add GMU_CX_GMU_CX_FALNEXT_INTF write for a650
  drm/msm/a6xx: add missing PC_DBG_ECO_CNTL bit for a640/a650
  drm/msm/a6xx: add support for Adreno 660 GPU

 drivers/gpu/drm/msm/adreno/a6xx.xml.h      |   4 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  53 +++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h  |   2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 172 +++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      |  33 ++++
 drivers/gpu/drm/msm/adreno/adreno_device.c |  13 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   5 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  13 +-
 drivers/gpu/drm/msm/msm_gpu.h              |   9 --
 9 files changed, 248 insertions(+), 56 deletions(-)

-- 
2.26.1

