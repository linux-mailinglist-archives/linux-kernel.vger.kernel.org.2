Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C83358AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhDHRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhDHRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E1C0613DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g35so1835442pgg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJ9Bq7I+RO+flvh+OXa43h5cJJd1W9cz3i6BtHkT8v8=;
        b=qaRYFdcKrWAzX3q4lvtZVJ+IgRd+uBPwpKSMBNKzf18zO0jBRjYCldiBDO/WVhTCHJ
         v7P6TIEKYaM29lWx3EAOj6r/Z7cAwrFRAWLMEKvQf7LGCKCesA2vFlV5kzktLAzh3xjL
         EoMJvQOrrxhkQi3egGVLZAXywmNqyAIVUyEMgyfW9mUl8QLn6cxbpZb3rVVGk0Ch1d4i
         COV7s+oddjArIud5XENOXPj9CRDfoWAb0AvGNkWAtDwUsh5UlDhHhwhUyhgNDRUPyRw4
         AXNlX2RuDer+ezvh4zdjmgiagnniMVHyB9JaS5gb1nY9+5LXwuDzHJV2EEVawg4zd7Ik
         KpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJ9Bq7I+RO+flvh+OXa43h5cJJd1W9cz3i6BtHkT8v8=;
        b=gXVkjQstbiN8KSUWl0pQpDzVkF9IME4eLRT74nf0WZwDYpaD1+65TyIB16PWrznGY8
         JpP4t0/fMnmXatzyhT+yHAdkh60FyjOb5jGZ39owbk0mENX6VfkwaYV0onYn2gUGYhIc
         Y4fofH5YQSIEgQxKoncBB9scpm23Vf0ZRtgJ1N+2OZhO0c3dhjzd5qgwSq6tCCGRbWLF
         B6oS1cO4kMSofm0sajD8QnpwgaxyQHVQz3bn45Knsd2t8ALCXmXkeG8R7ymhz8//nb7X
         T6AWdarXos50DZvw+Yf5Mdt6pRthWTq/8ZlF73OeGGd4HV3X2ibQ5hUfVswKlcO7Su5Z
         qZhQ==
X-Gm-Message-State: AOAM532J598mr8Cq8JRjo/FPtfk0gCIaL4PMfD0EgIB90Z2jtRpJb/Ng
        geIj8HQKDGKYqZK2jIrrLJgD
X-Google-Smtp-Source: ABdhPJysVD7x2DCqOYhbJapjnZ1FZ9X3jK21motxouKyh2gtfIaTl31l89Ly8Qqw99fGaYzDPCsBpQ==
X-Received: by 2002:a05:6a00:1ad4:b029:216:aa9d:dcea with SMTP id f20-20020a056a001ad4b0290216aa9ddceamr8172874pfv.47.1617901534581;
        Thu, 08 Apr 2021 10:05:34 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 10/15] dt-bindings: arm: qcom: Add binding for Telit FN980 TLB board
Date:   Thu,  8 Apr 2021 22:34:52 +0530
Message-Id: <20210408170457.91409-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Telit FN980 TLB board based on SDX55.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 174134f920e1..d5d561d9e8aa 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -172,6 +172,7 @@ properties:
       - items:
           - enum:
               - qcom,sdx55-mtp
+              - qcom,sdx55-telit-fn980-tlb
           - const: qcom,sdx55
 
       - items:
-- 
2.25.1

