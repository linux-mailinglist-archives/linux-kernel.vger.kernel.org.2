Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F43AB63A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhFQOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhFQOnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B24AA613BF;
        Thu, 17 Jun 2021 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623940856;
        bh=cciTma9NGACs3NCBVSWNLnqjxFGTI3CpYRsIyqJS/lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBBS4fS2qNa3G96i9GEJRyOmEBzVihw1+W4wgRm8BtoOGmRcsi0llTA3lVGljkCaU
         hEBDHf8y4J9gs+I5FQKaNN2E83nG1+D8ssojICynRc/07RzPG3y5YkeuG8rZCTDn6S
         y42W+nHv2pRB4Q0eiihYrQByDShlZQ29mf4dlsj7zRLapcRaIZ7PAz/cs7y0d4UEXe
         PqPuqYO3mIu3J/ls10fPUzutEZUT7RBoGE9ETNfbLhFGmT67TSBlwwzP2fylWWyE+b
         J+7Bl2jf5g8e35A64AWqKZ3xWNGB7QVF+S12drd+/schTVs04rLCv5JwhReKYziVnd
         JnDqx+nynG7uA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/3] debugfs: add skip_reset_on_timeout option
Date:   Thu, 17 Jun 2021 17:40:48 +0300
Message-Id: <20210617144048.4655-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617144048.4655-1-ogabbay@kernel.org>
References: <20210617144048.4655-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

To be able to debug long-running CS better, without changing the
userspace code, we are adding a new option through debugfs interface
to skip the reset of the device in case of CS timeout.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 8 ++++++++
 drivers/misc/habanalabs/common/command_submission.c | 1 +
 drivers/misc/habanalabs/common/debugfs.c            | 5 +++++
 drivers/misc/habanalabs/common/habanalabs.h         | 3 +++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index c78fc9282876..e78ceb1f70b3 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -207,6 +207,14 @@ Contact:        ogabbay@kernel.org
 Description:    Sets the PCI power state. Valid values are "1" for D0 and "2"
                 for D3Hot
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/skip_reset_on_timeout
+Date:           Jun 2021
+KernelVersion:  5.13
+Contact:        ynudelman@habana.ai
+Description:    Sets the skip reset on timeout option for the device. Value of
+                "0" means device will be reset in case some CS has timed out,
+                otherwise it will not be reset.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
 KernelVersion:  5.6
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 6d51f54030c1..adedb288d452 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -663,6 +663,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
 	cs->timeout_jiffies = timeout;
 	cs->skip_reset_on_timeout =
+		hdev->skip_reset_on_timeout ||
 		!!(flags & HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT);
 	cs->submission_time_jiffies = jiffies;
 	INIT_LIST_HEAD(&cs->job_list);
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 8381155578a0..703d79fb6f3f 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1278,6 +1278,11 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry->root,
 				&dev_entry->blob_desc);
 
+	debugfs_create_x8("skip_reset_on_timeout",
+				0644,
+				dev_entry->root,
+				&hdev->skip_reset_on_timeout);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f8b7080e0570..12d9dc42e05e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2222,6 +2222,8 @@ struct hl_mmu_funcs {
  * @supports_staged_submission: true if staged submissions are supported
  * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
  *                    triggered, and cleared after it is shared with preboot.
+ * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
+ *                         complete instead.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2337,6 +2339,7 @@ struct hl_device {
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
 	u8				curr_reset_cause;
+	u8				skip_reset_on_timeout;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
-- 
2.25.1

