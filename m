Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17041981F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhI0Pot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235100AbhI0Pos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BCF160F94;
        Mon, 27 Sep 2021 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632757390;
        bh=P86cBH1nf5DfPMZ7Grlz7Pivw0MvErpNkzJ45WZUB2I=;
        h=From:To:Cc:Subject:Date:From;
        b=c+JNOFl2zUqUZoLIu0lznJURo6n+3GWiKgHBRErKfwx1Vkvxlg3aA5vGHd4xmmGjt
         xvfsaF7ytHSDsXUH2kOKWkGOqJjX5WUoirqc5GGoW3PkcCpFJYX0SopwzFYvI50YeB
         musN90yK8x4SBq0a3Feu3JL3Zc2V1H7diD8AsocJk6JLpPbplMt9l+oraAZgG1UDkJ
         6QrLs/TBVaHJcTFM79ycuv3M41cZ9A/dE/zgZhkQkW6Wgc4U+wDHDyL7BQfVukL1Be
         lEpqlDDAff+hybok1TodgI1AdxbLrZLot2eiyqRmKIrg9Sc+bOTl9DaX3roMeb1ACO
         GXKVD7awT7yZw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <kbusch@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
Subject: [PATCHv2] nvme: add command id quirk for apple controllers
Date:   Mon, 27 Sep 2021 08:43:06 -0700
Message-Id: <20210927154306.387437-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some apple controllers use the command id as an index to implementation
specific data structures and will fail if the value is out of bounds.
The nvme driver's recently introduced command sequence number breaks
this controller.

Provide a quirk so these spec incompliant controllers can function as
before. The driver will not have the ability to detect bad completions
when this quirk is used, but we weren't previously checking this anyway.

The quirk bit was selected so that it can readily apply to stable.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
Cc: Sven Peter <sven@svenpeter.dev>
Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
Reported-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: fixed logical bug checking the quirk setting

 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..7712a8f78337 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -978,6 +978,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP)) {
@@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	nvme_req(req)->genctr++;
+	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		nvme_req(req)->genctr++;
 	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..ed79a6c7e804 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -138,6 +138,12 @@ enum nvme_quirks {
 	 * 48 bits.
 	 */
 	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
+
+	/*
+	 * The controller requires the command_id value be be limited, so skip
+	 * encoding the generation sequence number.
+	 */
+	NVME_QUIRK_SKIP_CID_GEN			= (1 << 17),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..456a0e8a5718 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3369,7 +3369,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
-				NVME_QUIRK_SHARED_TAGS },
+				NVME_QUIRK_SHARED_TAGS |
+				NVME_QUIRK_SKIP_CID_GEN },
 
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
-- 
2.25.4

