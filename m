Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715DE3478C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhCXMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhCXMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:44:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE61C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:44:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so32622448ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3C+3mDs8vGmnW3km7Uq11zgkVw2a5Nc8ErirW+ALE4=;
        b=iwYZy1Nsr2QY6H2EgfrT9yG2cqScpO7/uDnbcVCg4chL4tDG6Jm+y8HzUtygPO5mfp
         KA6MAzjXw3rF8SbIWSEDOvryWfORNmdChDyPIX/4HwfvdsJkJsRr1QXS1h500r1weACy
         w66GqswG/yjthcAzY+1uW23IWJnk5wbvWWr4hwBN2Olv90AhPn0tRkYaJYKPdIdmsfk7
         Uej5/7fZoeVzsF2HpHB0gLOWAIqbGvNG5jVEYpY3zeWQElIW5Bl0GSw+nbBn4lzx4nP/
         aaRbMtdo+wZaKO3lRjlXUdGnAa/yW6fbjXAs6Du2JRr7GZoeN2bQcgMqn+wguOYgOAE/
         03cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3C+3mDs8vGmnW3km7Uq11zgkVw2a5Nc8ErirW+ALE4=;
        b=SGAg2SDLXLrfzxq9XVAYtlVvBB8GAJNRBcCq+JdslfjbP9pR4cw0aFTxfVxZcn7aTx
         6H6kibgdP1yUNm92lkxHprTvkeO3HMy7wW2Y/AetqvzEWDeIWd7UsswUoTdIH4eTKNMJ
         aMJLa10n42insQnE6a2dkUgTX09Tdc4ZKr49NK+uA684FVMdm3OAfQ6iXo71Rsr9Su++
         bRgj5xnreToOSm+chXE36C+Bu/lXStce1B8yL0cipdGgEyHlDBkxh3xc4p9JSiKnZFgm
         vJSLQCnOBvMya42rg9S82cYGGT3HG4ple93oYYM8hLHSyOkExiw2Ea0hVWL7MY/tPjjE
         6O7g==
X-Gm-Message-State: AOAM530M7O8T+tz0z/ws6ZxFsL6xACDU2dC71VRBOTsyAI1LDI5/29sx
        goFh9py8ZdiRq5eQPibq8Cl2lA==
X-Google-Smtp-Source: ABdhPJz6Nec0sefAZdpW0T3BFckZyWqLrM/834NeK8Ct79eMtTu1trIebowmcEEYisfPNZ3Ku72r2A==
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr3453210ejf.277.1616589841323;
        Wed, 24 Mar 2021 05:44:01 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id la15sm876077ejb.46.2021.03.24.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:44:00 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Robert Foss <robert.foss@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: thermal: qcom-tsens: Add compatible for sm8350
Date:   Wed, 24 Mar 2021 13:43:08 +0100
Message-Id: <20210324124308.1265626-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tsens bindings for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---

Changes since v1:
 - Vinod: Remove comment

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..e788378eff8d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.31.0.30.g398dba342d.dirty

