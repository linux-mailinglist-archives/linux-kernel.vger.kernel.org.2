Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974EC3249B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhBYENO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbhBYENB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:13:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764CC06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:11:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so2470025pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hU6WGdCR9365lMcGYUik+Qyi/ZAYDHu+MFoj3y6wt4=;
        b=PLak/fmjN7fnFTz8fRzhp1I+hcyR24BNlkBt5PJNVU8drkHY1J+dcgL9k1ye8PzB4P
         XgniJRQ2nOYiqNNyhmVcWaxrxhf8nKffy5ArsDIKieuXGcs7Pt+28n/MDmCQVcRdtvCX
         U4OcK9AbfHpeTyG/tJio6DBDkX64Me6iyH2IWf6mzidlyUiVSec5eZ4N/iHNnpwbmyVn
         SUD6Xx40S9tRXZQ37zRs+OwPIDxkyYhtAblnvXqDUWdCnJYmzK4y1XwAZ7BZ4ybWaXXF
         8GDQNQEe427tSGC7c8qUTdeKx4+k/mok2MRa2gO3bQNoHfY5HCjz8kvmYF1/giAjeoyr
         V64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hU6WGdCR9365lMcGYUik+Qyi/ZAYDHu+MFoj3y6wt4=;
        b=nbx42CbwwDTQNAvSPi3gk3P/SiILoXCY+ZhTCrN7myIPkjbwB6wFChE7/x0vK6edR5
         Hl9q1wZ/bu9D1h3YRyxefOWf0P2lsQzsQck3Maa6gCw/BcEibeJBvsrk0hqzCY6UVk8n
         dHPBXik5KtpvMZFti3psspD8Sn1EHbhPJF09FtXKdMcvRPzWjkc9Z+mfp2ot5EMMf1IC
         ctGDDZp1qfge7vJ7f2nHPG+UjFF1vGwHIQdX98+4kxDYqKR4xQZZd+URC//mmruULGlf
         /T6lHjA8u337dgsJo9dE7b/eeeVZK24uEgiGTyiRELfpl/9GosjEOrQvOSU9zbw++WGJ
         E0Qw==
X-Gm-Message-State: AOAM53046zsnGE8wyZoCTnscLjdlIsPg50zC+Q2AkZsQc8CFpqraRt5J
        dp/Q3FKKYqEalqXHVXiDEIrn
X-Google-Smtp-Source: ABdhPJzuwcRoiNHqmUzL20tCRghQTkRE9CDlSMQRUYr9GReiIvlfg/rCEryLOScv6WOd2u3ydXxAZg==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr1304343pju.214.1614226310108;
        Wed, 24 Feb 2021 20:11:50 -0800 (PST)
Received: from localhost.localdomain ([103.66.79.45])
        by smtp.gmail.com with ESMTPSA id c12sm4155494pjq.48.2021.02.24.20.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 20:11:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Thu, 25 Feb 2021 09:41:28 +0530
Message-Id: <20210225041129.58576-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225041129.58576-1-manivannan.sadhasivam@linaro.org>
References: <20210225041129.58576-1-manivannan.sadhasivam@linaro.org>
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
index d0e422f4b3e0..4a528468b90f 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -143,6 +143,13 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
+      nand-secure-regions:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          Regions in the NAND chip which are protected using a secure element
+          like Trustzone. This property contains the start address and size of
+          the secure regions present.
+
     required:
       - reg
 
-- 
2.25.1

