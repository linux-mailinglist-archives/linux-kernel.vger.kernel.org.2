Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384143A836B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhFOO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:57:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62262 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhFOO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623768935; x=1655304935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVUuMLnGsuOIL+luQzRHwhsTJ0I1qWBUUGyiM+baYXE=;
  b=NHINu7IJr+W2qels076xCirHDYuYXUDuKr+gNHz/+y8Gqg1omU3F6nQ1
   qDitMvPPyHIDfEWwrTj5kdNPjLU4izgIgtFDjetkcDuQyDYzqdsmhhmMN
   NOXNcjWsqTVg9drjJQVGBYo3QZ1n2pL1+rCWLEf95kfbHkitMwW41uBTO
   D/e1YjwLtFNm/xwUR9LTJjcMgTG1O1x/RT3Pl9UBNmSoeW8WhOBpzXznx
   VbiqLjysv7zvRYlDYuD2KGexRh9mSO8UwDCMsCyjJQWs6QQfAx307RRPT
   H1eMCcE34os95gKPQZIMXi13AovLer3aVZSuCrWubzPW9LuNASQFe3G8M
   g==;
IronPort-SDR: ByL2jc/ubpdZY3OSHmaoG9qDvfrxc8wQzIg1Fju3x6ql6ewVk4iIvpAeMj0o/bu3Ke4dokPxCj
 +vFRXK4PTO4QNmwS10UFpSioKW9e7vHkQAN5Iq2sDb3PHSGpvG48CIBZCjElzIAxsqWoOaYpji
 IR+DyVfTESFx2dkY2hvj1NjSGr4idCWSQ4u9vMixMX04a/q6Vbyky4B3uXmLKfe3Ri0v+y+Ksi
 OSy8hifxRoLh6pxz1WTYPM7V4g16O0ms8IKgLT8neJH4m1G72WSg9gCYJiKsczVIgZSDYmMsoG
 y7Y=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="171974926"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 22:55:35 +0800
IronPort-SDR: p0BWq5D6YQ7qv0s7lDzFTwZ5zb8w+He3MMNJuBwQQFMuupOidASPj4xKpnCt0S2mVYG8P/6LBb
 pyArZvTBqpWUKywrjFwZ/zXOaw40KtoIRad2a/bvoWns/fJNxLPcW5ExD8tBALG4ZxXULCkO6D
 fXj+zlxMQmsY8Ug8v+2RlDMggzx0JA2O0v1smApGWapUr9PBIXJh9moa3wHjVG4tR1XOY/m2bH
 oFjBuODAWjz3hjreY9+zRIhndBaGZWHFFABguterzIhnePVA9XJf4oviix8sjV6/WVWr79FmWd
 aJfJYx5at6mnBgk/Dy8bofSl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:33:06 -0700
IronPort-SDR: xvX7noCKpyz7UVKBZNDQZoW5fe/h/htOsun4spIaVBtAUlj4NRMXowr79hG/DB8tffMOugMwF4
 JOPyLlBQziWRBy4YJ+E5RtdZFNdyqjOPpE3zQ43IroIstx9aLqhxskSg1T0n0K68MhAgzCyRWV
 oq+5Q6pM1omxRa98y/QZ7BlQZPIRetXeNomAB6JXLTtV1MoRer+0lP9C1Voe+m8r76uNRMUh1D
 tgBgDr2RWy+fnx/ppvlYbhJnwLNnImzVZQ+XRR7WIs5zmkU8grpu3eXEL+q4GSid7Is8Ekq1hY
 Ryc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2021 07:55:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/3] mcb: Use DEFINE_RES_MEM() to simplify code
Date:   Tue, 15 Jun 2021 23:55:28 +0900
Message-Id: <1eefa01948355a890b18a68c1eb6a90dc9dc6a87.1623768541.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623768541.git.johannes.thumshirn@wdc.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The value of '.end' should be "start + size - 1". So the previous writing
should have omitted subtracted 1.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-lpc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 506676754538..53decd89876e 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
 	return ret;
 }
 
-static struct resource sc24_fpga_resource = {
-	.start = 0xe000e000,
-	.end = 0xe000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
-
-static struct resource sc31_fpga_resource = {
-	.start = 0xf000e000,
-	.end = 0xf000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
+static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
+static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);
 
 static struct platform_driver mcb_lpc_driver = {
 	.driver		= {
-- 
2.31.1

