Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC23307B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhCHFp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbhCHFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:45:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C843C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 21:45:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id x29so5720873pgk.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 21:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vZpb9y8MutMaka6YLswZQUFtbMSrJ0Y46Hxti/8tHM=;
        b=BJ/nj+3l8mDnLcnBxLlfarOq64qe5GCTAGyv452RcjzDzQpB4tYWS6+XYTFp1wDjLg
         iekeoQ8giTKMDsFCXfSNVD0QgoGyu/K42d7mJXVvz2aZnWHm/gNU14zW/Y3R7m5YsN3h
         fd7WoXMP/NspTSfDlYrON5Hdlbrys7rnjkhYIunH2u2usjqGZ3LVdW0ymxcqrvobyp93
         UvbWKUzzalTAkVeIqkca95kXND+bReJeQoPRoLuOgzOD2pqaupg7xO76WXBfkXBWfOsj
         LEIpVyb42vMZL1lLkvnY0ikFcr64g4HTqfIZseiRA1pZfYXuyiUcX6jbIpEDNbTM5rL6
         NjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vZpb9y8MutMaka6YLswZQUFtbMSrJ0Y46Hxti/8tHM=;
        b=or1XLrJrokFmUfgDkIz0h6+lBScTClPrbYDxKBjdmz1PjGi956sdN796j+nlqD9Bh7
         KAZGAoT+EKEn/7iCPqFzH5chtCAR0yXjZbRMTw3U6+N+DSYfuZHh3vefHyAFIO4LL07p
         kXmU62edaStJrmH4HnwGwL/HMGrZhLLOMj33DHu2EfApkgDK7h/ZLpHfT9IYcR2kV1g0
         96px03P4Ej6yqdPqzQ69gqbrjPjpFtk/SCcIKinvAtU0r2bQnjDl3UsMtWKR6yc9dpoI
         UQMKaQzpH4U5gPLYc59q3Egni6nJlphyXgeoa59J5gi7O5h3RZb5KgTqfV1tElaZ26dC
         X89Q==
X-Gm-Message-State: AOAM530aiSpiyD3KmL1Dpsrf7RL3JJgjNN8oj7rvv7lXSnrZYDER2rK2
        LCWOU8NbEQ9caaaSUKGmldng
X-Google-Smtp-Source: ABdhPJzu4JCu5Md6ryj1ZYan4yE9jY/7uorHkfnhX/Zx7RM8Yyi0ijeyH/Uqm+yzonvi8XTt8PV6Fw==
X-Received: by 2002:a05:6a00:1493:b029:1ef:a5e:ae7 with SMTP id v19-20020a056a001493b02901ef0a5e0ae7mr20047950pfu.61.1615182313824;
        Sun, 07 Mar 2021 21:45:13 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6e84:fef9:1070:d306:6d0e:bf6b])
        by smtp.gmail.com with ESMTPSA id y29sm4331506pfp.206.2021.03.07.21.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 21:45:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Mon,  8 Mar 2021 11:14:46 +0530
Message-Id: <20210308054447.28418-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308054447.28418-1-manivannan.sadhasivam@linaro.org>
References: <20210308054447.28418-1-manivannan.sadhasivam@linaro.org>
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
drivers can skip touching them.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index d0e422f4b3e0..15a674bedca3 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -143,6 +143,13 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
+      secure-regions:
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        description:
+          Regions in the NAND chip which are protected using a secure element
+          like Trustzone. This property contains the start address and size of
+          the secure regions present.
+
     required:
       - reg
 
-- 
2.25.1

