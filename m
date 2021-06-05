Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA939C835
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFEMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:50:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFEMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:50:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155Ci19S112138;
        Sat, 5 Jun 2021 12:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=07BOHHPaJrmXU5W7/AFSyJRb0cJYxMTbyObPQAH3yd0=;
 b=mGX/IO+Z5uRjA6BmSCsJIH3EHN1cA/bFccMo28wvQn0j8IUKsDqExKMVADpCJdC/z7Lp
 6zRGxYM8f43SX1E3tUSViJE2EKutMpZWFaj3b4CFsMKnGejg8C9HJLrn2Xe0SbmaIWRW
 2Ocyi/2GNw+spmCOsFvyrFWTfjA3lCtoUHj7FeEg6lK1gSM1clVYGYblku+c55CH2syu
 smp15iY5RjKRcfq/TF1fO5kwN0z9B4SEy/NKkdmTQnoGwyEY52mORs2Uqp/YEtkLrl4p
 MOfSPOqvr//GDBwC7T3M552JLcDSgCanAS/eVEZqN1P+yuJqV3nqe0yECGMymmwdy6sO xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3900ps0cm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Jun 2021 12:48:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 155CkOwo135464;
        Sat, 5 Jun 2021 12:48:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxcsjrq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Jun 2021 12:48:41 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 155Cmem4137233;
        Sat, 5 Jun 2021 12:48:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38yxcsjrpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Jun 2021 12:48:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 155CmW3p012720;
        Sat, 5 Jun 2021 12:48:32 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Jun 2021 05:48:31 -0700
Date:   Sat, 5 Jun 2021 15:48:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Solganik Alexander <sashas@lightbitslabs.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Message-ID: <YLtykIn+Or0l08oV@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: c7xZCEaeYkskdruWm_5pWeTmldsdxDrL
X-Proofpoint-ORIG-GUID: c7xZCEaeYkskdruWm_5pWeTmldsdxDrL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106050092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These error paths currently return success but they should return
-EOPNOTSUPP.

Fixes: 73ffcefcfca0 ("nvme-tcp: check sgl supported by target")
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 34f4b3402f7c..72e9d34c3092 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1973,11 +1973,13 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
 
 	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
 		goto destroy_admin;
 	}
-- 
2.30.2

