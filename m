Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0243E408
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJ1Opp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhJ1Opn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:45:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E4C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:43:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u11so14134220lfs.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=148z8Jno5ibjrSfO3iE+zKfRZ+rTkFE53njyJOvaPpE=;
        b=FM3+GGUSfg6YDOe1Wo1KLij7xyUbtrOhNvp+MkkZNaMFKzpKBK1xHqInpLPyQ6Fu5+
         nCwUQODEkDLD+RMo4eYW6XVC8Dc2/aY+djYAUDLKaYKzxEtrl6Mw1M/BxJbOYOosRQuI
         RSYZ+qCyKm4drPnOA+LrKBrBRhmUYu2nTiyLbGw/RkRHpla6vhj53vxN2YiYG7yDyA/I
         K7t/VuQ4K3PPYlPOe2CsJEMnLVeK7lNZ7hfjBU0/vjlbCM8Lh783WXExHiU6NYakmIB7
         h+4q6/zc4jCQW8LJOAsVce89xiPiRSWf+m3scb67KgBxMyzKCPmXVKoPf/2k4kVeuF4B
         PCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=148z8Jno5ibjrSfO3iE+zKfRZ+rTkFE53njyJOvaPpE=;
        b=mh0G7NhPlK7D8aUs/vrjvIJTCQIdGaWFdt9isGIHOtA9SJ1b9/txIMplqMoaRlF1X2
         3/bTpcUxPq0fQCmDVgE0NhYgiir94yDZ27M+TKAtLtUPVMNS4ZvszeV6+IFnGiTVZYzm
         F/mq05eqaT5Cdhg7AIxL0rcH2s4W+EmAV53+TVIR4WZvGVkytjdnoB9N+4Sna/C9vvby
         9g6SxheP1M+Kr0rLgm8rgE1EZP4qtJC55ndElpAwb2pPsDmAcZGQTDtGzQHfFOFZfnAX
         gGlif7YhxNj5nvV3sfpKFDDgQNsPgT72CMynATIHZ6job3iGTo1OxVuENgI4hYSjHSRG
         VYhg==
X-Gm-Message-State: AOAM532vyPCmWRr8Aest9AqnLSldCNxMO08eIrTsd16XpatsiZReG51b
        4X0z1paDamornvdXMC5f+piSzA==
X-Google-Smtp-Source: ABdhPJwtVWJTLzQqQ6CF4sgcVaSbsL/TbZAhf+71RjlxI06EBTx9BcGPNlntpxY18ixgsSk2ylCj6A==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr4657354lfr.415.1635432194696;
        Thu, 28 Oct 2021 07:43:14 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id h31sm332844lfv.111.2021.10.28.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:43:14 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: samsung: pmu: Document Exynos850
Date:   Thu, 28 Oct 2021 17:43:12 +0300
Message-Id: <20211028144313.9444-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 SoC can reuse PMU driver functionality. Add corresponding
compatible string to PMU bindings documentation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
index 17678d9686c1..0bbd89265b28 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
@@ -24,6 +24,7 @@ select:
           - samsung,exynos5420-pmu
           - samsung,exynos5433-pmu
           - samsung,exynos7-pmu
+          - samsung,exynos850-pmu
           - samsung-s5pv210-pmu
   required:
     - compatible
@@ -41,6 +42,7 @@ properties:
           - samsung,exynos5420-pmu
           - samsung,exynos5433-pmu
           - samsung,exynos7-pmu
+          - samsung,exynos850-pmu
           - samsung-s5pv210-pmu
       - const: syscon
 
-- 
2.30.2

