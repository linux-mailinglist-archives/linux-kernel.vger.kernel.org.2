Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83448430A69
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhJQQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbhJQQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 12:12:42 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17E5C061769
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:10:32 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so1193229otb.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgKWltHaKHYGUgrOG09psAIMqFJFjmywOMsFGZMfP5E=;
        b=kFN8Y6m5oFdtbcLbKoxaGPElNgzyMpxok0YQuEI0tZEnRnc3BEvWRfWe80sBkTuASf
         qfS6fjF3JzvLOT6uIYd47QCTzcNiATI6sqaSpc1XkQXwPewpkmo002jVy0vl2dPIxPSp
         giyTcIG4MlYzZy3GchWzAWdpJbMjkXNQljiVcMOqsRkoTxATqQlh/9H0Rvr21MYiAKTl
         Y9JzYv+yah2Yf4mpV9rlPB0LNYK+81uLq82FCdL9xt+Bgi6MfLaoOwIZvOTnWjxpO85L
         f3GYrtsdmG8QD/prnrczEVa5QauQ65XY9Vlx4h8yNVnwqdbg+6sTpONeeSEOi0KAgVVR
         VoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgKWltHaKHYGUgrOG09psAIMqFJFjmywOMsFGZMfP5E=;
        b=qzqTfZQINnIFqsapdJul8uY0JuLAKSYLf5Nu/TY4sOJnwjDdv4QtB+zYMYkPwe3E3y
         g8imfm8aN15oHrvBjzq96sRtyzbwXXFwdhsuIelX7IyuidxXF0aSDwIHjQPNJ/95Imx8
         JsE2doYtlQHPZC42puNdd/EJRm3ene0GDGJi9oMhYxHC0TxQnzDht7uUKuVuFWBDi3E2
         LXTS1DtZhA8wvmf2nSBCwG0xe4uX40RiWVeZEEfG+ek84fOYfagyoVSGcK/xrFfhfjQ6
         AQdNlJjTajbXHCYnuIO5ifOohRPQtZDddcm6LJaYOgjhk14YbFvaW2pCegv09FcSJ1gN
         y3cw==
X-Gm-Message-State: AOAM532cRyfrAQjNlyVQQhGj1CKmjw3jeK8azA0XwomZmiibwn6JX5kb
        IY39ZyIF7p+gSNuA0mESVyonPcDWZYwOwg==
X-Google-Smtp-Source: ABdhPJwHjFgTxnlnlKIYopATbX82zhLCNTEPivbZUh//ZaOqVEu9M9ZYnjNkGksl0PakDfkkQYxwbw==
X-Received: by 2002:a9d:17c4:: with SMTP id j62mr17351821otj.225.1634487032141;
        Sun, 17 Oct 2021 09:10:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ay42sm2514892oib.22.2021.10.17.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:10:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mfd: qcom-spmi-pmic: Sort compatibles in the driver
Date:   Sun, 17 Oct 2021 09:12:16 -0700
Message-Id: <20211017161218.2378176-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
References: <20211017161218.2378176-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the compatibles in the driver, to make it easier to validate that
the DT binding and driver are in sync.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/mfd/qcom-spmi-pmic.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index a35d5cf16faa..8be07102a468 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -40,27 +40,27 @@
 #define PM660_SUBTYPE		0x1B
 
 static const struct of_device_id pmic_spmi_id_table[] = {
-	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
-	{ .compatible = "qcom,pm8941",    .data = (void *)PM8941_SUBTYPE },
-	{ .compatible = "qcom,pm8841",    .data = (void *)PM8841_SUBTYPE },
+	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
+	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
+	{ .compatible = "qcom,pm8004",    .data = (void *)PM8004_SUBTYPE },
+	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
 	{ .compatible = "qcom,pm8019",    .data = (void *)PM8019_SUBTYPE },
-	{ .compatible = "qcom,pm8226",    .data = (void *)PM8226_SUBTYPE },
 	{ .compatible = "qcom,pm8110",    .data = (void *)PM8110_SUBTYPE },
-	{ .compatible = "qcom,pma8084",   .data = (void *)PMA8084_SUBTYPE },
-	{ .compatible = "qcom,pmi8962",   .data = (void *)PMI8962_SUBTYPE },
-	{ .compatible = "qcom,pmd9635",   .data = (void *)PMD9635_SUBTYPE },
-	{ .compatible = "qcom,pm8994",    .data = (void *)PM8994_SUBTYPE },
-	{ .compatible = "qcom,pmi8994",   .data = (void *)PMI8994_SUBTYPE },
-	{ .compatible = "qcom,pm8916",    .data = (void *)PM8916_SUBTYPE },
-	{ .compatible = "qcom,pm8004",    .data = (void *)PM8004_SUBTYPE },
+	{ .compatible = "qcom,pm8226",    .data = (void *)PM8226_SUBTYPE },
+	{ .compatible = "qcom,pm8841",    .data = (void *)PM8841_SUBTYPE },
 	{ .compatible = "qcom,pm8909",    .data = (void *)PM8909_SUBTYPE },
+	{ .compatible = "qcom,pm8916",    .data = (void *)PM8916_SUBTYPE },
+	{ .compatible = "qcom,pm8941",    .data = (void *)PM8941_SUBTYPE },
 	{ .compatible = "qcom,pm8950",    .data = (void *)PM8950_SUBTYPE },
-	{ .compatible = "qcom,pmi8950",   .data = (void *)PMI8950_SUBTYPE },
+	{ .compatible = "qcom,pm8994",    .data = (void *)PM8994_SUBTYPE },
 	{ .compatible = "qcom,pm8998",    .data = (void *)PM8998_SUBTYPE },
+	{ .compatible = "qcom,pma8084",   .data = (void *)PMA8084_SUBTYPE },
+	{ .compatible = "qcom,pmd9635",   .data = (void *)PMD9635_SUBTYPE },
+	{ .compatible = "qcom,pmi8950",   .data = (void *)PMI8950_SUBTYPE },
+	{ .compatible = "qcom,pmi8962",   .data = (void *)PMI8962_SUBTYPE },
+	{ .compatible = "qcom,pmi8994",   .data = (void *)PMI8994_SUBTYPE },
 	{ .compatible = "qcom,pmi8998",   .data = (void *)PMI8998_SUBTYPE },
-	{ .compatible = "qcom,pm8005",    .data = (void *)PM8005_SUBTYPE },
-	{ .compatible = "qcom,pm660l",    .data = (void *)PM660L_SUBTYPE },
-	{ .compatible = "qcom,pm660",     .data = (void *)PM660_SUBTYPE },
+	{ .compatible = "qcom,spmi-pmic", .data = (void *)COMMON_SUBTYPE },
 	{ }
 };
 
-- 
2.29.2

