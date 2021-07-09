Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E173C1E61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGIEee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhGIEeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:34:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02070C061767
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:31:42 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t30so5941855ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+l6RNZfO6t53h33tKaqwIC7dbp1+6FXvY3b6ZyHCbIM=;
        b=WlwvwLrQoeElCrOz8khcG1qUMUEX4LRnDzheKeTWgD0s/tDz3fm1rN5TCIGDvNLuWo
         VCeygJMIaI/e0Mx4OmU4mn7CbsYP+a2twV4vfJ1QwL1CbFLkihZ1ers+wr1iLTyzN6hI
         rVEyAGniCLt28C3LKq5xbcM0+urmeCV3MuGXUggWspmcLEXOKDmV/IMYZnkFONNhqa8D
         NMfMfVYJdp2WVsQ30HIsoUniSnmW1SERAu5uRkjqzYBJknZIlFVxMESm+QpmKsmvE5t2
         E7nyWENWm9fzwvquITAraHwHDC8DFgOtwlP9nr/T+YzFL2Lgpe5g8QXOeZDOrZeuk45/
         0kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+l6RNZfO6t53h33tKaqwIC7dbp1+6FXvY3b6ZyHCbIM=;
        b=ALzy+WSahPqMHsUQ3Z5d8kxtLTKfmKe8RmshUp6pxKenDvzQSViXgxKRFLy2RYF/qR
         8iCykYOS14v/+34s0GavgSrTYtzbBsgjcp9kk/n8dELHhPfxyMwqtv6zk2beB8/j2PW5
         V5PNsk2gXvBoCzhIVUfmcGbmn7Om41+dYjZQXARpnven0FAD8xOGpYGar14ktiU+sOE5
         Txcyi4VtDYL88jM+6S9fUICJnULyOsfTW3Mu05j5q5nL+VhYOgtjVhomM6t2pa1px5C/
         tguGHXoStmeh6YwXD+oVkqYvv5/vWJoF2THSaeBfEs5zmPqIrMReejkdzDS6PeaVQtDL
         cGiw==
X-Gm-Message-State: AOAM5319mLWjWziqFDp/8mNW7ifhgMg48Idkh0aNyW+kVxcfOf73PdWN
        6MLegjellLuAZ6idcBT48CrxBw==
X-Google-Smtp-Source: ABdhPJzJ2+kFilhrLt7SsXBip2dwdXrJIpKz5q8WYP9kQ47A3T9krwTqZFcblwqNnP6Hh6jPrB0U8w==
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr22464773lji.161.1625805100191;
        Thu, 08 Jul 2021 21:31:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h1sm13028lft.174.2021.07.08.21.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:31:39 -0700 (PDT)
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
Subject: [RESEND PATCH v2 2/7] dt-bindings: clock: qcom,videocc: add mmcx power domain
Date:   Fri,  9 Jul 2021 07:31:31 +0300
Message-Id: <20210709043136.533205-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
References: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
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

