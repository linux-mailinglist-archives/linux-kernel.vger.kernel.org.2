Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684773FACD5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhH2PtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbhH2Psy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:48:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338DC0613D9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q21so21226236ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTbSV1E56r1NVZnQXDLnD85O88p/XKd1hFPjXfdyNKM=;
        b=fUKbEOZOe8ciXUu+L1aPDtOfETIX4lcjQ4ye+RO8Tb0n1yBBGrGTWsfykF/igiM2ti
         JsntY4K3BnJ0JSV52cElEARTVg7hjXxeOm/ObhO+4voF5W8gZCVj5cAPpFviz2dXL5z2
         ZkyHOsYV343oMOambqC74/BCeIHJ9tAJvvGvWYWW5JOEcPkbM+pVOGBdfeC+B3VAC8Nx
         qkH7BTiwbSGg2hoQbJnZJcDlc7MxGQXTguFaXElriA/Kjq0fmfAu3sp3VaYRHuShlgjJ
         McJntFk9Ecn3hcYI8GEbPTqTICpCH0JGAV/g04Xx3ANQFhFakicsFmRUMbjirUWIn5yU
         rzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTbSV1E56r1NVZnQXDLnD85O88p/XKd1hFPjXfdyNKM=;
        b=Tyrw0AqX5KeueRvZ5Y0wXnf58QJqHA97nOlWjTn0weAxWv23gyYikojMEpUS8Nzcqr
         Yc7oX8bEMfJDyDa1SdgM7/7THv0CGWo35gkSqOHSfckGzIouF7SxpsMUkc/a51k0TpCa
         gVl/qvzaPbn7LLTsrH8TB4HvbsiVL3pSWnGspwn4Er5j+15sDH4+Z6Xjx6HkxlY/djI/
         q1mZQ+dr2kpPXjbi98hsUVeLrfkditmvs/b0wUU5w8JFc1K2/ZqVCzc7glaczq8ARUpp
         BXMbbSxSth7sdjxbbwZXgvZxDhhVczEmQ0J4bOm95Z4Ed4V0M6lgzWjJ2mA5sbIO4DWO
         FJMw==
X-Gm-Message-State: AOAM533/5u44WKaCU9Q05nYeirjZXAujk5Y0LVH0EOXve3VoYW8p3S0t
        j6gjegQGSo9oHiHHVNti+CBprg==
X-Google-Smtp-Source: ABdhPJwu1w8Ez8V1SSEP1iN9iT0vYNZi4Mw24O1Bs5AWrkAvlJWFDrzy8Pzs0mcDOxQoHdV1ODa9ww==
X-Received: by 2002:a2e:bb93:: with SMTP id y19mr16468601lje.79.1630252080977;
        Sun, 29 Aug 2021 08:48:00 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y5sm1481243ljd.38.2021.08.29.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:48:00 -0700 (PDT)
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
Subject: [PATCH v7 2/8] dt-bindings: clock: qcom,videocc: add mmcx power domain
Date:   Sun, 29 Aug 2021 18:47:51 +0300
Message-Id: <20210829154757.784699-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
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
 .../devicetree/bindings/clock/qcom,videocc.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 567202942b88..5d7053503435 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -47,6 +47,16 @@ properties:
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
@@ -61,6 +71,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@ab00000 {
       compatible = "qcom,sdm845-videocc";
       reg = <0x0ab00000 0x10000>;
@@ -69,5 +80,7 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8250_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
     };
 ...
-- 
2.33.0

