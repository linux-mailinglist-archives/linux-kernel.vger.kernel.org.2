Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5134BF0D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhC1Uxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhC1UxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:53:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4630C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 75so15408260lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DDdVykV/0O7hJCqNoZ+wSUJ/w2kFv7G/Wtz4fTZPBw=;
        b=SzFLFLPcDIg98gskIC32OPQDTcn3RDLzYFL3LgxXEisuWoJNnenpapHKnOaKzs2Ujb
         Pf6lJoliMfHI1jaqNeaNgvVmghqUSf+Rg9rc00tKUW4kh/m+qnWU3XQayLKeyB8nZ/BC
         gGHyUm6P8+jqFetEjd45/GoLId8gI6NudjGkSbSREvnYV5lfXgyZ+f/3mfZhAkI9u6RM
         N6Ct/XKBLax/YWwgxwudgwmTvdppcRVUTZZzjU53xOtxJzwCpo+hFw2R19YKSZ++X+MS
         n7NmOG7BD8uFXfweRN8qY57BHjkX0rfhh4+MhD+YlZfxepBr2LVnu5bBHiMXjeMgYpjf
         +arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DDdVykV/0O7hJCqNoZ+wSUJ/w2kFv7G/Wtz4fTZPBw=;
        b=cn7mRkMTuqFIP7c+doAwVXy4/vJhlQMsiwjlPlRQdBcR3yBsiE+uoYXySCOr8bfPEO
         F0KtSvZeQXCakfAgRyUbE3B2hbYIQosNST3NZXyBFnu4bZpcZATQ6+jtRBgrwRHp63h5
         qYc2GziaWRdSciYNYwkleP+NiQNyt2ju8Ga4EoVhkOy93zW6eANDu0mrFN6LiZLilNKY
         vvCBtd/IxSihwz8PBC6ClkYd9qZFRT5dMp1VQRR3ff4T+lZA9vsq779JWsNseTjZh9MD
         MvIa6oxVttsTe8ErsX4P8TprwRxxDYdgM4g7yvL6Bv5fYi/XhH/3BkkzZZhGoH2Ky3DG
         Ml6Q==
X-Gm-Message-State: AOAM532rDNr1PCR9ocYBDPc0/9yXksYPYxgk0YIGdMkDUKinyBWvHer7
        pzidZsRaBBihWlOqAmOdmNiW5Q==
X-Google-Smtp-Source: ABdhPJxOtzegb86TPTmyFZjDkmSZk8cQLsgTcRp0nO1c+3XhKOENwmgj3hS0Y1G4rrRKjY3+4p5egw==
X-Received: by 2002:a05:6512:b8a:: with SMTP id b10mr13849198lfv.69.1616964784117;
        Sun, 28 Mar 2021 13:53:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j19sm1589788lfb.15.2021.03.28.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:53:03 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/7] dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
Date:   Sun, 28 Mar 2021 23:52:52 +0300
Message-Id: <20210328205257.3348866-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
References: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SM8250 in QMP USB3 DP PHY bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 62c0179d1765..217aa6c91893 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - qcom,sc7180-qmp-usb3-dp-phy
       - qcom,sdm845-qmp-usb3-dp-phy
+      - qcom,sm8250-qmp-usb3-dp-phy
   reg:
     items:
       - description: Address and length of PHY's USB serdes block.
-- 
2.30.2

