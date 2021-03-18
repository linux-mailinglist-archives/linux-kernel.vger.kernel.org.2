Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61A340EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhCRT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCRT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:59:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A8C061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m17so6477826lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0485Vy5N6KF2+fijz/rHnQfF/jhn88oJ4/4iLXGr30=;
        b=bIQdLWlU/R+vkdZoL2d/dFJE1/PsfRTcgZVvuFUHgy34PbujMtVZSoCHQMyHcpS1WB
         5EqNI/Qje8BXfFsUXoSSg64d90LszNPF6vDDLt161C3H0mlcjsqaD2VoKSZvv28JptGO
         ClXqT9UeFSn67A0R1RaeXEypEMhhyOnweZGzo7I+E0fzJlMoFXYX3TQE/ovN4U5SciHx
         e2svcOpaNHltSMtDg/bxubPtPW3ES69cragGLfSr/SNtnRa2QB/qYXXV7IPsN/JjvTd9
         RzFJNi1m+SCC3EC/53LxenNmOCjq6Ja16zy0tDebrHnmpQ4V4juJYSV6yhq5upLAy2Fo
         l1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0485Vy5N6KF2+fijz/rHnQfF/jhn88oJ4/4iLXGr30=;
        b=g9n15Z5QW1OzC80M+w1kstGSkSKF5+2ivhxxUdthxepcA0ltRm//iLlykH8rIlSlQK
         wdqgeKSaHpBXks04YEhokRD8vgOEAPXctr3IubMDqcruEJHqSDPVst9ZB0O+kHk+1bpJ
         d6xX7TGUuxPm3/Iz3GFxZmrLjf3sCZxZXn1/RU7P32l0F0wCN/ELZCV461uvX3gKR2Yc
         GYMRGDPvdC8HuurzbJGnaaM8P55wy8mvCHuBlJsYDPdazhP3PCU/Kyqc7tosicQrkrMn
         Ac5TeBb9UAYCZxAePuKelIoKASuqPvG+PxnvMz6huLaD0HgYK9OOBCpweuBY1wUk7hYU
         Q8YQ==
X-Gm-Message-State: AOAM532TYk3E41WprcP7oDQW3II0dTCV9ajvFtHygFJZmQak8BZHumDh
        naToxdmV3DkzUIvEwstm68QedA==
X-Google-Smtp-Source: ABdhPJyQVaWuhfh9NV1eeAbn/ZqEF+Ygjs+vKHv3HVdMIp4DI1FUuTAoM72aFLqem17qsKvtaeKPPQ==
X-Received: by 2002:a19:404f:: with SMTP id n76mr6482924lfa.184.1616097575858;
        Thu, 18 Mar 2021 12:59:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g6sm344159lfh.232.2021.03.18.12.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:59:35 -0700 (PDT)
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
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
Date:   Thu, 18 Mar 2021 22:59:25 +0300
Message-Id: <20210318195930.2229546-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318195930.2229546-1-dmitry.baryshkov@linaro.org>
References: <20210318195930.2229546-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SM8250 in QMP USB3 DP PHY bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml         | 1 -
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 626447fee092..c558aa605b9d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -38,7 +38,6 @@ properties:
       - qcom,sm8250-qmp-gen3x1-pcie-phy
       - qcom,sm8250-qmp-gen3x2-pcie-phy
       - qcom,sm8250-qmp-modem-pcie-phy
-      - qcom,sm8250-qmp-usb3-phy
       - qcom,sm8250-qmp-usb3-uni-phy
       - qcom,sm8350-qmp-ufs-phy
       - qcom,sm8350-qmp-usb3-phy
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 33974ad10afe..9792cc567cb5 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -17,6 +17,8 @@ properties:
       - qcom,sc7180-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-dp-phy
       - qcom,sdm845-qmp-usb3-phy
+      - qcom,sm8250-qmp-usb3-dp-phy
+      - qcom,sm8250-qmp-usb3-phy
   reg:
     items:
       - description: Address and length of PHY's USB serdes block.
-- 
2.30.2

