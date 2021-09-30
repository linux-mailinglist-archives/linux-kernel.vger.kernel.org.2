Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BEC41E0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbhI3SVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbhI3SVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:21:08 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE8C06176F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso8426085otb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+i3Hpuj5DWyGD+byaVbyqbrajvj21zbxepyMvzvhl+o=;
        b=Mbb30YK1RDVjc5EhL0k7FsEfYAyU9MMKl40UwymGuRCKl8Ofgos0ZS1iG15WrKpXLi
         G2XweJZxOWUr9h19Ir1iIRk3MtzNrMpBtsYu3iCt618A784qWNdFGU6N+lruxSE36oji
         CQjH9biwDwMicKW7ZZLas5BllttEJ3U3tybqnBTICr3znG9x9z62m7gUXqYfnovotkL2
         HMkvaYN7XZKB2dcIkxsvx9rz7q2nQtSWiVebt00E5Nvyzzm7m3VRJaZMWYLWb9F+n1MO
         LO+laMNZjJDOnJ1vnEq+R3tpAmXAPSGg4SOr1usB2+KLaMB4pAJj52AweM1uARq/I5pY
         DpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+i3Hpuj5DWyGD+byaVbyqbrajvj21zbxepyMvzvhl+o=;
        b=0h3NFB7H7gNn9/gpUPCtT/ydgI+I8ewillX/V21o1Fohdp9EE6rzl5bEsmJcJGcEzF
         DyfAggk8BJMklMgMPj6a1Gf0NQ6bM5MSjbmVyqUJA80mUpHNPOPhbbhFRJ7EYUyHDckP
         cttSLPRTWiUaBW7TPeA4yVMZfs6MjEJnCYC4ihG+UBDQybFmvoJlLkqTasnyYHc11Z5e
         K92xLAhOjQ9B0zSA6/tQo0y5SSgydU7mvhiCy2c3zVmD3DFzSKSG/+rBAbOF+bXVy9tj
         CCLimzkUJspsH86tJnpsKc6d1Bw+gBI0cGV0MChWrref9sV1TC4LG750Igw2b5G6Do5w
         RMbg==
X-Gm-Message-State: AOAM532cuLb0YiuYahxk48VL/WLK053c0wehFVS4z3dVnceiH6LjvkNM
        CFi0xMJ8VMPbbB55u8yKxLQJvg==
X-Google-Smtp-Source: ABdhPJyj6JIbGONbv+B4qS/JI1a9zg/1qkSmDFplVqbsyTD9Q/8A//mOcE1jHm1IEkvTmKkbYl7bag==
X-Received: by 2002:a05:6830:4411:: with SMTP id q17mr6248039otv.67.1633025964474;
        Thu, 30 Sep 2021 11:19:24 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k6sm727416otf.80.2021.09.30.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:19:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: [PATCH v2 1/4] dt-bindings: sram: Document qcom,rpm-msg-ram
Date:   Thu, 30 Sep 2021 11:21:08 -0700
Message-Id: <20210930182111.57353-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210930182111.57353-1-bjorn.andersson@linaro.org>
References: <20210930182111.57353-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SMEM binding always depended on a reference to a SRAM node
of compatible "qcom,rpm-msg-ram", document this as part of the SRAM
binding.

The SRAM is consumed as a whole and not split up using subnodes, so
properties related to this are not required.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch, to resolve issue with the existing qcom,smem example

 Documentation/devicetree/bindings/sram/sram.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 3eda5049d183..e3311b54db33 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -31,6 +31,7 @@ properties:
         - amlogic,meson-gxbb-sram
         - arm,juno-sram-ns
         - atmel,sama5d2-securam
+        - qcom,rpm-msg-ram
         - rockchip,rk3288-pmu-sram
 
   reg:
@@ -135,7 +136,9 @@ if:
   properties:
     compatible:
       contains:
-        const: rockchip,rk3288-pmu-sram
+        enum:
+          - qcom,rpm-msg-ram
+          - rockchip,rk3288-pmu-sram
 
 else:
   required:
-- 
2.29.2

