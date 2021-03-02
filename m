Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94F32A4EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383430AbhCBLfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:35:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838813AbhCBLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:19:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122BF7vd146712;
        Tue, 2 Mar 2021 11:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=814zCU+jbtYbxBBfpFjuVjzIdDrMYHR5u+Tdz4KtzyA=;
 b=WHnM18Pv9MMbBNIweEMKyRoYOxGZ6EoRlOraoOXC5f2rMQPZ1E2xV+0OI1Mo+D5R0cRJ
 mc4Xyy2Nd/rV3tyqlEwXx8Hp4dVFHrUTwILsO+L8uwp2R5c8icHzXfVj25iNy593LwIR
 SlgpPa0NZYJr357NTY2FOoo56PbbB5gmxcMTUbpdbptrN2I6mfCwNivRM7fyNsdT1jY6
 nFa5p4WDpciRwSekqaKiFNTbtldUfzIrMmODt6lK70l9zLpkXe1xE46Yee7oSQjCmnOY
 rZsnjzLWMX/O4JaUYBVkDnc5oQHvUwhrZlOg0Hcjs3wdxWgGYAXQ00DUuslJWRJCdKp4 Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqmy5bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 11:18:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122BEwnv011942;
        Tue, 2 Mar 2021 11:18:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36yynp0jju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 11:18:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 122BILGP005022;
        Tue, 2 Mar 2021 11:18:21 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 03:18:20 -0800
Date:   Tue, 2 Mar 2021 14:18:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firewire: prevent integer overflow on 32bit systems
Message-ID: <YD4e9XOD8JPlJzxW@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TCODE_STREAM_DATA mode, on 32bit systems, the "sizeof(*e) +
request->length" operation can overflow leading to memory corruption.

Fixes: 18e9b10fcdc0 ("firewire: cdev: add closure to async stream ioctl")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/firewire/core-cdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..314de0384035 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -587,6 +587,9 @@ static int init_request(struct client *client,
 	    request->length < 4)
 		return -EINVAL;
 
+	if (request->length > ULONG_MAX - sizeof(*e))
+		return -EINVAL;
+
 	e = kmalloc(sizeof(*e) + request->length, GFP_KERNEL);
 	if (e == NULL)
 		return -ENOMEM;
-- 
2.30.1

