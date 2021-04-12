Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBBB35CAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhDLQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:10:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhDLQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:10:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lVz8e-0006oQ-GF; Mon, 12 Apr 2021 16:10:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] habanalabs/gaudi: Fix uninitialized return code rc when read size is zero
Date:   Mon, 12 Apr 2021 17:10:12 +0100
Message-Id: <20210412161012.1628202-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where size is zero the while loop never assigns rc and the
return value is uninitialized. Fix this by initializing rc to zero.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 639781dcab82 ("habanalabs/gaudi: add debugfs to DMA from the device")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8730b691ec61..b751652f80a8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6252,7 +6252,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 	dma_addr_t dma_addr;
 	void *kernel_addr;
 	bool is_eng_idle;
-	int rc, dma_id;
+	int rc = 0, dma_id;
 
 	kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
 						hdev, SZ_2M,
-- 
2.30.2

