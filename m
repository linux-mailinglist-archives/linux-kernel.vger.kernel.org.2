Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96F340F021
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbhIQDGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243402AbhIQDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:06:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F6C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:04:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso6284188pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xfWLMEnzqQR6BIE1mrFkeIl5FyjRfgu7/fKn/trtwfw=;
        b=VbCmsAOiAPn/MfnVJTvWqSXqMPyS5YLX+2NNDlGtOSM+864NXmsBuBGRoUtfxlKpCl
         hZtw9GZiF2oXMLLL8Z1JrGU/hiMBjiNFDat2cvixKGNzHU+XWlna3gytdnT1isVWnAdZ
         mJGf9DUb6w+RMt2k5X4zLGqEz57baAW7WqNYnCO6ORi1wi3eZqMDyxpp+qNbzchojMN8
         OUzf39rX8NNVrAdBEGEtS8ac6LTxx2UqJwOP0um6+GfBg4tj9KdY5JC5EPIEynQQ03Sv
         thtL1sfZ+bu8qlqVZ6i71WLbBiPv5lJipdaIBwnmIcR2M6qNRuKln+B2bVMP53YDw/39
         thUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xfWLMEnzqQR6BIE1mrFkeIl5FyjRfgu7/fKn/trtwfw=;
        b=yP1sP3zNautfTlr2yL39l5mfq4R3a0MvPlyHFlhxaQYUhQKsERQyI+XyVmX9mfMGBU
         QewNAsS7EwuzWWG0SeSLO2AOQamBTv5zqrebD2mIpo8K5JdyvY9iAFSQXykm8gaavL8g
         6K8YTjjh4e54kXiUhre+Tu5O2sWhpCyYaSlykgas7LqOS1Ke7NWVrbFgaV2eEpu9mQPl
         gbq2FoSpDBQ396GzR7aOgfzmlmm4zbwWqGRE+scdGky3PAJR82fm+HHDhJ7o2fxVDNxE
         mAXMGzCPe3ggTNM+l56dArELJSQMW410V3eGexB5Z/YmaaEVDNWpq1+VKoSbFcUAOwUs
         ++FA==
X-Gm-Message-State: AOAM532/DBrcq99ja1vcL36pAMnQh/I2MVcPRvwbqQp+Vs9K1MG4AqvZ
        swV5ceoCC/uqhD41eEnbgobUpQ==
X-Google-Smtp-Source: ABdhPJwVZGAnX+2ysP6GEehgG9kVZxzPc74SiVh/9WTG2vVLMNsyjMPOSFfGOArdlV++viZcnGY50g==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr18599261pjv.39.1631847891465;
        Thu, 16 Sep 2021 20:04:51 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q2sm9133930pjo.27.2021.09.16.20.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:04:50 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Add QCM2290 RPM clocks support
Date:   Fri, 17 Sep 2021 11:04:31 +0800
Message-Id: <20210917030434.19859-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds RPM clocks support for QCM2290.

Changes for v2:
- Use `rate` field of clk_smd_rpm to report branch clock rate, so that
  only .recalc_rate hook needs to be added into clk_smd_rpm_branch_ops.

Shawn Guo (3):
  clk: qcom: smd-rpm: Add .recalc_rate hook for clk_smd_rpm_branch_ops
  dt-bindings: clk: qcom,rpmcc: Document QCM2290 compatible
  clk: qcom: smd-rpm: Add QCM2290 RPM clock support

 .../devicetree/bindings/clock/qcom,rpmcc.txt  |   1 +
 drivers/clk/qcom/clk-smd-rpm.c                | 135 +++++++++++++-----
 include/dt-bindings/clock/qcom,rpmcc.h        |   6 +
 include/linux/soc/qcom/smd-rpm.h              |   2 +
 4 files changed, 111 insertions(+), 33 deletions(-)

-- 
2.17.1

