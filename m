Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADC340681
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCRNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:10:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37604 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhCRNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:09:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ID4QcE065919;
        Thu, 18 Mar 2021 13:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qhivaSffjcPONjbtNTtUJv8Md5/DStyaFkCE2sLu96s=;
 b=wISeVLclV+h9kAkrAuA4YbGccKorpd1oMg3pfgwkoaz6rjR6rlZeJNCYD0rV0niFz8pK
 peREuocj0aOiJNlSnG/kRzxelbAfyxcp2iPEfOgu27qW8msLhNov1wVNUkxj4ropBjOG
 KpOAQJOeu3s2oHVsMxRIh8gukSIoKnMoOopwBwlXa7bazMOwwCZgdMNLontey2gX0Uma
 OY4O9FsEVfHTJkB7LK90iJNReCL5H8HeCtC21ztUAd8vmEsRjsIxs6Mzt8mxGyYg6iyQ
 aizU2YKhPkCPyqnuEa5Lm41FiVwMG/lKntU7dG6qD7RcmvNetKe12LGWakjAtyUVlM1T aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekvbu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:09:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ID67hj027727;
        Thu, 18 Mar 2021 13:09:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3797b2wju1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 13:09:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12ID9jKJ031311;
        Thu, 18 Mar 2021 13:09:45 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Mar 2021 06:09:44 -0700
Date:   Thu, 18 Mar 2021 16:09:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cifsd: fix a IS_ERR() vs NULL bug
Message-ID: <YFNREQvcyecq3NMp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smb_direct_alloc_sendmsg() function never returns NULL, it only
returns error pointers so the check needs to be updated.

Fixes: cabcebc31de4 ("cifsd: introduce SMB3 kernel server")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/cifsd/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifsd/transport_rdma.c b/fs/cifsd/transport_rdma.c
index 1698f7ed9c2f..638b551019a1 100644
--- a/fs/cifsd/transport_rdma.c
+++ b/fs/cifsd/transport_rdma.c
@@ -997,8 +997,8 @@ static int smb_direct_create_header(struct smb_direct_transport *t,
 	int ret;
 
 	sendmsg = smb_direct_alloc_sendmsg(t);
-	if (!sendmsg)
-		return -ENOMEM;
+	if (IS_ERR(sendmsg))
+		return PTR_ERR(sendmsg);
 
 	/* Fill in the packet header */
 	packet = (struct smb_direct_data_transfer *)sendmsg->packet;
-- 
2.30.2

