Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8831CCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBPPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:09:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPPJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:09:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 916BF64E04;
        Tue, 16 Feb 2021 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613488121;
        bh=etXw2kOThD0HEFq/1K4IvR8VQW1u7sHDbpF8zl47wYE=;
        h=From:To:Cc:Subject:Date:From;
        b=WuR6SA8ZzTmJOQDg7BB3qTRj20icHyUOz9cxepfYCGRKmLWWNofD3N8V0ZC3CHVDV
         aBYHfKQZ+2ztVPy7fXInRZlXFfFSh/sL3nMD3up1lSuqsIkc5EBIguEfOBLMEKFpvC
         VDtzN2YaMkU58aHHNd7JstiM6fttRQxK4kiWHuDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ogabbay@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: habanalabs: remove unused dentry pointer for debugfs files
Date:   Tue, 16 Feb 2021 16:08:28 +0100
Message-Id: <20210216150828.3855810-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dentry for the created debugfs file was being saved, but never used
anywhere.  As the pointer isn't needed for anything, and the debugfs
files are being properly removed by removing the parent directory,
remove the saved pointer as well, saving a tiny bit of memory and logic.

Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tomer Tayar <ttayar@habana.ai>
Cc: Moti Haimovski <mhaimovski@habana.ai>
Cc: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 5 +----
 drivers/misc/habanalabs/common/habanalabs.h | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index cef716643979..770b0131397d 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -965,7 +965,6 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
 	int count = ARRAY_SIZE(hl_debugfs_list);
 	struct hl_debugfs_entry *entry;
-	struct dentry *ent;
 	int i;
 
 	dev_entry->hdev = hdev;
@@ -1072,13 +1071,11 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				&hl_stop_on_err_fops);
 
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
-
-		ent = debugfs_create_file(hl_debugfs_list[i].name,
+		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
 					dev_entry->root,
 					entry,
 					&hl_debugfs_fops);
-		entry->dent = ent;
 		entry->info_ent = &hl_debugfs_list[i];
 		entry->dev_entry = dev_entry;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 60e16dc4bcac..48937e9eed83 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1393,12 +1393,10 @@ struct hl_info_list {
 
 /**
  * struct hl_debugfs_entry - debugfs dentry wrapper.
- * @dent: base debugfs entry structure.
  * @info_ent: dentry realted ops.
  * @dev_entry: ASIC specific debugfs manager.
  */
 struct hl_debugfs_entry {
-	struct dentry			*dent;
 	const struct hl_info_list	*info_ent;
 	struct hl_dbg_device_entry	*dev_entry;
 };
-- 
2.30.1

