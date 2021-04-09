Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1235A805
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhDIUky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:40:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53949C0613D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:40:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d2so5764916ilm.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqErB1BGtSYLSRcvCx/61ODE5QLSgu/K7kbGZ07zxxc=;
        b=CRP2+XeE0cWPtKGLK3vM3qpEMrFVKcT+k05Mf0QBcCsNPy7LTFx7Mg82oqg6PRNP6+
         x6X+IDRmR8IL/2tQ9LQNkKT5HUYb76npzAr41tmCCN+3llZc6+lG9SiIVqh5Xsgi1aaC
         oygNusjXjaa5DSMOu1coNLxXicgNcz2Oe2jeqS34X2SwTKso+RWG8ONQ6b2GoArBz8w5
         d7GjvBOiFfTu2aKLtSF5SEXXbGIAdrhuxRNQzrNFC3u5RBn3UiHnHUo3hrDOw4tux92l
         jBT08vMEGB2UMoPiqafFt8kgzdOeUrVJu5++RtQ6Km9eJEOWa8xP7WBhqqwlDHoZl7NM
         A/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqErB1BGtSYLSRcvCx/61ODE5QLSgu/K7kbGZ07zxxc=;
        b=icnwSTFv3snMoU3gjNqaVVGFI/nCgXr0oE7Bf8Sp4G7DekXna/wNLY/DJaOR32L9lg
         rG6whE1rEONo3y9+S64XuWhSCnt3PxQomqrwsRhCSXO04cpQj+yVbGrRrMKlwWMYa3i+
         8ioxdl7nEwGP704jcH+fSRAIGoMBQ2bW+InXZPSXRlFxlTMC/mqesjN3vtcJI5s9020i
         Tvpw7y6zKoTkMwuV5GjlRnASitmg2vFeUsX2bbWdvNY+GHoyVR/TyVwyvlrI5fGOm0jA
         8FqtfwI8hyPjr3SZ7gm/OLpacFynTU+K+6Wi4lmx0DRDn7tUoNhe3yXfydcrrYhjCJTb
         I3SQ==
X-Gm-Message-State: AOAM531ZetDgJ2KQGvpC7ejhSQCMHMwlu6bMvdpx+dGlZNIXng2NNj3T
        hZrPBzQhjHgm+nQVzEK1WUGp1Q==
X-Google-Smtp-Source: ABdhPJyhqyM6lypSVScVyrDKkEEtsmxSsYZMSCcVOR90TXUyUWmH2NHHQcvTxRZJBtK+df2aMa2LWw==
X-Received: by 2002:a92:c26e:: with SMTP id h14mr12449414ild.33.1618000828764;
        Fri, 09 Apr 2021 13:40:28 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id b9sm1667212ilc.28.2021.04.09.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 13:40:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] dt-bindings: net: qcom,ipa: add some compatible strings
Date:   Fri,  9 Apr 2021 15:40:21 -0500
Message-Id: <20210409204024.1255938-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409204024.1255938-1-elder@linaro.org>
References: <20210409204024.1255938-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add existing supported platform "qcom,sc7180-ipa" to the set of IPA
compatible strings.  Also add newly-supported "qcom,sdx55-ipa",
"qcom,sc7280-ipa".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 8f86084bf12e9..2645a02cf19bf 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -43,7 +43,11 @@ description:
 
 properties:
   compatible:
-    const: "qcom,sdm845-ipa"
+    oneOf:
+      - const: "qcom,sc7180-ipa"
+      - const: "qcom,sc7280-ipa"
+      - const: "qcom,sdm845-ipa"
+      - const: "qcom,sdx55-ipa"
 
   reg:
     items:
-- 
2.27.0

