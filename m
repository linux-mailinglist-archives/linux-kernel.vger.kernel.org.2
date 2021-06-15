Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F523A7988
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFOIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFOIzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:55:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C23A61424;
        Tue, 15 Jun 2021 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623747213;
        bh=kKl+dwSE+1mpdV00Nwtq36eOm8r1Np9GR2J4zMKETqw=;
        h=From:To:Cc:Subject:Date:From;
        b=iIjqDQCkREsuoyshVjxAlG26ViqPXxn07R7wHtY4bn+ow+zCoRhMDeMg7X6xjcTIA
         oHspnUL9EWEABb2Po9zPWAn915q1wN4lMnLeFeXDzNOizDvRRN4SQWzUhA/U3PyqvU
         h1bWVLokIJeSa8rI3kSEB77LS6Im7ZGJqgdd/jf/u/g4Mbnl7bEX9jcCquqdGPFCxm
         rBur5heW5klvj5nA8No67/s2yg+AAQC7oVBQARt6p4nmliNGdBnhPOUS20E/y96lqc
         fe7C/x2ru85m8A0Ef+w/7WPrFKBXohH9mDY8L3t6XuqavzCUCQJiTWTP7Xwb8Mbcrn
         ClhVdqnsMMISQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH v2 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Date:   Tue, 15 Jun 2021 11:53:25 +0300
Message-Id: <20210615085326.16134-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User process might want to share the device memory with another
driver/device, and to allow it to access it over PCIe (P2P).

To enable this, we utilize the dma-buf mechanism and add a dma-buf
exporter support, so the other driver can import the device memory and
access it.

The device memory is allocated using our existing allocation uAPI,
where the user will get a handle that represents the allocation.

The user will then need to call the new
uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.

The driver will return a FD that represents the DMA-BUF object that
was created to match that allocation.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
---
 include/uapi/misc/habanalabs.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a47a731e4527..aa3d8e0ba060 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -808,6 +808,10 @@ union hl_wait_cs_args {
 #define HL_MEM_OP_UNMAP			3
 /* Opcode to map a hw block */
 #define HL_MEM_OP_MAP_BLOCK		4
+/* Opcode to create DMA-BUF object for an existing device memory allocation
+ * and to export an FD of that DMA-BUF back to the caller
+ */
+#define HL_MEM_OP_EXPORT_DMABUF_FD	5
 
 /* Memory flags */
 #define HL_MEM_CONTIGUOUS	0x1
@@ -878,11 +882,26 @@ struct hl_mem_in {
 			/* Virtual address returned from HL_MEM_OP_MAP */
 			__u64 device_virt_addr;
 		} unmap;
+
+		/* HL_MEM_OP_EXPORT_DMABUF_FD */
+		struct {
+			/* Handle returned from HL_MEM_OP_ALLOC. In Gaudi,
+			 * where we don't have MMU for the device memory, the
+			 * driver expects a physical address (instead of
+			 * a handle) in the device memory space.
+			 */
+			__u64 handle;
+			/* Size of memory allocation. Relevant only for GAUDI */
+			__u64 mem_size;
+		} export_dmabuf_fd;
 	};
 
 	/* HL_MEM_OP_* */
 	__u32 op;
-	/* HL_MEM_* flags */
+	/* HL_MEM_* flags.
+	 * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
+	 * DMA-BUF file/FD flags.
+	 */
 	__u32 flags;
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
@@ -919,6 +938,13 @@ struct hl_mem_out {
 
 			__u32 pad;
 		};
+
+		/* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
+		 * DMA-BUF object that was created to describe a memory
+		 * allocation on the device's memory space. The FD should be
+		 * passed to the importer driver
+		 */
+		__u64 fd;
 	};
 };
 
-- 
2.25.1

