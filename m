Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534473A4E05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFLJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFLJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:48:39 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:46:38 -0700 (PDT)
Received: from localhost.localdomain (bband-dyn73.178-41-129.t-com.sk [178.41.129.73])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 4037A1F983;
        Sat, 12 Jun 2021 11:46:37 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH V3 2/3] dt-bindings: mailbox: Add binding for sm6125
Date:   Sat, 12 Jun 2021 11:46:29 +0200
Message-Id: <20210612094631.89980-2-martin.botka@somainline.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210612094631.89980-1-martin.botka@somainline.org>
References: <20210612094631.89980-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding for sm6125

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
Changes in V3:
Add this file
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 5dc1173d03fd..9f4fbc6a141c 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,sc8180x-apss-shared
       - qcom,sdm660-apcs-hmss-global
       - qcom,sdm845-apss-shared
+      - qcom,sm6125-apcs-hmss-global
       - qcom,sm8150-apss-shared
 
   reg:
@@ -75,6 +76,7 @@ allOf:
             - qcom,sc7180-apss-shared
             - qcom,sdm660-apcs-hmss-global
             - qcom,sdm845-apss-shared
+            - qcom,sm6125-apcs-hmss-global
             - qcom,sm8150-apss-shared
     then:
       properties:
-- 
2.31.1

