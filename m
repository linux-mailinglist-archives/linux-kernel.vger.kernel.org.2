Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127294090F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbhIMN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244182AbhIMNwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CAFB6187A;
        Mon, 13 Sep 2021 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631540070;
        bh=ZkBB5WuHosXe/9jqN8ntx8HZyJ4sv1now/CKp4qhYGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zc1YeSIEd0YpCi9iTLBtqSjdlXyQp09LDF4nYhvMW0gF83Q4S9Mk52OWgSLC30g8T
         JOfnFqNC8i4DgwLwwNEHyYZFp9CilBkm4w6Jlce0mCFbSU4Nebn5c7U0IDl4ViNWT8
         di6xzPsnepwBLGvn8JePMCIhVMlhGmN1vd1lJjds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruozhu Li <liruozhu@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 021/300] nvme-rdma: dont update queue count when failing to set io queues
Date:   Mon, 13 Sep 2021 15:11:22 +0200
Message-Id: <20210913131110.012030365@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913131109.253835823@linuxfoundation.org>
References: <20210913131109.253835823@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruozhu Li <liruozhu@huawei.com>

[ Upstream commit 85032874f80ba17bf187de1d14d9603bf3f582b8 ]

We update ctrl->queue_count and schedule another reconnect when io queue
count is zero.But we will never try to create any io queue in next reco-
nnection, because ctrl->queue_count already set to zero.We will end up
having an admin-only session in Live state, which is exactly what we try
to avoid in the original patch.
Update ctrl->queue_count after queue_count zero checking to fix it.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4697a94c0945..f80682f7df54 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -736,13 +736,13 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	if (ctrl->ctrl.queue_count < 2) {
+	if (nr_io_queues == 0) {
 		dev_err(ctrl->ctrl.device,
 			"unable to set any I/O queues\n");
 		return -ENOMEM;
 	}
 
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-- 
2.30.2



