Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636CA30C720
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhBBRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236942AbhBBQ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:56:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA4A64F7E;
        Tue,  2 Feb 2021 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284967;
        bh=jjQmM8mh6rhcpK1tq4WpXVyL9f7prV3gj5SjVVDnrec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMAj+dSXyIPAH6Hj7T9Cf1Eiy+fn+B1QZHmiIMCoYfcprNl1aWvwIEshrZhzZ4Qew
         5dU2KrM1TyhLJ5Qpns7VFpqOojrcBWDVfMmSaINjNJuBLGeAnAYoCa3gdRFH5EjY5g
         oMDm33NyC2w1h9KIhWsADcrcCUruWeRKRS2EFqV5pf9qOfKDKNciG03NMpFUQ4PaHu
         UJ4oFDTFOWkdYHKeO77q72lFidZxDjlkS08EWkdYTXOXzdnbVxQKOyMrqAFKIqUQBs
         vcYT4HQ1SanlIpK9jG45iUfHBWX4hDc+3nLPlwio+g5IAP2H+L6ll3s15Bv6r89B3f
         8VP64a+HS7oiw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs: support fetching first available user CQ
Date:   Tue,  2 Feb 2021 18:55:58 +0200
Message-Id: <20210202165600.4620-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202165600.4620-1-ogabbay@kernel.org>
References: <20210202165600.4620-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

User must be aware of the available CQs when it needs to use them.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h       | 2 ++
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 3 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c             | 3 +++
 drivers/misc/habanalabs/goya/goya.c               | 3 +++
 include/uapi/misc/habanalabs.h                    | 3 +++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3c54010f7ab9..98163317ec43 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -411,6 +411,7 @@ struct hl_mmu_properties {
  * @first_available_user_mon: first monitor available for the user
  * @first_available_user_msix_interrupt: first available msix interrupt
  *                                       reserved for the user
+ * @first_available_cq: first available CQ for the user.
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  * @fw_security_disabled: true if security measures are disabled in firmware,
@@ -475,6 +476,7 @@ struct asic_fixed_properties {
 	u16				first_available_user_sob[HL_MAX_DCORES];
 	u16				first_available_user_mon[HL_MAX_DCORES];
 	u16				first_available_user_msix_interrupt;
+	u16				first_available_cq[HL_MAX_DCORES];
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index e86f46d4b613..03af61cecd37 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -397,7 +397,8 @@ static int sync_manager_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 			prop->first_available_user_sob[args->dcore_id];
 	sm_info.first_available_monitor =
 			prop->first_available_user_mon[args->dcore_id];
-
+	sm_info.first_available_cq =
+			prop->first_available_cq[args->dcore_id];
 
 	return copy_to_user(out, &sm_info, min_t(size_t, (size_t) max_size,
 			sizeof(sm_info))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 006c34ae35c2..8fc0de3cf3a9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -529,6 +529,9 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 
 	prop->first_available_user_msix_interrupt = USHRT_MAX;
 
+	for (i = 0 ; i < HL_MAX_DCORES ; i++)
+		prop->first_available_cq[i] = USHRT_MAX;
+
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 53db7e966866..d26b405f0c17 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -457,6 +457,9 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 
 	prop->first_available_user_msix_interrupt = USHRT_MAX;
 
+	for (i = 0 ; i < HL_MAX_DCORES ; i++)
+		prop->first_available_cq[i] = USHRT_MAX;
+
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ebde42b37b43..64ae83b5f8e5 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -414,10 +414,13 @@ struct hl_pll_frequency_info {
  * struct hl_info_sync_manager - sync manager information
  * @first_available_sync_object: first available sob
  * @first_available_monitor: first available monitor
+ * @first_available_cq: first available cq
  */
 struct hl_info_sync_manager {
 	__u32 first_available_sync_object;
 	__u32 first_available_monitor;
+	__u32 first_available_cq;
+	__u32 reserved;
 };
 
 /**
-- 
2.25.1

