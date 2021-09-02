Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95303FEB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbhIBJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:21:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbhIBJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:21:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC3B020320;
        Thu,  2 Sep 2021 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630574405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mCLKxbu6H+gkdS0vBCZqNAhLeUSXY2O0pR+5uorc2Nw=;
        b=JGF7G2OHkGr0sf/v0m6TDelhbrvh4KOEC7hFWe5P59cDLhEA1aEklrx1qysiYXZtXBWtBH
        GhyIRC3MQpEcDddcAUaF0F8n6pe70Up3S6aPDkWFd2JxAFMPNTYzEEkk+GTeuZbVMSfWcB
        ytcYx87TF6x3qLvIWIjI/NGTizWJJIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630574405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mCLKxbu6H+gkdS0vBCZqNAhLeUSXY2O0pR+5uorc2Nw=;
        b=DguZ15XQXGjXoPokT0nFdDs7FBrn0b7Se0GxWqm0Ui+n3W+t6g6SfpH+Krux6Jhir5xq1X
        FGTZiVVVgCefKDAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 56DE9A3B8D;
        Thu,  2 Sep 2021 09:20:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id C55C1518DECC; Thu,  2 Sep 2021 11:20:05 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme: avoid race in shutdown namespace removal
Date:   Thu,  2 Sep 2021 11:20:02 +0200
Message-Id: <20210902092002.67614-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remove the siblings entry, we update ns->head->list, hence we
can't separate the removal and test for being empty. They have to be
in the same critical section to avoid a race.

To avoid breaking the refcounting imbalance again, add a list empty
check to nvme_find_ns_head.

Fixes: 5396fdac56d8 ("nvme: fix refcounting imbalance when all paths are down")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
 - added nvme_find_ns_head fix as suggested by hch
v1:
 - https://lore.kernel.org/linux-nvme/20210830093618.97657-1-dwagner@suse.de/

 drivers/nvme/host/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a3a33f5f11c..ac9a61d1d011 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3524,7 +3524,9 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (h->ns_id == nsid && nvme_tryget_ns_head(h))
+		if (h->ns_id != nsid)
+			continue;
+		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
 	}
 
@@ -3836,6 +3838,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
@@ -3856,13 +3862,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	/* Synchronize with nvme_init_ns_head() */
-	mutex_lock(&ns->head->subsys->lock);
-	if (list_empty(&ns->head->list)) {
-		list_del_init(&ns->head->entry);
-		last_path = true;
-	}
-	mutex_unlock(&ns->head->subsys->lock);
 	if (last_path)
 		nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
-- 
2.29.2

