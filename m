Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82AE30A7A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhBAM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:29:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBAM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:29:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CEAQA173379;
        Mon, 1 Feb 2021 12:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=PBNq7gOuz6MH/3F/CeGL6t5zFVKRrjV8r/ABw1F27D0=;
 b=YjpTfaVofaVVA/uacU1LiOgPFQ/lRg6AoJ5ep+lA5z376jmbOvb71YX7TZFF3tYtL9/7
 RgeQVkq+ZW9F4ti0pIYpe2gUt+5i7PB1lb56BMuGBq+bSGoOWxKlhwkz2SweeTgN3s8m
 ooCmyifcLEienQz0eC5RlkFA+sML9IGtMSJRh8QjehVCmvQHTj8NUJtL1epNwxVIgzP4
 FntrU5Yk2NLl/mV/JvY9ovUXiX/YDslyByp3myY+1S50awRninsTEX1NldSdjZcgjMPK
 EASiuKA80IotPjziEL8IkBb3NuhxhLSVOR6RBvbiA0qvrid+yVzy57jGgKcTGA+8k+7m gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvqw03n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:29:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111CA7IJ146815;
        Mon, 1 Feb 2021 12:29:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 36dh7pn8p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 12:29:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 111CT1lf006023;
        Mon, 1 Feb 2021 12:29:01 GMT
Received: from mwanda (/10.175.186.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Feb 2021 04:29:00 -0800
Date:   Mon, 1 Feb 2021 15:28:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: Fix test for end of loop
Message-ID: <YBf0Br9obNGZTcNI@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010064
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9881 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "desc" pointer can't possibly be NULL here.  If we can't find the
correct "desc" then tt points to the last element of the
fsl_mc_accepted_cmds[] array.  Fix this by testing if
"i == FSL_MC_NUM_ACCEPTED_CMDS" instead.

Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index eeb988c9f4bb..bdcd9d983a78 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -338,7 +338,7 @@ static int fsl_mc_command_check(struct fsl_mc_device *mc_dev,
 		if ((cmdid & desc->cmdid_mask) == desc->cmdid_value)
 			break;
 	}
-	if (!desc) {
+	if (i == FSL_MC_NUM_ACCEPTED_CMDS) {
 		dev_err(&mc_dev->dev, "MC command 0x%04x: cmdid not accepted\n", cmdid);
 		return -EACCES;
 	}
-- 
2.29.2

