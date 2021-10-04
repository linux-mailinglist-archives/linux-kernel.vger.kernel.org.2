Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AD4209A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhJDLBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:01:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21452 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJDLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633345197; x=1664881197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6K5Rf9XtKev4ZWc+I1iNJd1RLme0vI8ykcZiWCraLOU=;
  b=Mg1DlXbbR3qd11fX8gR3qo7ywoG/d+DF9rcatztaojauM5Ra25LJ/nh0
   0wBDRhD+HXqm0UgE3Hv4gj6DKKWgisJtS54YdDrllQ8NX1QYu/MAFP8+W
   LqXQYBekyf9K5ZYRr4nr9pklNTX+3z5gXX+CUtRurCTsnv0fRxs9bOKRz
   J8QorPDZ8b15KPIRcXuDSO87O2W6kgehoNoPgmydxh4DGLgaXBkQoMZCF
   3zYDbGSdTkwkTXBHzLx990czLBeuq5sY5e49WIy6d68LUq67NRoUiWTqz
   jgEv71e+L2GPFETYHW5M8tdA1p9ICtvNDnLcmpbGlHzyNF++Y2d8BpKDx
   w==;
IronPort-SDR: N2bHGEH778SUoEiXpKSpONL7hHN+nfSoot0Ox+itbtPBF7C5Z7o5vKcwD9tMRcRJnz+owWdsOe
 qGNeuzGqswGlYPZn85j3LDsvMpKobQ5NHQwIgczPgYrIW8/W/JEk63L/54exFeHLlB1UAtzHYB
 hZyqazlb+qE4IUwxTOt9aPtuvkNaYkvC/Fq5hc+FCtikmAY6H5hgvEzLCcnDwf4nmYGedHBisD
 fCAN7gasyJ0vKuty3UMqdTUEUZVP3cEWOFiYlNHmcMdGqsKhBiw5KYh0F5Iu1kBxLJkmlFiBS7
 jBVdBakaFLULa9n9FEJsiOPj
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="138939049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 03:59:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 03:59:56 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 03:59:51 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <corbet@lwn.net>
CC:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 3/4] dt-bindings: arm: at91: Document lan966 pcb8291 and pcb8290 boards
Date:   Mon, 4 Oct 2021 16:29:25 +0530
Message-ID: <20211004105926.5696-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
References: <20211004105926.5696-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Microchip LAN9662 PCB8291 and
LAN9668 PCB8290 Evaluation Boards.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../devicetree/bindings/arm/atmel-at91.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 08efb259a947..c612e1f48dba 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -162,6 +162,18 @@ properties:
           - const: microchip,sama7g5
           - const: microchip,sama7
 
+      - description: Microchip LAN9662 PCB8291 Evaluation Board.
+        items:
+          - const: microchip,lan9662-pcb8291
+          - const: microchip,lan9662
+          - const: microchip,lan966
+
+      - description: Microchip LAN9668 PCB8290 Evaluation Board.
+        items:
+          - const: microchip,lan9668-pcb8290
+          - const: microchip,lan9668
+          - const: microchip,lan966
+
       - items:
           - enum:
               - atmel,sams70j19
-- 
2.17.1

