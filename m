Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458B73117BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhBFAWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:22:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhBEMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:47:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CUYPJ079869;
        Fri, 5 Feb 2021 12:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zXwtIkuYEvqCQ/ph9hBq5tQzsewQzXSxbOL7lVa4vXg=;
 b=oH1DGtQvWsFrFUqJ19MwDJRh34+8Yu03cm+lpQkudCPi/di7LwYhcw4ZMEZ4lVkvcojZ
 zYuIwAjkAhbxaMwqyVFBF1BHpOtY+vMh48Vajs6mwdAaILpboJJoDZ2dC3PXorURrE9t
 adkCNmNZKw4Ipg4Q+ec3wb0uKgpZ7WzzVBgZ5cTUnYekFvIo5GNi3gSvOMqtpgcuxZWY
 vpmCCnQuDA6IAhqd7/csnwlfnX34A27zJ8yOzv/6xkB2bGeeLxZitUxZZwdKlO2kyX2G
 PXUcdckWkwK8+1EkoTys0aL4ywUxpQAOhEp0id70M3BXMgGldczItGn/oGXk1wRpSNfM 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvrcb5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 12:46:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115CVOCK100352;
        Fri, 5 Feb 2021 12:46:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36dhc437au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 12:46:34 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 115CkRpd001622;
        Fri, 5 Feb 2021 12:46:30 GMT
Received: from mwanda (/41.210.143.249)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Feb 2021 04:46:26 -0800
Date:   Fri, 5 Feb 2021 15:46:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/mediatek: Fix error code in probe()
Message-ID: <YB0+GU5akSdu29Vu@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error path is supposed to return -EINVAL.  It used to return
directly but we added some clean up and accidentally removed the
error code.  Also I fixed a typo in the error message.

Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iommu/mtk_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0ad14a7604b1..5f78ac0dc30e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -886,7 +886,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	link = device_link_add(data->smicomm_dev, dev,
 			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link) {
-		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
+		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
+		ret = -EINVAL;
 		goto out_runtime_disable;
 	}
 
-- 
2.30.0

