Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CC3C1D17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 03:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhGIBdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhGIBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 21:33:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0849C061764
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 18:30:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u25so5350216ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+l6RNZfO6t53h33tKaqwIC7dbp1+6FXvY3b6ZyHCbIM=;
        b=ZZEqGAZCU2TkOIQNC//EmuOwpy7TQr2lniHCokxqka0DIqhGUcpgcnvIpZjmdFc/S7
         RIAnTOeKGfIFk3P3m3AMboRRkBvC+v38PeEn3Ej9VgEO8lq+l0/wdDVHPAEUT9JB4ifB
         JyHmVnGuXsVPv3uQNxpNx7dzfFrmMYanKA8o+IeP6eiok00DHpdaxUcCAE6dLeszJd/x
         xpJcWJJZ++VKTrvzzdVTRZ+ptl7bj9qyBoPCYtWtQ0Lha1fOr/o82hSQBkbpS7WF8Zx+
         mj7jLwz+KAXhCH9tGDaIyK3BJcjSQBflR076b3Glji62H6TUWAtGbu3DVHnDLddH818J
         jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+l6RNZfO6t53h33tKaqwIC7dbp1+6FXvY3b6ZyHCbIM=;
        b=L783HmhJMw5EQ79IU45fuCeIrZkwi4JiaMAAP8Ouq8bwBnCaubkbV1Hs74VV5jIS8w
         MjAQVBFyiDT6iLVgXVBW2MNcRfhf4+W8A3gWHVUTEX27IqgE9dchPgKxL76RyQCTTeMh
         LVtLDzUaSk/hTPSOviJNHYcMyFOeTka2IKJLijx7PPy1gyiSE4e0IP3VmSYzujQ36ge+
         HrWnydojmL+F5gVOwXfrd7P5U9smL8Tfw+MoWlFgX/ot1pb6o6pSueI2eFxrYp6wusiz
         Z3ZgWtUpmea6/smI2S4ZT03cNnnhY19yDlo2b2QS/pXYPOe9YljvZdtvanvr+3cGzR0J
         gvzg==
X-Gm-Message-State: AOAM532F9s4eCC6HylerfKy1sWD9boogyFmQ/S51QUxMC16eez1xUeeU
        ZrYFhYQvoR037Y+e7KDgrbRwRQ==
X-Google-Smtp-Source: ABdhPJzJHBrtrgx0MRckehvohWFIxVb0UbKrJyjrQYAJFyl/NqebfeWi1xRAfMxCLN44HpTyoXi4CA==
X-Received: by 2002:a2e:8244:: with SMTP id j4mr16500025ljh.364.1625794249066;
        Thu, 08 Jul 2021 18:30:49 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16sm405637ljj.113.2021.07.08.18.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 18:30:48 -0700 (PDT)
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
Subject: [PATCH v2 2/7] dt-bindings: clock: qcom,videocc: add mmcx power domain
Date:   Fri,  9 Jul 2021 04:30:38 +0300
Message-Id: <20210709013043.495233-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709013043.495233-1-dmitry.baryshkov@linaro.org>
References: <20210709013043.495233-1-dmitry.baryshkov@linaro.org>
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

