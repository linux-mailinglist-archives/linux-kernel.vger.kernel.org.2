Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD0423EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhJFNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:25:27 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:44843 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238700AbhJFNZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526604; x=1665062604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiwKrakkr7oJWU4yWLb3EUl6t+GPdcswu9rVDvYTZ6g=;
  b=EhIKEfO6ATG71+pipW5zctTmv78GLF5jSllL1oa6Eyd++YyKSNOHO2b5
   gJUaI5/ZOIn8GJ+6ceB45JONi5FvofHYKI+kL95ymIp47JkPQ5CN6Al3q
   sSk008ppcz+HnKXdSwnT1P4brrdWtTLttR4hnU7eCaeEqWPPNgV1QYABp
   FwudUioVf6i56UfibqjIYQtnhP22wYA6TM6MRZSeSPVbCE1FYbUKAZ4Rd
   YHOvdcZTq+Z7h58l8njAw2SQkAX5p39Sk6SFNvBqKcdjObVsRdLoARCU5
   bgul/MKohO8F15Kt3khH8zBVMe3ywNj1J/2lboKSN0Pf8ZuoqYWvBfouc
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897926"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Oct 2021 15:23:20 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Oct 2021 15:23:20 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Oct 2021 15:23:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526600; x=1665062600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TiwKrakkr7oJWU4yWLb3EUl6t+GPdcswu9rVDvYTZ6g=;
  b=l5b2oEI2q/P5LUq18Mh5Y7FUhchxQAvbOR3JBLPtfqdyUvj2ERm//lFw
   0PkbKmM7aFXipt5bQIsM9TyvJ7ulKjxpp1aylZIf2snX1o5MvvowayyOt
   BVmGHZFgoeEjlXDrV2lp59CoCVRSTxlOJCjruuJ2jdfjLUV0eQSCstYfR
   5YMZ4TjbkySiSpgz1uAwEz+QQidmAMG6Ygj9LIuK2MVs7pOK9lQaYcqtY
   gia+WWoo57N9/76dYUyFcb2vKiccLkvbzJvKmUOadosTGBDlTXDrI5/GR
   Gdxc9+D4LuN6QCHzsQuxECleo6WOimxasGDWyTphrZ09lfZpPYgpj1trT
   A==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897925"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BE9F8280075;
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
Subject: [PATCH 4/7] dt-bindings: arm: fsl: add TQMa8MxNL boards
Date:   Wed,  6 Oct 2021 15:23:06 +0200
Message-Id: <20211006132309.1239708-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8MxNL is a SOM family using NXP i.MX8MN[Q,QL,DL,S,SL] CPU
MBa8Mx is an evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mn-<SOM>" for the module and
"tq,imx8mn-<SOM>-<SBC>" for mainboards

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 42de579724bf..ed6f090df397 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -768,6 +768,17 @@ properties:
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn
 
+      - description:
+          TQMa8MxNL is a series of SOM featuring NXP i.MX8MN system-on-chip
+          variants. It is designed to be soldered on different carrier boards.
+          All variants (TQMa8M[Q,D,S][L]NL) use the same device tree, hence only
+          one compatible is needed.
+        items:
+          - enum:
+              - tq,imx8mn-tqma8mqnl-mba8mx # TQ-Systems GmbH i.MX8MN TQMa8MQNL SOM on MBa8Mx
+          - const: tq,imx8mn-tqma8mqnl     # TQ-Systems GmbH i.MX8MN TQMa8MQNL SOM
+          - const: fsl,imx8mn
+
       - description: i.MX8MP based Boards
         items:
           - enum:
-- 
2.25.1

