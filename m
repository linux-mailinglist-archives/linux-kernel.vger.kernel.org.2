Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA0410990
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 05:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhISDgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 23:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhISDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 23:36:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:35:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u18so13965785pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2ZHVK/Jt1mzqXZxHbsZQx8f4Inu42Nq3yYQLi7QmACA=;
        b=yDXRj+7JMxBz4eJVFeHMHnBiwLOzFA7A0Idi+V8spGFR6kLdjnBgQankrYQ6dMk6fJ
         ZqXEVNw+EbCJRergP2xlyOSvLiBr8ORsxQP5dkvX6ZvjmZUYm5QDcCeKvo41KYz4J2J9
         3jKEf4uzCQDgMw/tgMIlzPJ/h+vRuQ7kF61vyOLpqV52zwg3KbTZlA436EO17teF1Vzr
         yYuzf+x/Uda4WbKCZA2dbrmSf8hZL4tJLy+XCpLHQDwwbiN82HLF8DL6PntmC+4BuKQu
         dMVGoXl30wP0GEACIG5UvLwswV8itAiULFVPJ/1EacGkitCkS0zfDtkPxa/3s4MAS97e
         bABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ZHVK/Jt1mzqXZxHbsZQx8f4Inu42Nq3yYQLi7QmACA=;
        b=zv8N4IkscdozEGLohRTJBrRXWqYIC4uiIaDpCbe7/fkykA8QJDYhJySvR/obDulGiZ
         5YjRnbjg1BjiyqBK8MiqNBXJYV/kHhv+t12oIAc6ICsPDfpXi3RK3dSHleDYdiSh2sOv
         dKRfYTx4ZaIK+tiO/9ynzImmCgvSwgEGPS5SIOizgzdB1CZfb+4SFSuIbN0YRtUmeCNA
         PgFQvk2mNxXeAwUXPQyCDL0H9+SxP0CkD4wKmVx+VZyPW3Qar2CW02aj4q1LwcRxji0q
         vB4mVX0k159vqUNYZDAVRgSrIIxgmDki/re5eYoyszeexh9DIF5SmsuMgZwiOBAejBCH
         ksjg==
X-Gm-Message-State: AOAM530GyrfEet3OVcSwrYXaYbWxhxAz1zwlV+hMz0AQ5iNRKEqWlHnC
        ywU8gODAAdvfyKPBG8cvYeVxmA==
X-Google-Smtp-Source: ABdhPJy8kRKK01qfSwpFJtkhq1N9s3rgKcp2JFmJyloTNrozfp56ZQ5kzL6yUVOU6GzPOUA9NL8w7A==
X-Received: by 2002:a62:774b:0:b0:43c:36de:ed14 with SMTP id s72-20020a62774b000000b0043c36deed14mr19028132pfc.36.1632022526820;
        Sat, 18 Sep 2021 20:35:26 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s2sm1644509pjs.56.2021.09.18.20.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 20:35:26 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] dt-bindings: phy: qcom,qusb2: Update maintainer email
Date:   Sun, 19 Sep 2021 11:35:19 +0800
Message-Id: <20210919033519.29559-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manu's codeaurora.org email address bounces.  Before he comes
back with his new email, fill Vinod's address in there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index ec9ccaaba098..d6301471780c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -8,7 +8,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Qualcomm QUSB2 phy controller
 
 maintainers:
-  - Manu Gautam <mgautam@codeaurora.org>
+  - Vinod Koul <vkoul@kernel.org>
 
 description:
   QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
-- 
2.17.1

