Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745C63F0505
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhHRNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237664AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D614660238;
        Wed, 18 Aug 2021 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293981;
        bh=3O9ymya0cB4PL3SxKYky55pjj6ERC1E8m3yDL+7ywno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxMEuQNfazHKfYsNq5TomVAdarPQ7e1SH6YOcgioTtbP7StByN1aXru7o6+FsGhBN
         jBXiq3mKykAB0yDbbVSQHt9kp8RJwkZUOTLxyApnlpigEcPsU7k0q873xfkC8tyNVc
         XpWShSnnO2gy2FYB9RH9uv8huXpm2wLsVQ+Qky07KTjuBnMm1XdnOrQgdevYLrKIZw
         /FKoRQgRgBDjdwMdvYYuYV0cmQBzinfGgpeLtnz/FOpVPhakOM/pYWIYH5EUW4y5hP
         PBmbbGZjEgEK1P6PiLfxkRevirz3uMPN7J/rGRfw7Cw3ENzrbqq0AIGNXjH6I6ZrkR
         KRzrsqfS8uZFw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 13/16] habanalabs/gaudi: unmask out of bounds SLM access interrupt
Date:   Wed, 18 Aug 2021 16:39:19 +0300
Message-Id: <20210818133922.63637-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The out of bounds SLM access TPC interrupt indicates a severe compiler
bug and needs to be informed to user.
This interrupt is currently masked so unmask it.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6671d1aca8e1..c8bd76e30679 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2686,7 +2686,7 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 				tpc_id < TPC_NUMBER_OF_ENGINES;
 				tpc_id++, tpc_offset += TPC_CFG_OFFSET) {
 		/* Mask all arithmetic interrupts from TPC */
-		WREG32(mmTPC0_CFG_TPC_INTR_MASK + tpc_offset, 0x8FFF);
+		WREG32(mmTPC0_CFG_TPC_INTR_MASK + tpc_offset, 0x8FFE);
 		/* Set 16 cache lines */
 		WREG32_FIELD(TPC0_CFG_MSS_CONFIG, tpc_offset,
 				ICACHE_FETCH_LINE_NUM, 2);
-- 
2.17.1

