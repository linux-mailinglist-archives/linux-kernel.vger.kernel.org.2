Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2C34C389
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 08:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2GIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 02:08:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2GIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 02:08:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T5rrrN107848;
        Mon, 29 Mar 2021 06:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=R+JGjlBwrbZXzxMGadFoiOE/AboavnCWBSLV2LWuS/M=;
 b=0ag0kgtlKyhEAyHorgwZM4C7UMLX3tflqVSXNdN1w6DtNuB2QDiMVdWb4lBw7aV+BT29
 PJbdg+jheVelvCEGolmbXeRjXGJsYSYfk0fuQ59flPlUr8wCwyIGFkngXeUf3gCM2WuL
 jBEHqkGolbnoW4sLkMyUyIAzPQSt1Mi/oZeNrSWoMhnvO1cR3dFWbfYRwhBdDWs29W3r
 UbUegi+iGBF5gbNxpIxFx3M7A9zvAGaTHLxUqSRpmumA8qIOJLJNkztw/ETOIqwLONbB
 0+ewSH8wlJINAfw7NzpBAYeFxJjhbfm7bx40D2cIK4WqLS70mnDg9/zm59re0BvaxixV 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37hvnm2bjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 06:08:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T5tV0p066458;
        Mon, 29 Mar 2021 06:08:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37je9mxtgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 06:08:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12T689bC018061;
        Mon, 29 Mar 2021 06:08:09 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 28 Mar 2021 23:08:08 -0700
Date:   Mon, 29 Mar 2021 09:08:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] thunderbolt: Fix off by one in tb_port_find_retimer()
Message-ID: <YGFuwRKm0iurFAtI@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGFulvAa5Kz6HTsd@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290047
X-Proofpoint-GUID: r2VsRpKZnRk7xHLCaEUM7MpBZcn4ZASy
X-Proofpoint-ORIG-GUID: r2VsRpKZnRk7xHLCaEUM7MpBZcn4ZASy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This array uses 1-based indexing so it corrupts memory one element
beyond of the array.  Fix it by making the array one element larger.

Fixes: dacb12877d92 ("thunderbolt: Add support for on-board retimers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thunderbolt/retimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 7a5d61604c8b..c44fad2b9fbb 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -406,7 +406,7 @@ static struct tb_retimer *tb_port_find_retimer(struct tb_port *port, u8 index)
  */
 int tb_retimer_scan(struct tb_port *port)
 {
-	u32 status[TB_MAX_RETIMER_INDEX] = {};
+	u32 status[TB_MAX_RETIMER_INDEX + 1] = {};
 	int ret, i, last_idx = 0;
 
 	if (!port->cap_usb4)
-- 
2.30.2

