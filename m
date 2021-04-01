Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098013519D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhDAR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhDARmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EADC00F7FD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:15:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a12so1692784pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=p8Vu5ZvLUSLepbw2MVmx2WeN8I+Zxz5MU2S6/VR8IzPIHsXrQtI4YtTw5Ithnwu2Sr
         34QwLJU5Ujb/2ElBq3VO13OHtVIsZ3iqJjNeChtJXsKzXUVTN9oQOiS+Rh3NyEY0sH7m
         oHsIQgF1noCVG0hBMXQThunqlM5C9iF7Vgpm/axnPEW7lGzW772zMv98DTkS3tyHiICN
         bmQkdGmL7Ff2mnAz2meAtZtrrhKnPLFJjiaBx4sWn386lnanoXLuKjGFC/aUSblE1gnx
         7y83EYuPkbobFshrGX6+nic5asRx3GLqrWnOE+F3ZH+huVDcOHvHb4FDGRY7U2iVkNtT
         ugiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=BzukLDd7rsIMCwDMv6cL1JKGUz9h88/hUKKEZKcJ63CYbuNzd+eCrLLVzpBuyg4bo2
         rUIrku+e7A9rDOGzIAdOVlc6noWqgfbpVyvQLnNkuYVouOA2i4s8DNZU9Lx+uNEdH9MR
         JTNct9/cDHwT5sfdZgCr3bbdajJNKFv36+jr6tUgaJ4YWtdh7Xz3EP77TjilcN610pSH
         8ofVvtImWYMQjDhzuHP0UeQgzmNIoX8d8s3WQc48AvYseSuX1U/8YS1ECEZXeJ4Ys62E
         kVicplEsAknB1jhMdjkojCXzvTj1Bdgv4ma1FJNbglOcoFszz74+/F+w5NLwUYe3y0Vr
         BgGg==
X-Gm-Message-State: AOAM530WnZMp0Wp21x08lCfjM96AmtpjUaXXhrR+5oI63Qxrtl7Epg8X
        +Db8N6jWVcXgslTELYED8jgr
X-Google-Smtp-Source: ABdhPJwRmhl3TIKgIdZ+RmULKMqYyRa10/cmsKN2X28wr+9oyOZImS9dX/firxN51T5kWZBZAaKQcQ==
X-Received: by 2002:aa7:8b0f:0:b029:20d:1b60:e823 with SMTP id f15-20020aa78b0f0000b029020d1b60e823mr8022613pfd.16.1617290130298;
        Thu, 01 Apr 2021 08:15:30 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.138])
        by smtp.gmail.com with ESMTPSA id 35sm5652769pgr.14.2021.04.01.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:15:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 2/4] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Thu,  1 Apr 2021 20:45:06 +0530
Message-Id: <20210401151508.143075-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401151508.143075-1-manivannan.sadhasivam@linaro.org>
References: <20210401151508.143075-1-manivannan.sadhasivam@linaro.org>
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

