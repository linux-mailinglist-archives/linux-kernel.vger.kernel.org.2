Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18EC35EEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349639AbhDNHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:45:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44906 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhDNHpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:45:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7iYh7070282;
        Wed, 14 Apr 2021 07:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YYpWT+54DiKG1mpTtvWPuyxWI9sWMxE6oWl1mUNmwaQ=;
 b=HCAKevP6LQXNzXzhEedvKuNgDJGg5J7CQYGr1LiGN9n5CT7YXrVL/JENDKs5emz/CRT3
 NbgtjzAGsCfs6iJoF7YxkDjb2yi5K/0984VNaeUXyTiUCICiZ4EwQ9oXBbXdh4lmfrpe
 AQzgewFd+oG0M38MJvcZ8P3ks6tJcTZvCKs1oJc0HLDFIMLdqvhjbGUjSY9JWz8VVi3O
 Kp6YuY3ysnoNu5Z49m+vog/wOpN/PLIN0DUmAHxXOVFeERdw8ZGBkRyEh2OhlWukr0ee
 nT7hLeEPPHaMNmgPeT0SKctrylyT2mv9fRAySWEgATPgr4ab9p8Ih4cTsBHPSsMlSO7X Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymhe23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:44:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7aSWA121769;
        Wed, 14 Apr 2021 07:44:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37unxy0ykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:44:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E7ikTf028859;
        Wed, 14 Apr 2021 07:44:46 GMT
Received: from mwanda (/10.175.166.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 00:44:45 -0700
Date:   Wed, 14 Apr 2021 10:44:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: typec: silence a static checker warning
Message-ID: <YHadaACH8Mq/10F7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140051
X-Proofpoint-GUID: poEY082I-9YxXb2AuSj0ebG01W9PIzAv
X-Proofpoint-ORIG-GUID: poEY082I-9YxXb2AuSj0ebG01W9PIzAv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains about a potential missing error code:

    drivers/usb/typec/port-mapper.c:168 typec_link_port()
    warn: missing error code 'ret'

This is a false positive and returning zero is intentional.  Let's
re-arrange the code to silence the warning and make the intent more
clear.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/typec/port-mapper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index fae736eb0601..9b0991bdf391 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -157,15 +157,17 @@ int typec_link_port(struct device *port)
 {
 	struct device *connector;
 	struct port_node *node;
-	int ret = 0;
+	int ret;
 
 	node = create_port_node(port);
 	if (IS_ERR(node))
 		return PTR_ERR(node);
 
 	connector = find_connector(node);
-	if (!connector)
+	if (!connector) {
+		ret = 0;
 		goto remove_node;
+	}
 
 	ret = link_port(to_typec_port(connector), node);
 	if (ret)
-- 
2.30.2

