Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE4369AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbhDWTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhDWTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:12:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B632C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f12so37191540qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEaQvWN4Z8yVJOtNMFNTVQ5YEguXpuTG96s4DFICCJ0=;
        b=kuLS0suPNfLfL/e8JYU0ZgCsM09iPvMie9U8PBPzCHE65hayjIIyW/c4VG+rtLVCSu
         05TvT3RLM45wuNRjopgjY3Ors5GfQ3GgS4MzsYw0AROaDcmp3HGCEXLesOWJqNnwyUv/
         KNMT2zM+KPa66AQGjuCtTmcxbdAnZZFMYgSIClJJe4aldjscpatDVowDz9PfHRWwzSvK
         5ehh2Cv0Q2JZVupwoAxE/5tR84zK+L89u6vsLAHhgN95YQBxjXrULY0sjy5EImrS4d25
         9KA8QFscriXuiQggAaZlQ3YITF3zntxWUoR5StcQnymT/ycSe8fELhGgl1gqMv0AD8dM
         tXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEaQvWN4Z8yVJOtNMFNTVQ5YEguXpuTG96s4DFICCJ0=;
        b=oxSagxh3HCe+NfFPNCFebaq6pSKo584Mh/gV1e/vcMUlE+aR6Y8b4qsfoRCi2rlLd+
         tq4e/u9rgh1ADTc6lqKC0x+0TyE0XWLKmXILbX/LwfPQra660Lp+ruo0Ovo4NDIFTZPg
         EE674MggP0u6YriFDExPR80Fd2Qhali2slWCbFxGBS7+jr4Xb7QNEm9sZl/rC0pE+RrX
         aIzZ5DEt6y+zzV+MNN9UlconjntrAD13xRWfNBBMdDwlFztboqDVizQJZuLbCsx6Oz3/
         XeiteEQiODzAGL8jEj4CxllKQ/enGRjWv/frwdaDp5wlrHQrP8ouocrA0e+B4J0N3uL5
         jyhg==
X-Gm-Message-State: AOAM531AE3w0Tc4WFLS34WtiXnbnB95VSOivCENl0ERqHUpCKQKQsX67
        NYkRdLga/CNu1n1+NjDRnUzY6g==
X-Google-Smtp-Source: ABdhPJyNFE1wEhOEH03d5WveOtjIevlxoZNdPt2fGHLKPGOwI4mNzLVERkLgfGOFwAeF0imWrkJqYA==
X-Received: by 2002:ac8:7191:: with SMTP id w17mr5368523qto.199.1619205121519;
        Fri, 23 Apr 2021 12:12:01 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id a22sm4834630qtp.80.2021.04.23.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:12:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bernard Zhao <bernard@vivo.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH 0/5] drm/msm: add MSM_BO_CACHED_COHERENT (and related changes)
Date:   Fri, 23 Apr 2021 15:08:16 -0400
Message-Id: <20210423190833.25319-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MSM_BO_CACHED_COHERENT, a coherent version of MSM_BO_CACHED
which is implemented by setting the IOMMU_CACHE flag.

Jonathan Marek (5):
  drm/msm: remove unnecessary mmap logic for cached BOs
  drm/msm: replace MSM_BO_UNCACHED with MSM_BO_WC for internal objects
  drm/msm: use the right pgprot when mapping BOs in the kernel
  drm/msm: add MSM_BO_CACHED_COHERENT
  drm/msm: deprecate MSM_BO_UNCACHED (map as writecombine instead)

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  4 +--
 drivers/gpu/drm/msm/adreno/a5xx_power.c     |  2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |  4 +--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c  |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c          |  2 +-
 drivers/gpu/drm/msm/msm_drv.c               |  3 +-
 drivers/gpu/drm/msm/msm_drv.h               |  1 +
 drivers/gpu/drm/msm/msm_gem.c               | 34 ++++++++++-----------
 include/uapi/drm/msm_drm.h                  |  7 ++---
 12 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.26.1

