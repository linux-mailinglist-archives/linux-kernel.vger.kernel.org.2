Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC92B3883B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhESAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhESAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:20:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E4C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:19:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 5so5973809qvk.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ya4sSOjySMHGjVVWLWrWfBjZGU/UNkNaSi2rQLK5WkI=;
        b=dgR0jZfPugb1vJ6AMdf0SFLrD7qlnWMdO85o1cRnR++JEcxOi464/LprwILu/TDG1T
         GXfq4n65XTy653sRWBW4Gmm3Eq2RPYoMdVC5VmtnEhr6JQFnvZWRrhoqcfMJDtBLGCvH
         CnF2K+6XwGU+dd7cbE1e5b7JsS1ek7cABHLqn+Qp30zp7C3Cfa/GB2mH78GutSI6zTDF
         qShfcvujoAF2FX3OndvJmtB3GMacy1AZypxOqK0Zhq9LuedC/a0SmvlbSU+HYXCIGCsx
         L9Zw2G1BSmTNkwGxDtd17hOSrFoUA8o5F2p5UezVPI7VuhpQXaRUENPAyMSHz8/RxG7a
         HTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ya4sSOjySMHGjVVWLWrWfBjZGU/UNkNaSi2rQLK5WkI=;
        b=GJVognlbNz/8VK+2HhRRpK5QQ4SAd6CT/gri19FjSQm9GBKrvKDDROc+gcRTDzAKbb
         2nsqHZcHX0UT/arKr4dEcV52O/0Gj/GZYNcfqxHOFK626lahNdj3JQiEsBhrhUWZfULj
         efrVFiT/TXV+P0EDViI3HcA4yPUQ2Y03EtLiiZPOb8oGJTpItKL2D9+C0+iDQwdD9tbF
         sBwObCZooujZaBV9HJVDEkUNPcLzibSxmuEA7gvman5h7ebfVMovJv1POSphFsWWVZI1
         jIR+GHkr4gBtIfYc9r3bTsGpOlsI4pL/uLzD78IRRUuz5TthylwJUgQ+g6xj01ytRBJZ
         OCTw==
X-Gm-Message-State: AOAM531aZlSkM2OI+8xIIGMa1eAkh2pxdCSZ4lukK2e68/Z9LehOMuqy
        xqkcow8JqjmOklbzTvVOeXFWxw==
X-Google-Smtp-Source: ABdhPJwYXbSRGZh4yAsyxeZTUi/2xCvEgR/QeTo+ZBXTGsrF34zvxgnmkdi2Js6f+e2PAkuYw9il+g==
X-Received: by 2002:a0c:eed4:: with SMTP id h20mr9086949qvs.40.1621383558985;
        Tue, 18 May 2021 17:19:18 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id i9sm14998529qtg.18.2021.05.18.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:19:18 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] dt-bindings: clock: add QCOM SM8350 display clock bindings
Date:   Tue, 18 May 2021 20:18:02 -0400
Message-Id: <20210519001802.1863-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210519001802.1863-1-jonathan@marek.ca>
References: <20210519001802.1863-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
bindings. Update the documentation with the new compatible.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 6 ++++--
 include/dt-bindings/clock/qcom,dispcc-sm8350.h              | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 0cdf53f41f84..8f414642445e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -4,24 +4,26 @@
 $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250
+title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250/SM8350
 
 maintainers:
   - Jonathan Marek <jonathan@marek.ca>
 
 description: |
   Qualcomm display clock control module which supports the clocks, resets and
-  power domains on SM8150 and SM8250.
+  power domains on SM8150/SM8250/SM8350.
 
   See also:
     dt-bindings/clock/qcom,dispcc-sm8150.h
     dt-bindings/clock/qcom,dispcc-sm8250.h
+    dt-bindings/clock/qcom,dispcc-sm8350.h
 
 properties:
   compatible:
     enum:
       - qcom,sm8150-dispcc
       - qcom,sm8250-dispcc
+      - qcom,sm8350-dispcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8350.h b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
new file mode 120000
index 000000000000..0312b4544acb
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
@@ -0,0 +1 @@
+qcom,dispcc-sm8250.h
\ No newline at end of file
-- 
2.26.1

