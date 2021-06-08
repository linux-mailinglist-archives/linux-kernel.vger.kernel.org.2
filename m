Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16C39FE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhFHRw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhFHRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:52:26 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6090C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:50:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so20079053otu.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfxJ0B3CrJj0aGpmXt38E2admgu06MumRoXg1smpcJI=;
        b=PQasmvC6JpfO/qy8QSodizBlrcfnYV39OsA6aZToafmZpxEklj22rE7lZVClFPlQkX
         tTstjMJco52Qs/PCJnOjKpfWIExgp3Vnl33aK4rq+8wMtuX7gQJX8dn8xSET8IYovrIF
         0B3bXQuMB3C1/cTKvaPx5W41lQ3IFa9n8I4hiFBc85JLLanMP8D4aH/ixRqu52WvuU8Q
         bj+9J22evK1y2ie5uD1UANthtmJa8bPIQhPftVad00g7BYbGpA1qE1g/HwEJosNpuWPK
         n5kGT5bfBnIpLWuHEOsOcS/Nl3fga/TWzd3qCsxIa7QYTC8wyIariqTNZKrzblC99Zbv
         MoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfxJ0B3CrJj0aGpmXt38E2admgu06MumRoXg1smpcJI=;
        b=h9EqdxUPIR4ADE8EASNClJkDn5QZZM7BZ7QgEIz6DkQjRsOBuiFmHmLBZQCSECfgNs
         enmR6qwSMirFOSXQTB4T2u9t1NDELC9E4c3nxN8EAjpXTiqNyk07GqnqBVOg0jxaJTiF
         eox8Mh/mbiQuyrRvOdUT4yxocZGLRFvGr8TKphuBGxjQTfG6yFJahgvzf2M9A0IKfosd
         8ETOTqH0tV4zxYUc3T+rENSw1kLE3/Oe4ZFknXNNpD2r+AXH+4R/jZQ3q3Vl84TbK2Sf
         of52kWy8XH8Q8V22Dx+MAahfmc04+FjGHrjXZtE/WDA9aFHIyGx7oM7F+8nhMm3x13GU
         go3g==
X-Gm-Message-State: AOAM530ZiXDmPQMIyikJyuBPVIIxfRlbx7/5XoVDs1mnY3gWtVSgRcxc
        Ftc21krZdpliximjmixZNy0XPg==
X-Google-Smtp-Source: ABdhPJzG4ddwYAsy0X/jhztKCSD/hl2swMUjGyGJ9b2UzaOpSYfiOL8y8c8roF/XGXkDAwFK+kOLbw==
X-Received: by 2002:a9d:741a:: with SMTP id n26mr18737302otk.223.1623174632318;
        Tue, 08 Jun 2021 10:50:32 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c11sm1663960oot.25.2021.06.08.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:50:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: pas: Add SC8180X adsp, cdsp and mpss
Date:   Tue,  8 Jun 2021 10:49:43 -0700
Message-Id: <20210608174944.2045215-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Audio DSP, Compute DSP and Modem subsystem found
in the Qualcomm SC8180x to the Peripheral Authentication Service
remoteproc binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- "Rebased" on yaml conversion

 .../devicetree/bindings/remoteproc/qcom,adsp.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 6c11812385ca..21a541859c7e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -25,6 +25,9 @@ properties:
       - qcom,qcs404-cdsp-pas
       - qcom,qcs404-wcss-pas
       - qcom,sc7180-mpss-pas
+      - qcom,sc8180x-adsp-pas
+      - qcom,sc8180x-cdsp-pas
+      - qcom,sc8180x-mpss-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
       - qcom,sdx55-mpss-pas
@@ -143,6 +146,9 @@ allOf:
               - qcom,msm8998-adsp-pas
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-wcss-pas
+              - qcom,sc8180x-adsp-pas
+              - qcom,sc8180x-cdsp-pas
+              - qcom,sc8180x-mpss-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sm8150-adsp-pas
@@ -249,6 +255,8 @@ allOf:
               - qcom,qcs404-adsp-pas
               - qcom,qcs404-cdsp-pas
               - qcom,qcs404-wcss-pas
+              - qcom,sc8180x-adsp-pas
+              - qcom,sc8180x-cdsp-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
               - qcom,sm8150-adsp-pas
@@ -283,6 +291,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7180-mpss-pas
+              - qcom,sc8180x-mpss-pas
               - qcom,sdx55-mpss-pas
               - qcom,sm8150-mpss-pas
               - qcom,sm8350-mpss-pas
@@ -430,6 +439,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc8180x-adsp-pas
+              - qcom,sc8180x-cdsp-pas
               - qcom,sm8150-slpi-pas
               - qcom,sm8250-adsp-pas
               - qcom,sm8250-slpi-pas
-- 
2.29.2

