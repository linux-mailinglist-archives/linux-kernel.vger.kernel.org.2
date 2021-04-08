Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F9358AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhDHRFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhDHRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13DC061763
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so3572177pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KN4LU6k0DDNtB1tTf++h2CYThhSstL5XVO+zCntug+s=;
        b=s8bMWKPRweagGjIdIt4CPbxE7dEHVwxb2IkFrTXDK1uw/gKkyB3t2grQ8rpauRBNVY
         rQ7Y3FFr7HZ52e/lVDfzfMzP5zBmu+BVsG/+D1MpwfthofMYo88twkfK7J3xxs4UcZ3B
         4Vj6H7ujzrN/J6qRPdyuG0SbBxnO+GJMyRB8KuWPp9I5mShfI7AxVRRpdot1KOVC8O91
         KSHw7Wo+tZbmoR63/kvYba13T2XyHyritv48oKa3S0sr6zFUyOnpPGxEfyBIsOi9HRsu
         frEzU9GYTjmz1pjf1NX2zxWGxTFTOewj052IcE9TUhxXfPWUHa1/uFYbndbR1XAWILVa
         MLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KN4LU6k0DDNtB1tTf++h2CYThhSstL5XVO+zCntug+s=;
        b=UXGRxbWIK/R0Gzh/pyR+0nPsoe5K9SPHVzSjV39LKzW5W5+gN91Guieh0CIjNt+ZLY
         jrKXpf1rqiXgtmzkJPZFkQU8hIbb40FHbcUqeIgGulyuBH9oEL0a3a4YpEU61i7+MUnR
         Pm1iQ2XoIMO07MngOfVxRLk7UYzZKhkCt5gQELukk+XZnMhXp/q+SUp1D+McjX0l4wJ9
         ziN3GZEKmZAkgBBrrR3dOf8MALvZSoTIeNWnCN2ibV0pfd4Od78muakAQnB1otQMtVTu
         fcopGVgQwdteOi0yxUTqLxq9NzLcbNLktJRHvzodYLQ4m8HRM8TyK6LAf4kEdIUruNDx
         sYSQ==
X-Gm-Message-State: AOAM5331nArsm4Kg/ENCCSr4DBoEpCLg6llPrWsyl4gBgjdsA/CNmXKa
        aIn2wlslQufZlO1rSIAla5I3
X-Google-Smtp-Source: ABdhPJxrgISlc62IX4IrrCXEuOeSApRtkwb7Vy+9D9YjAnW51sMkUa217juGyd07cataj8BahgKN2A==
X-Received: by 2002:a17:902:9a98:b029:e6:faf5:8196 with SMTP id w24-20020a1709029a98b02900e6faf58196mr8612088plp.23.1617901524203;
        Thu, 08 Apr 2021 10:05:24 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 06/15] dt-bindings: firmware: scm: Add compatible for SDX55
Date:   Thu,  8 Apr 2021 22:34:48 +0530
Message-Id: <20210408170457.91409-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree compatible for SCM present in SDX55 platform.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index a884955f861e..10281ae6e1b6 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -21,6 +21,7 @@ Required properties:
  * "qcom,scm-msm8998"
  * "qcom,scm-sc7180"
  * "qcom,scm-sdm845"
+ * "qcom,scm-sdx55"
  * "qcom,scm-sm8150"
  * "qcom,scm-sm8250"
  * "qcom,scm-sm8350"
-- 
2.25.1

