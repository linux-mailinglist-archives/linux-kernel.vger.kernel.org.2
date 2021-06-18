Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F943ACB15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFRMii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhFRMif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:38:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93FB8613EC;
        Fri, 18 Jun 2021 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624019785;
        bh=kKl+dwSE+1mpdV00Nwtq36eOm8r1Np9GR2J4zMKETqw=;
        h=From:To:Cc:Subject:Date:From;
        b=k5YrrBAxdE8zUmY8WvvE6MJEHD4yCIfdhvVUBlI/qsUYJjYXfbKU78ApJg64xU1w0
         7qVG5t7WmchDe1sFQazK5BroSYVUpuwWCeJQjZKn+NVSZEZR83wuOrbwgzND8hO6xj
         LeGInqvzq3wnMOuT582NCuDiz8hpEMnM5/fItlJtMGeIUVem4IjyF9PZlr21qPYRcw
         1OrO4AmqhBJCzw7ReLn/CQ97OKXWmWIWJekrO+4rgfXkdFWmthIQCpPPjZbYiMWg6S
         v8GMav3uPaH40/Rv2M1px0v63R1WEz2KC51rodtiVAv48rOedfjrayds0BLFUoeUOa
         G8T2S2M7U15bw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Date:   Fri, 18 Jun 2021 15:36:13 +0300
Message-Id: <20210618123615.11456-1-ogabbay@kernel.org>
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

