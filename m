Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207A736984F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhDWR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhDWR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:28:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59439C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:28:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u8so36871879qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AzW8gw/lChay/rLNwhgwlXkUklC1imdiRu5IZJc3UKs=;
        b=LRP8c9RoAsA+Ug0WokdedrbQa2U05MvwsRm0dqesAWlibw2QdTtvxcvQdUdPS4/R7k
         Dzzgk/NVhLr39A0/Y+c0E1oIpASUsgWoW44wkizulOIUdGTXJf1TxYOcaOZaGjLiltw5
         RprsqwrB6ufVd6lQbc1PR4I1cP30CgXdaD1SMVUeTa+CWeuN8MVkcryjdYdsMhZSfvcW
         q/bEEWQp8ROwYU7YLpQPR3/29AuViizc0bR4USvz2GkjG5ENkcpzr+g9mFWjncMMjEdn
         cQ8BfK2rAUfr0wNUuQ6115cBIxw5mz2WlRL2LJkboEdvmPFdQjhkkvWM8XnePAToLPEi
         TZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AzW8gw/lChay/rLNwhgwlXkUklC1imdiRu5IZJc3UKs=;
        b=CUDDteGpUn1DMEzk9GESHsiOOwGdFvDWr473I4OHzmiles/SiaYL8kOTzkghsgcgYZ
         ozUDrVaNnip837VgtUVXVyHP21uriPsya2jiIl5+MzGRxIHy8J96SFa0yX83TJmBxSv4
         c/sVHMTULq/UxwuKEhJ7/iC/nAMxeXL9H4ojkdRS5aTNGg2gOoqwd2WNK9Xbv6M/qw6k
         ckqStMjcesxe7vlDB1ffcCUfTJVrN19JHNAYTrURbMH2VOFp3PdgU7GuCdJ1eXfoYLiw
         iruCgPIbeAgEcR8UH/YR1sahU2TGlvHNnmgaMCERzB5RUMRVAYuDRB8hGag8FgVq2Z97
         j78g==
X-Gm-Message-State: AOAM532Yz9BhJrRnjPERYcS9NwienejeTtd9vF80nCGOfQmzoGwTcln2
        +97RI9sjO67bEAVy9knGkgO3oA==
X-Google-Smtp-Source: ABdhPJxdsCxGFuhVZIOZpCiAsDpeoN9/VhBAMMWbtJ2u0oxLiMSQyFyiBW+kjeIGADoDSII06RkhTw==
X-Received: by 2002:ac8:4d43:: with SMTP id x3mr4954636qtv.326.1619198889461;
        Fri, 23 Apr 2021 10:28:09 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id y23sm4782627qkb.47.2021.04.23.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:28:09 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Emil Velikov <emil.velikov@collabora.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 0/2] drm/msm/dsi: support CPHY mode for 7nm pll/phy
Date:   Fri, 23 Apr 2021 13:24:38 -0400
Message-Id: <20210423172450.4885-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required changes to support 7nm pll/phy in CPHY mode.

This adds a "qcom,dsi-phy-cphy-mode" property for the PHY node to enable
the CPHY mode.

v2:
 - rebased on DSI PHY reworks
 - reworked getting cphy_mode in dsi_host.c
 - documentation change in separate patch

Jonathan Marek (2):
  drm/msm/dsi: support CPHY mode for 7nm pll/phy
  dt-bindings: display: msm/dsi: add qcom,dsi-phy-cphy-mode option

 .../devicetree/bindings/display/msm/dsi.txt   |   1 +
 drivers/gpu/drm/msm/dsi/dsi.xml.h             |   2 +
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  34 +++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |  47 ++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |   3 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 147 ++++++++++++------
 6 files changed, 186 insertions(+), 48 deletions(-)

-- 
2.26.1

