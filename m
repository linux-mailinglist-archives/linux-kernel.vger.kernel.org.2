Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4547D389092
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347629AbhESOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:20:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354066AbhESOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:19:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEF9S0101727;
        Wed, 19 May 2021 14:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=3N0UDr8fp/rROWpaUFSOnbPEWFC1lCojv6j2aMf4zHY=;
 b=IffCIAR0qn7rYRPWwUZlSa5i7x5lpIzo+wqkYYxxq5NSLm1Ft0UfJ9L1kYk6HqeJmNjE
 WVhCX3+28DAYd8060//bo79+PIi5ZnxoWRjWPIrHdOL0B1mMzXM82I0XMN9507w9w1Rx
 tA4BUePtbhxBJxRRquqESAmef1zBkiw3thanHaxjSWArg73eJl03k/jSQpRmnwXCndl1
 mn1u9bkBCayc4GKOH09AjU2RD9l9JP0ddEeQmjLAkchVhcC1qNA15Q/0cx5L2WfBQSPl
 szGWiN8yNqrbm/TiTiFEkh8Sjia/Qf4R5QbBAS1vZsw1MqvO50Bi5b4C3i/7ZW5AqG5z aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38j6xnhnxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JEC4xK028409;
        Wed, 19 May 2021 14:18:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38mecjb8qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:14 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JEFewt070836;
        Wed, 19 May 2021 14:18:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38mecjb8np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 14:18:14 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14JEIBxX031464;
        Wed, 19 May 2021 14:18:12 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 07:18:10 -0700
Date:   Wed, 19 May 2021 17:17:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] w1: fix loop in w1_fini()
Message-ID: <YKUeCfjQqt5NuSta@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518082855.GB32682@kadam>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: A5jfNBGAkI2EWzceDpCJO9nvvs7mwSYj
X-Proofpoint-ORIG-GUID: A5jfNBGAkI2EWzceDpCJO9nvvs7mwSYj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=936 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __w1_remove_master_device() function calls:

	list_del(&dev->w1_master_entry);

So presumably this can cause an endless loop.

Fixes: 7785925dd8e0 ("[PATCH] w1: cleanups.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/w1/w1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..8b2d82959ded 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1259,10 +1259,10 @@ static int __init w1_init(void)
 
 static void __exit w1_fini(void)
 {
-	struct w1_master *dev;
+	struct w1_master *dev, *n;
 
 	/* Set netlink removal messages and some cleanup */
-	list_for_each_entry(dev, &w1_masters, w1_master_entry)
+	list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry)
 		__w1_remove_master_device(dev);
 
 	w1_fini_netlink();
-- 
2.30.2

