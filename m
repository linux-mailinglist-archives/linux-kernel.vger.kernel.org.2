Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA90423EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhJFNZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:25:30 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:35555 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJFNZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526605; x=1665062605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=exCoL4cMMUf+jxb5+mFaDcRh20Gt9l6AtspBiZs2pnI=;
  b=aQTKDFVQWDmqNZQpTzB+jADxiDbsIj32Yb+qnX/nlqAtLFyMhqjosDzu
   TBdGyX2bKjrepi+DV/43944JcXWdUDn6R/ipqi55UXJ7zLXDCBUSxyTRA
   ZlITrLo+8Lxmz0FDZ2/dgT6vEBKzo91DgQ6G87SCTFVEcZCkIn5WqV8BH
   NnjtaC9iDHRu9coFk3T7Q8TkEey+IHbB0Oi8KUFD06fpjiyyQsOEffY4E
   Mky2zjKK4aRwfJwV/lLNuX/In3DgarZwsOQtP6AJhlSXinzNHIbvJTwDc
   Z+4CHMDVXF9agS4Eb2RXPgYAd37LWQ0/h3fdFIp7+lrHrjuIC89Zs6W5y
   g==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897931"
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
  bh=exCoL4cMMUf+jxb5+mFaDcRh20Gt9l6AtspBiZs2pnI=;
  b=MJrTpaeLZhi/YLR0zcw4I8Slr6sLAQJ4cPj9E3wtVYjdxKFcY7NtIiqt
   PaA/JFp8Gqij6WsnM2bX9KlSW/gMHtxlA5lEbEDhd07RPrLvDCYStEQyi
   m6EQ4qe5rPykSdDCPL4B7rPxlE8il7OrswJ0YN4qkSLNd2xhOmrWhyIgj
   fLHh7bJCu79csfK2Ba73ZqYvgiilqsTvi50EOioBCGdYkGimWBNMwZYqt
   Wo98goXcZ5N+BU6RqQyT4BYiqn6T8TKkj/pBKDBSh6XN2hGFhTCSDm/1I
   JN7p1/aIj77WNe08g0HrdHfTauK0/4n9U9EJf8wLSToWVVe1acGyPLhv5
   A==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897929"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2021 15:23:20 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3AA9F280075;
        Wed,  6 Oct 2021 15:23:20 +0200 (CEST)
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
Subject: [PATCH 6/7] dt-bindings: arm: fsl: add TQMa8Mx boards
Date:   Wed,  6 Oct 2021 15:23:08 +0200
Message-Id: <20211006132309.1239708-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
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
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ed6f090df397..18034b23ca08 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -815,6 +815,15 @@ properties:
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

