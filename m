Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86021362EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhDQJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235938AbhDQJHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 640AF6120A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650407;
        bh=XjYotBsXS9vRUKhkgkQVRrqVlZ2scED/2l/UEdZyNms=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Psi/ejpJCodsT01+WK4kynApmNwMshJXkYzBA0afdemeBcLoZXlhb2/jiMPZ1s1+G
         l94gf1gfkOzIz4kfvLK1YAVRy60VcXiaq84HhCBNEyCLhIR8jb40ZmpJOQGswjaZST
         m02FgWbtSpnll4iB0E1b5vGxZTd8qzH0y0I6nMrxKVBNTsKF/Mi2GZmSAoRac8vgj2
         VVztFskay+QZv/swYS00Fhx/hW+HVNgsfA2PDrbkCpt4e6FZL8SHlzQOv6gqr4TS3Y
         7wByMvedg+Tqwg1yf7lDI2pmuJ8dUO/j00YY7pdR6KfKLeoRkxeMMkekzNqWsw4QBr
         urZNpsgm4+/Gg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] habanalabs: update firmware files to latest
Date:   Sat, 17 Apr 2021 12:06:34 +0300
Message-Id: <20210417090638.9802-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the firmware files to the latest from the firmware team.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/cpucp_if.h   | 4 +++-
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 27cd0ba99aa3..bf10ca8d2457 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -107,7 +107,9 @@ enum pq_init_status {
 	PQ_INIT_STATUS_NA = 0,
 	PQ_INIT_STATUS_READY_FOR_CP,
 	PQ_INIT_STATUS_READY_FOR_HOST,
-	PQ_INIT_STATUS_READY_FOR_CP_SINGLE_MSI
+	PQ_INIT_STATUS_READY_FOR_CP_SINGLE_MSI,
+	PQ_INIT_STATUS_LEN_NOT_POWER_OF_TWO_ERR,
+	PQ_INIT_STATUS_ILLEGAL_Q_ADDR_ERR
 };
 
 /*
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e0a259e0495c..84c14688d69a 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -8,7 +8,7 @@
 #ifndef HL_BOOT_IF_H
 #define HL_BOOT_IF_H
 
-#define LKD_HARD_RESET_MAGIC		0xED7BD694
+#define LKD_HARD_RESET_MAGIC		0xED7BD694 /* deprecated - do not use */
 #define HL_POWER9_HOST_MAGIC		0x1DA30009
 
 #define BOOT_FIT_SRAM_OFFSET		0x200000
-- 
2.25.1

