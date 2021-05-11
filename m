Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77B379E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhEKEWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhEKEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:21:58 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88DC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:20:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j75so17847839oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3sAnreHKyEqLrxBWePiwhRu930iTUs8+45ufhMRReXo=;
        b=zH6hgGNYjGqj2IMIUj5mNl+3TVZadxNEV50zVtX+0J6nuVggTisVFFsYuN3EHs4u0z
         21UOgf2M3zYl7eB7JIStzDf4Q8V3hoMWES4S3L9PLuG5S3cAiueFXZJFnwDe/ozFoQ2F
         ocqEPPY9E4EiMsLr3PESgaSifyp4zDW6DbkcqDwr1On0rlb/Rw/G4tpEj8DPilF8EUVc
         TVIxN42CAf5ndDM677Hb92pXr+3bHwG9xi6MRrRG/xwgjvxWdkGlrfZL8mklS7tRiZZV
         LctmGTxJ8w34HuduKQPjX/POXOUVnkWrAqdYNAlPtsMbBGzMnni7B+f969XFI79k7a+5
         5rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3sAnreHKyEqLrxBWePiwhRu930iTUs8+45ufhMRReXo=;
        b=eVewh2cfccaVC0xLSC1QTUXZ1b6MzPOcJkIBsecIrMIwSPWFz4BqWh+EjeQvcs83pq
         EOJYwS1EV89xdAY1KiVruvQn/oRJoTPvS4cJcF04QEIhH4N7+zdm1+CdSxl8BCFMGGz1
         qKNWB3qxDoRsquY1i/OfrxXSk4C1tnxOfY70bdyYZnkojvWamJPeA3RaRZmAIl5EZd3g
         CHQpNHIyujbmrF+LV/LHK0BJWcQ3dxP8kor2vUGvXYARqdOwFbc4fzsT6pQ1o+lHTwVh
         AIRHBZiHPkvucqQ/6GRzG96fVVpB7hlgLdS4UcaucXBIFQwi8aFLr3J/AanzSm5I+D1J
         cXBA==
X-Gm-Message-State: AOAM530PnJG+Y0KCmyYjlht+zr2uAeJu7YsmDKhJZzk0t0Or4nAK0LcU
        3F37j/9sFVTNzFKzNwi8Hlu8YQ==
X-Google-Smtp-Source: ABdhPJwojnmqufg0lJ4akmfDWkkObUb4HRQ0v8GMtG0dAG2Vf9ooU4W4IGX+N8IzuFQ1r8r8SyJnsQ==
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr1967717oig.151.1620706852170;
        Mon, 10 May 2021 21:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:e623:42c1:10df:adff:fec2:f1d])
        by smtp.gmail.com with ESMTPSA id r124sm3042294oig.38.2021.05.10.21.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:20:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>, sbillaka@codeaurora.org
Cc:     Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/msm/dp: Add support for SC8180x eDP controller
Date:   Mon, 10 May 2021 23:20:39 -0500
Message-Id: <20210511042043.592802-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in the series is somewhat unrelated to the support, but
simplifies reasoning and debugging of timing related issues.

The second patch introduces support for dealing with different register block
layouts, which is used in the forth patch to describe the hardware blocks found
in the SC8180x eDP block.

The third patch configures the INTF_CONFIG register, which carries the
configuration for widebus handling. As with the DPU the bootloader enables
widebus and we need to disable it, or implement support for adjusting the
timing.

Bjorn Andersson (4):
  drm/msm/dp: Simplify the mvid/nvid calculation
  drm/msm/dp: Store each subblock in the io region
  drm/msm/dp: Initialize the INTF_CONFIG register
  drm/msm/dp: Add support for SC8180x eDP

 drivers/gpu/drm/msm/dp/dp_catalog.c | 99 +++++++----------------------
 drivers/gpu/drm/msm/dp/dp_display.c |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c  | 22 +++++++
 drivers/gpu/drm/msm/dp/dp_parser.h  |  8 +++
 4 files changed, 53 insertions(+), 77 deletions(-)

-- 
2.29.2

