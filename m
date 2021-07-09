Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A93C285F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGIRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhGIRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:34:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1AC0613E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:32:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q18so24734198lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLWZj85HgqkOqv1HxmNCRrODidaWLC0A2DygbxwWKbA=;
        b=o6PnS0GeNa0e7e9IYLaOaw2dOPONtiUFh8iGm+grX09+xf9s+u3UnRFEcT+jYTQHnV
         WEpXItGnvRJbeiYiS7aCO9/dI09CI3C0+NkCoBvacPZeDMej5vIphi+4vrIbjDQW3xJF
         vDiwYl6+v2PmzA5r8Ll8sY6saB67KiDDc0VH+75xLCL6hhhU6CgckOqXCn8tPnJxQsNH
         o9cXFxRV83CmhIB7HXDzl9fWBd9kCfQ0DUiEJycPQ1N0sgeHMATjzVxE2p+Lb+rP+xfh
         3Or7cmus14QExq/lBPH874ms5L6m2fdjG335qnw51bkqMafMN3GpK4N4OEGt8kko8aZi
         LJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLWZj85HgqkOqv1HxmNCRrODidaWLC0A2DygbxwWKbA=;
        b=snskHC2mN9aj+A5DBaBWO2x4/z/lSg2SOQCAJIPr5wZEidqnq+q3YVUwAgCmNE8akV
         SpLn53ZLJMzn3JFzQQBek/h4BcytgMXDcu3VLMI39dJndd3+Uz5Qt0i+H6xJI8nba9V4
         iQ7WtZVvEIST5PC+FumLODDam/8cJVV5vQA+9xa85XGrCbP1rynTIKrKJYSU+vPJThz+
         LYyjgbGTHSWdnUG7D7GiQ0Z659PbUhBQr3rYtgWxfpGLrmFk0Snh66ImVvegwsRJdO8x
         Ly01mWLbZtc/Kaz7VCeR0z40+Wl3pWU9qC0Nx7oSV1qkC59+HMbTj/Rm7Z4W8GLqGVYw
         HXjA==
X-Gm-Message-State: AOAM532/q1PFE2VYdJTE1DVAcTVYIg6ne2IbDonG4iDoeQrBD2bTGCwS
        FFz4/I0eBuyEqCBOQAgkZHGDlQ==
X-Google-Smtp-Source: ABdhPJwEQLoRd1w6PfNkPyS9S5rZ2TWa8UqsLDK3TnyBxmXnZv1cIcW+tsqWV/9Ow4rAE/e4Pem26Q==
X-Received: by 2002:a19:8c0f:: with SMTP id o15mr29897641lfd.509.1625851924989;
        Fri, 09 Jul 2021 10:32:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b14sm511129lfb.132.2021.07.09.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:32:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
Date:   Fri,  9 Jul 2021 20:31:56 +0300
Message-Id: <20210709173202.667820-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sm8250 dispcc requires MMCX power domain to be powered up before
clock controller's registers become available. For now sm8250 was using
external regulator driven by the power domain to describe this
relationship. Switch into specifying power-domain and required opp-state
directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 0cdf53f41f84..d5c4fed56b6e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -55,6 +55,11 @@ properties:
   reg:
     maxItems: 1
 
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -69,6 +74,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8250-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -89,5 +95,6 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8250_MMCX>;
     };
 ...
-- 
2.30.2

