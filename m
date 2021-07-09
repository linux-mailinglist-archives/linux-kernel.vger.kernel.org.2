Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56A83C1E56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGIEe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhGIEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:34:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31237C061767
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:31:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r20so5928107ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLWZj85HgqkOqv1HxmNCRrODidaWLC0A2DygbxwWKbA=;
        b=sParuvrSW3yxOcQImsE/pSCTQsOWei74sYLKne+13T8AGuPpPTPGmK5tqJ4t/huvC5
         JqLDLskOrOsSFTCiWSPOnOYtGMF4nepGfge0N7s3Hc2mQCV92Y5FnUvfk0avW1wP+c/O
         zzNNICJ5cPLJvz5M4slRZs6w+pZrJ2ssyQW6qzU7Zf7w27OyOE2+MuwolUJ6dxR/tcoq
         vY/bsMKFBI5LVvmLS9I2oRBAiazKiG3T7ow9wMDWwo8URO7kgblsJCAbCSFsR5eFXJjI
         OyANlUpiTCdH4cosnKXw09vr+OuDE0MVDu62o3ozIoT9t05f2bPckUVb+Wn8gGPc1hu4
         5xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLWZj85HgqkOqv1HxmNCRrODidaWLC0A2DygbxwWKbA=;
        b=pR4ceg5pPN34BGJ6aY6zmsLMDCQzJZx3YgUJSOhB7SiU7H8aIMrbFUMWZT0mY2i5A7
         KOgwOxvUnFzbVtVpyRYScEOA9MhHyZwyZMIedOSjkO2ORqta7LbJhabbmu9SS8eXEptH
         ZvFnj1y7XP3NNLOcS5cBpQbeCV9kclLPmBPD8BhD8uOFx3UuliLpw+yYeiV0dQJ2IeSl
         0LE2hde5F+nSXjByerUrhM6AWChERChBcGqcTQk0ZaK3Mb3OMPmroFE17zBt1y4GnxLv
         aSnb4kRNdEeo9Ll6riVoAegUsm+DUjGnZ+kmBjNq+bETwLwicFMAtKCAi8ft3tJ29t67
         e+ag==
X-Gm-Message-State: AOAM531D2zFaEroy8Z/B1LwUd6wdTU1/D0goaA+KVToX9/801mtbLGDn
        9/XPaPArLzc7al0VLNKM7B3SOQ==
X-Google-Smtp-Source: ABdhPJzC7Z+xZjYcUQMVMQp4Gm4Y3ui0lhahHrsnQGoO/Uq+qBwQl2gqLJ7mDclck5qgW7HBdX0rhQ==
X-Received: by 2002:a2e:a54a:: with SMTP id e10mr27331977ljn.120.1625805099320;
        Thu, 08 Jul 2021 21:31:39 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h1sm13028lft.174.2021.07.08.21.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:31:38 -0700 (PDT)
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
Subject: [RESEND PATCH v2 1/7] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
Date:   Fri,  9 Jul 2021 07:31:30 +0300
Message-Id: <20210709043136.533205-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
References: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
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

