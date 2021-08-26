Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098143F7E67
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhHYWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhHYWZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:25:31 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so950834otu.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsXe1e72wRkGIfMRaHX5V5OYsm6EaNn+8h1FDv1jEg8=;
        b=u3SuP2a+axhJJ3ZFEMFVhEpZAHwKfExb7Q1cnnzCtb3nQy4FMfuBD8YPhOjL4p1Suu
         SXRqPLGCZ0BZxQfJxAmnW0XQDcYtn9Bo/pd/MUIWpi34SdReEWfeVhgiRniKI/RQje6T
         yxDhU4iVyjE3FqfnPHKsFi/zvNKoADJ+daHM+jRKIgT0cT+GNQOpY1/Fgavt91L1G4ac
         5q8VCEb15WFvq53rok5lk7IqdqvLVczUkhX4sQuiDh0QppSAFzJH3wb63EaJk4g4QNiA
         4KDTwOfhxXPkfQ1hp5Z3rdYgf6Ql6pTzr5MpdPbckdsX3hEdUF0y2tY/Ksn13tc7XcR8
         V78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsXe1e72wRkGIfMRaHX5V5OYsm6EaNn+8h1FDv1jEg8=;
        b=ba72JtciVuu2BrpQ0p9rywvuB3xeEZBrUj8RLFRYWWs9CVGymd8fMU1zB4/QcXsQdJ
         QeyAloQVUStoLqrvIN9vIsxJtIkBxKya56rYDvMt/+rsxftQJ8PfjMfAb41QpTN9WWam
         LvPXM3CX7fpEPVkW2OtejeCarPhn/MV0UcsyliTbRFEAeMPsEV3YYAiCwftTIea78U5L
         r5EPhPykoNF+NG/rzfUdJs8cIiYHb4RytWHHKu41lUxbOiXsIm8bmsqKPoeRs5dwPQEL
         8XKenliSAZpxDLG3P9bqW3xGtupDIeVMNKmjVYdCeOwMl/O1JQDiDkQd+MelQv2S8puS
         wxZg==
X-Gm-Message-State: AOAM53141wkyZ1CN6Q/O4TVdgHSLh8hi48F3PBK8+5DBuclmWvOG/j+D
        PHHf5gSLTJUhEjxC6YDahV5vzA==
X-Google-Smtp-Source: ABdhPJzxblTCS2xRcc4B1gj6x6TLZbGGe/ZkxV55c9Zg/bc+WmiakZRcH3jYSR1lzG2mYLzQvdoLAA==
X-Received: by 2002:a9d:4683:: with SMTP id z3mr542498ote.95.1629930284432;
        Wed, 25 Aug 2021 15:24:44 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u19sm263721oiv.28.2021.08.25.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:24:43 -0700 (PDT)
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
Subject: [PATCH v2 0/5] drm/msm/dp: Allow variation in register regions
Date:   Wed, 25 Aug 2021 15:25:52 -0700
Message-Id: <20210825222557.1499104-1-bjorn.andersson@linaro.org>
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

 .../bindings/display/msm/dp-controller.yaml   |  13 ++-
 drivers/gpu/drm/msm/dp/dp_catalog.c           |  64 ++++-------
 drivers/gpu/drm/msm/dp/dp_parser.c            | 102 ++++++++++--------
 drivers/gpu/drm/msm/dp/dp_parser.h            |  11 +-
 4 files changed, 100 insertions(+), 90 deletions(-)

-- 
2.29.2

