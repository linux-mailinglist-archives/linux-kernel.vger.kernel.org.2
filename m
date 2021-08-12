Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D013EA2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbhHLKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:07:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:49110 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhHLKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:07:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628762837; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KiE+rVQY46cVQ5OE7ZvIdEvKX6VtwKSVL05iVQtQQGg=; b=KyO1YuVc04/gCeTbpSEWugShe09xnrj8Cv6As8QbCySi+e++bS4ZZfREK0PqjSkEBIPiK+Gk
 qneQVVSuaqFmsIoujZXPbFA4XDlfPSmAgr8HScJPNk5cOuK61A27oqnYLA5wTbbEklJKQtoY
 Jtc1ONGxWR3rIvjnXI6fet5+2jY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6114f2d37ee6040977488c4f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 10:07:15
 GMT
Sender: luoj=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75F62C433D3; Thu, 12 Aug 2021 10:07:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akronite-sh-dev02.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: luoj)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FE79C4338A;
        Thu, 12 Aug 2021 10:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FE79C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=luoj@codeaurora.org
From:   Luo Jie <luoj@codeaurora.org>
To:     andrew@lunn.ch, agross@kernel.org, bjorn.andersson@linaro.org,
        davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr
Cc:     linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, Luo Jie <luoj@codeaurora.org>
Subject: [PATCH v3 3/3] dt-bindings: net: Add the properties for ipq4019 MDIO
Date:   Thu, 12 Aug 2021 18:06:42 +0800
Message-Id: <20210812100642.1800-4-luoj@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812100642.1800-1-luoj@codeaurora.org>
References: <20210812100642.1800-1-luoj@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new added properties resource "reg" is for configuring
ethernet LDO in the IPQ5018 chipset, the property "clocks"
is for configuring the MDIO clock source frequency.

Signed-off-by: Luo Jie <luoj@codeaurora.org>
---
 .../bindings/net/qcom,ipq4019-mdio.yaml           | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 0c973310ada0..2af304341772 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,ipq4019-mdio
+    enum:
+      - qcom,ipq4019-mdio
+      - qcom,ipq5018-mdio
 
   "#address-cells":
     const: 1
@@ -23,7 +25,18 @@ properties:
     const: 0
 
   reg:
+    minItems: 1
+    maxItems: 2
+    description:
+      the first Address and length of the register set for the MDIO controller.
+      the second Address and length of the register for ethernet LDO, this second
+      address range is only required by the platform IPQ50xx.
+
+  clocks:
     maxItems: 1
+    description: |
+      MDIO clock source frequency fixed to 100MHZ, this clock should be specified
+      by the platform IPQ807x, IPQ60xx and IPQ50xx.
 
 required:
   - compatible
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

