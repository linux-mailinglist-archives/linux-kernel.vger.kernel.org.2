Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A24465C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhKEPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:33:21 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1233 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhKEPdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126236; x=1667662236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZn3u3dxIArmV6AHFkeuoAMe3sWNN6s3QNGcUlXuWCU=;
  b=ZhqpeFRJdPBGAgqACq7lf7ExCLxU+BFv4OdrJNkRXQ391Gb+PSEt4pG9
   L3CWdvyvIcs0FsHfTMcgmOVQkpgSAoygUleHyN699TFz/Zz9FO0OruUYt
   U5X1htmWjoa3vhlUwTaaArJ/F0Ckq/ev6B2hay3aCR/ENaKqwNYr4rWeu
   IkZ5h2YRV5F5+EktJKWv9J8DIwQXsYbPooG6mb45KNbQefhSdLYvkYJWy
   QRHdnHV5jVWsmQgtxaDqOXGBxQ6ixrwugRSBVq6AgEMJvnfgg5HSLDesZ
   X4r9mrx6s2V5xAALQW0wluztcT14xq8QeLj1d2GH63u3P/fpqOygppbP4
   w==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358798"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 05 Nov 2021 16:30:34 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 05 Nov 2021 16:30:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126234; x=1667662234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZn3u3dxIArmV6AHFkeuoAMe3sWNN6s3QNGcUlXuWCU=;
  b=IYOQgB4fbIKAbK/O2N/YpELxdKzn8UfOiZFPGVbfQg/RDF7xWoLST7WL
   6QnCaPxyfLOa7S/eLE0kvwpfweQ9rrvtS07Uf6eWsHhGHnLTvf7Tf+p5x
   BT91tailHTmj/hTlgMN/SAEomCi3nMxQUw72jKi0hl0NEz8iaVVHXT/ff
   TkRr84jEYHx7GtGJ1gRGw2e94jawFgqfipMJNq/YYlAloA3KcjuQ4yxJ/
   lpIF4pzlykxuQRGjZ57kI64l2rgy+EmK4NvrG6kTMZjNkY3lLbYPMRXSB
   r6QFGvMC3pmkRiB1pvf2BWsdWzRLaeAhnWx+Jcagtx0fwBUDvQE3G5EOG
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358796"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E5866280075;
        Fri,  5 Nov 2021 16:30:33 +0100 (CET)
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
Subject: [PATCH v2 1/7] dt-bindings: arm: fsl: add TQMa8MxML boards
Date:   Fri,  5 Nov 2021 16:30:19 +0100
Message-Id: <20211105153025.187106-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
References: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8MxML is a SOM family using NXP i.MX8MM[Q,QL,DL,S,SL] CPU
MBa8Mx is an evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mm-<SOM>" for the module and
"tq,imx8mm-<SOM>-<SBC>" for the module on that mainboard

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..abcf559e311e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -754,6 +754,17 @@ properties:
           - const: variscite,var-som-mx8mm
           - const: fsl,imx8mm
 
+      - description:
+          TQMa8MxML is a series of SOM featuring NXP i.MX8MM system-on-chip
+          variants. It is designed to be soldered on different carrier boards.
+          All variants (TQMa8M[Q,D,S][L]ML) use the same device tree, hence only
+          one compatible is needed.
+        items:
+          - enum:
+              - tq,imx8mm-tqma8mqml-mba8mx # TQ-Systems GmbH i.MX8MM TQMa8MQML SOM on MBa8Mx
+          - const: tq,imx8mm-tqma8mqml     # TQ-Systems GmbH i.MX8MM TQMa8MQML SOM
+          - const: fsl,imx8mm
+
       - description: i.MX8MN based Boards
         items:
           - enum:
-- 
2.25.1

