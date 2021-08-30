Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D83FB32A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhH3JhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:37:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhH3JhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:37:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 320F31FDE9;
        Mon, 30 Aug 2021 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630316180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O4mIgMIAjdBJAp1QnJNYKrG6vlL/YYTQqpNFWU7STG0=;
        b=uvRjxpGXemNhyBIWKHcKAHrhalQM6AOFW65JvSxG8cjtcS1o6dERhr7KGjkG9RaNnnMxiN
        ntrklrQ+i45kn+n2wP1PAy4fhGToOxwRucKlKFIZ3heaGIM9rqMu5INViNgE2GbnVcGuwK
        iHXjr7HRnrU+n0Ov80iZzyh7xYwCjAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630316180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O4mIgMIAjdBJAp1QnJNYKrG6vlL/YYTQqpNFWU7STG0=;
        b=FWn92FvIkrBaOc+nlaJEks2HGvxAX3li4QY9lkU0e5RqismcNxh+XvxlCoc49FNMV8wEtN
        loCd8+uEjqir5KDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2B755A3B8C;
        Mon, 30 Aug 2021 09:36:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 19E34518DCCD; Mon, 30 Aug 2021 11:36:20 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v1] nvme: avoid race in shutdown namespace removal
Date:   Mon, 30 Aug 2021 11:36:18 +0200
Message-Id: <20210830093618.97657-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remove the siblings entry, we update ns->head->list, hence we
can't separate the removal and test for being empty. They have to be
in the same critical section to avoid a race.

Fixes: 5396fdac56d8 ("nvme: fix refcounting imbalance when all paths are down")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

I am able to hit this race window when I try to remove two paths
at the same time by making delete_controller asynchronous.

[   93.977701] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77"
[   93.994213] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress:NVMf:uuid:de63429f-50a4-4e03-ade6-0be27b75be77"
[   94.009093] del cdev ffff991a00b3c388 minor 0
[   94.009102] CPU: 2 PID: 13239 Comm: nvme Not tainted 5.14.0-rc4+ #29
[   94.009109] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   94.009112] Call Trace:
[   94.009119]  dump_stack_lvl+0x33/0x42
[   94.009133]  nvme_cdev_del+0x2d/0x60 [nvme_core]
[   94.009148]  nvme_mpath_shutdown_disk+0x41/0x50 [nvme_core]
[   94.009157]  nvme_ns_remove+0x199/0x1c0 [nvme_core]
[   94.009166]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[   94.009175]  nvme_do_delete_ctrl+0x43/0x60 [nvme_core]
[   94.009182]  nvme_sysfs_delete+0x42/0x60 [nvme_core]
[   94.009190]  kernfs_fop_write_iter+0x12c/0x1a0
[   94.009219]  new_sync_write+0x11c/0x1b0
[   94.009229]  vfs_write+0x1ea/0x250
[   94.009236]  ksys_write+0xa1/0xe0
[   94.009242]  do_syscall_64+0x37/0x80
[   94.009256]  entry_SYSCALL_64_after_hwframe+0x44/0xae

With the patch only one of the nvme_do_delete_ctrl() will see
last_path = true and I can't observe any crash.

Though one thing I am not really sure how it interacts with
nvme_init_ns_head() as we could be in running nvme_init_ns_head()
after we have set last_path = true. I haven't really figured
out yet what this would mean. Is this a real problem?

 drivers/nvme/host/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42b69f3c6e20..953d07d6a29d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3809,8 +3809,13 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	set_capacity(ns->disk, 0);
 	nvme_fault_inject_fini(&ns->fault_inject);
 
+	/* Synchronize with nvme_init_ns_head() */
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3830,13 +3835,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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

