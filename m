Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905203A128A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhFILYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:24:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41440 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhFILX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:23:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599FZOe126813;
        Wed, 9 Jun 2021 09:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YnBQKz3dqrUNxi9NhuYJmaFtMbuoNqMgRmHcuk+qdpI=;
 b=sRxE+MxijCFxqckZdPl516xZAoGyX4NeLSEsGHwHm/QVAm/0Bw+WjX4xTL2C/7NQVnZg
 zBk19bqzgQP7rN6UDxSba1m0HSyHL9gJYPemVVCczqu9MTVftCXXi5C9e9bG9t7Wdrfl
 3VAeuZLBtXH4J0eDRmuesh1HKYwP7WW4Mq2MOAHSqcrbq8psLlsRhRqXjj6b8RgSYAuo
 PaxaribDfQN3wQbDt6Z8EhJ3SSIVkUOCsZuKbnV9hA3LYobBlUQ1j7xR9WKJtIGFfVQ1
 qOoYQ7FQtfIugBcr4VxqxBGw22rtYZKGyzUB4aUkjkIYED1mswvaVzd+PbOJKby/yNFF zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38yxscgnb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:28:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1599QZRP051047;
        Wed, 9 Jun 2021 09:28:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922wuedkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:28:42 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1599SfGF066343;
        Wed, 9 Jun 2021 09:28:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3922wuedjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 09:28:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1599SeDQ031727;
        Wed, 9 Jun 2021 09:28:40 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 09:28:39 +0000
Date:   Wed, 9 Jun 2021 12:28:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shai Malin <smalin@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp-offload: Fix error code in
 nvme_tcp_ofld_create_ctrl()
Message-ID: <YMCJv0sYKm+Gcwr7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: dwTMuy1y2bpTs-2e3Ko8WmdLFuDxgBH-
X-Proofpoint-GUID: dwTMuy1y2bpTs-2e3Ko8WmdLFuDxgBH-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error pointer if try_module_get() fails.  Currently it returns
NULL.

Fixes: 4b8178ec5794 ("nvme-tcp-offload: Add device scan implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/nvme/host/tcp-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index c76822e5ada7..c07f84a7e697 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -1215,7 +1215,7 @@ nvme_tcp_ofld_create_ctrl(struct device *ndev, struct nvmf_ctrl_options *opts)
 	/* Increase driver refcnt */
 	if (!try_module_get(dev->ops->module)) {
 		pr_err("try_module_get failed\n");
-		dev = NULL;
+		rc = -ENODEV;
 		goto out_free_ctrl;
 	}
 
-- 
2.30.2

