Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF43458E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhCWHjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCWHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:39:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:39:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so4512504pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=RRJTK1pfzaPiIg4O8eJnUtlpB1U56FQHHW/kPwgw4nhIsr/nTjDgEKrq0Y+zkB6FPV
         9L/si0PvnDb+3HoE8ohZIpt2XKP7eDyLcXz59tYjIi0RxvalmgmQEdHld3MA60g84PBg
         wgcdptFJikTVRsBW9SRBJQtd7QWT7ifheLwIw4kcFBIxpSV1wRDhqrH0eNPqCEGqLwid
         UI9XQ13eMHx1SJGprtlapmZtwJsEwyOHIINPFOkjX01D9oUH6Gos2e8VXHNaEJT4ALgL
         LbB5iscnnJGiVepzQkNny2ZYu0Df9+eF3VLUchoGtkYXhWvW0nQuBByhnZGR6YP+us9J
         d1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=pxjRHX12gudbfKxSY+/GrFbj8q7vils7eXXNPZF0c8jVi9GFrBy3nL0MxZkZlauQRf
         84CrOJ/h5FpS+Hy69/SqhrwlkBRpEee9yG9NqJyUVFsN8MTTmGWUtz3+Iq0V01PNPxLw
         K2TajEQqsAYJ9lA8VjN6c5VwPx1EJQFDcl0vT+qrWRB0QmPxOd0W+F5QcqWM5xhNU3R4
         ruLStmwyAU9cge7jV2PriWEcWg5XWEC3GbtMNcfoLvi1lBMJjqYfKBcc5q/xK0zSuGSq
         JBw7MNTE2wdhm4yHJV6c6vg07OYHjvfFxVQz8hkEtroXklpABTFi3a6la6CYEGSuAIOG
         CETw==
X-Gm-Message-State: AOAM530o1qPa/HHHG9nzOkPP9RaGV2I+0fVWE6/cBGjTurtYijNySBTx
        Riwl8tZBj8NdbztlZuRvAsYB
X-Google-Smtp-Source: ABdhPJy77U6rmZovSr8RvL2cMkDeU4jN/R3BFUQnsuCbAaCp1zxa3/iJxUE7FdougLiN+KzpyMoDjQ==
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr3204024pjy.164.1616485189313;
        Tue, 23 Mar 2021 00:39:49 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.149])
        by smtp.gmail.com with ESMTPSA id fs9sm1587465pjb.40.2021.03.23.00.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:39:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 2/3] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Tue, 23 Mar 2021 13:09:29 +0530
Message-Id: <20210323073930.89754-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323073930.89754-1-manivannan.sadhasivam@linaro.org>
References: <20210323073930.89754-1-manivannan.sadhasivam@linaro.org>
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
index d0e422f4b3e0..678b39952502 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -143,6 +143,13 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
+      secure-regions:
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        description:
+          Regions in the NAND chip which are protected using a secure element
+          like Trustzone. This property contains the start address and size of
+          the secure regions present.
+
     required:
       - reg
 
-- 
2.25.1

