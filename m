Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195031D136
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPTv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBPTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:51:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 510AE64D7F;
        Tue, 16 Feb 2021 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613505041;
        bh=bZD3iwrDUwsQ4+6q3L0Hj/j6q8I6OMnPXrhDdd4k3NY=;
        h=From:To:Cc:Subject:Date:From;
        b=cduykwX1liVZkaWUyniYAOznR3gZUfrfBf33PYCwyyc45LCe7Olmk8UfCXavGeQ2/
         3U1ghl7Ki7sAx+3X/ng8Ve23C+SmKtTHYQLoAwCjxbTt78slOwNIXmQUdbs13GVl0c
         GRm+ZAxbgq/42xlTsWHnrHLRuGCmxZpkX7/wkKg7uAsKyv0/SLjxAhyENwgOG+bkLA
         RwmxZnKdXTHq7DZBd9MwNbPbCvHkdDgLT7nsZ7xaiXuGwBObiTizFE42vVE10Zt9VS
         CRajSIbcNALUqIcqZ7HGGvDLYUrAuJQWnuzybaO8Sh0/FCxTf+CtiI3TlvSF+AGwUB
         CstKfdf7JUbdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] habanalabs: mark hl_eq_inc_ptr() as static
Date:   Tue, 16 Feb 2021 21:50:35 +0200
Message-Id: <20210216195035.21290-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hl_eq_inc_ptr() is not called from anywhere outside irq.c so mark
it as static

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index de53fb5f978a..44a0522b59b9 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -47,7 +47,7 @@ inline u32 hl_cq_inc_ptr(u32 ptr)
  * Increment ptr by 1. If it reaches the number of event queue
  * entries, set it to 0
  */
-inline u32 hl_eq_inc_ptr(u32 ptr)
+static inline u32 hl_eq_inc_ptr(u32 ptr)
 {
 	ptr++;
 	if (unlikely(ptr == HL_EQ_LENGTH))
-- 
2.25.1

