Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9D3D1BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGVCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVCDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:35 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89872C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:11 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id e203-20020a4a55d40000b029025f4693434bso1016558oob.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOa5JGP/QaB36txylGv/8WA29Kpuziv0aJWiro9yf5M=;
        b=MdLMOtJG6blCFS9ZTH8S0B80YLCo+rjEFclH0ZS6wgaH36oW9KyEsV2io3pQh229QB
         Hg4275E0wMP8ec8vDpevFb0ibQgPKNiuYJYuf6cyZmpPJbOi8xP8QKcN2Xhg7fucV2u1
         XqA3sdsMV8N90YS2v+ZffQzjj59QXMtLT7OxtZ7UoEa0eHYL9UnqsJ4zXdXDfBx2vu4e
         6EGKV54M1Lpk7UOuR11x51iQ+n4sBYVX8a2nhsXB8ta3/QLWrwDStzmU7IJiHw599gb0
         KC+gTtmlYTYTvdcjp4jFox22COV4JYsQm9JD+zie7nTBbi3S4BDxbBQjJuyM44GF/hZ1
         ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOa5JGP/QaB36txylGv/8WA29Kpuziv0aJWiro9yf5M=;
        b=ppzYOD8i17zWGRSE+r7p1bemYPBIzLNt4hJPU1BCmfk4vUNCHbA0aR1rVaIjOTs9NN
         uNXHiKtJy6CdbGhcgYfmZcglK+atzwzIYMJEuQB0yrQCNG3SQwxcSWizLx0AGQOIS5TG
         agy8kjfD2oY55CxaYLSs9KcsUx0eixuaNERkavtrTFaYFwNUPrc065SYrEoPKYbixBqN
         5zJYs1HyU48CBweBMkc7t/PzKxruZs/NQoGZWWywDxysnzDip3mIMlJwFKgW9kyInOJ7
         gwqzLRQG3YsOzOBn3BEP+llyw06FihSBhflI1JZ+jS93yAoWkJb2L2UWUvQJjq5FJF4X
         Qfcg==
X-Gm-Message-State: AOAM530SmkKnz52gAlkmvdlLf548JipA4H9ZaIHB2BZevD7lAReEM0iT
        wtOLVoQkDyww5wBmhjNgWnh40A==
X-Google-Smtp-Source: ABdhPJz2HYRl1Cim/GV648ggH+HYACL81Wpb3DNsLrReG79jvZfQmMU9JrGlmcKDwyeOs4OG9u2MIg==
X-Received: by 2002:a4a:4fca:: with SMTP id c193mr25835012oob.33.1626921850910;
        Wed, 21 Jul 2021 19:44:10 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm5346519oif.9.2021.07.21.19.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:44:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/msm/dp: Allow variation in register regions
Date:   Wed, 21 Jul 2021 19:42:22 -0700
Message-Id: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that sc8180x (among others) doesn't have the same internal layout
of the 4 subblocks. This series therefor modifies the binding to require all
four regions to be described individually and then extends the driver to read
these four regions. The driver will fall back to read the old single-reg format
and apply the original offsets and sizes.

Bjorn Andersson (5):
  dt-bindings: msm/dp: Change reg definition
  drm/msm/dp: Use devres for ioremap()
  drm/msm/dp: Refactor ioremap wrapper
  drm/msm/dp: Store each subblock in the io region
  drm/msm/dp: Allow sub-regions to be specified in DT

 .../bindings/display/msm/dp-controller.yaml   |  11 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c           |  64 ++++-------
 drivers/gpu/drm/msm/dp/dp_parser.c            | 102 +++++++++++-------
 drivers/gpu/drm/msm/dp/dp_parser.h            |  10 +-
 4 files changed, 102 insertions(+), 85 deletions(-)

-- 
2.29.2

