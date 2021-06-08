Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03E39ED25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFHDry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:47:54 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4392 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHDrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:47:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fzbdr4sCPz6vFb;
        Tue,  8 Jun 2021 11:42:08 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:45:59 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 11:45:58 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] nvme-multipath: combine grpid and ANA state checks in nvme_parse_ana_log()
Date:   Tue, 8 Jun 2021 12:13:36 +0800
Message-ID: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Combine grpid and ANA state checks in nvme_parse_ana_log() to
reduce repetitive code and more intuitive meaning.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/host/multipath.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f81871c..19fe16d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -522,13 +522,11 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		nr_nsids = le32_to_cpu(desc->nnsids);
 		nsid_buf_size = nr_nsids * sizeof(__le32);
 
-		if (WARN_ON_ONCE(desc->grpid == 0))
+		if (WARN_ON_ONCE(desc->grpid == 0 ||
+			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
 			return -EINVAL;
-		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
-			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state == 0))
-			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
+		if (WARN_ON_ONCE(desc->state == 0 ||
+			desc->state > NVME_ANA_CHANGE))
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-- 
2.30.2

