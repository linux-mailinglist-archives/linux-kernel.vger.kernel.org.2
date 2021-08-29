Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284233FACDE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhH2PtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhH2Psy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:48:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s3so21257924ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inLqKYpa2FC3cgFT4WtB/EnDDjgqc5HnVORQi3svwOE=;
        b=F8ay6u/cSfUnNNdwiS+jLN3ZqiU1Vt8oW1KbB9/12Eh1M2l7M8JFC0G9UYbEIkeQGQ
         GTXgqxpPZYfeDPS2wbgh0kNkYts4z7S/xQMyntn6PXz7sxE421Ry5TeJ+2/3e1qwDYuM
         X3Sba1dek5IMManHoIPomr4EbRfitiY1/MAXbbn+0x2+Fl9/dfehNxIn3feJWkwSyuHY
         KENvz7iQPxQOfQXJu+o+fzznF75+NNwGA8uy+8j1uLxJHfrUl9o9jWzLoNEIdyMrW1LP
         rVqxWJfbRzT2qtQgdDapfiMxL5ekY+0CtBB/nbMa5bHwYtGA4VwWWOBKHDuj0Qx2PiGt
         8PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inLqKYpa2FC3cgFT4WtB/EnDDjgqc5HnVORQi3svwOE=;
        b=qx308+DJz6g5gwqB+rqPZjcKiIrjSyJlquMpmp6exQmiBUo3jX8DC/vbyQoNWWHGIv
         zOXkoYTTxO2pq2bPpK2j5xcVn94wQWTbgL895u5d2Xr8Pw0vQdaSOZ7G4uwLewu1XS07
         qets+g12SMhOTo0o12OalTzHUtWY2ypDF6Wnz2AfG1075vwyReJcmydDLsZOr3gPci17
         umvEDmDnKawe20ehpHjJiX4YeudooAvr4mmGPY2cZjgB8Bn4cFU8hUx/Wt1m6EErgRcn
         S7IRd5LrarGEVRdI4Kw/r4QbMCH5Kcn898kLV6xoKosDMMoSJ1u+kWM4rO40RXNJRO4+
         1IGA==
X-Gm-Message-State: AOAM5306vsm6IvSQZHnETsnMFn2dOmudGbDox/v8kdVuVLRVM2z6vSL8
        N1D6pW6JTc5ctaZCSLLaIHcZBQ==
X-Google-Smtp-Source: ABdhPJz25zhv1EwE7h5kOWbKDjoJF/zD4TToDLyjp9wuFbb2cExt+RdUCStdkoXk01E9yDFSMYlXNA==
X-Received: by 2002:a05:651c:144:: with SMTP id c4mr16480033ljd.223.1630252080200;
        Sun, 29 Aug 2021 08:48:00 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y5sm1481243ljd.38.2021.08.29.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:47:59 -0700 (PDT)
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
Subject: [PATCH v7 1/8] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
Date:   Sun, 29 Aug 2021 18:47:50 +0300
Message-Id: <20210829154757.784699-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/qcom,dispcc-sm8x50.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 6667261dc665..31497677e8de 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -56,6 +56,16 @@ properties:
   reg:
     maxItems: 1
 
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -70,6 +80,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8250-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -90,5 +101,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8250_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
-- 
2.33.0

