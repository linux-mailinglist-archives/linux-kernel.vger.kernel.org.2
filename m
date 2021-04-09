Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263D1359C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDILCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:02:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56514 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhDILC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:02:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139AxYRc168460;
        Fri, 9 Apr 2021 11:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mz2y+XnikZJZelZ8GaE85MKQb8nXj/w5re61cvsAJWo=;
 b=DviYCbympS7wfZOEIuCGnZ827ut9eF8mSoxcswxZXjrWBbO+gXYCLyo/V0+uN52NMm+D
 nh3STcb25UkA+9l7oOAx/R6nMLdVyCm8EtjruF/UUxgyAv9dKnZtHFjTIuVqkO3uBvWe
 V/ajIoJ2wj5jg6zsDSDyGGizO8LSW3zz52sPWAQG8UEb0uDSf8sEQXKj6xz4kDaI9XPh
 2Mr+O852se+330oX8hehCOnafKwSINP2Ahw90qMnRnn5RJj3BSb54nZZogt//q0D6v7s
 jq2cR/ody9Ofv6h/Z3mmWaBqAjjbALICgyeEY6Q4+hbjm9Y+/AfL0DOh+7LRTxTgy816 Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37rva690xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 11:02:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139B07dZ130627;
        Fri, 9 Apr 2021 11:02:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37rvbgw6d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 11:02:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 139B24R8007388;
        Fri, 9 Apr 2021 11:02:05 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 04:02:04 -0700
Date:   Fri, 9 Apr 2021 14:01:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] node: fix device cleanups in error handling code
Message-ID: <YHA0JUra+F64+NpB@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090080
X-Proofpoint-GUID: vRiJKWlUc4kC8qyZ7XayenFg1K8G50zE
X-Proofpoint-ORIG-GUID: vRiJKWlUc4kC8qyZ7XayenFg1K8G50zE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use kfree() to free device managed resources so the kfree(dev)
is against the rules.

It's easier to write this code if we open code the device_register() as
a device_initialize() and device_add().  That way if dev_set_name() set
name fails we can call put_device() and it will clean up correctly.

Fixes: acc02a109b04 ("node: Add memory-side caching attributes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/base/node.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c746..2c36f61d30bc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -268,21 +268,20 @@ static void node_init_cache_dev(struct node *node)
 	if (!dev)
 		return;
 
+	device_initialize(dev);
 	dev->parent = &node->dev;
 	dev->release = node_cache_release;
 	if (dev_set_name(dev, "memory_side_cache"))
-		goto free_dev;
+		goto put_device;
 
-	if (device_register(dev))
-		goto free_name;
+	if (device_add(dev))
+		goto put_device;
 
 	pm_runtime_no_callbacks(dev);
 	node->cache_dev = dev;
 	return;
-free_name:
-	kfree_const(dev->kobj.name);
-free_dev:
-	kfree(dev);
+put_device:
+	put_device(dev);
 }
 
 /**
@@ -319,25 +318,24 @@ void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
 		return;
 
 	dev = &info->dev;
+	device_initialize(dev);
 	dev->parent = node->cache_dev;
 	dev->release = node_cacheinfo_release;
 	dev->groups = cache_groups;
 	if (dev_set_name(dev, "index%d", cache_attrs->level))
-		goto free_cache;
+		goto put_device;
 
 	info->cache_attrs = *cache_attrs;
-	if (device_register(dev)) {
+	if (device_add(dev)) {
 		dev_warn(&node->dev, "failed to add cache level:%d\n",
 			 cache_attrs->level);
-		goto free_name;
+		goto put_device;
 	}
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&info->node, &node->cache_attrs);
 	return;
-free_name:
-	kfree_const(dev->kobj.name);
-free_cache:
-	kfree(info);
+put_device:
+	put_device(dev);
 }
 
 static void node_remove_caches(struct node *node)
-- 
2.30.2

