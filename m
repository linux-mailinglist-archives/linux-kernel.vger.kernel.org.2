Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28A359CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhDILIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:08:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57790 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhDILIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:08:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139B4o1Q029316;
        Fri, 9 Apr 2021 11:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2ZMA5+AaVamT/hsJWd7Sm1OuibhcsV+raAQJ1eKQDV8=;
 b=bJm/2VgNC5x7cezt8+HlhKiTrpVlHrKXLlhfDi2QClAAeHt6e8ZbrQbiF9v7QCymGwd5
 40+2Y5J+d2LnwgZyKEo5TFtiDMBiDHvoTtq2TojA+oSWPcaqo1//s6D/0uaK8s0hd6xp
 /zgtxROuEKHQ55jTZyjmpsIGxkC5bQ4U8NPmKIxhV3dm1v4KD6pdvArU9t842SpFgo32
 cvx849czSf0xDGAS4LuGo1a3ibMuZ07y7lIO4f7hHf0b+fabfyueFLmZiR9dDK6GD2BD
 g7mIBzyLLp8BbGCL0QVrQAsHaCs/VhSjiCJH/eY0/vMmWL51ZOklM0jRzRTNeKrszH+z Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37rvagh2cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 11:08:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139B5Dl6133750;
        Fri, 9 Apr 2021 11:08:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37rvb2e0r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 11:08:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 139B8SBe011505;
        Fri, 9 Apr 2021 11:08:28 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 04:08:28 -0700
Date:   Fri, 9 Apr 2021 14:08:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] HSI: core: fix resource leaks in hsi_add_client_from_dt()
Message-ID: <YHA1ofdGOEiBGxzL@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090081
X-Proofpoint-GUID: -qDvEzAHYK671yJysi1G5t4S4_I0AIzF
X-Proofpoint-ORIG-GUID: -qDvEzAHYK671yJysi1G5t4S4_I0AIzF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some of the allocations fail between the dev_set_name() and the
device_register() then the name will not be freed.  Fix this by
moving dev_set_name() directly in front of the call to device_register().

Fixes: a2aa24734d9d ("HSI: Add common DT binding for HSI client devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Jason, this is the most common type of error I see with device_register().
Is there a downside to calling dev_set_name() later?  Presumably it's
printed out somewhere, but I feel like just moving the dev_set_name() is
almost always the best and simplest fix.

 drivers/hsi/hsi_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index c3fb5beb846e..ec90713564e3 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -210,8 +210,6 @@ static void hsi_add_client_from_dt(struct hsi_port *port,
 	if (err)
 		goto err;
 
-	dev_set_name(&cl->device, "%s", name);
-
 	err = hsi_of_property_parse_mode(client, "hsi-mode", &mode);
 	if (err) {
 		err = hsi_of_property_parse_mode(client, "hsi-rx-mode",
@@ -293,6 +291,7 @@ static void hsi_add_client_from_dt(struct hsi_port *port,
 	cl->device.release = hsi_client_release;
 	cl->device.of_node = client;
 
+	dev_set_name(&cl->device, "%s", name);
 	if (device_register(&cl->device) < 0) {
 		pr_err("hsi: failed to register client: %s\n", name);
 		put_device(&cl->device);
-- 
2.30.2

