Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44DF3AE407
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUH02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUH01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B838161026;
        Mon, 21 Jun 2021 07:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624260253;
        bh=NlLp4SHgPWDNBC8Iwd4sT87u6nl2o7uXKt/G6Zzn7UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hji63fnXSCVaaJd0tTlctdjEnPCQR95A1uI/qszNtiYQHf8PJcSOsT4h00JVqE+S5
         gMyEmqe472XI6X6OEbOE4CzC84LNW14HvFEGlOnEQeRqc8NoY+7xk9O1QrsMueJERw
         h56hMG5j+8Shc3dcAmfq+QfAYYEbarsgSttAc5vDTosLTqURxEWYTVFOmBK9oT+vxM
         PoJWudDB2WVQb1tTzDN1qzEiUq6cy9YoBoIjrAccMd9lPwKH6JmClQJeGrw0hbtRF9
         Mk+xRHh3Aw2iiHL33s0KOfFcoaVM0468Cy7uiovfngOuFfsZQZlhwufgOv9Hug/Xc/
         2Bax8rr8Z0wpA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 2/5] habanalabs: get lower/upper 32 bits via masking
Date:   Mon, 21 Jun 2021 10:24:03 +0300
Message-Id: <20210621072406.5421-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072406.5421-1-ogabbay@kernel.org>
References: <20210621072406.5421-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix multiple similar occurrences of the following sparse warning:
'warning: cast truncates bits from constant value
(7ffc113000 becomes fc113000)'

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 drivers/misc/habanalabs/goya/goya.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index be830948e051..4a75df240cfc 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3858,7 +3858,7 @@ static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->boot_err1_reg = mmCPU_BOOT_ERR1;
 	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
 	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
-	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
+	static_loader->sram_offset_mask = ~(lower_32_bits(SRAM_BASE_ADDR));
 }
 
 static void gaudi_init_firmware_loader(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 06f5f1439e69..755e08cf2ecc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2484,7 +2484,7 @@ static void goya_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->boot_err1_reg = mmCPU_BOOT_ERR1;
 	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
 	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
-	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
+	static_loader->sram_offset_mask = ~(lower_32_bits(SRAM_BASE_ADDR));
 }
 
 static void goya_init_firmware_loader(struct hl_device *hdev)
-- 
2.25.1

