Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71F53C2C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 03:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhGJBfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 21:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhGJBfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 21:35:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B904C0613E9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 18:32:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v14so26879302lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qhvMLleXU8XB+hP5k6t45pc4R6yiwCRVKRmnoSH9uY=;
        b=NC794FtPnTVb6jwGxk8olKK4GLQcUz8otGUoiN3jZj8/lRUyRjfrHf6PkBr7TpskOd
         k/DAfrexwr1d0Dic1t2+ZnlIrNdlNXeIsbL8gXN5LhqmjjjFl6BcZff4i3M0RPyMIfav
         4OvdRffu4Xlm0X9MPd0ZxqDogJa5hocWCA1OpYqXIvBkqvsYG/hR6Vb3PueGnLZ0zb/C
         sJiWDkrsiDkop0si9JGdq+oNgDKK9kpQOvMlh7ccW+dtVZQ/kBFF7i8/7A4/+YbbNGEP
         LoAIOiISvf7fQGJ72WnkrP0TOnttwgei0paaHuYa5YN+ppqCUo9e4/mA1vo6FoueXI3n
         D/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qhvMLleXU8XB+hP5k6t45pc4R6yiwCRVKRmnoSH9uY=;
        b=elr80SujqL9GQ9Zuadbe2n1n1zjRTFz4UnXzrsOgQvcIxX6j5fPJQjc7p/3VJWmVuG
         0esqjAm0+oPGk3HUns2SSvkkm1a1mED9w6J3qWxj+GARWJSNVZ5VOPHEZigc/NHmya6+
         /5eD/KYgy0qH8tEKiMEHVDGX0w9ekztXcmjmPwT4hYaYhmtn/bzZzLDY0WTv+UfclPag
         3FfCEBedvvGGScISwHFo2MkR0gazBxMGSZQhxRZQmh1/5sU7M95hnpUQuzsB9x3GcDUI
         9b8liW9l956to9XwM0KOWk3DaFeovLTGv0VRaWQmgwcI+hetXvdo0bQBCc7VXJr8QpN8
         nE1A==
X-Gm-Message-State: AOAM531mXRV2EO8Jge6U974Y8laCKRDNfR0sqIwvCQ11t2/oJNPpaawF
        ABftn14bHVV3P2vXnGWO+EyPJA==
X-Google-Smtp-Source: ABdhPJz9jcG35w9SWS3uxRL6ARRlS5cpPeZv89o6TTwQw6/6CYd9Xtr7YTZmI8olO1MZX05tsjt0GQ==
X-Received: by 2002:ac2:4259:: with SMTP id m25mr905215lfl.357.1625880776743;
        Fri, 09 Jul 2021 18:32:56 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p13sm588788lfh.206.2021.07.09.18.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 18:32:56 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: clock: qcom,videocc: add mmcx power domain
Date:   Sat, 10 Jul 2021 04:32:49 +0300
Message-Id: <20210710013253.1134341-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710013253.1134341-1-dmitry.baryshkov@linaro.org>
References: <20210710013253.1134341-1-dmitry.baryshkov@linaro.org>
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

