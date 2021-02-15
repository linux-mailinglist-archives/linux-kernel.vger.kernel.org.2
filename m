Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398831C04E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhBORRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:17:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhBOP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:59:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFoBbm121923;
        Mon, 15 Feb 2021 15:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DgV2X2itjEB7vni0gXukDnNbihcxKMHYwvnAV8Y5ZW8=;
 b=EL0iVfkq1vNYRZFLSUH2rjenEeqBfKzNfUxXiC/06vxI6qTYBHz9uH1jdyRZ1z4d+3oj
 0nvSeEKZRNzN7K+Pl9ILwppJuOcxGwkCBFgujG41f7Uf+CbdIbat0PQ8DRwagP+yYVxU
 uIHoX6IvB2UB7ybh8+9edGcShCzJx1IKaWoiuIfzhHZ1LjO654yK3/bxqiMP6itrqbju
 A97eYzH4gcHcFOrZQ/Ltsp3nhnnfRH1SqYeize2t4gUFl/i0soE6kIaHG9qA5/mXHg2q
 xD5Neo5cW3zbymz/zOxbjtcVkZz3TKpozZ//NqYkB4UOwNdeE8ZFztbB4HL2yuUFDosx vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36p7dnccjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 15:57:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFnv1M009643;
        Mon, 15 Feb 2021 15:57:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36prpvsdnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 15:57:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11FFvQmt002562;
        Mon, 15 Feb 2021 15:57:26 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 07:57:25 -0800
Date:   Mon, 15 Feb 2021 18:57:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        David Lechner <david@lechnology.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] USB: gadget: Fix a configfs return code
Message-ID: <YCqZ3P53yyIg5cn7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=994
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=931
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the string is invalid, this should return -EINVAL instead of 0.

Fixes: 73517cf49bd4 ("usb: gadget: add RNDIS configfs options for class/subclass/protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/gadget/function/u_ether_configfs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether_configfs.h b/drivers/usb/gadget/function/u_ether_configfs.h
index 3dfb460908fa..f558c3139ebe 100644
--- a/drivers/usb/gadget/function/u_ether_configfs.h
+++ b/drivers/usb/gadget/function/u_ether_configfs.h
@@ -182,12 +182,11 @@ out:									\
 						size_t len)		\
 	{								\
 		struct f_##_f_##_opts *opts = to_f_##_f_##_opts(item);	\
-		int ret;						\
+		int ret = -EINVAL;					\
 		u8 val;							\
 									\
 		mutex_lock(&opts->lock);				\
-		ret = sscanf(page, "%02hhx", &val);			\
-		if (ret > 0) {						\
+		if (sscanf(page, "%02hhx", &val) > 0) {			\
 			opts->_n_ = val;				\
 			ret = len;					\
 		}							\
-- 
2.30.0

