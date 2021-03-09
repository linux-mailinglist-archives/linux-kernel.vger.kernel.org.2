Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF42332B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhCIQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:07:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60202 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhCIQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:07:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129Fra1f124120;
        Tue, 9 Mar 2021 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=b5dVdoI7QKOmhvlb6MzN5U9RU3I4t3hNEqEOjp5BgBA=;
 b=ut3AgnFMRDb2vT/2Uu+wpFUpa8Tlu080teWQp5ScnFNOJvtnXN9gIHodjoK1CmDxBEMg
 JYAZJijU2K+NY0vSXomRh5hu8xXdkxoZiZt7x+E/+HygkBifMqhPD5r8v/CksryQW8cS
 b7kJm6qIPNB4NDQhpUFMN/XoYhDjA3dqKYCB5k2e+z7jr6PptkUQ7b+gF8wPOT1FvHHD
 Dn+h8NQ7L32KPUF0Y2UNKZt0nMBlf7NUHm3O3gfmp0+DkdvJxZ5MW6ipks+r/67uel3u
 VhVVwsMN9Lkm7+ZraGYxxK+NAzKgkBuxu7Te7tjTefMaT5RuD8hQx34cvQtZd1bZinCr HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 373y8br0ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 16:07:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 129Fsxo0078429;
        Tue, 9 Mar 2021 16:07:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 374kgs0yxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 16:07:04 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 129G70Ku012258;
        Tue, 9 Mar 2021 16:07:00 GMT
Received: from mwanda (/10.175.175.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Mar 2021 08:06:59 -0800
Date:   Tue, 9 Mar 2021 19:06:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Shimahara <akira215corp@gmail.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] w1: w1_therm: use clamp() in int_to_short()
Message-ID: <YEedHNwqEH8fvjkD@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's slightly cleaner to use the clamp() macro instead of open coding
this.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/w1/slaves/w1_therm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 976eea28f268..ad47c164bc05 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -906,8 +906,7 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
 static inline s8 int_to_short(int i)
 {
 	/* Prepare to cast to short by eliminating out of range values */
-	i = i > MAX_TEMP ? MAX_TEMP : i;
-	i = i < MIN_TEMP ? MIN_TEMP : i;
+	i = clamp(i, MIN_TEMP, MAX_TEMP);
 	return (s8) i;
 }
 
-- 
2.30.1

