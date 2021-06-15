Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813143A836C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhFOO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:57:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62265 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFOO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623768936; x=1655304936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsV4VNn+dZe1tkBalNemzPSjzjiInUEt/6cyVt3/JMM=;
  b=aPojEvdxakXEGo1POa2l0d4lFY1tRXHx/okhveJ4d/kRRPNeMsXN/ItR
   s5MMMpJTcdz88IsPonyMl7u1sojIViZdjyPb59IZDEEFzi/zh2CBTxGI4
   C5d6ProV1dJW05W3+UtxqZvEftTtT9JTBcp7r5LBaDSYpGobAH/76uOzG
   kCKoTC7HcAipmZwX0VClaqutyk+f/uaTVMPDG95Hx5D5rxKj5Mu17HC3C
   WWXljh/4vnTCsIJMeLnJ/leO6L84OR6l3WAcPeLUz5eDZzo/ZMGO1A/2K
   H+KSd32u6z9nnotaL1ZzQVgzxNw/WeYaDemLhBnnkc2foucnAETMJntaQ
   Q==;
IronPort-SDR: WaSWgEDFE4709bwMglyA9GQO6YFwYJVJjwfhR0fmkyFUgCzPOKXHt/T6e9duoNYOxSErpYwcvL
 sisY236KAnOgtT1yN7xx94fPtPJ9q13Ipo8/huSN6ICU0mkeDb50rHXQEcvnwsA9pC9jusBCXN
 YnJ+HKqFKqnY5Z+6+FMvLmuTqZ++rriwrLpjaRrTbFD00/pw8n367KrPseBwsiwv9+ZaIemZaV
 dNu3VFkFv/I8rv0G5DHAUQNKWCtvTLx77idKGUAUmlaQhepf30IHATRTcDh/Vk90W/8Pn0sZ6J
 3+E=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="171974928"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 22:55:36 +0800
IronPort-SDR: uFhSKSXBh4LcXxQksj2nUgmOLp4zfkR8nNPQKwHG/mDNDWeQf7+M1c8f+wBiGaXSrpPz1X6+Gk
 a8JjSLuvwgSn1fjJzibBS9Vg2Ri2jz/z8DV5gT6W4s0JEKac16h9jjLsKIrAv0cI8umF14e9S5
 dMHw7sJd44CkKc3I7brZSSpJJh8TF36cI6SjyYoBV5JcV/W78UuuNEJLP2XA1WXA+P/tmUolpX
 9NOHUNapoHy2tnoCTHGLulbzCq3jiukjkkWOAgCPKSM+vEVQRFHN8wPV48L1VvOnzvGvkYuRuJ
 Xbwbd5Lka4oSv/XfkVpZ/m3/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:33:07 -0700
IronPort-SDR: lWuEZz0KTAEnVmAcbJrgB391xMsTk11rDcdFWlMkx3UDQJEwZjtQphdBRqnwngaBcp8ukpYeBt
 YB0M16y/kYdaPE9HF3Hh17QaxATWRUhjYP2oKGUBTgA6MS3YafLljBCrH6Vr54xKo7zwaHnvLM
 80B+37LrUVORIoHmwyaXWFOVIH15Lzv3vBMYRYv4rSqBdvqxHmHvYiWTJv51O+iFWrJG4AisFq
 UWfsa3NHWJmh/9j1zaYtIk4o3cEMuMRTMSf6YdT3NumKinJN0gvvOPNlg61nxNc07xtoD9Nal0
 Hik=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2021 07:55:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 2/3] mcb: fix error handling in mcb_alloc_bus()
Date:   Tue, 15 Jun 2021 23:55:29 +0900
Message-Id: <b2fa90594069aa3f61d4658603d922f097ce2bde.1623768541.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623768541.git.johannes.thumshirn@wdc.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

There are two bugs:
1) If ida_simple_get() fails then this code calls put_device(carrier)
   but we haven't yet called get_device(carrier) and probably that
   leads to a use after free.
2) After device_initialize() then we need to use put_device() to
   release the bus.  This will free the internal resources tied to the
   device and call mcb_free_bus() which will free the rest.

Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 38fbb3b59873..38cc8340e817 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -277,8 +277,8 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 
 	bus_nr = ida_simple_get(&mcb_ida, 0, 0, GFP_KERNEL);
 	if (bus_nr < 0) {
-		rc = bus_nr;
-		goto err_free;
+		kfree(bus);
+		return ERR_PTR(bus_nr);
 	}
 
 	bus->bus_nr = bus_nr;
@@ -293,12 +293,12 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 	dev_set_name(&bus->dev, "mcb:%d", bus_nr);
 	rc = device_add(&bus->dev);
 	if (rc)
-		goto err_free;
+		goto err_put;
 
 	return bus;
-err_free:
-	put_device(carrier);
-	kfree(bus);
+
+err_put:
+	put_device(&bus->dev);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_alloc_bus, MCB);
-- 
2.31.1

