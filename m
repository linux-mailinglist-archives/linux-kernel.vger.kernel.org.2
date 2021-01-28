Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3630730D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhA1JnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:43:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55032 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhA1JiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:38:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10S9E4Qq014468;
        Thu, 28 Jan 2021 09:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Qcbhu6FPjjmyWu2EJMpsp4cxmH7sCf68qs6ILGhCu64=;
 b=lnsUak4kUX9WfC1pryMsefodLy12bkhdTVJNnPxcJ4Hqo75+kM23cHNcXv6cJiOb56Jh
 DUdDyE8mH180Do3Bw/pF+iWQE5FufQaYaDBIpMUOCdh5HDrMkPVlL5sSFjbwbzwfF9Lt
 TrVXjslqS4KK4Sfa4isb3jGx7GLrFXvgZPBWm/l6TZqwB7HZdMSPoOGY6SYy6ipgpr4G
 abLar+8zpnDF8ve7x+nL38xgztRR78xGJJriaSxEEJAPtlC7IIqFo2kxYfemd6vW1ZI0
 jNd+9qKsl5jsH99u6SDZLgjMwK8IYN1YTka8744TZisODif0A64wpOy20URUeq1vqwG1 eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7r36fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 09:37:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10S9GE6p156504;
        Thu, 28 Jan 2021 09:37:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 368wr02s31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 09:37:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10S9b0Ai002136;
        Thu, 28 Jan 2021 09:37:02 GMT
Received: from mwanda (/10.175.203.176)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 01:36:59 -0800
Date:   Thu, 28 Jan 2021 12:36:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mtd: parser_imagetag: fix error codes in
 bcm963xx_parse_imagetag_partitions()
Message-ID: <YBKFtNaFHGYBj+u4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280048
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kstrtouint() calls fail, then this should return a negative
error code but it currently returns success.

Fixes: dd84cb022b31 ("mtd: bcm63xxpart: move imagetag parsing to its own parser")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mtd/parsers/parser_imagetag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/parsers/parser_imagetag.c b/drivers/mtd/parsers/parser_imagetag.c
index d69607b48227..fab0949aabba 100644
--- a/drivers/mtd/parsers/parser_imagetag.c
+++ b/drivers/mtd/parsers/parser_imagetag.c
@@ -83,6 +83,7 @@ static int bcm963xx_parse_imagetag_partitions(struct mtd_info *master,
 			pr_err("invalid rootfs address: %*ph\n",
 				(int)sizeof(buf->flash_image_start),
 				buf->flash_image_start);
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -92,6 +93,7 @@ static int bcm963xx_parse_imagetag_partitions(struct mtd_info *master,
 			pr_err("invalid kernel address: %*ph\n",
 				(int)sizeof(buf->kernel_address),
 				buf->kernel_address);
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -100,6 +102,7 @@ static int bcm963xx_parse_imagetag_partitions(struct mtd_info *master,
 			pr_err("invalid kernel length: %*ph\n",
 				(int)sizeof(buf->kernel_length),
 				buf->kernel_length);
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -108,6 +111,7 @@ static int bcm963xx_parse_imagetag_partitions(struct mtd_info *master,
 			pr_err("invalid total length: %*ph\n",
 				(int)sizeof(buf->total_length),
 				buf->total_length);
+			ret = -EINVAL;
 			goto out;
 		}
 
-- 
2.29.2

