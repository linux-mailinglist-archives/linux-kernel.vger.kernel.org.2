Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83D3A671F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhFNMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233786AbhFNMxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C18D613EF;
        Mon, 14 Jun 2021 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675075;
        bh=03d9WI+sn21Ykan0MoaIzOfYeY2BpiLdpB+5Ys4Hffo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpmmCxaG/cmDdoyhpRIOEFU2oPxXTO3J1UU1pgsIm84HxsKBF6anv5Go0qY5NO7Zg
         RR/s68A6ye0AgRiHhjZRMMMHT2JwcqmjtlpseK0tKK2ilAtPa8OIa+/e8tFaeCxsQK
         fSTv/neOdvPnxzBYiBEDNB7ZulH8g7vZ5ycMo99JwxmEV4ExT+jH/tm+RpmNYf/ilg
         5QgO2mLeCpn1aAZBPUgSAMik5pTwtYMEa5M+cwbvRYWovqvTsWyWzRmTMOsKL0x5Rt
         3tGCDlizRhG5w5lljDvrqoUhJqNNxF7cvkclTuaiwq7E7gzBgx88LMOx/cxUN0M8IO
         DFhLUqr/u79+w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 8/9] habanalabs/goya: add '__force' attribute to suppress false alarm
Date:   Mon, 14 Jun 2021 15:50:59 +0300
Message-Id: <20210614125100.17627-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix (suppress) the following sparse warnings:
'warning: cast removes address space of expression'

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e91b730baebd..5a837c0b4d76 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2937,7 +2937,7 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 
 	*dma_handle = hdev->asic_prop.sram_base_address;
 
-	base = (void *) hdev->pcie_bar[SRAM_CFG_BAR_ID];
+	base = (__force void *) hdev->pcie_bar[SRAM_CFG_BAR_ID];
 
 	switch (queue_id) {
 	case GOYA_QUEUE_ID_MME:
-- 
2.25.1

