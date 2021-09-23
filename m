Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB48E4165BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbhIWTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:12:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55256 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbhIWTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:12:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18NJAUT2012502;
        Thu, 23 Sep 2021 14:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632424230;
        bh=zubgOhvYt3kRD8V9aXMUQ5+bNfhGbwJuJ3zX+oDpLuI=;
        h=From:To:CC:Subject:Date;
        b=w/BwgMyHFDaSPiXugZArYYBx+e1WHxn9e+K49gG6W1+Fu0azZvZnvsOEhaFjU56ve
         4A3ABzNds+qjJ2NDXNOIs08+Ii2nwSyoLSSQaQ+394D8eBPEJlPKpy8ODmo0YfhZ7s
         8akrSeG3nLf7aMBJv1yEbYH0FHw2WfBfyzCyzK2g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18NJAUDk061962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Sep 2021 14:10:30 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Sep 2021 14:10:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Sep 2021 14:10:30 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18NJARXk011208;
        Thu, 23 Sep 2021 14:10:28 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH] MAINTAINERS: Add spi-nor device tree binding under SPI NOR maintainers
Date:   Fri, 24 Sep 2021 00:40:26 +0530
Message-ID: <20210923191026.19184-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding is for the SPI NOR subsystem so the patches should be sent
to its maintainers. Currently the patches get sent to Rob Herring and
MTD maintainers who might not always have the full picture.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bfdb06fe2b3..d64912d7e9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17745,6 +17745,7 @@ W:	http://www.linux-mtd.infradead.org/
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
+F:	Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
 F:	drivers/mtd/spi-nor/
 F:	include/linux/mtd/spi-nor.h
 
-- 
2.33.0

