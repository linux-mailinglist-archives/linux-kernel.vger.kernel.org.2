Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D319E342067
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCSPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhCSPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:00:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:00:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v8so3083927plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=ohvrJt68oUBNkBpQAKJcjO2bUbdF7woTHDFm5MbJb0YRsHlluRF1P47NUZjK+Mfriy
         vhedOAaoRdsWWXEABh7ctC4jxo2q3MnFOaAkNIJi6F3NtpowIbuKZMSdqOggmXSx0HHI
         XlIL8nsLCd7MDB7nn7FBrEmwrBngUdYX3sTf/OpEoREMSV2Ab+Lqn1OxuzoNeGp3RxWx
         9sovfJ6xzlKoWFvFITeYW9RlMIxWvH8SE40OOpNmicQ5z5WnPljHnGDNyumQjcMhK2Va
         BqDk37lGlQsvlCEd0ZHcg/opa5w1PXo+q0jaxyd0FTxg4/ah4wi8OCBsm2N5obrZrOE8
         uohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGzmTTjWe1AbEuSBzNDXhCdxGNlI9I7Ym5rhNfsOEPE=;
        b=rDU1zkNxinvA10hklskgReZVPveGRbXidOVyq17eFVfa1BxJEh0W+zVVOER/KQ+nnh
         dDzCtD1bQdEJbRx689X37A2kZ4Mmut5VnuFe1LJprZD7TRwNP2ZWZziqvPOSbogy7IXu
         +bptbVw7Pbl8bD204Z6HScLyWxj8VWhAdCZz9Sfg5cmKboIIuu4BkybYlyyL7K1354jR
         NevOedy06wIe6J8E2eAw5INuPimgByca5ry1G7bu6+x/5m1mVmQJHKa8qxTWGIokB3E7
         XF8eJN5a8XYyg4A4jUD4PSgizvViaLPAvn/cQ/yheXFih23yWxrlbteIFj3n8OPkhy/4
         B/fA==
X-Gm-Message-State: AOAM533sj1iOxH+yk6uu4PCXvf0tZWS82F0gZ8mKSnWdJdls3HttOzMr
        9H5pExCkaQDqDU52Z1fqripE
X-Google-Smtp-Source: ABdhPJxbYUC3aJcdyDm/DVWvSwOUU/+CzGqsycRz3kMEYgrnzWUZb1jzISsn8q4kMb4ExdZ6nDsphQ==
X-Received: by 2002:a17:902:f1c2:b029:e4:6c23:489f with SMTP id e2-20020a170902f1c2b02900e46c23489fmr15169667plc.62.1616166036933;
        Fri, 19 Mar 2021 08:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:387:dba9:92f4:36c7:1aec:59de])
        by smtp.gmail.com with ESMTPSA id h19sm6092345pfc.172.2021.03.19.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:00:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 2/3] dt-bindings: mtd: Add a property to declare secure regions in NAND chips
Date:   Fri, 19 Mar 2021 20:30:09 +0530
Message-Id: <20210319150010.32122-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319150010.32122-1-manivannan.sadhasivam@linaro.org>
References: <20210319150010.32122-1-manivannan.sadhasivam@linaro.org>
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

