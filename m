Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0630DD22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhBCOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:44:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42798 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhBCOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:43:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113EddLW124085;
        Wed, 3 Feb 2021 14:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5t4O+GIexDFCZs7Qyj87f4qgjjlUM1s/DGwBFjRwnos=;
 b=oT3yFpbY53FL535i6zqjrmzFhjsxUCDQI8zJhGV1S2TKxJj+jBVDXfcrKycNrq17YUOn
 y8kmrT+Ojf+KsxlNkRUwgu6oZ8OLYTgqNHNGtYqtGAHkQhQnTvxBpgSmEPJs3wzuQ8OF
 VjCa+pZUGMuayWkBQGImRjrn1FekpJHUIduKLqT+/ZlSXaOXwkJkd9ojlymj/Mo6uu5N
 T2JbSy8bEZqptBOR0Yj83U9R2/J2vy/Gp8Mj/UtBo+elQosCrz4lcQbZeYWtiLn/S/PF
 FEE9V5wzB594fdmA4KdTLOSwvvHQvrwXRni64vqm8vo5j56ZkHW6juGxxnA5Z5aUh+/C Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyb0mt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 14:43:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113EeHd2124705;
        Wed, 3 Feb 2021 14:43:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36dh7tjjyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 14:43:05 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 113Eh3iB000517;
        Wed, 3 Feb 2021 14:43:03 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Feb 2021 06:43:02 -0800
Date:   Wed, 3 Feb 2021 17:42:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        James Hu <james.hu@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: bcm-vk: Fix a couple error codes in probe()
Message-ID: <YBpyEbmz00rjvT9S@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These errors should return negative error codes instead of returning
success.

Fixes: 064ffc7c3939 ("misc: bcm-vk: add autoload support")
Fixes: 522f692686a7 ("misc: bcm-vk: add Broadcom VK driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index c3d2bba68ef1..a82a8927d92b 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1358,6 +1358,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		vk->bar[i] = pci_ioremap_bar(pdev, i * 2);
 		if (!vk->bar[i]) {
 			dev_err(dev, "failed to remap BAR%d\n", i);
+			err = -ENOMEM;
 			goto err_iounmap;
 		}
 	}
@@ -1463,7 +1464,8 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
-			if (bcm_vk_trigger_autoload(vk))
+			err = bcm_vk_trigger_autoload(vk);
+			if (err)
 				goto err_bcm_vk_tty_exit;
 		} else {
 			dev_err(dev,
-- 
2.30.0

