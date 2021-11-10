Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E377444BF91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhKJLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhKJLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F50C061230
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so99984pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpst4LNqpOQv3g4mfS4aBAHT3dcK/uR+u5lZdpUeqpY=;
        b=Q+hXJwnN9C+thQknUIy7UewotrRXlH6mjjYFSdXv6ykK+3QaDbtrsSKhlUgOT2lvkc
         zDXHI76eBRW7Gozjchfe4wYB1NA/SrmZojBwM0mr3QGItO4Z+0dK8/haW2eeYXRyV0t7
         AJunsWo+9cDw5JlGf3QQ19kN4EwIed/RBwyz+E/5KlijF3X6MDZ+92T/MzANl0mmG3uw
         lPbKdHQTLDF8l62ZAM8oM5IFkqVlPb8bPGclYWPITYKqS0ejqaXYacz2tHTErH4uyF3Y
         ox2/QCpRUPtbrHGhnQ1spGfL0Qh16tL9qx9fnCiQqsTeYWXYOUEL1q1uoIpGy7qOSOlk
         08og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpst4LNqpOQv3g4mfS4aBAHT3dcK/uR+u5lZdpUeqpY=;
        b=dO0zLyqxJzjjpO9MztgPGu0TlLIyKRbyWBqBc779obcKajTkpzh5xUHczxHrFAZAlv
         eTVk+nGu1tmei9KEQ7sDJSH/Rv+jdpABlb+Z4fQLnyAxcryBzGcoTRPXZcLFqXn23ACj
         IF6MJlopHDSaHNTukeULLzp3Vam+BTL69RA/dExPRMNzPhlc0uGc/CllPrfZDy+ab9bz
         SXJ/Htb3L9ekn4FsVglRecvB/gaSF/GIzLn7tvkW4D+qh4qX8tB6snk1yj7nCLVxXmWs
         cgGCPQm9ao6tuvuJhHsw1X2/d8ZNvtc8wZQ9tRLNkrceBzL4/um9B9F/7Nwe+DD4MawU
         2pxw==
X-Gm-Message-State: AOAM531CtKx6nSF+gGk2VNdrACijU5O/27q8+fOZyrXAL544c4A5F0pF
        +B6vAJ5S+H5IVZiN2UiDBsPPFg==
X-Google-Smtp-Source: ABdhPJxIalNrxJYWD+oPN0ufYN8oyRBeLMKqAWl14iEJmuvXtt2j/L9VDcfw4CY1utoWLh2EnQePog==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr15816864pjb.243.1636542037675;
        Wed, 10 Nov 2021 03:00:37 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:00:37 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 11/22] dt-bindings: crypto : Add new compatible strings for qcom-qce
Date:   Wed, 10 Nov 2021 16:29:11 +0530
Message-Id: <20211110105922.217895-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer qcom chips support newer versions of the qce crypto IP, so add
soc specific compatible strings for qcom-qce instead of using crypto
IP version specific ones.

Keep the old strings for backward-compatibility, but mark them as
deprecated.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index efe349e66ae7..77b9f544f32f 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -15,7 +15,13 @@ description: |
 
 properties:
   compatible:
-    const: qcom,crypto-v5.1
+    enum:
+      - qcom,crypto-v5.1 # Deprecated. Kept only for backward compatibility
+      - qcom,ipq6018-qce
+      - qcom,sdm845-qce
+      - qcom,sm8150-qce
+      - qcom,sm8250-qce
+      - qcom,sm8350-qce
 
   reg:
     maxItems: 1
@@ -68,7 +74,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-apq8084.h>
     crypto-engine@fd45a000 {
-        compatible = "qcom,crypto-v5.1";
+        compatible = "qcom,ipq6018-qce";
         reg = <0xfd45a000 0x6000>;
         clocks = <&gcc GCC_CE2_AHB_CLK>,
                  <&gcc GCC_CE2_AXI_CLK>,
-- 
2.31.1

