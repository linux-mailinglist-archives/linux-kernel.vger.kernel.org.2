Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC83A04C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhFHT54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhFHT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:39 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDAC061795
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:55:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k4so21516985qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN/dADQ65ljJkOdLNlsYJNf64TdCy5snXLeJXI/fSws=;
        b=tl6qBfeR1ctMdKOjD5T7yqHao2tzBYPwBZ6V7bhuPFKO/eH0NCRXEHAZNCBXm21vh6
         y+Jo6Lh2RnmrDGBcqsjKAkzFJkxr7aCjm19n/+UXJWae4U8zd3GMNLBODNvdGNIICjan
         Wk01zjyEh80E5jQGbtt4eSMWfBMj5BCcLPr4/vsqVc0SFWUjvYYTR9eqwatQ4qyUsDYL
         sxqIeBRVaLxnIVC4Ae/NGANFJ25uT7q1kEcFs/0s6XMesfA4z/g4NGVZz7hBQ3g+TxFz
         vHekfmbcapwt4zasp8IASP5xmqq0xOkziXoyPB9saT/TMxZVUKM94a6nnAJqepFv06za
         AT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HN/dADQ65ljJkOdLNlsYJNf64TdCy5snXLeJXI/fSws=;
        b=GcI7phUQQOShQCvPjjVIs1UbqT2xj3dVqLkDgOuK84iWnYy1XxyRnLchIhT2ah29Ro
         8nu54kCSnOOhqlPri7ImHLMFWqxYLPdpEX5HChsw76o5YZhLTqpnj8J8soK7dCEFuGGa
         GbN+yMKHJ6Y90AKgtyMGuaBsas9TJ1MgYXdM6Z1pDrC+Cg1iC+ZH+ldGdJjx+MQXm0ni
         FKiHJ8ikL2IeKUk2YfxRqf8XtS/ooJYGsa2kl1hJXcme14zYUHBPzsc44CMPXSs85rnZ
         0aqs/5/lu7la++V0kYPVnzvXAp+BmCo9nVS8mrK4kd0AcqqxtDd6hqNST4ESq0ktGEpQ
         GeZg==
X-Gm-Message-State: AOAM533jZODtU+DEXdun22quHoTc1hviIJL89WZCLrwboCZpp4+LPUT3
        V2029tc1og9+d2RSpUPUrv8/Rg==
X-Google-Smtp-Source: ABdhPJxCiMcEk4rEfSFxoc9MLYPAFpeFQHE1XQnjKYvFYU9dDovhkcdD8gGzWd5X3y+DjjX9qqPZtw==
X-Received: by 2002:a37:d58:: with SMTP id 85mr20317382qkn.414.1623182131919;
        Tue, 08 Jun 2021 12:55:31 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id l141sm643687qke.48.2021.06.08.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:31 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3 0/3] drm/msm/dsi: support CPHY mode for 7nm pll/phy
Date:   Tue,  8 Jun 2021 15:53:26 -0400
Message-Id: <20210608195342.18269-1-jonathan@marek.ca>
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

v3:
 - yaml bindings
 - changed binding to "phy-mode = <PHY_TYPE_DSI_CPHY>;"

Jonathan Marek (3):
  dt-bindings: msm: dsi: add missing 7nm bindings
  dt-bindings: msm: dsi: document phy-type property for 7nm dsi phy
  drm/msm/dsi: support CPHY mode for 7nm pll/phy

 .../bindings/display/msm/dsi-phy-7nm.yaml     |  70 +++++++++
 drivers/gpu/drm/msm/dsi/dsi.xml.h             |   2 +
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  34 +++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         |  49 ++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |   3 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 145 ++++++++++++------
 include/dt-bindings/phy/phy.h                 |   2 +
 7 files changed, 258 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml

-- 
2.26.1

