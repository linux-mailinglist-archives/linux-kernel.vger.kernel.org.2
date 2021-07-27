Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977C73D7F16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhG0UUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhG0UUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DABC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so23960079lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIpScdiCXHtz5HFKS+jehHcY8/9fE5GMmH0c5uPACAU=;
        b=nYvQb6W555wl2V6qSzIGTVspbx408MqdKucy3dCzQ4yXvijpf5V7cL6KL1+gYCeoNh
         73kz4Kd26K2eLz0+o5lT0KDyh3SJLRHcmZHJDyiySF5N4cITPhtkbgvqcFeIQFcA0SUY
         hGIFbf6MjbfTOyKF8ulwwWPNwH4eYNm66Lf3aHo1KGUPDhylmLpI62vWhdL0JEkRjI5P
         9utgmcivV+JnRF5b4FKI0+e2xzdxpIPICIRsCoyzxo0UQqA+3qgtO3IMhaSIMZ726fZ5
         dAlCAP6fQiFHox8Q4e6UazGUV3YikbwIMqcs0ypJ2+sOTfV6rpVSmUDK9S4CtAjzLOYg
         GDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIpScdiCXHtz5HFKS+jehHcY8/9fE5GMmH0c5uPACAU=;
        b=DFx0PWrPSmqGTRMS5k0SYWeEpdHx22CJZD8qxoec9GcP9Z0Sp5yLzk89vDV36Y1gKQ
         Q2k83mhYZo9gzXxLasGE0nMEqYSfl0CAFCKxxyvScOChK/B9/RDLGbxnBbHBO+zmg6DJ
         Ov9ohadxeYs4XSjZJuSFXiNJIR8TUT5OHdcdlmNeOyVHtDqosrCl2mHxYgluLrfY/rlN
         W05qcZA/d+IprdbXavGHrHEe+A9RAYlJxcMshn6dT3JLt6ZvB2hj5UOByvOtR3Yzz5WH
         T3bCDE+ncu1lvewBqN6U7lIONaLTxPLtvjKmU8q5CLbTU2H6S81mkdHV1RpKuarYXBXO
         GDRA==
X-Gm-Message-State: AOAM533W0kxXvpjgP3Xxsf0eF8u5sceG5K67ndQmfrtcs3A+1FUgSx1w
        9MO+B6d0U6TfGo3E4b0tFCCN6g==
X-Google-Smtp-Source: ABdhPJzaTMep7BtxnZA7h6E2VYvnScNJNSBj17Kk409jF+FhgYLfGq5cC1gWhh2xNYJfdJ0EQgEZ1g==
X-Received: by 2002:a05:6512:604:: with SMTP id b4mr18708423lfe.184.1627417218990;
        Tue, 27 Jul 2021 13:20:18 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:18 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/8] dt-bindings: clock: qcom,videocc: add mmcx power domain
Date:   Tue, 27 Jul 2021 23:19:58 +0300
Message-Id: <20210727202004.712665-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sm8250 videocc requires MMCX power domain to be powered up before
clock controller's registers become available. For now sm8250 was using
external regulator driven by the power domain to describe this
relationship. Switch into specifying power-domain and required opp-state
directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 567202942b88..db4ada6acf27 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -47,6 +47,11 @@ properties:
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
@@ -61,6 +66,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@ab00000 {
       compatible = "qcom,sdm845-videocc";
       reg = <0x0ab00000 0x10000>;
@@ -69,5 +75,6 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8250_MMCX>;
     };
 ...
-- 
2.30.2

