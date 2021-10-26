Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A943B609
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhJZPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:51:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236994AbhJZPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:51:00 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QFC8TH014888;
        Tue, 26 Oct 2021 17:48:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Z4tfzYw9eG2voXHJI5ARvyFBLH00E40u2YN2hzN5tg8=;
 b=VQ5nMSkpJtvX3Z/QafgaV8pPl1N/XYcPzuK29C80bQRADauKVHjo7m6sWzDeGnp4lzwc
 EsgMvP0R1RYf9PFNIiW4KyXSFU5LGSzhWspUD7nZ4ix9gW2SK6vME6EzIoPlYooOM5gl
 Gc/t7t5sxWlj6fjsBJ/qGqKoofNUIEsJU49UxkRDAXD2EwE4JBozoOAu+DqfkG38Camz
 domycwJsTx+CO1Dogr/3j/CoYkJxnQhpfANweJr34cQCB3uh6XV37O10pybb7+WUQ50Z
 uBz4Ih1L4MdvlLtOrC8PBJ62o4vv6gRIdJGNyM9dn65mGvGETN4NxoZ7X36sdBn3MMaL dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bxm40r8hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 17:48:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 67987100034;
        Tue, 26 Oct 2021 17:48:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F39524FDE1;
        Tue, 26 Oct 2021 17:48:18 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 26 Oct 2021 17:48:18
 +0200
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] phy: stm32: fix st,slow-hs-slew-rate with st,decrease-hs-slew-rate
Date:   Tue, 26 Oct 2021 17:48:17 +0200
Message-ID: <20211026154817.198937-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_04,2021-10-26_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st,decrease-hs-slew-rate is described in phy-stm32-usbphyc.yaml. Then
fix the property name in driver.

Fixes: 2f5e9f815a2f ("phy: stm32: add phy tuning support")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 7df6a63ad37b..e4f4a9be5132 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -478,7 +478,7 @@ static void stm32_usbphyc_phy_tuning(struct stm32_usbphyc *usbphyc,
 	if (!of_property_read_bool(np, "st,no-lsfs-fb-cap"))
 		usbphyc_phy->tune |= LFSCAPEN;
 
-	if (of_property_read_bool(np, "st,slow-hs-slew-rate"))
+	if (of_property_read_bool(np, "st,decrease-hs-slew-rate"))
 		usbphyc_phy->tune |= HSDRVSLEW;
 
 	ret = of_property_read_u32(np, "st,tune-hs-dc-level", &val);
-- 
2.25.1

