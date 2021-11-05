Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7634465CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhKEPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:33:30 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:1233 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhKEPdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126239; x=1667662239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USFTG4CyjJ2V0A/IaDFHB/t0MuF5SPUlnI/RWiXmNVg=;
  b=eZfQDUjCfGGOReZ/ZmMrc8ZgFKoVA3I5o4qiSn381CDooOpyawiGPBzd
   gG4GIhgOIYlQa7Yh5D48y9qp6Fqh05Laz3jbc+id9l0fm0coES+7j57Ab
   lqyfp/ca7NiIg3NvsFDIRiCtWM4PUDyGxbdmgKOXIj3FtCymX0WcE5k+8
   72/4MD7I/2vQ/dBZK0JQhf5k6K1rG3AF/sL0Nopef28Sa5FOtRUKAtyQV
   vqmyTIgtgDFaX2V4FSMNQ76zSYk8c7vFmdp7K0qMqylunXsCHnC87tz/n
   tTJooJ7PSte8YieNaRlJ+poYIMyiPwRuWKJtQastdTPLbFREcinhmTfjY
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358804"
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
  bh=USFTG4CyjJ2V0A/IaDFHB/t0MuF5SPUlnI/RWiXmNVg=;
  b=bqMyzuA+YKByDetkDO7+i0nDRsdZdKFFTwWvpYJGrwmH7wC3B457dDjB
   HhA+BgQPBX7Lf71gVUtHcCBKZxoUZUzG35OyJpV3YJ2co8ni8IOVe0YTV
   drVbSAGKXe2q9tWMwiEMVMDBy2t/TZr35PsWPLUTD8rPirR5veSq44+el
   jgLs3qmDUltlKC+7Jf/QG/GqDGACtaS0+bCSvBUjb0TvOBGKRDpZAwb2Q
   w18XDPKaSgA0z5ly3mwe1uE4fe/lpW8k4wpn/mMMVUG5YxbTQ/v/w8sOY
   2Bk2YXO3GneS1QCpjV+s8JYolYzvdUq4cO9UjvpaNb+m5ZdN17CA/Di0h
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358803"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9E67D280065;
        Fri,  5 Nov 2021 16:30:34 +0100 (CET)
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
Subject: [PATCH v2 4/7] dt-bindings: arm: fsl: add TQMa8MxNL boards
Date:   Fri,  5 Nov 2021 16:30:22 +0100
Message-Id: <20211105153025.187106-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
References: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
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
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index abcf559e311e..145f529ffc45 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -780,6 +780,17 @@ properties:
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

