Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC545333406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhCJD4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhCJD4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:56:04 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E742C061761
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:56:04 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id v12so15072857ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aj082LGyMZQ2YsFd832Lo5lJGIXrMT5Ar9DshQA3/sk=;
        b=Dj+0sOU+MbYoauDvAP07KkIx6pmGSWkLXPRzUcrQjximqSfd+n+7zXqCY3qBtauSnd
         dfRfqS/BIDqGiDsPCNHwhzmNG09wiMKeut2wUiW4jGy2HOlysH64wyms9tI1yiiw8LNb
         MxG6vB4FrMe2zIjADrpqY4gRO6JjGAzyceh8j1QiTUxQ0F3bDdkYcXBbm8Qq2tiqohqY
         wjdbVs6JSIM57TJM5f4nBAvVQxjGtBsijshFpWxMdX9I3dh6w2OKbdMSMI84Pyj6Aq4D
         7k9mgd9qCw1OGjGs0Z6k8gdycBnYf9Ra1EjFeaD42fmCkgvmTTtrOyZjdFZGbjn7Owf6
         V3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aj082LGyMZQ2YsFd832Lo5lJGIXrMT5Ar9DshQA3/sk=;
        b=dG4hniR/ljJPtgqsoPM1iyXScLTe1kiU0lX6NIkn07v9TmPgRY2gYpRAqHaKorWCrK
         1PHX+KZ3xysAYisAWA5lF5NeN0oKyXLD7YwAMxrkMZXsD4NOjdfqWOvwMy42WQMBdlfk
         qld9BV0f5fB7nwoXJev1SmOwGyEp0C/r5O2xG2CfYgZp5L9RvBP9rtvsA35+k3/PX8qA
         88q672C4qrl2M85P/fB/szRrhrrJcHKdWEdxpR4dD4l7vgNIu9KfNE4jsx56AwyFIntu
         nrrsDnf2mkrdP5tgBWIy3KM0ApHtJ8Ib16PXb5ttWd0ao8CTNGpVHwxT4Vd3N28ahu4l
         1FTw==
X-Gm-Message-State: AOAM530XyTc2H1C11htHde3mgMCkalBxFIr4TjuzK1PMY4KrBMxMcvT0
        N1UmLToT9J7a+Tqvwrw2hEwSkTsXGYSowQ==
X-Google-Smtp-Source: ABdhPJzQxsC9ytUE5OK5+wQiR0umi1d24NiVdAVQ72mHUzWKWceak8ugpN5CWA2DMB51CZ9qs5grJQ==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr1114244oti.342.1615348563866;
        Tue, 09 Mar 2021 19:56:03 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t22sm2658012otl.49.2021.03.09.19.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:56:03 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dt-bindings: arm: qcom: Add SM8350 HDK
Date:   Tue,  9 Mar 2021 19:57:10 -0800
Message-Id: <20210310035710.2816699-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8350 Hardware Development Kit (HDK).

Reported-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 174134f920e1..9d8acf6f6152 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -187,6 +187,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sm8350-hdk
               - qcom,sm8350-mtp
           - const: qcom,sm8350
 
-- 
2.29.2

