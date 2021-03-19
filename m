Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE68341A73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCSKuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCSKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:49:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00EC061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:49:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso7058752wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CepUcafGtrFUpUZtYhucDpANeVxiqNaK7mNfdLMmOyM=;
        b=zu6kEtsgJp2yJyo5y9yaZyeIslO8DJEBjXDq/dHhC5q2XALqTz8lRFBBt3LEG7rrw8
         LMppSHvuoL/pqe0Lh5m6jyYpdcp0hgeCN8wbk6vwOPIJ7BtXCMyXQxnwkWVYQ3ErJ8p6
         BgcnYPkFdAd9ACa+V6zluQZWhJOaD8+OkXa/99jKbqEnSfdZrNllLntAVlbXGTEJPZKt
         F0KzkWYEZ/d2ohnQnPiOpwP+RPwUPx3FHLDUdBcENq6oOmPwAw59KiiEV0LL4ObJdd+k
         abKk+Bu217H/NOeH/98zyztUzq3JxgJJDR4yjqHGDCDXo8FnpahpqGxZiHfg0SPrW4Mb
         jbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CepUcafGtrFUpUZtYhucDpANeVxiqNaK7mNfdLMmOyM=;
        b=RecFF1LEGRVgeONfK7BiHjwhAghBuom709sI8TNvBhgZfY8hSwW/w4d7iL8u0P8SG7
         VzXUxPgKqnHCc3uDO+C82qY+m2toAaiCaEggK+yREF9Oo+MwIagtZCiMYjUQwryu69Hb
         A3+eQ1jnPk1NQeAkMv4i8hgQkf9RB28u+5ulL6c2bWJ7NUuU8GlNra7fqIehnPTSpDIE
         0f2L5/KwLj1JWR1MNhD7MHXjf1QlKfEdCE5mvdFbo9RLTtFSGa/PexvpkuYnjPyIeM64
         qV/RjMYTbt00oMHRflXcue20MhZpbCArBkI6ooQ8bRlP6yiuLhk/dsFBJHoYLSC+q6Oq
         FAbA==
X-Gm-Message-State: AOAM531WDypNWwTpN55wsW+l8IF68Z/nHrfYvLjQgxWL9lsn9HCO8Fvy
        /uIroyzKJsMAaUyDHvUT8mh/ow==
X-Google-Smtp-Source: ABdhPJyHEH6apFgqPDDVWjovz+O8j/BxFJef1bbaqK1m/dkdKmD6T3k9KdkKIMgqOMAIYTb5OwE+9Q==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr3139217wmi.28.1616150973768;
        Fri, 19 Mar 2021 03:49:33 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id y18sm7416224wrw.39.2021.03.19.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:49:33 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     amitk@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1 1/2] dt-bindings: thermal: qcom-tsens: Add compatible for sm8350
Date:   Fri, 19 Mar 2021 11:48:54 +0100
Message-Id: <20210319104855.85075-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tsens bindings for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..e788378eff8d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.27.0

