Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1B33A4E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhCNM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235100AbhCNM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:59:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DD0E64EE5;
        Sun, 14 Mar 2021 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615726757;
        bh=9kdQ/sN+ePokgbPjiuVEufaNqeH8JcbaMw4l2I5DE3A=;
        h=From:To:Cc:Subject:Date:From;
        b=aU14JMC3kZIuY3epm1FTHxflhvH35fehJ+8jyTu4BqjeOGB9n1aSVFmSuDAoqaFmL
         bX++0aleAgakV8GmjGeQjs/DoP+7mq400Y9E/RqZi/jSKQJkBB2EedMUnG+XwhP+Vo
         cOknwPe4je4Mxnicn2zoj6eDUMDAnB0etEwUgPRqZTZlQJcBW8yTRgKE8wo3s3VHa1
         xizJ/qC3JrJwuzEY8gucXtuk7vmL51EqnxkT8IzduHhWfj1Q9Z0noi74OThsmrYG/e
         yuhXp4Q61ZuHvnrW4XCU/wJ/bH1sTasRnMqOJzsCE79sJs9EFmT3isFZO7orGVoRo3
         3wBllki7WZVhw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/4] habanalabs/gaudi: unsecure TPC cfg status registers
Date:   Sun, 14 Mar 2021 14:59:09 +0200
Message-Id: <20210314125912.9306-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Unsecure relevant registers as TPC engine need access to
TPC status.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_security.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 7085f45814ae..9a706c5980ef 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -9556,7 +9556,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC0_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC0_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC0_CFG_TPC_STALL & 0x7F) >> 2);
@@ -10011,7 +10010,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC1_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC1_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC1_CFG_TPC_STALL & 0x7F) >> 2);
@@ -10465,7 +10463,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC2_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC2_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC2_CFG_TPC_STALL & 0x7F) >> 2);
@@ -10919,7 +10916,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC3_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC3_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC3_CFG_TPC_STALL & 0x7F) >> 2);
@@ -11373,7 +11369,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC4_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC4_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC4_CFG_TPC_STALL & 0x7F) >> 2);
@@ -11827,7 +11822,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC5_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC5_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC5_CFG_TPC_STALL & 0x7F) >> 2);
@@ -12283,7 +12277,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC6_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC6_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC6_CFG_TPC_STALL & 0x7F) >> 2);
@@ -12739,7 +12732,6 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	mask = 1U << ((mmTPC7_CFG_PROT & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_VFLAGS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_SFLAGS & 0x7F) >> 2);
-	mask |= 1U << ((mmTPC7_CFG_STATUS & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
 	mask |= 1U << ((mmTPC7_CFG_TPC_STALL & 0x7F) >> 2);
-- 
2.25.1

