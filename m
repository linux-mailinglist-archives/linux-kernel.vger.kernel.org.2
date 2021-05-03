Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29337124D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhECIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:14:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 01:13:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so8307226pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6l3WZj3YpLSLYBE9dlRHMNdaDR40xxIBOfhqWp69mbg=;
        b=PxTG76pbMhf9gDZV9ObsYKFQOAHw3xCIumGo/a5UrFjqweBEA3ARHUIr3/9jLyUlfM
         ihk2yhBP3z0vCBj6hSOhGNqqHBbn0s7WEbmJ1w0ajHwEpeXL7ByX6+k0TtOC7VPI0urq
         Qt7+bOBU+/qfGiyjdsO2aQ8H95K/ylJBj7g9tds5xvAe+yALmRNCMxv3JJqsw5VtG1bu
         cvUTA1i5jsX9J5Xsv5230RGN4hifxksYC/1/ZTwQjIHK2zmfXPFuoZpYK6f1zNADs4Gv
         ok4+5PbbceFwsfUrz9Fdbivp86VXarUJTNUGO8Y7CXU/oDn7ckFCIEkuqpUZABDrwmsu
         Qygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6l3WZj3YpLSLYBE9dlRHMNdaDR40xxIBOfhqWp69mbg=;
        b=hXSoLN97Pfy8+TJtdK9hJI84xQEp4Sd4+ocAzQQFnXnUKix6IxSsnmtVDyJDEJyLpA
         vx0DRbK1wt19JGD2VF3H/FCMsndJb3FplVGm33r0cKsnuOark/zT+pn4nn1sM/sGtRod
         0PWTv+zSdxLT9OJbOyd0RMCPZ39Q5fwyxfqMx6l7gz9vhh0ThX8W/RzjiQxndesbgDFg
         D10QGWQqDDYNJB3JaHCqjac9DpJZ9cOXB97Fx/SKtanISsWAsSgCgFjzVR1JqRwRU2dF
         Yreqcom6b5QQPLGOpAwso+fxFrr4jqggaaU82JXr5by2cCS/auuLC+KUjOXjvYgfQDkD
         QxnA==
X-Gm-Message-State: AOAM531t+5189fYqMA/dhIhVfgwWPc9zPD8nm1TJZDUwFs0zfFJ8W/wm
        4BwlgAx8VXcyC24s4omsXdL8G7oxGQrEAw==
X-Google-Smtp-Source: ABdhPJyYPZ8CccDF4nlBAWOKglRbYMUGeH0Fb356HueluTIFPNGSI1/AsIO6EDgbSlp3Son4BOcPTQ==
X-Received: by 2002:a17:902:b28b:b029:ed:19aa:5dec with SMTP id u11-20020a170902b28bb02900ed19aa5decmr19812693plr.78.1620029623187;
        Mon, 03 May 2021 01:13:43 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fa17sm12031939pjb.17.2021.05.03.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:13:42 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Li <benl@squareup.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] Add MSM8939 APCS support
Date:   Mon,  3 May 2021 16:13:32 +0800
Message-Id: <20210503081334.17143-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a series to add MSM8939 APCS support into qcom mailbox driver.

Changes for v2:
 - Add MSM8939 APCS compatible.
 - Reword commit log.
 - Add Bjorn's Reviewed-by tag.

v1: https://lkml.org/lkml/2020/10/12/1770

Shawn Guo (2):
  dt-bindings: mailbox: qcom: Add MSM8939 APCS compatible
  mailbox: qcom: Add MSM8939 APCS support

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

