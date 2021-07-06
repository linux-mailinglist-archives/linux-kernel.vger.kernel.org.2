Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33EC3BD939
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhGFO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:59:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34794 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhGFO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:59:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1m0mVH-0004Qy-Hf; Tue, 06 Jul 2021 14:56:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet: remove redundant assignments of variable status
Date:   Tue,  6 Jul 2021 15:56:50 +0100
Message-Id: <20210706145650.32555-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances where variable status is being assigned a
value that is never read and it is being re-assigned a new value
almost immediately afterwards on an error exit path. The assignments
are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvme/target/zns.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 17f8b7a45f21..46bc30fe85d2 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -115,14 +115,11 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	}
 
 	status = nvmet_req_find_ns(req);
-	if (status) {
-		status = NVME_SC_INTERNAL;
+	if (status)
 		goto done;
-	}
 
 	if (!bdev_is_zoned(req->ns->bdev)) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto done;
 	}
 
-- 
2.31.1

