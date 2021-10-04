Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53DE4209CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhJDLRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:17:31 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:27097 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhJDLR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:17:29 -0400
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19847137"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Oct 2021 13:15:38 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 04 Oct 2021 13:15:38 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 04 Oct 2021 13:15:38 +0200
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19847134"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Oct 2021 13:15:38 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4FE09280065;
        Mon,  4 Oct 2021 13:15:38 +0200 (CEST)
From:   Alexander Stein <Alexander.Stein@tq-systems.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add output-driver-strength property
Date:   Mon,  4 Oct 2021 13:15:28 +0200
Message-Id: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This property is for optimizing output voltage impedance and is
specific to each board.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I checked Micron and Macronix datasheets. Both have similar but not
identical supported values. Also the register locations are different.
For those reasons I decided to specify the Ohms value directly and let
the device specfic driver figure out if it is supported where to write
it to.
BTW: Are the Ohm values and the corresponding register bits standardized
somewhere?

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..7d7f20a741b5 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -72,6 +72,12 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  output-driver-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Output driver strength in Ohms which optimizes the impedance at Vcc/2
+      output voltage.
+
   label: true
 
   partitions:
-- 
2.25.1

