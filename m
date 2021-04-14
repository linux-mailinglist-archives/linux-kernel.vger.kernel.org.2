Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BF35ECA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbhDNF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:57:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhDNF5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:57:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E5sZoh110755;
        Wed, 14 Apr 2021 05:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=P/i1vmHNJnjFbfOoldRB68MAgV3STMB5j+k2o9a8Suk=;
 b=QVb8laRID4mbAeilrue4sdNdmU4Zl8xBvYMs3NXRac6+RMyUyI9WUeP82gyu4BQUS177
 SQnDd79xDBu1AgzdZ/pHBL5q0yPeEzSel91UFXRb2OTX/y5/Qsoc8Dr1ajuVFryb3Yw3
 Q6+uoTGRdS1MUl3BGHDeLX46AbyFadKmqdSqEyIkmOUvkABdyg6LHINgp7HME9Qeq4wC
 Cgv7I8m3/ska3u7lcTzelDSdmrvmWwRbxpx8RSqfG5/2ICY6zwZIc4Iq7X1N0og12b7S
 fU8MepCS5JCy94as/pPByLiFZNaeKZAI17ZUWa/nNuLh5JWRB+34lpISPruGOidnN46d 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymh4rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 05:56:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E5uVjd077636;
        Wed, 14 Apr 2021 05:56:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37unkqj5su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 05:56:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13E5ueng003657;
        Wed, 14 Apr 2021 05:56:40 GMT
Received: from mwanda (/10.175.166.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 05:56:40 +0000
Date:   Wed, 14 Apr 2021 08:56:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mtd: rawnand: fix an error code in nand_setup_interface()
Message-ID: <YHaEEYg2DUFwnxSo@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140041
X-Proofpoint-GUID: r7lz9uowWJzlA_c7QnSMVcENprQihhwG
X-Proofpoint-ORIG-GUID: r7lz9uowWJzlA_c7QnSMVcENprQihhwG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should return an error code if the timing mode is not acknowledged
by the NAND chip.

Fixes: 415ae78ffb5d ("mtd: rawnand: check ONFI timings have been acked by the chip")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested.

 drivers/mtd/nand/raw/nand_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index fb072c444495..d83c0503f96f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -880,6 +880,7 @@ static int nand_setup_interface(struct nand_chip *chip, int chipnr)
 	if (tmode_param[0] != chip->best_interface_config->timings.mode) {
 		pr_warn("timing mode %d not acknowledged by the NAND chip\n",
 			chip->best_interface_config->timings.mode);
+		ret = -EINVAL;
 		goto err_reset_chip;
 	}
 
-- 
2.30.2

