Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC40C430A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhJQQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbhJQQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:12:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC5C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:10:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t4so21002536oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyfqM/OkOGDTylEF0G7QeEmAUFbRxWpurX7Xal1S7XI=;
        b=BniomNIAIl1COE780+8tOO3H5psZSPZRgPEGVC9tx0lgAa4+UiumebMQBGtFDQauar
         Bz2xiROrO9UgYshcN6KP7cl1Koziotsj3jHuLwC10Tjh+RngUlmIsP5Q+2iVERCxGEjA
         ep+wDj8k56AWc6oNDgOIuVjgorme6DOhmxwsWWeU4FLidnU1qEpNleuvmNz1cAmbZDA6
         pusPrqPYEbHwXy1SGrFHmQEWDtpBP+bdaiF90DlTcrvfY8cPh7ihn/UsLnPTaYDJSzTr
         4Oro+Fi5oYOVKPP0o8ggnLtJmn8LkyBWTBHk7m8eMRpbrXmUVtbOKvSmyAuoaJYnWVzu
         TXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyfqM/OkOGDTylEF0G7QeEmAUFbRxWpurX7Xal1S7XI=;
        b=XRJwkicoJKBxLaTmlur5F2vLrcZTQ2y2LlSH6HzFqeOqe61n+LdzrCu9ohsgicpt7V
         1q1dAaux6RDV5/PuM2iSiT2aqMpmULW3cycm1UTLZVe/PMOn1qj8RI4+ZU+KWIoJttVq
         VQiRUqLJRfwgtJVIRI8LEF4u99ZDiwJhLzcLKN97piW1M63siw2f5C3iRXeJ/sjoP/UI
         lsSK0RbTumvQnslt44yNJ+LQUd5yK2/J85SiBSY2hX2gN1uS6CSKfvW90TdceO0tiqU0
         kpBPK2I5P764Hj/5SO2QvWSullBXKFpgcQciNLyiwDIkTsvYw2bbQ42O6Y99c89A+a0H
         ADjA==
X-Gm-Message-State: AOAM5332SIsISDVYBF1g1X6mn/MJ3WyFDxYBRMdKE4p2xA8KsgcLUkEl
        1JpMZIxzGYKy6/eLNm6MMJY1Lw==
X-Google-Smtp-Source: ABdhPJwGEO3qxmQuJKwk0Tkuuk/wqgtQj/kcR1yilUJBAL84QN0sXXyJ4sORAxlWoyolHfyIF5gPZw==
X-Received: by 2002:a05:6808:1250:: with SMTP id o16mr16934453oiv.63.1634487033017;
        Sun, 17 Oct 2021 09:10:33 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ay42sm2514892oib.22.2021.10.17.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:10:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mfd: qcom-spmi-pmic: Document ten more PMICs in the binding
Date:   Sun, 17 Oct 2021 09:12:17 -0700
Message-Id: <20211017161218.2378176-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
References: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding with eight more SPMI PMIC compatibles found in the
PMIC info list in the Qualcomm socinfo driver and add the two PM660
related PMICs supported by the SPMI PMIC driver but are missing from the
document.

Then remove the duplicate entry for pma8084.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rebased on top of sorting of entries
- Added the two PM660 related PMICs from the binding
- Dropped he duplicate pma8084 that showed up in the sort

 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index 67785b6d66e9..7a27c500ff63 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -15,14 +15,22 @@ each. A function can consume one or more of these fixed-size register regions.
 
 Required properties:
 - compatible:      Should contain one of:
+                   "qcom,pm660",
+                   "qcom,pm660l",
                    "qcom,pm7325",
                    "qcom,pm8004",
                    "qcom,pm8005",
                    "qcom,pm8019",
+                   "qcom,pm8028",
                    "qcom,pm8110",
+                   "qcom,pm8150",
+                   "qcom,pm8150b",
+                   "qcom,pm8150c",
+                   "qcom,pm8150l",
                    "qcom,pm8226",
                    "qcom,pm8350c",
                    "qcom,pm8841",
+                   "qcom,pm8901",
                    "qcom,pm8909",
                    "qcom,pm8916",
                    "qcom,pm8941",
@@ -30,14 +38,15 @@ Required properties:
                    "qcom,pm8994",
                    "qcom,pm8998",
                    "qcom,pma8084",
-                   "qcom,pma8084",
                    "qcom,pmd9635",
                    "qcom,pmi8950",
                    "qcom,pmi8962",
                    "qcom,pmi8994",
                    "qcom,pmi8998",
+                   "qcom,pmk8002",
                    "qcom,pmk8350",
                    "qcom,pmr735a",
+                   "qcom,smb2351",
                    or generalized "qcom,spmi-pmic".
 - reg:             Specifies the SPMI USID slave address for this device.
                    For more information see:
-- 
2.29.2

