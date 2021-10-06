Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC002423EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhJFNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:25:17 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:35555 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhJFNZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526601; x=1665062601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKJ0bFm8eNqWG34ObesftZ7ZzfHcMk2zMn++WOC2aLo=;
  b=NLhM3GUM1f4waV/cvRNsNEhfYzFOayQ3dxdUxc7aBKmbYWcKDci1jabp
   d6mLRjJ/4vWvaTzysZv9xeEXxPj0s9V8PxOgYh+BSy0hIxGSPveN97rf6
   IaIqUdp0lZC/GjlBIEdWf//hW09/SpmXywqwGs87YA6Vp+giPddISNhYH
   txAclwwy8VogInkSUCIQFOgNsQgx/NdCRZbcT8OEGqCXEbDHmd+QRefox
   +CvGE4UBBlk4Y75WvuBJ72UTH3qyhE9mL2UHkY4XFWKMNRaxtYU3mu8O6
   VmA1UGxIuRQ5vmjXHc4zXCGP3s13wtCuyBx8zBi5Xc7Qxlkmt6N1s7eVG
   w==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897920"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Oct 2021 15:23:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Oct 2021 15:23:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526599; x=1665062599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKJ0bFm8eNqWG34ObesftZ7ZzfHcMk2zMn++WOC2aLo=;
  b=Wt+mOkgXyxl2wONy8k4waUG3UYuj7al53P2aYs9Mtp5iCI+3Ic4q6H17
   XvrLQTW8pyqxML8Al0CayB4WK0AWu2CzOQuE3tzh08YGZhKnwScsU4ser
   SpkjJbDLDVzhxDEK7aMOUIyfc4fbXuYfgB7htnn29IoONtMWwvnEmXK6I
   YvYbYGIwW6/VS+4fifKl42aF5dM/qSh7vVaWmq2XGpZbzEr6DuBp5Iqd4
   QJ4o+osTXl2eR4V8caZPSdVGLldnbfg6S6UqIrOS8RYercHRbS8oweojs
   C0IceW+jF0w5GwT+nBEwxzWf3+eZd6zGtvdAP8RrIZdP5EEaDRPODOIM9
   g==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897919"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1122C280075;
        Wed,  6 Oct 2021 15:23:19 +0200 (CEST)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/7] dt-bindings: arm: fsl: add TQMa8MxML boards
Date:   Wed,  6 Oct 2021 15:23:03 +0200
Message-Id: <20211006132309.1239708-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e..42de579724bf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -742,6 +742,17 @@ properties:
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

