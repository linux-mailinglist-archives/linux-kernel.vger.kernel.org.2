Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1A3A6718
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhFNMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233663AbhFNMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99320613CC;
        Mon, 14 Jun 2021 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675071;
        bh=UZyBM62sTFzncu04mIpqDsZnwjXHcWsUryEGmt7n9CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXl5eDQsIi3hQ6vkxByJVHxcedWarD4v/hqNzNzk5m2lyJSv2JmJZOkkioiS/c+z3
         J0nwAGeiwfVkIvIvIdnQrrhGE3QdcM19OubisbXrcyrSGTm0/1T1Gbi+ZvS4K6Rkl+
         V22dk3sgTn9rN1+fRt142/68x/0MGu/ME4X6tSDr0QR1j7agC6JKp+JMABGDHrGfdx
         j3JaqjU3bzrgqcnRhVpA7Z/huzJMqbquXAtFZRvutTduf0nxukndRI1G0OORQgHeWQ
         ClVHqCvWQ8K1i8/vAfxdG5YDnqVYAGVkLIcZlBigBHpqnswAv52v2NQUrbdVYr5/II
         mGH35pLIEjuoA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Albo <talbo@habana.ai>
Subject: [PATCH 5/9] habanalabs/gaudi: update coresight configuration
Date:   Mon, 14 Jun 2021 15:50:56 +0300
Message-Id: <20210614125100.17627-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Albo <talbo@habana.ai>

Update STMTCSR and STMSYNCR values in order to reduce amount of sync
packets

Signed-off-by: Tal Albo <talbo@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 9e271fd9f0d2..c2a27ed1c4d1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -424,7 +424,7 @@ static int gaudi_config_stm(struct hl_device *hdev,
 		if (frequency == 0)
 			frequency = input->frequency;
 		WREG32(base_reg + 0xE8C, frequency);
-		WREG32(base_reg + 0xE90, 0x7FF);
+		WREG32(base_reg + 0xE90, 0x1F00);
 
 		/* SW-2176 - SW WA for HW bug */
 		if ((CFG_BASE + base_reg) >= mmDMA_CH_0_CS_STM_BASE &&
@@ -434,7 +434,7 @@ static int gaudi_config_stm(struct hl_device *hdev,
 			WREG32(base_reg + 0xE6C, 0x0);
 		}
 
-		WREG32(base_reg + 0xE80, 0x27 | (input->id << 16));
+		WREG32(base_reg + 0xE80, 0x23 | (input->id << 16));
 	} else {
 		WREG32(base_reg + 0xE80, 4);
 		WREG32(base_reg + 0xD64, 0);
-- 
2.25.1

