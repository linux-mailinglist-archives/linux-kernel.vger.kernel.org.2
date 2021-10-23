Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57143829B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhJWJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 05:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhJWJXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:23:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C18116105A;
        Sat, 23 Oct 2021 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980846;
        bh=+59WMV3Dlz1AP4Ei8SuUj51Ty+lB2iDdY5m0xFBMPdo=;
        h=From:To:Cc:Subject:Date:From;
        b=mOHfaMtFi2+smdUAbwKDIe5GC78AMa3rGA/wzQkXQsHJpSAXvA/Bqw0i9N/7gTh8z
         KDBkCyZl07zMvUXvS7q1sTvBzU2p26aY7Bu1g+0QEZRPX+8a+mUJc32IRFsHMdB2vj
         x96LAeBoQtfNIYEj1N1cmx8wP7t0IYSTkHvW/5kcp/Dhy5T5AzlgARKtDXsYre/J9W
         +5QjBpwFe9ylCtVAMqnysmU6Leh8t/wwYOMxRl8hlzW/qZ4XNss/NQjGOVufDiV7v+
         IxfPhm1WTnmoVcBp+JMvUfAsPVIRTtivpk2fNbQi9Vq4KLjwb6qX9/D0RnLWXc7QjR
         Eq+Y7nQTlKKYg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/2] habanalabs: modify wait for boot fit in dynamic FW load
Date:   Sat, 23 Oct 2021 12:20:40 +0300
Message-Id: <20211023092041.2364497-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In the dynamic FW load protocol the boot status is updated to
"Ready to Boot" once uboot is active.

Polling on other boot status values is a residue of code duplication
from the static protocol and should be removed.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 4e68fb9d2a6b..025707a21882 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2060,7 +2060,6 @@ static int hl_fw_dynamic_wait_for_boot_fit_active(struct hl_device *hdev,
 		hdev,
 		le32_to_cpu(dyn_loader->comm_desc.cpu_dyn_regs.cpu_boot_status),
 		status,
-		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT),
 		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		dyn_loader->wait_for_bl_timeout);
-- 
2.25.1

