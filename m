Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CD31C036
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBORM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:12:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56300 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhBOQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:01:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFodLs138074;
        Mon, 15 Feb 2021 15:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HIymXua2oUPLe6bYpcuYwLHXGiO0NxGKTlDMqX9jdyc=;
 b=pBdBNUEORBIEYES8Jo08C8ztVKwY7I11cRtbSMQyz92Tex2/RM5TwiAqYkZDCh99/ynO
 6WZM3k2G5lnRnHqY/LiBN9wm3l/NgwxheU9owsM2uGS0U7jL+TQfXuAcXQsyEHl5RvHh
 VaI5kxFjOOag/v0XNB2+RlCYO5gmW7N1w1Y5vJD083TWsIDBKlFaF6QKAapqr70hO6yJ
 +HpP94Bm7kMDeXo5bQgkJTDCK5KoqyRkAMRZUxZK3m8wDUOBMoUWgYeoXPhfaV7f+VPh
 Srqdtyev52FD2Hl+2J1YIq4HlvpOtISVJdnY+zB6jr7OhTApLaujAyiKGswJoMPTUWiw RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36p49b4kyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 15:59:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FFpSoK063679;
        Mon, 15 Feb 2021 15:59:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36prhqh691-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 15:59:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11FFwwcQ003695;
        Mon, 15 Feb 2021 15:58:59 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 07:58:58 -0800
Date:   Mon, 15 Feb 2021 18:58:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vipin Kumar <vipin.kumar@st.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mtd: rawnand: fsmc: Fix error code in fsmc_nand_probe()
Message-ID: <YCqaOZ83OvPOzLwh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9896 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dma_request_channel() fails then the probe fails and it should
return a negative error code, but currently it returns success.

fixes: 4774fb0a48aa ("mtd: nand/fsmc: Add DMA support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 0101c0fab50a..a24e2f57fa68 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1077,11 +1077,13 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		host->read_dma_chan = dma_request_channel(mask, filter, NULL);
 		if (!host->read_dma_chan) {
 			dev_err(&pdev->dev, "Unable to get read dma channel\n");
+			ret = -ENODEV;
 			goto disable_clk;
 		}
 		host->write_dma_chan = dma_request_channel(mask, filter, NULL);
 		if (!host->write_dma_chan) {
 			dev_err(&pdev->dev, "Unable to get write dma channel\n");
+			ret = -ENODEV;
 			goto release_dma_read_chan;
 		}
 	}
-- 
2.30.0

