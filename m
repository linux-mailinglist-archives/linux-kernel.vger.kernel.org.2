Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C63D2296
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhGVKgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhGVKgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A02F61222;
        Thu, 22 Jul 2021 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626952608;
        bh=6YpfqfDCmyEQ30W2o7ecYMGa3W4dHBYkFLk1xq9rsQw=;
        h=From:To:Cc:Subject:Date:From;
        b=UqUm5wyre3rGzj5bavi8OsyUAJy29HXv3IkdErHCGrooqC+YwIo50WTX3x3t/UXtV
         WTUqU235W8XMoPd4OcLekWnsW2RedHypug/bgF4SR8iddEQKsp1CmYG27cjctgoq4t
         hfSnHGYqLLo45jAuIjlLrzP9qPoYgyNMCVxkQMo7zfUrUzGc6qXJq3kL7fkbp8ary/
         SnaVLxAAVAmI9tPRmoX+lWVl0ckAH9yyL0VxCQI+bbAQXS458vFNoDd3ykOvDw6ohG
         uUn0Rr1OXIZp/4iFUuJGKEvfm2bEhnDk8qpMs2nKM2dcwJHA7HaEypPUFJkDLSvMfg
         Wq3C5feBNP9bw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: make set_pci_regions asic function
Date:   Thu, 22 Jul 2021 14:16:41 +0300
Message-Id: <20210722111643.17568-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In order to better support variants of the same ASIC
the set_pci_regions function is now an ASIC function which
allows each ASIC to implement it internally, thus keeping
all definitions static to the file.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 5 +++--
 drivers/misc/habanalabs/goya/goya.c         | 5 +++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 38617d4a34d5..75be25d47c98 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1160,6 +1160,7 @@ struct fw_load_mgr {
  * @init_cpu_scrambler_dram: Enable CPU specific DRAM scrambling
  * @state_dump_init: initialize constants required for state dump
  * @get_sob_addr: get SOB base address offset.
+ * @set_pci_memory_regions: setting properties of PCI memory regions
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1288,6 +1289,7 @@ struct hl_asic_funcs {
 	void (*init_cpu_scrambler_dram)(struct hl_device *hdev);
 	void (*state_dump_init)(struct hl_device *hdev);
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
+	void (*set_pci_memory_regions)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2fe14a138f37..0cb21440b5ff 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1867,7 +1867,7 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	hdev->supports_staged_submission = true;
 	hdev->supports_wait_for_multi_cs = true;
 
-	gaudi_set_pci_memory_regions(hdev);
+	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
 	return 0;
 
@@ -9463,7 +9463,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.init_firmware_loader = gaudi_init_firmware_loader,
 	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
 	.state_dump_init = gaudi_state_dump_init,
-	.get_sob_addr = gaudi_get_sob_addr
+	.get_sob_addr = gaudi_get_sob_addr,
+	.set_pci_memory_regions = gaudi_set_pci_memory_regions
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index fad130f6a118..9d66bdda8789 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -963,7 +963,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	hdev->allow_external_soft_reset = true;
 	hdev->supports_wait_for_multi_cs = false;
 
-	goya_set_pci_memory_regions(hdev);
+	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
 	return 0;
 
@@ -5670,7 +5670,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.init_firmware_loader = goya_init_firmware_loader,
 	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram,
 	.state_dump_init = goya_state_dump_init,
-	.get_sob_addr = &goya_get_sob_addr
+	.get_sob_addr = &goya_get_sob_addr,
+	.set_pci_memory_regions = goya_set_pci_memory_regions,
 };
 
 /*
-- 
2.25.1

