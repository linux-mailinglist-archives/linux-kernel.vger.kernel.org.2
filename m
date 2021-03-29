Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CC34C385
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhC2GIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:08:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2GHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:07:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T5t53r148370;
        Mon, 29 Mar 2021 06:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mOopXmFZc3N/7ZeLtL2vh5si5JzJ5ybMrlOHvDseLQs=;
 b=fe0L7l0iwIWiCBIK4kdmiLZc7kTpanW0vZXP46OiuXn2lYC2j9f/wxAD0+0pCD85bVnZ
 6qgy1o/lssf3+xdvrvvkwtscSpp/1gEUzGa60QUM/2LrtC9CzxI0U+OI8aoosbb4lv8u
 G+0nuBZadvm7VhgZkj1jAGYfMzYo+DmJNWRf8zuWA1MGeKr3E272xtEk4VSYfOnkepZM
 zmdeSoJmYousJFIYQeUABEzo+Iezv8XTo658VHMekLHK3w1BgRUad6p9T35KkPJPAfPM
 1JS5b8fkPqJ7zmz3zuGTy33QLh73jwupvIeX11WwhpYR4M2PSJYH29NPGuzXLwsa5Gyt Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37hv4r2bqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 06:07:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T5tMun117009;
        Mon, 29 Mar 2021 06:07:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37jemv9wb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 06:07:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12T67Ri9013425;
        Mon, 29 Mar 2021 06:07:27 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 28 Mar 2021 23:07:26 -0700
Date:   Mon, 29 Mar 2021 09:07:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <YGFulvAa5Kz6HTsd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290047
X-Proofpoint-ORIG-GUID: f4YMGlPH_E86zyyj2k4ZSIveVt9aJHu2
X-Proofpoint-GUID: f4YMGlPH_E86zyyj2k4ZSIveVt9aJHu2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the device_register() succeeds, then the correct way to clean up
is to call device_unregister().  The unregister calls both device_del()
and device_put().  Since this code was only device_del() it results in
a memory leak.

Fixes: dacb12877d92 ("thunderbolt: Add support for on-board retimers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from a new static checker warning.  Not tested.  With new
warnings it's also possible that I have misunderstood something
fundamental so review carefully etc.

 drivers/thunderbolt/retimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 620bcf586ee2..7a5d61604c8b 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -347,7 +347,7 @@ static int tb_retimer_add(struct tb_port *port, u8 index, u32 auth_status)
 	ret = tb_retimer_nvm_add(rt);
 	if (ret) {
 		dev_err(&rt->dev, "failed to add NVM devices: %d\n", ret);
-		device_del(&rt->dev);
+		device_unregister(&rt->dev);
 		return ret;
 	}
 
-- 
2.30.2

