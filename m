Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD47370A8B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhEBGjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 02:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhEBGjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 02:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9679861476
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937531;
        bh=kQttLTIIUCicm1iRyu3syeryFv//zpkTRfVaZ7LXNwk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RBByShyeaUjUtVP5CTfy/bBN9hJBE+bMzT/+pt+ZqRDV1sQCBEGBdaLycTQDe0GqA
         U7R5ucwLooV2vRJ0st3ujA7U4OMsqFCB/R2iFkTU4UWc11a9EUR0PuTRmrqZwxGb+Q
         4OEkCih94Cdlrm2gdsC+jBfoJ2Em4J6GTqvlcOEEx5Uri3unogS1GfA1Uy0mQ2lc9/
         LGkfJHUIRTisiidLCDDPV8AHd96RO1EFLZpGucNvw/vkG06mFoCPYDRWHTLSXQeLqh
         uZXGMZzXecirKisy3G/Ucv6V/EvV8YKT6WvztvZUeDZZ11FIdtJw9aP3Iy1obj56rx
         QSfCzvmPY89gQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] habanalabs: use dev_dbg upon hint address failure
Date:   Sun,  2 May 2021 09:38:43 +0300
Message-Id: <20210502063845.4615-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502063845.4615-1-ogabbay@kernel.org>
References: <20210502063845.4615-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hint address failure that results in a valid mapping with an address
that was allocated by the driver is not a real failure.

Therefore, the driver shouldn't notify about this in kernel log. The
user is responsible to check the returned address.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index b92878d76f23..43924e1c0315 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -570,8 +570,10 @@ static u64 get_va_block(struct hl_device *hdev,
 	if ((is_align_pow_2 && (hint_addr & (va_block_align - 1))) ||
 			(!is_align_pow_2 &&
 				do_div(tmp_hint_addr, va_range->page_size))) {
-		dev_info(hdev->dev, "Hint address 0x%llx will be ignored\n",
-					hint_addr);
+
+		dev_dbg(hdev->dev,
+			"Hint address 0x%llx will be ignored because it is not aligned\n",
+			hint_addr);
 		hint_addr = 0;
 	}
 
-- 
2.25.1

