Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2073B41A540
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhI1CWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhI1CWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:22:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691AC061765
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k24so19617809pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NYqezzVsApLcG6o8A6nHf5azw/hdK7Hyfm4V2m2anYE=;
        b=ktEgcMjNRerbDRlQjW54gIRGhF9RrTp5S+D9vZR7qXJhk/vYJwKDeewlR70iO4VsmR
         HShmITge9HqC/yfj4wq6+pqlvXlFf+fM6Znpd68LvZ3M77397J2/5xM9LdJL/C5y7Xt6
         an0j2Ge9ID6jmgvOsLXLCkBZRffpNPYdu8D5GcS0lK7fIgULZqB4EfgUo2v0OQdqFXzR
         hIuUq7G9mHjL/p7gUW8SQPz8G1CGymjtuA94xt5YfkJFK40FijiL6VoB7DNmBYaVPyfw
         nd+C9r19WRK+LUHGf09jyMsJtKxnci9oQt+1+dK9+VABpLgSAexdXIvyjkJo7B1MZONk
         s61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NYqezzVsApLcG6o8A6nHf5azw/hdK7Hyfm4V2m2anYE=;
        b=EmmwI+mewBa+tNSnmvKzDvpOFnKtI7qdEWYhyLtLt2wQOOHj/J5UFEHKyRvh1PYl3Q
         OFISQJMKEG+r3NC68I439q7UeLjLiDgIlC16oaOaDOdy0XIhSYbUwqBhzCEvDwXVOp+Z
         dRaJNHjibDon8bO7qPZowH/75FnW1ztfXhe2bJDxtgBksJFeTGqPj6HN2rI0EJZXmcQB
         i3/VnkPP967vZG95jqW9EohGGGXMchHdX+fyg8CFA5VwNwqbOkbGDqEGMzlud3JAC/qo
         b6pO7vq+IvRT+rl8aJW+Llhw99yrLKdSvwJX8v5zy/469CQRnv42Abclv0fa0e21a1bN
         OtHg==
X-Gm-Message-State: AOAM532ffAPCj9NMmL7yUhH3s817PVVe8v5bLUoklV4Hu2yuGIIwcZgx
        1l2h2we4rLKcVLTO6ocnfZxf8w==
X-Google-Smtp-Source: ABdhPJxtkhkcETWROWusxFox1a51j3uHtyRo8hzT6t77fL1kJ0MDx4Rzp4PMmrb6aL2EFka98H0kUg==
X-Received: by 2002:a63:6e03:: with SMTP id j3mr2371457pgc.465.1632795623623;
        Mon, 27 Sep 2021 19:20:23 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u12sm19178729pgi.21.2021.09.27.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:20:23 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: phy: qcom,qusb2: Add missing vdd-supply
Date:   Tue, 28 Sep 2021 10:20:00 +0800
Message-Id: <20210928022002.26286-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928022002.26286-1-shawn.guo@linaro.org>
References: <20210928022002.26286-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides vdda-pll and vdda-phy-dpdm, vdd-supply is a required supply for
PHY digital circuit operation.  Add it for correctness and completeness.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index ec9ccaaba098..e49fa4ce18c8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -50,6 +50,10 @@ properties:
       - const: ref
       - const: iface
 
+  vdd-supply:
+    description:
+      Phandle to 0.9V regulator supply to PHY digital circuit.
+
   vdda-pll-supply:
     description:
       Phandle to 1.8V regulator supply to PHY refclk pll block.
@@ -156,6 +160,7 @@ required:
   - "#phy-cells"
   - clocks
   - clock-names
+  - vdd-supply
   - vdda-pll-supply
   - vdda-phy-dpdm-supply
   - resets
@@ -174,6 +179,7 @@ examples:
                  <&gcc GCC_RX1_USB2_CLKREF_CLK>;
         clock-names = "cfg_ahb", "ref";
 
+        vdd-supply = <&pm8994_l28>;
         vdda-pll-supply = <&pm8994_l12>;
         vdda-phy-dpdm-supply = <&pm8994_l24>;
 
-- 
2.17.1

