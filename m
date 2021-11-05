Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2964465D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKEPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:33:34 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1241 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233583AbhKEPdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126240; x=1667662240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0miUMMRCKmjRiKcNdO5dEnWmlLnXSDZQBjrW39kORL4=;
  b=LGGwwBKmCN+gxErvLCdZnHT0PKzUURZkWRZP3EmIcwud6o+eH2Hj/Ouu
   fgPL+Llvenz2dLuOzGB0uDALeusL0XuV8/XAUzjy8/FYOJEwgBYgEgqlw
   nkN0p/hbKLMYhc6t1iu4s4KDkJRi/+t85dyPgrbrt16jZ0+/PiCELUuNu
   Yg9WOuT1c3QjFPcTHiR48O/gOrTtVEl5xNE8ORBe32hW8iBKc0MbND4cg
   YDtN1e9g1AugYo9t06SgLWfkUOUmESua1HLWERSPKQSOa2vqoWqfUzCq2
   ZoHoCyhOojsIQxo22XDa//5q9WyS+iK8cn+BS1xTRSwCJSWlB0n60okAi
   A==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358808"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Nov 2021 16:30:35 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 05 Nov 2021 16:30:35 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 05 Nov 2021 16:30:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126235; x=1667662235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0miUMMRCKmjRiKcNdO5dEnWmlLnXSDZQBjrW39kORL4=;
  b=MnSWCjmwxu2dXQUzNNOYHh3ujRysqbhdg30lVcGj7L9XolUlxlW6yQPQ
   CVX7VatY3LMzJtTVwCSaec/LTRsHN6D91FRpui8yjGyNPWUDswhdE8f0M
   1JMuzMphoIAbO0xemdU4S/Y9HjiDGQOWIV2ylgsgl28PLJmquZ6pGv8c7
   Z7JaKgFDdPRbII9ZNurj+v8uige9rKL3rwA0KcU07qvAyGvPTXAnwumi8
   orsJobEcBDD0qC1ieMvY1TjpiNY4nF8pNJsaRABo+7B0MGXGTZVKNGGYH
   SxRh+EOsEArzRIUJhlKmWvNpKQ/OafETTxHmm7+/1cnMSEUnW4m2BxvAp
   g==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358807"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Nov 2021 16:30:35 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1F64A280065;
        Fri,  5 Nov 2021 16:30:35 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 6/7] dt-bindings: arm: fsl: add TQMa8Mx boards
Date:   Fri,  5 Nov 2021 16:30:24 +0100
Message-Id: <20211105153025.187106-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
References: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8Mx is a SOM family using NXP i.MX8M[Q,QL, D] CPU
MBa8Mx is a evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mq-<SOM>" for the module and
"tq,imx8mq-<SOM>-<SBC>" for the module on that mainboard

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 145f529ffc45..47f91b43f74f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -827,6 +827,15 @@ properties:
           - const: purism,librem5
           - const: fsl,imx8mq
 
+      - description:
+          TQMa8Mx is a series of SOM featuring NXP i.MX8MQ system-on-chip
+          variants. It is designed to be clicked on different carrier boards.
+        items:
+          - enum:
+              - tq,imx8mq-tqma8mq-mba8mx # TQ-Systems GmbH i.MX8MQ TQMa8Mx SOM on MBa8Mx
+          - const: tq,imx8mq-tqma8mq     # TQ-Systems GmbH i.MX8MQ TQMa8Mx SOM
+          - const: fsl,imx8mq
+
       - description: Zodiac Inflight Innovations Ultra Boards
         items:
           - enum:
-- 
2.25.1

