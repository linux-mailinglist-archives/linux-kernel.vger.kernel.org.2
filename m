Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2D3433D3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 18:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCURkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 13:40:32 -0400
Received: from mx4.wp.pl ([212.77.101.12]:59808 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhCURj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 13:39:56 -0400
Received: (wp-smtpd smtp.wp.pl 17111 invoked from network); 21 Mar 2021 18:39:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1616348394; bh=o94tkwrqVWEmgKEXCHzrLb0JlcxwSS/Fe4MA+Z0KhV0=;
          h=From:To:Cc:Subject;
          b=rVtzkc97oTQyB8AxXLjn967Mwnc46U4/qebufullHLdtXdkH9E3Kwo5jkrSPRp7GF
           Qw15nDI3bXl5iObNjtnHY2nlZh3XlWxVjYaOQpSO9O4uaUGwo8I+2hjtSF7srEopb8
           i9S4PTFqmgw+INH+VDmTuC1Zj8AbjE0iWpnwoYFg=
Received: from riviera.nat.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.1])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <hauke@hauke-m.de>; 21 Mar 2021 18:39:54 +0100
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     hauke@hauke-m.de, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        kuba@kernel.org, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v3 3/3] dt-bindings: net: dsa: lantiq: add xRx300 and xRX330 switch bindings
Date:   Sun, 21 Mar 2021 18:39:22 +0100
Message-Id: <20210321173922.2837-4-olek2@wp.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210321173922.2837-1-olek2@wp.pl>
References: <20210321173922.2837-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 694cc7d6ce3d37cab56c3578962be28b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [MZG2]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for xRX300 and xRX330 SoCs.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
index 886cbe8ffb38..e3829d3e480e 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
@@ -5,6 +5,10 @@ Required properties for GSWIP core:
 
 - compatible	: "lantiq,xrx200-gswip" for the embedded GSWIP in the
 		  xRX200 SoC
+		  "lantiq,xrx300-gswip" for the embedded GSWIP in the
+		  xRX300 SoC
+		  "lantiq,xrx330-gswip" for the embedded GSWIP in the
+		  xRX330 SoC
 - reg		: memory range of the GSWIP core registers
 		: memory range of the GSWIP MDIO registers
 		: memory range of the GSWIP MII registers
-- 
2.20.1

