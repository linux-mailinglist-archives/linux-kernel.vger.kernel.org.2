Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248B042A5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhJLNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhJLNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B19B961040;
        Tue, 12 Oct 2021 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634046059;
        bh=Crnf7/MBmrhOvcEa5NivXhy6VKW4OjTUlb45xNL5jCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSItp6XkrACl3U6+vUFa2ZIizqm6DI3YKXdP5GWdgONR88hAsXSmUOFelYsh8d9oc
         AZHzMhhiOQql1VyyWYVzCgAfbmnO4VtMZYODypS+h2ysjHZkcpwLvJInOF1YHoiQka
         EverQ9FMpcmhIBcQkHjdtdI3FfOPq2hTVCXm7FWlfEgJ5+1/kKXIQT8kh3T5CWcMl7
         nIwMWObyDmS8L2TgMEXly6z+kr+U44pqksEMruMbtQbEAuY+YzIrM4xWQkodvgFVz3
         XtD/++oQpXkeZt8U4gkZ9rbs/GqC0Zqt15ppNHCtfy8lJ5HZdf0s5CVfjWbMexD+U3
         AmGijrmaNgCFQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 2/3] habanalabs: initialize hpriv fields before adding new node
Date:   Tue, 12 Oct 2021 16:40:50 +0300
Message-Id: <20211012134051.73555-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012134051.73555-1-ogabbay@kernel.org>
References: <20211012134051.73555-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

When adding a new node to the hpriv list, the driver should
initialize its fields before adding the new node.

Otherwise, there may be some small chance of another thread traversing
that list and accessing the new node's fields without them being
initialized.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_drv.c   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 1da56069750a..949d1b5c5c41 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -225,6 +225,17 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	if (!hpriv)
 		return -ENOMEM;
 
+	/* Prevent other routines from reading partial hpriv data by
+	 * initializing hpriv fields before inserting it to the list
+	 */
+	hpriv->hdev = hdev;
+	filp->private_data = hpriv;
+	hpriv->filp = filp;
+	hpriv->is_control = true;
+	nonseekable_open(inode, filp);
+
+	hpriv->taskpid = find_get_pid(current->pid);
+
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	if (!hl_device_operational(hdev, NULL)) {
@@ -238,19 +249,15 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
-	hpriv->hdev = hdev;
-	filp->private_data = hpriv;
-	hpriv->filp = filp;
-	hpriv->is_control = true;
-	nonseekable_open(inode, filp);
-
-	hpriv->taskpid = find_get_pid(current->pid);
-
 	return 0;
 
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
+	filp->private_data = NULL;
+	put_pid(hpriv->taskpid);
+
 	kfree(hpriv);
+
 	return rc;
 }
 
-- 
2.17.1

