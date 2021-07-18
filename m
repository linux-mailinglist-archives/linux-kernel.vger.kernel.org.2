Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D73CC889
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhGRKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhGRKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3024CC0613DC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y42so24293316lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D63/+TxRKfSO58fkCSffqgWBORWJvZPVM0amiHKwxec=;
        b=t+HDcrLUacRbP8DNOo5e+GGGeA4NvCD16BJ6c9ka/ZJCd3Nrv0m/OPSnhoca/L5Igj
         NWWteA5rbOi21sMd5M2yzB7oPIJPe1s+LlUlQTO9nibj69OR/n//T/n52ChJmo8kA1Lw
         Jj7WfAhY2T/S9uCN0pnCx6Y1EpU9+90hCQgo+Rqqkuz6RZ0PZiXgoprRAJ75NE5dGKWn
         5Hin+Sxz3IVE5JWELvfTEFkpkjYPU6Y4+cZPS5JW83kuF9XJR/Z3aHM1UY5PBgb9lnWT
         tWhmhCMwLAo/Orn+ldJhB472Aanj37ZIkjs/pg3O+Eman8HYvduy0fN2WdSimiL9JFq+
         XTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D63/+TxRKfSO58fkCSffqgWBORWJvZPVM0amiHKwxec=;
        b=bMgWcCtSlnaohduWAa94QNYBVyQgq6VDLi3WmCjvCiqjTEcq5dSezmXMCYYsHAMMhc
         5p49cU/PA7tMCuk/BkWITp26Qtc/rztLHDRXKsjJqQgcvKrTwMn48JGDP7uPsAWtrL5K
         WLt77yma8UAlwFeKa4gMWllofccXCghCfk8U9pZfN6ZWCWgtnUJqb9S8TqwNxTwpRb/n
         xwkmfxx0yg6njciTCQNZkOHRTtYXmQhxh0jBKp2HOBkOVwfsYXPjZ3T7JAXddKiyExoZ
         5qnVQPnaU08+2/zWytiSEd4Ddl1w+zOO3QLey4jpCKUuuS6gLokUei8CRqYfA9NT8Ivn
         oySg==
X-Gm-Message-State: AOAM530Tbw0eUbQqmKH0nkc4K8vSt6NOaMf6xg9sgRZWLNruS0cqhgG3
        RvPxD+Gzqzm3Gah58iYyvsXQ0w==
X-Google-Smtp-Source: ABdhPJxc2vkNluaAJwBoTzZVkGdqt9L9Rob3X0LlWnRT1n/e0yx/7dEc6/8BDRbSN5dRTl7uFfdk6A==
X-Received: by 2002:ac2:4206:: with SMTP id y6mr14382336lfh.206.1626605348335;
        Sun, 18 Jul 2021 03:49:08 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:08 -0700 (PDT)
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
Subject: [PATCH v5 1/9] dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
Date:   Sun, 18 Jul 2021 13:48:53 +0300
Message-Id: <20210718104901.454843-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
References: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
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
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 6667261dc665..6b3380cf1a10 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -56,6 +56,11 @@ properties:
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
@@ -70,6 +75,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@af00000 {
       compatible = "qcom,sm8250-dispcc";
       reg = <0x0af00000 0x10000>;
@@ -90,5 +96,6 @@ examples:
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8250_MMCX>;
     };
 ...
-- 
2.30.2

