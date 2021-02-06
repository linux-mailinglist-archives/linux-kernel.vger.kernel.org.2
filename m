Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66E1311F29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBFRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhBFRkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:40:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2294764E2A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612633200;
        bh=XX1Ezmq9b1glhJo4yYiu02uGXrH3eXsmRJjRIWPlrCk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sSWG4fE2FBhhLcL+zN96dcSitqQ4w81xWCFr7OaAkwz4oniFaM8ATItjfAOgcaeOj
         FH5nSOvefDr13qT6zLdVurIsHi3kkMmVV1fycpE64rwRZ/sfmK2g3cpWRERBWl3v/P
         PU+BcPPPfgEJ7O7XNjgT+TxwYBNlbGdAAFy+O/JqI3ocPMhdo4FMHHGrL0NsIS0F2M
         /LsYu6QkhGvLambhqMeEb60UnOTPJTGASXjdzkvLTV63nApmhUzdBK0tWHiRJrQTMo
         a8shNUtvkMJYylpLlqTutUVXVWAmNiwvLYToTdrH8fgWladx0SjW4Pz5BXdkhnn68L
         lXRfMW2Zjl04A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] habanalabs: return block size + block ID
Date:   Sat,  6 Feb 2021 19:39:53 +0200
Message-Id: <20210206173954.4662-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206173954.4662-1-ogabbay@kernel.org>
References: <20210206173954.4662-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user gives us a block address to get its ID to mmap it, he also
needs to get from us the block size to pass to the driver in the mmap
function.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  4 ++-
 drivers/misc/habanalabs/common/memory.c     | 19 +++++++++------
 drivers/misc/habanalabs/gaudi/gaudi.c       |  2 +-
 drivers/misc/habanalabs/goya/goya.c         |  2 +-
 include/uapi/misc/habanalabs.h              | 27 ++++++++++++++++-----
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 46c37b0c704a..dc9f5a83dfc9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -862,6 +862,8 @@ enum div_select_defs {
  *                   showing it to users.
  * @ack_protection_bits_errors: ack and dump all security violations
  * @get_hw_block_id: retrieve a HW block id to be used by the user to mmap it.
+ *                   also returns the size of the block if caller supplies
+ *                   a valid pointer for it
  * @hw_block_mmap: mmap a HW block with a given id.
  * @enable_events_from_fw: send interrupt to firmware to notify them the
  *                         driver is ready to receive asynchronous events. This
@@ -980,7 +982,7 @@ struct hl_asic_funcs {
 	u64 (*descramble_addr)(struct hl_device *hdev, u64 addr);
 	void (*ack_protection_bits_errors)(struct hl_device *hdev);
 	int (*get_hw_block_id)(struct hl_device *hdev, u64 block_addr,
-			u32 *block_id);
+				u32 *block_size, u32 *block_id);
 	int (*hw_block_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u32 block_id, u32 block_size);
 	void (*enable_events_from_fw)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 7171e8820a2d..7cadf75ebb81 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1289,12 +1289,13 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 }
 
-static int map_block(struct hl_device *hdev, u64 address, u64 *handle)
+static int map_block(struct hl_device *hdev, u64 address, u64 *handle,
+			u32 *size)
 {
 	u32 block_id = 0;
 	int rc;
 
-	rc = hdev->asic_funcs->get_hw_block_id(hdev, address, &block_id);
+	rc = hdev->asic_funcs->get_hw_block_id(hdev, address, size, &block_id);
 
 	*handle = block_id | HL_MMAP_TYPE_BLOCK;
 	*handle <<= PAGE_SHIFT;
@@ -1371,7 +1372,7 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
 	u64 block_handle, device_addr = 0;
-	u32 handle = 0;
+	u32 handle = 0, block_size;
 	int rc;
 
 	switch (args->in.op) {
@@ -1416,8 +1417,9 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 
 	case HL_MEM_OP_MAP_BLOCK:
 		rc = map_block(hdev, args->in.map_block.block_addr,
-							&block_handle);
-		args->out.handle = block_handle;
+				&block_handle, &block_size);
+		args->out.block_handle = block_handle;
+		args->out.block_size = block_size;
 		break;
 
 	default:
@@ -1437,7 +1439,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
 	u64 block_handle, device_addr = 0;
-	u32 handle = 0;
+	u32 handle = 0, block_size;
 	int rc;
 
 	if (!hl_device_operational(hdev, &status)) {
@@ -1524,8 +1526,9 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	case HL_MEM_OP_MAP_BLOCK:
 		rc = map_block(hdev, args->in.map_block.block_addr,
-							&block_handle);
-		args->out.handle = block_handle;
+				&block_handle, &block_size);
+		args->out.block_handle = block_handle;
+		args->out.block_size = block_size;
 		break;
 
 	default:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f937d90786b2..35342edd4a02 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8490,7 +8490,7 @@ static u64 gaudi_get_device_time(struct hl_device *hdev)
 }
 
 static int gaudi_get_hw_block_id(struct hl_device *hdev, u64 block_addr,
-					u32 *block_id)
+				u32 *block_size, u32 *block_id)
 {
 	return -EPERM;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c30524660761..ed566c52ccaa 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5390,7 +5390,7 @@ static void goya_ctx_fini(struct hl_ctx *ctx)
 }
 
 static int goya_get_hw_block_id(struct hl_device *hdev, u64 block_addr,
-				u32 *block_id)
+			u32 *block_size, u32 *block_id)
 {
 	return -EPERM;
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 64ae83b5f8e5..5a86b521a450 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -782,10 +782,10 @@ struct hl_mem_in {
 		/* HL_MEM_OP_MAP_BLOCK - map a hw block */
 		struct {
 			/*
-			 * HW block address to map, a handle will be returned
-			 * to the user and will be used to mmap the relevant
-			 * block. Only addresses from configuration space are
-			 * allowed.
+			 * HW block address to map, a handle and size will be
+			 * returned to the user and will be used to mmap the
+			 * relevant block. Only addresses from configuration
+			 * space are allowed.
 			 */
 			__u64 block_addr;
 		} map_block;
@@ -816,11 +816,26 @@ struct hl_mem_out {
 		__u64 device_virt_addr;
 
 		/*
-		 * Used for HL_MEM_OP_ALLOC and HL_MEM_OP_MAP_BLOCK.
+		 * Used in HL_MEM_OP_ALLOC
 		 * This is the assigned handle for the allocated memory
-		 * or mapped block
 		 */
 		__u64 handle;
+
+		struct {
+			/*
+			 * Used in HL_MEM_OP_MAP_BLOCK.
+			 * This is the assigned handle for the mapped block
+			 */
+			__u64 block_handle;
+
+			/*
+			 * Used in HL_MEM_OP_MAP_BLOCK
+			 * This is the size of the mapped block
+			 */
+			__u32 block_size;
+
+			__u32 pad;
+		};
 	};
 };
 
-- 
2.25.1

