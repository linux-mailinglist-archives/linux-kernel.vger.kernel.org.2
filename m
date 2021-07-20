Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FBF3CF9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhGTMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:03:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhGTMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:03:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB34B22461;
        Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626785038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gt1WlTf8P4ACBthbjpoZHuxeoWC03SZl9KVFVscbuPc=;
        b=09kIZ0BrxdXcxI+gMZTqrrv+2TxrcOtg2zP8a1FxUpR0Zs88XNOBoK4iz0gIM5Js2rHPdj
        Cu/1+EClCP0KaGtah6bOBFUlz3scOGWckVEjgPOzBLgOE017thBiJA5vzwINy5VWZU0qJl
        hODefdHyF85rv643hiex5AT1zZCA2c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626785038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gt1WlTf8P4ACBthbjpoZHuxeoWC03SZl9KVFVscbuPc=;
        b=cGO9X/pNj64FFDyUpVjw1kw3/1QOS/LQAGEjDiXn+btL857WyajnyWeprxBQiNoGOHiy9i
        LLkx34wW3zWJz4BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 12EECA3BA9;
        Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 01241517192A; Tue, 20 Jul 2021 14:43:58 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 2/6] nvme-tcp: Update number of hardware queues before using them
Date:   Tue, 20 Jul 2021 14:43:49 +0200
Message-Id: <20210720124353.127959-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210720124353.127959-1-dwagner@suse.de>
References: <20210720124353.127959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

When the number of hardware queues changes during resetting we should
update the tagset first before using it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cf3440fdada8..286e318403cb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1791,6 +1791,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret;
+	u32 prior_q_cnt = ctrl->queue_count;
 
 	ret = nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
@@ -1808,14 +1809,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
-	}
-
-	ret = nvme_tcp_start_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
-		nvme_start_queues(ctrl);
+	} else if (prior_q_cnt != ctrl->queue_count) {
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
@@ -1830,6 +1824,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		nvme_unfreeze(ctrl);
 	}
 
+	ret = nvme_tcp_start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.29.2

