Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC541F41B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355620AbhJASA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355546AbhJASA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:00:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C4C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:59:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so12471934ota.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOEpp8U8xX+6/NOjtA3o9vPVh0Gxvu3XnufRMdc17ts=;
        b=VpKDdIERxN8vo/ULToynZ+l8fN3RR2TnS8NX7KSsSFiRalxivhNx+68K+vjjmJQ2vf
         aQgEaDQkWCe10d2uljIBR9dbopWyR6lTNRkh6gm82qm/vFoXqdtD1JKefZhVM94h+xFz
         CWl7PRS9+e2WpM/wb6zFQowu8Txsz+w7eFF4SLpVJ1SdGwVo/n2ZuRnjJySEjoQ+oMXW
         5p4zsSpDuNMKO83ipGowzGBsIvl87Z0YKpH1lzZb5sBDuxZG9W3yCvCAq6Wp1Q3UfeAr
         TKOqxs5A2x4pbBUEMlSCBfjoQIrjfhaWsSAo9jVD3lAOKHfH7bwUP9DkOvjYIZ4ig2sS
         f/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOEpp8U8xX+6/NOjtA3o9vPVh0Gxvu3XnufRMdc17ts=;
        b=aRYDlKA4JBHzHUElLeb2BiixjFDQ/8zUx4vWYGo6AmgHIlqlHd4Oi9UdflsPpyGWjE
         +c+LXxQHN8NFqcD0fvwIzDc6TXqDH0Ecien4RhQAW7lPU9XB6bV1HRF7zBcARDs9FKRY
         Xng3bvgKGn5h8S7VZHrn5mrIYEshzRlye+Z4c4+s8R1TKqxpyZkGWVd+zzzkfgFTroEx
         W/IZ1UQzPkNwkvNvDI+vup6BNL+PHa4rwOU/ht035+F/3JDqxoV2KBduf6BNCkWH9Xtk
         hh7taX3lIRRdUG64xkhwiy0D7cYl3rULHJ+KU/+Ezr8fH2T0TmFmcvo2rwFpfotcqVHz
         GXtw==
X-Gm-Message-State: AOAM530AwHjMUCDgDVQItt8THKTzoYqEyDyuhupCUcIpS1LY36AaIhbq
        bgoyIHTCW/ts6rEigDRiTpSr4g==
X-Google-Smtp-Source: ABdhPJy0f4QtOVsANWtDyoi86zc179vzJoaTYKeyXJEeqhBvho5HZ2MJ/DCOIFhb/oT9MOrv7y/LVw==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr11580550otk.348.1633111151822;
        Fri, 01 Oct 2021 10:59:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w2sm1284798oof.23.2021.10.01.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:59:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] drm/msm/dp: Support multiple DP instances and add sc8180x
Date:   Fri,  1 Oct 2021 11:00:53 -0700
Message-Id: <20211001180058.1021913-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation supports a single DP instance and the DPU code will
only match it against INTF_DP instance 0. These patches extends this to allow
multiple DP instances and support for matching against DP instances beyond 0.

With that in place add SC8180x DP and eDP controllers.

Bjorn Andersson (5):
  drm/msm/dp: Remove global g_dp_display variable
  drm/msm/dp: Modify prototype of encoder based API
  drm/msm/dp: Support up to 3 DP controllers
  dt-bindings: msm/dp: Add SC8180x compatibles
  drm/msm/dp: Add sc8180x DP controllers

 .../bindings/display/msm/dp-controller.yaml   |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  23 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  66 +++++----
 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c           | 131 +++++++++---------
 drivers/gpu/drm/msm/msm_drv.h                 |   4 +-
 6 files changed, 132 insertions(+), 102 deletions(-)

-- 
2.29.2

