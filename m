Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2939702E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhFAJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:20:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8168 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhFAJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:20:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1519BpjQ026536;
        Tue, 1 Jun 2021 09:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=reRDu9GsUx7OwMLhwupNf1qTcQUsoNQo5MgHhqoJ5Ic=;
 b=uVTpfE/JHdH5s5grBCdnGQZH6BE1sryIqfsXRfucNqabItAagmtfg4LRAKdCc1qEggyS
 yBq7zUsJp36BZ5pxZP4ePsI4F6VgEuJPuUtV3ty48Gm/kzIQW2gb8yyiB2uWEjGRWYVR
 r2x8fcRMhYcl59A3HXBUYtVaHb08gYdjWXQQNDTVqghKlDRh6JC1Exy25PBNZfc79yDm
 NuQTdOUZd5iEnS/XQNi20Uaqrl+M0kTlyS8ZEeUdonY5WdNEayP4jpC4VB4oVrt6/N9h
 GE3f6PPruadCukJk3/cczGM9fa93aIwM/WDF5FabSdWRk+HrVUtfFYqY+h039gFOmmjz hQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vtymgdpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:18:48 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1519Il6p077205;
        Tue, 1 Jun 2021 09:18:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38uycr3xq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:18:47 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1519IlIN077190;
        Tue, 1 Jun 2021 09:18:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38uycr3xp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:18:47 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1519IjxZ014314;
        Tue, 1 Jun 2021 09:18:45 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 02:18:45 -0700
Date:   Tue, 1 Jun 2021 12:18:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Werner <andreas.werner@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mcb: fix error handling in mcb_alloc_bus()
Message-ID: <YLX7bAD4UPCpIBmq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: C0mKEQ2aivBmcgqrsSKmDC84IE6-OHBv
X-Proofpoint-ORIG-GUID: C0mKEQ2aivBmcgqrsSKmDC84IE6-OHBv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.30.2

