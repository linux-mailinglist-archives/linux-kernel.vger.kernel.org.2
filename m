Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E333F4DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHWP76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhHWP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B33BC613D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629734354;
        bh=v7XnXeBow2G6ce8WpfzmV/K1G+h3g4PniQXQKxsLxhI=;
        h=From:To:Subject:Date:From;
        b=Yig+0HYJVkvehwrjBHiThLjpKauAVbUsCNvdx2NZSYsuFkb9xDVV1l5lascFoMn7O
         4GzzPW6B9ja4dF3mh6+u/xwXb0H6oErB7mn/+AGAt3qqJUWkZvGS8rB2fb00HGlJax
         MqqNMWT0GmPWkP0EJ5CTAoV95uDoBRSJb9AD1h3Yqzzx+D9mYKWSD0XpA0VAnRvvZB
         Ml8Rn8jkTaF5n4OwYl6Nlatd5duyJT196JHA5X9ymMLGTkPD2QDlQhDR4rpqj4jH6Z
         +q3s9VwETYDrMM8uORf+hqbJAhA1oZsh/Pd9nVFmCECcmR41L+ePd4XMkMfh1HTz6r
         SYdVQ60GXzhOQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs/gaudi: block ICACHE_BASE_ADDERESS_HIGH in TPC
Date:   Mon, 23 Aug 2021 18:59:09 +0300
Message-Id: <20210823155910.100371-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This register shouldn't be modified by user. Prefetch is disabled
in Gaudi.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_security.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 0d3240f1f7d7..cb265c00cf73 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -9559,6 +9559,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC0_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -10013,6 +10014,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC1_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -10466,6 +10468,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC2_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -10919,6 +10922,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC3_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -11372,6 +11376,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC4_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -11825,6 +11830,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC5_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -12280,6 +12286,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC6_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_MSS_CONFIG & 0x7F) >> 2);
@@ -12735,6 +12742,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask |= 1U << ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_TPC_STALL & 0x7F) >> 2);
+	mask |= 1U << ((mmTPC7_CFG_ICACHE_BASE_ADDERESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_RD_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_WR_RATE_LIMIT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_MSS_CONFIG & 0x7F) >> 2);
-- 
2.17.1

