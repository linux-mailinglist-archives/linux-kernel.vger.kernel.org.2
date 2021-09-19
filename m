Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE541097E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhISDMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 23:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbhISDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 23:12:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:11:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so445183pjn.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R30B43xyz2y8LC6ycmn9kteDx5Gx9CHyBFPXTaULZU0=;
        b=fNi01DaE/B/10oGxW1oTOrTnEfWv3N+3WkHOqbm/m2uvIgzPKNhqTNLAFqkIMU6u9y
         bhZxISlX9y3KdwaBGaQf3VwKvYHojM9vdwAoCmbQOO8dVjFfIrqVm+Y/Bdsvj6+glSY0
         3cvC3QithyJQlGKfj6vP2o8efw08HARme3UyaZBfEhHsQkqaT39YcZm2En8RSsKY0S+7
         1iL0Ka26ZuefjmKPYD0tiLGIYsw9cYspQqJc1pxLT8A2wix2UJKNBAVMsXGl1oWcw8An
         9ZXt8yG1QRxGrRTnIiGSYjbYzxhN1G7t/cBbChzzWzKqcZxd58+fMlhhXvk5IA7X+uQL
         UJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R30B43xyz2y8LC6ycmn9kteDx5Gx9CHyBFPXTaULZU0=;
        b=a0EH3QY+bc6A0SNeFRldptSbm/K86jhMH1s8x1dKGEYaoMpohFhaQx5bU6uvEyPn4s
         /DXU6+VpXSkSwNDO/WAdFNIEkPBiFbAWQgtvmviCj61UEqEjOA6SiOEX2Z9Qn+vpeId0
         e1iSWSd+s1cR7DSDQaBcwjuOd06LukQym+syXcTm4u/7mzSGaV1cJ79SlExD/nyBOZ3D
         sZyy+tWjJjuZUkFkiju2rtuQcJxOPetJH8k6S9X8apj3QnFVOcnf36b5j66yEHhRvtmc
         aUusfVwaPcWbMEZgPrMN2OASs7JyvcAo9U2lznfzBOTTmuNEirxrki6qDoFQcIV/bAYk
         9gGw==
X-Gm-Message-State: AOAM533vKy0csbyFNmH7YKi7/kQEOPS1jvh61yRa4wzy32R2/OoNc+o8
        DYeb+JHMLsWydHYv/+qFbMgfkQ==
X-Google-Smtp-Source: ABdhPJxBtNL84WRMvdDSgQAFsSSInOctHxHUB8iiqLXyFf6sGvVSOqagb8cOPqiaxAHFO9G+9lXNJw==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr16768240plr.82.1632021082696;
        Sat, 18 Sep 2021 20:11:22 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 132sm10224931pfy.190.2021.09.18.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 20:11:22 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qusb2: Add compatible for QCM2290
Date:   Sun, 19 Sep 2021 11:11:09 +0800
Message-Id: <20210919031110.25064-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210919031110.25064-1-shawn.guo@linaro.org>
References: <20210919031110.25064-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for QUSB2 PHY on QCM2290 platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index ec9ccaaba098..48ae604b2194 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -21,6 +21,7 @@ properties:
               - qcom,ipq8074-qusb2-phy
               - qcom,msm8996-qusb2-phy
               - qcom,msm8998-qusb2-phy
+              - qcom,qcm2290-qusb2-phy
               - qcom,sdm660-qusb2-phy
               - qcom,ipq6018-qusb2-phy
               - qcom,sm4250-qusb2-phy
-- 
2.17.1

