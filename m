Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5353215B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBVMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:04:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D0C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:03:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d11so2648018plo.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOqS3cmQFNPFE5oe5VQB+Nk7w3LubjtRbocEu7F5iiI=;
        b=vFxVbXKUqZ/PhEhh0tcVrVjqFnWAQDNVgcn43MpfUe4vuLQ1G8UaFfLvQIHe5/qGQw
         MQz/G0mcLEqEa33/kZXqP2CyYxjWxPjqwHOhf3fQrN/OvnTT83e1tdLUPXZbLjvKN1nt
         vNHbKLAnUXCdqyMeg72hnk/pS5kpbs949/bNJbXzDcB9U8P67S45nFj0r3dip4n5q8J4
         ExibsB4a1fiXD0F5IecD2lHsQFre4zikn3FD592AottfLygfpk5frggIz8yMgfK2TKYE
         5/t1caj+HICVv17ZEJlMYg03wpmWYNyd4oL8mR0CBr54PWV8GnvPlEp+cy0MCR5bZl72
         AQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOqS3cmQFNPFE5oe5VQB+Nk7w3LubjtRbocEu7F5iiI=;
        b=FCOHPiYQxfDWHiHF5KPvOfXvYDEbJ0DZltdLjRrf6YHj8CPWseUquoAdfyzCNMF4uG
         KJGa3ewDPMJy7I95tdE4vhyXkvD4DzfpMz3L36cWerHGO2RN7fOgAxHHZ9wvG2voiAYa
         cOh10o7L/vY4DQPbmGBUtuYmgIRVTbDI6e2HsKKt158I1yjG2EI2U2OCwPpX5EbOX/7Y
         AU0Dk0zqvkySUrmq29h9LANR2BLQIvYtmUoRKb8OQHc0geSBoTR+Wwrguvh3i0zClcBy
         oeKs93cwumXTzhF5IyLQWKMJYo+zsTs/jwt2m2I3ow8EXEilugtydTmfH+1UTYFt56hX
         Y6Cw==
X-Gm-Message-State: AOAM530qIZWvGAySbiLgQAXRGhjI4GiFC7v7jgFYVEjd/ecHDxZDriLE
        A6IpDjveICWRnO2Wk2bH/0Vr
X-Google-Smtp-Source: ABdhPJwDxNavOfUSgL+tVcok+qfNwASekjEXEmDMFINM10uJIvTfV9yZKboK8YK7erN+uRsIa3jkVw==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr23313246pjc.224.1613995401804;
        Mon, 22 Feb 2021 04:03:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6215:cc7b:cb8f:abf4:d1c9:3864])
        by smtp.gmail.com with ESMTPSA id g17sm17017221pfh.14.2021.02.22.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:03:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] dt-bindings: mtd: Add a property to declare secure regions in Qcom NANDc
Date:   Mon, 22 Feb 2021 17:32:58 +0530
Message-Id: <20210222120259.94465-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222120259.94465-1-manivannan.sadhasivam@linaro.org>
References: <20210222120259.94465-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a typical end product, a vendor may choose to secure some regions in
the NAND memory which are supposed to stay intact between FW upgrades.
The access to those regions will be blocked by a secure element like
Trustzone. So the normal world software like Linux kernel should not
touch these regions (including reading).

So let's add a property for declaring such secure regions so that the
driver can skip touching them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
index 84ad7ff30121..7500e20da9c1 100644
--- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
@@ -48,6 +48,13 @@ patternProperties:
         enum:
           - 512
 
+      qcom,secure-regions:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          Regions in the NAND memory which are protected using a secure element
+          like Trustzone. This property contains the start address and size of
+          the secure regions present (optional).
+
 allOf:
   - $ref: "nand-controller.yaml#"
 
-- 
2.25.1

