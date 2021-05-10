Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F7379133
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhEJOpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:45:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49630 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbhEJOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:44:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDxN050709;
        Mon, 10 May 2021 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620657793;
        bh=jVe7gI6Q5hdiAjiuDelq2TLB0qnXfcHkmNIu8ilhMP8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NINyTEOfzKZmAIHOcKsAd2huy8Q/lkRmhenMpRujsuOP4CUXf5z2d5o2/y1ns1Zm4
         PB1ygrPQ1y1QOpto0zYW37uueHQHVtdNIFp5hnxFz34j8wJhyKqyIeLZYe5/eZGIUp
         znNTObcbirnPMmd5ug8bBlEpmgKZuV0+4pBLcLeo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEhDh0073655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:43:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:43:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:43:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDjh098895;
        Mon, 10 May 2021 09:43:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] ARM: dts: keystone: k2g: Rename the TI-SCI node
Date:   Mon, 10 May 2021 09:43:10 -0500
Message-ID: <20210510144312.986-3-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510144312.986-1-nm@ti.com>
References: <20210510144312.986-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets rename the node name of TI-SCI node to be system-controller as it
is a better standardized name for the function that TI-SCI plays in
the SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

yaml fixup series:
https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org

Specific yaml:
https://lore.kernel.org/linux-arm-kernel/20210426155457.21221-5-nm@ti.com/

 arch/arm/boot/dts/keystone-k2g.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index e5c813b5556d..d7fc6057ca41 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -254,7 +254,7 @@ msgmgr: mailbox@2a00000 {
 				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pmmc: pmmc@2921c00 {
+		pmmc: system-controller@2921c00 {
 			compatible = "ti,k2g-sci";
 			/*
 			 * In case of rare platforms that does not use k2g as
-- 
2.31.0

