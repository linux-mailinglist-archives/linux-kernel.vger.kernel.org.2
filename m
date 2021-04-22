Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96956367D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhDVJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:02:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51236 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhDVJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:02:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M8xue2163355;
        Thu, 22 Apr 2021 09:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+DyWdORbB7Ede6TpRJ/COaO5LuAEsT1iyov80SfV6MA=;
 b=RkvrseLlIi8ldTQhwyIm+Iz9Av0wjYrAK5/iK7kJ1Z8i0zDRDeI5CVvQkTWM48BxPu+a
 PXj+ltiJ34XvhKIuApEbAUSTH9aNrYq08atDtbKtuwzLmb5pzBHlozdP6XHRKVStazcK
 WGqvQkzKXLbV7tDh7q0jWuE4YS3w8Dlnsn1o+BEYwcR6eCXuv4AhRXygD2c2az2J1mTH
 caBAmzd1QLibZYm9zOwmMThANcxVYcTOo+ds+nhu7L7uEcYjT2+xnGLUIur2hFT35Y7D
 6gdA8DALMwR7vxMTo4A3pDY3Mk9sW4AaC9Qpib6ITCkK49KGnc3tGyqjekq9OaVlk1rk rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37yn6cct5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:01:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M90tuB109723;
        Thu, 22 Apr 2021 09:01:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m1wnbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:01:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M915OF110866;
        Thu, 22 Apr 2021 09:01:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3809m1wnbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:01:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13M912IR018219;
        Thu, 22 Apr 2021 09:01:02 GMT
Received: from mwanda (/10.175.205.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 02:01:01 -0700
Date:   Thu, 22 Apr 2021 12:00:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: gadget: prevent a ternary sign expansion bug
Message-ID: <YIE7RrBPLWc3XtMg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: YYEUKkGAQil2fRn5kdTJJMwDAOkMSuAT
X-Proofpoint-ORIG-GUID: YYEUKkGAQil2fRn5kdTJJMwDAOkMSuAT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxlogscore=944 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that "req->actual" is a u32, "req->status" is an int, and
iocb->ki_complete() takes a long.  We would expect that a negative error
code in "req->status" would translate to a negative long value.

But what actually happens is that because "req->actual" is a u32, the
error codes is type promoted to a high positive value and then remains
a positive value when it is cast to long.  (No sign expansion).

We can fix this by casting "req->status" to long.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/gadget/legacy/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 71e7d10dd76b..cd8e2737947b 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -498,7 +498,8 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		iocb->private = NULL;
 		/* aio_complete() reports bytes-transferred _and_ faults */
 
-		iocb->ki_complete(iocb, req->actual ? req->actual : req->status,
+		iocb->ki_complete(iocb,
+				req->actual ? req->actual : (long)req->status,
 				req->status);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
-- 
2.30.2

