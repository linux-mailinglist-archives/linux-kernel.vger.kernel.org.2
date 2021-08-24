Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967B33F612E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhHXO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:58:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhHXO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:58:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 34E2F1FD9D;
        Tue, 24 Aug 2021 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629817066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lTY2+6RSUY5UGPOVYIqJLIbgI+78nykiaQqgyxaQdR0=;
        b=nVAQuPIE2aHk8Xqf65LgW+pGJcxIj7xpZIXafRKBKQD2pDaJpeUWaQrx2EFBp9XRYMZXDy
        3DFw2R3UfiBRvhJRrf4vSnD3fIEoVu25bzhFns1l3l2kBynSLPHXlA0f23QWGHB8mdkCZy
        /eacySNqSfg4bws9dggjurzFygz1LK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629817066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lTY2+6RSUY5UGPOVYIqJLIbgI+78nykiaQqgyxaQdR0=;
        b=dxpqltLT00QV/2Rfz3Uu8Dtx6JvdMtAwd41NxGZQ8CEHLcnumo9z4hrfm+/1Gr0MFGL3Xk
        kd91EpMXnn1Iw2AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2EF38A3B90;
        Tue, 24 Aug 2021 14:57:46 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 1D3F1518D984; Tue, 24 Aug 2021 16:57:46 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4] nvme-multipath: revalidate paths during rescan
Date:   Tue, 24 Aug 2021 16:57:42 +0200
Message-Id: <20210824145742.94212-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

When triggering a rescan due to a namespace resize we will be
receiving AENs on every controller, triggering a rescan of all
attached namespaces. If multipath is active only the current path and
the ns_head disk will be updated, the other paths will still refer to
the old size until AENs for the remaining controllers are received.

If I/O comes in before that it might be routed to one of the old
paths, triggering an I/O failure with 'access beyond end of device'.
With this patch the old paths are skipped from multipath path
selection until the controller serving these paths has been rescanned.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: - introduce NVME_NS_READY flag instead of NVME_NS_INVALIDATE
          - use 'revalidate' instead of 'invalidate' which
	    follows the zoned device code path.
	  - clear NVME_NS_READY before clearing current_path]
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v3:
  - https://lore.kernel.org/linux-nvme/20210811152803.30017-1-dwagner@suse.de/
  - Renamed nvme_mpath_invalidated_paths to nvme_mpath_revalidate_paths()
  - Replaced NVME_NS_INVALIDATE with NVME_NS_READY
v2:
  - https://lore.kernel.org/linux-nvme/20210730071059.124347-1-dwagner@suse.de/
  - removed churn from failed rebase.
v1:
  - https://lore.kernel.org/linux-nvme/20210729194630.i5mhvvgb73duojqq@beryllium.lan/


 drivers/nvme/host/core.c      |  3 +++
 drivers/nvme/host/multipath.c | 17 ++++++++++++++++-
 drivers/nvme/host/nvme.h      |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9a46c54f714..42b69f3c6e20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1875,6 +1875,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			goto out_unfreeze;
 	}
 
+	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
@@ -1886,6 +1887,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
+		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		blk_queue_update_readahead(ns->head->disk->queue);
@@ -3803,6 +3805,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	clear_bit(NVME_NS_READY, &ns->flags);
 	set_capacity(ns->disk, 0);
 	nvme_fault_inject_fini(&ns->fault_inject);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3f32c5e86bfc..ea2b70fd9ac1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -147,6 +147,21 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->scan_lock);
 }
 
+void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+	sector_t capacity = get_capacity(head->disk);
+	int node;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (capacity != get_capacity(ns->disk))
+			clear_bit(NVME_NS_READY, &ns->flags);
+	}
+
+	for_each_node(node)
+		rcu_assign_pointer(head->current_path[node], NULL);
+}
+
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	/*
@@ -158,7 +173,7 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	    ns->ctrl->state != NVME_CTRL_DELETING)
 		return true;
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
-	    test_bit(NVME_NS_REMOVING, &ns->flags))
+	    !test_bit(NVME_NS_READY, &ns->flags))
 		return true;
 	return false;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2e1f298b217..8fd30ef19757 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -456,6 +456,7 @@ struct nvme_ns {
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
+#define NVME_NS_READY		4
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -748,6 +749,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
+void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 
@@ -795,6 +797,9 @@ static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
 }
+static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
+{
+}
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.29.2

