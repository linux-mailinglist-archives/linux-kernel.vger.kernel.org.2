Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298B337FC42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhEMRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhEMRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:18:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB536C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t7so20312399qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWQ2eSbCWjaDmjGhi3u40pp1LlF3mF4wAzWbmvdU88=;
        b=U2LT0FzDjK/xMUpUok6rSRmC6sln8a9nq/xG/GL6wWaMq+utmx9QWM8EjSOd4yAB9W
         D73Rb2yb9eNTDyBOnFP1gcEEvygZTYKBABEQkTkPLbbA+V923ocPaA9AOLWD63m39uWh
         2AcKeCnkKFdxFPTwEGwbN/NMQwWv+XuQ8VFBFK8mBggX1zYm/BDFM1P6YgiAzuEboE00
         FIn1P08oi2blVdk+ZtXb1RTt2yVMxCuFestLIVv/4b+JnUmkMCwD2Rl/PRyFjXOgvBka
         4pvVK9nzzPK/uoUqGA9o+VLjWUpWbgw2M6EAxvi4kRaro0Q2q3Cl+24gAxIXJibquQou
         Moww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWQ2eSbCWjaDmjGhi3u40pp1LlF3mF4wAzWbmvdU88=;
        b=mbRDoamFwi81G1WwKEbbMejG8C4FR9oqGAYK4p0nOenF6TXXWdNcVIQHYmmE3N0Sw5
         K2wD/u/u1MqwU7Jl4q9HdljaUmg1OUE/h611Ur6BJh5B0bldUXFdljskWbXltHueOyaV
         8oblOY+sxzdfaq5IX9FnrPdsIO8db+yJYbFgbqApUPEWcfpk4cz4COj/1Lv8stENzu2L
         trw5/f9WSH3hO6jgcPFVqOdffeS43lD/l1w356Pg65J4VR80JbM5Qo3ajD31uNBUapYb
         viSSXSelyB6t5Ed8fVtTiBMZUUqgvEBb0bUPPKisUKzngaj/R5+lV/vxSOZ0ZURgzLRc
         nFNg==
X-Gm-Message-State: AOAM5329AtYPF2bF0vp0rnHYsj3E9Klx2U8uPRdvj/gSMYV6wQxyJpud
        ahp5vml+tR7lctu+7okE7361QQ==
X-Google-Smtp-Source: ABdhPJy4jdPxUmPm2TaTkkMlXn2NLBuaDEPii3ErnXusughMxa4RFDdL6KRXs9VmvmjLX71N+V28tQ==
X-Received: by 2002:ac8:4641:: with SMTP id f1mr39171708qto.107.1620926249104;
        Thu, 13 May 2021 10:17:29 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:28 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Eric Anholt <eric@anholt.net>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        kbuild test robot <lkp@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rob Clark <robdclark@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/8] drm/msm/a6xx: add support for Adreno 660 GPU
Date:   Thu, 13 May 2021 13:13:55 -0400
Message-Id: <20210513171431.18632-1-jonathan@marek.ca>
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

Jonathan Marek (8):
  drm/msm: remove unused icc_path/ocmem_icc_path
  drm/msm/a6xx: use AOP-initialized PDC for a650
  drm/msm/a6xx: fix incorrectly set uavflagprd_inv field for A650
  drm/msm/a6xx: update/fix CP_PROTECT initialization
  drm/msm/a6xx: avoid shadow NULL reference in failure path
  drm/msm/a6xx: add support for Adreno 660 GPU
  drm/msm/a6xx: update a6xx_ucode_check_version for a660
  drm/msm/a6xx: add a660 hwcg table

 drivers/gpu/drm/msm/adreno/a6xx.xml.h      |   4 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  51 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 309 ++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      |  33 +++
 drivers/gpu/drm/msm/adreno/adreno_device.c |  13 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   5 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  14 +-
 drivers/gpu/drm/msm/msm_gpu.h              |   9 -
 9 files changed, 350 insertions(+), 90 deletions(-)

-- 
2.26.1

