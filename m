Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10259316480
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhBJLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:01:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44170 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhBJK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:58:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AAsC4H051795;
        Wed, 10 Feb 2021 10:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=r9UR4B24XVHVTdPlYrUE5hZen0PMrHh0j4KOUgCfPbE=;
 b=G0evvRgefLZiAQrKqdSv7IlOKlga+Sc1jNzwyfrYT83PYk7RJNzK4ViK7odINfv+YXoY
 GmgOZvOTqwF4PjPDKDiN98rqD0nF8emC8XioBWtJc22isgl+IlPw1ak1UttJ5DO/49pP
 CtSjg/36OYQz9x1/rsRjDB2HVY/1dMy2vsu35iKAG9z/Mtl/KSSpOZ2yPPFbU64e7w1h
 TkArsRYzelEZwzmklpaZBc05Iq7EVkygQ0RnPB2L1VPXibrvlZv5jsy/bZzDr3ic6oSy
 ZZPfAN2//5t7U8WifknlwMWuE0nEkMJPYvC2dZQx7hM1EkdICvmAQAHzJpgau8sQlv9L AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmak26k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:57:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AAuE7Z187809;
        Wed, 10 Feb 2021 10:57:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36j4pq05m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:57:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11AAvEEc018879;
        Wed, 10 Feb 2021 10:57:15 GMT
Received: from mwanda (/10.175.183.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 02:57:14 -0800
Date:   Wed, 10 Feb 2021 13:57:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] module: potential uninitialized return in
 module_kallsyms_on_each_symbol()
Message-ID: <YCO8AwE57IzaMamG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:

	kernel/module.c:4472 module_kallsyms_on_each_symbol()
        error: uninitialized symbol 'ret'.

This warning looks like it could be correct if the &modules list is
empty.

Fixes: 013c1667cf78 ("kallsyms: refactor {,module_}kallsyms_on_each_symbol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 95186c9d81ea..9bd3c821d029 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4447,7 +4447,7 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 {
 	struct module *mod;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&module_mutex);
 	list_for_each_entry(mod, &modules, list) {
-- 
2.30.0

