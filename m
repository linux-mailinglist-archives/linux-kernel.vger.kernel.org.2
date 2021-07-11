Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC53C3C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhGKM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhGKM5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80AE0601FE;
        Sun, 11 Jul 2021 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008066;
        bh=m9Il21Nm94D/8kcoLBfIjtVdA3hAFKmeost5b9tq6Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLXAYgR0731YpX92sUsUpg9wi0gqPVZUVUMRUiZc8YCMGcPAoAHuwKU/BYXeoCRyB
         w9qNcGj2clUZgXH9uonM3POB1XVEKdJhK7/Fp7UDwtSRpwns/E6g1CFkBhFU/uh/SO
         6GHYSOtOvLhWoMUUn+YgGlbgiyLbBUl8k3HiSMq+yr9QyRA+zwbePt2zJ9B5iKwGOZ
         zWIlSovl4gtJjvUEXA+0Qs1Ztyt9yiUy04Vsv+PexOWx3/lreL4iE9KAx01refrDO0
         H2QiBkVkfDzYaKURaj/oYZmlPkcry4ebpj1nVYIX2MD6sjKrvrCblFK7GUu4Ej0wk1
         /Chf1rvN+m7GQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zvika Yehudai <zyehudai@habana.ai>
Subject: [PATCH 2/7] habanalabs: rename cb_mmap to mmap
Date:   Sun, 11 Jul 2021 15:54:13 +0300
Message-Id: <20210711125418.17533-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zvika Yehudai <zyehudai@habana.ai>

This function will be used for more mmap operations than just
mmaping CBs.

Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h     | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c           | 4 ++--
 drivers/misc/habanalabs/goya/goya.c             | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 719168c980a4..58afefcd74f3 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -552,7 +552,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 
 	vma->vm_private_data = cb;
 
-	rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
+	rc = hdev->asic_funcs->mmap(hdev, vma, cb->kernel_address,
 					cb->bus_address, cb->size);
 	if (rc) {
 		spin_lock(&cb->lock);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9aedea471ebe..6affad6bc1b9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1024,7 +1024,7 @@ struct fw_load_mgr {
  *                hw_fini and before CS rollback.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
- * @cb_mmap: maps a CB.
+ * @mmap: maps a memory.
  * @ring_doorbell: increment PI on a given QMAN.
  * @pqe_write: Write the PQ entry to the PQ. This is ASIC-specific
  *             function because the PQs are located in different memory areas
@@ -1143,7 +1143,7 @@ struct hl_asic_funcs {
 	void (*halt_engines)(struct hl_device *hdev, bool hard_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
-	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
+	int (*mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size);
 	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
 	void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7dd36d1cb39e..14d0f6d9a383 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4299,7 +4299,7 @@ static int gaudi_resume(struct hl_device *hdev)
 	return gaudi_init_iatu(hdev);
 }
 
-static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+static int gaudi_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int rc;
@@ -9313,7 +9313,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.halt_engines = gaudi_halt_engines,
 	.suspend = gaudi_suspend,
 	.resume = gaudi_resume,
-	.cb_mmap = gaudi_cb_mmap,
+	.mmap = gaudi_mmap,
 	.ring_doorbell = gaudi_ring_doorbell,
 	.pqe_write = gaudi_pqe_write,
 	.asic_dma_alloc_coherent = gaudi_dma_alloc_coherent,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 4144a8445eef..017c913f7b5a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2798,7 +2798,7 @@ int goya_resume(struct hl_device *hdev)
 	return goya_init_iatu(hdev);
 }
 
-static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+static int goya_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 			void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int rc;
@@ -5584,7 +5584,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_engines = goya_halt_engines,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
-	.cb_mmap = goya_cb_mmap,
+	.mmap = goya_mmap,
 	.ring_doorbell = goya_ring_doorbell,
 	.pqe_write = goya_pqe_write,
 	.asic_dma_alloc_coherent = goya_dma_alloc_coherent,
-- 
2.25.1

