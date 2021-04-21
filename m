Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6732366C97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhDUNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243207AbhDUNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7130F61440;
        Wed, 21 Apr 2021 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010976;
        bh=9LZhPcsAFTiBpeb3woRbY/FWno/JF9JL5RZwq6we53Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4nPZ+BKAO/KdosR70wXSNbPkpoND7ATeY8+OyyGjqlgosXXObpIZJxCv3gZTZWcX
         jAF7gC7A4Whm3Hkf8XQaUy57jAtDdwiw9m1yi6VD8a/wX3nU3ZTIKPR8QOVRd+5r5N
         tx+GnvUL12nNNfMwyCUY03psoqCL+MW1vKIOBJzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 107/190] Revert "RDMA/i40iw: Handle workqueue allocation failure"
Date:   Wed, 21 Apr 2021 14:59:42 +0200
Message-Id: <20210421130105.1226686-108-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e2a438bd7116889af36304903b92e56d0f347228.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Shiraz, Saleem <shiraz.saleem@intel.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c   | 18 +++---------------
 drivers/infiniband/hw/i40iw/i40iw_main.c |  5 +----
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 6a79502c8b53..a6bf8f42e7da 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -561,7 +561,7 @@ enum i40iw_status_code i40iw_obj_aligned_mem(struct i40iw_device *iwdev,
 
 void i40iw_request_reset(struct i40iw_device *iwdev);
 void i40iw_destroy_rdma_device(struct i40iw_ib_device *iwibdev);
-int i40iw_setup_cm_core(struct i40iw_device *iwdev);
+void i40iw_setup_cm_core(struct i40iw_device *iwdev);
 void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core);
 void i40iw_process_ceq(struct i40iw_device *, struct i40iw_ceq *iwceq);
 void i40iw_process_aeq(struct i40iw_device *);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index ac65c8237b2e..450271fde637 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -3236,7 +3236,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
  * core
  * @iwdev: iwarp device structure
  */
-int i40iw_setup_cm_core(struct i40iw_device *iwdev)
+void i40iw_setup_cm_core(struct i40iw_device *iwdev)
 {
 	struct i40iw_cm_core *cm_core = &iwdev->cm_core;
 
@@ -3255,19 +3255,9 @@ int i40iw_setup_cm_core(struct i40iw_device *iwdev)
 
 	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
 						    WQ_MEM_RECLAIM);
-	if (!cm_core->event_wq)
-		goto error;
 
 	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
 						      WQ_MEM_RECLAIM);
-	if (!cm_core->disconn_wq)
-		goto error;
-
-	return 0;
-error:
-	i40iw_cleanup_cm_core(&iwdev->cm_core);
-
-	return -ENOMEM;
 }
 
 /**
@@ -3287,10 +3277,8 @@ void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core)
 		del_timer_sync(&cm_core->tcp_timer);
 	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 
-	if (cm_core->event_wq)
-		destroy_workqueue(cm_core->event_wq);
-	if (cm_core->disconn_wq)
-		destroy_workqueue(cm_core->disconn_wq);
+	destroy_workqueue(cm_core->event_wq);
+	destroy_workqueue(cm_core->disconn_wq);
 }
 
 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index ab4cb11950dc..9db84ec08fc0 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1634,10 +1634,7 @@ static int i40iw_open(struct i40e_info *ldev, struct i40e_client *client)
 	iwdev = &hdl->device;
 	iwdev->hdl = hdl;
 	dev = &iwdev->sc_dev;
-	if (i40iw_setup_cm_core(iwdev)) {
-		kfree(iwdev->hdl);
-		return -ENOMEM;
-	}
+	i40iw_setup_cm_core(iwdev);
 
 	dev->back_dev = (void *)iwdev;
 	iwdev->ldev = &hdl->ldev;
-- 
2.31.1

