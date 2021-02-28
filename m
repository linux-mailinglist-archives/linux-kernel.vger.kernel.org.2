Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5356932741A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhB1T20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 14:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhB1T2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 14:28:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 708EC64E99;
        Sun, 28 Feb 2021 19:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614540459;
        bh=kW7POxGOwrWcPIUXqo7FwDomMG+QfoT98XbmG/vJ8Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jg9pr/iyChDNcCtoUmKDtwXwehy+4KRu8W4fi9YzAoxuSgHkkTC6/aaMwEbnqt+L7
         p39nmUT1CnbieD9QSw/O5LmWrXSBZZ51595Rmt/3bhkPshGpdQg9Top/dx4WjxuuGB
         fP12urNF5At1lJEVmLAJHAcv9BRey2bJzIAdC+Iim/230bD2ic2RYYxiQ96bH5VJ0f
         pq+w69DbN3qYtlZzUIMoCCCfGAlO5f/EtgsSjGocn6TLZSCOVsw57AO8d2YwcsuxXU
         RHkrb2GVktLdL2brGlKMaP+vre1QpxLNCGW0+Xfu9Ksvy3INflyl7KqUqPRLaMt5k3
         flRBz788fKYJw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/2] habanalabs: update hl_boot_if.h
Date:   Sun, 28 Feb 2021 21:27:33 +0200
Message-Id: <20210228192733.12076-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228192733.12076-1-ogabbay@kernel.org>
References: <20210228192733.12076-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Update to the latest version of the file as supplied by the F/W.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e87f5a98e193..d17185b6aea9 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -170,6 +170,15 @@
  *					is set to the PI counter.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_FW_LD_COM_EN	Flexible FW loading communication
+ *					protocol is enabled.
+ *					Initialized in: preboot
+ *
+ * CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN	FW iATU configuration is enabled.
+ *					This bit if set, means the iATU has been
+ *					configured and is ready for use.
+ *					Initialized in: ppboot
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -195,6 +204,8 @@
 #define CPU_BOOT_DEV_STS0_CLK_GATE_EN			(1 << 13)
 #define CPU_BOOT_DEV_STS0_HBM_ECC_EN			(1 << 14)
 #define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN			(1 << 15)
+#define CPU_BOOT_DEV_STS0_FW_LD_COM_EN			(1 << 16)
+#define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.25.1

