Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC136E2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhD2Aif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhD2Aie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:38:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A759C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 17:37:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso55232808otv.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzVBAT7fLNBdUBZLJQxVK1ZVpLgca3IdfSpNyGEzsn0=;
        b=K0KwdJty6MIrAKG+FegIYHm0zfWgr1uKyaUrSLhlh/tDnJMEA2u06pRNJxSe3nflmF
         3/BIhzdwil+l1pDc4/cpnFAoFXp1JbkJBXVXLvAD5s43u0wHo6jbveH5OyeilDC2Y384
         XJbDU6s93q1BtIg7pVuTrew4U1I8Jrwdp13+8ioBhE4CNDKd6fX34brZ5KCSWndJ5y8h
         n8Gy/rJT2Q58MN3032BjCoVissGrJFh9ZxjTh0R4z1E+cI/SGC8eqqBfVMf37WkL0EBk
         /WHIioDg2u9HjdDLbchAe5LuQaWXl2hGyCVQEx9MU9wcVBlbcRUChI/gjJThvugLwLK9
         0YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzVBAT7fLNBdUBZLJQxVK1ZVpLgca3IdfSpNyGEzsn0=;
        b=YjrrkHAQ96jfLtIbkTzkuukig+NdkPoodUGm2Gap+Nr61F7rmhHhLVs2/cAW9BKS/n
         DkdcaAnzxpit3Pc+Bvx9RHGNtZOsUpLGkNCawGL6IsmpHEujZB8kK1lpEWBRfkl0H7vz
         A6qocjMjTDTCITB370mM62RH1/tFxMBI3wWFy1/r91sgxirLajB5X+lyAOPjOhFB3HTD
         U8L3sb8Tq+INMPNl/BpLTm7SxYAEdi+V0GHJfTPqSzXwL8zmXhtGtA/x0t8x594QtGAH
         nYCKvQyzEeqHNJfwz+XRWY2yp3ONzwLbKUQBskmn+hk+rdUyWoyK3bhlN2t1Jir/pBnh
         ZNkA==
X-Gm-Message-State: AOAM531UNMdVpm6IQLBcPeB7FyJAx+PvXrRZbh0FFQyG7y1Hn3cdoGQj
        KHHRL3hhHqYpS54JiU6C17v4Sw==
X-Google-Smtp-Source: ABdhPJyqMG44KHGTxh7hXcyD116UD+IX6SFca2bhJAL4JzBdZXEePILZGpGFFp8CFrGMcVVTJOqMaw==
X-Received: by 2002:a9d:bc3:: with SMTP id 61mr25494742oth.7.1619656666762;
        Wed, 28 Apr 2021 17:37:46 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o64sm314893oif.50.2021.04.28.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:37:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Add compatible for pmi8994
Date:   Wed, 28 Apr 2021 17:37:51 -0700
Message-Id: <20210429003751.224232-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMI8994 has 4 multi-purpose-pins, add a compatible for this hardware
block to the MPP driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

PS. I see that while the related gpio driver was converted to hierarchical IRQ
chips the mpp driver didn't get the same treatment. We should fix this at some
point...

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
index 0ba07bc96c55..5363d44cbb74 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
@@ -21,6 +21,7 @@ of PMIC's from Qualcomm.
 		    "qcom,pmi8950-mpp",
 		    "qcom,pm8994-mpp",
 		    "qcom,pma8084-mpp",
+		    "qcom,pmi8994-mpp",
 
 		    And must contain either "qcom,spmi-mpp" or "qcom,ssbi-mpp"
 		    if the device is on an spmi bus or an ssbi bus respectively.
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 3c213f799feb..2da9b5f68f3f 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -920,6 +920,7 @@ static const struct of_device_id pmic_mpp_of_match[] = {
 	{ .compatible = "qcom,pmi8950-mpp" },	/* 4 MPP's */
 	{ .compatible = "qcom,pm8994-mpp" },	/* 8 MPP's */
 	{ .compatible = "qcom,pma8084-mpp" },	/* 8 MPP's */
+	{ .compatible = "qcom,pmi8994-mpp" },	/* 4 MPP's */
 	{ .compatible = "qcom,spmi-mpp" },	/* Generic */
 	{ },
 };
-- 
2.29.2

