Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741A39F91A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhFHOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:30:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3801 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFHOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:30:18 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzssw0SQszWsXc;
        Tue,  8 Jun 2021 22:23:32 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:28:22 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Arie Gershberg <agershberg@marvell.com>,
        Shai Malin <smalin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] nvme-tcp-offload: Fix error return code in nvme_tcp_ofld_setup_ctrl()
Date:   Tue, 8 Jun 2021 14:38:54 +0000
Message-ID: <20210608143854.4154005-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return negative error code -EINVAL if mandatory sgls
are not supported.

Fixes: 5aadd5f9311e ("nvme-tcp-offload: Add controller level implementation")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvme/host/tcp-offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp-offload.c b/drivers/nvme/host/tcp-offload.c
index c76822e5ada7..3879d5ed7497 100644
--- a/drivers/nvme/host/tcp-offload.c
+++ b/drivers/nvme/host/tcp-offload.c
@@ -622,6 +622,7 @@ static int nvme_tcp_ofld_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 
 	if (!(nctrl->sgls & ((1 << 0) | (1 << 1)))) {
 		dev_err(nctrl->device, "Mandatory sgls are not supported!\n");
+		rc = -EINVAL;
 		goto destroy_admin;
 	}
 

