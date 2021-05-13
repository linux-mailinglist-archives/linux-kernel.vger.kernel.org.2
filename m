Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78137FF59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhEMUiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232887AbhEMUiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:38:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0F95611CA;
        Thu, 13 May 2021 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620938214;
        bh=VlAuVRbSl70RsF+Hbd+PeL96a/23cRPU8oynfp6C+jk=;
        h=Date:From:To:Cc:Subject:From;
        b=rYc4vO9DB9mIHeAO/V6CPrg5l1FJJsoPI/4KYQK5Soy8oNu+zH4fDeCExIGbZZovh
         DJmsVOjFG8wIbD20jd2/Nw1MeD18st4GdDfMQA7gruaibtyVj9r88oz3NVdkIfoQr3
         QJ1hBWvkaGgp5EtRMxrxTS0B/pG2oazqTuyKV9LIbTIRUPEx0jfcnBqTgxIwjfTDLV
         IgTANytJcDMaVGuslvTdffeguorK8moe0zhg0stK5iQuSlGhlWxJ3lPu55WMA18/9w
         34+hwdkTr0IDDZhk429dYAP0VtpRupkf744Jf6jXzvLG1GQL2qisiRRnnSXhDEQOLe
         XYvm/do+LI/9A==
Date:   Thu, 13 May 2021 15:37:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] rsxx: Use struct_size() in vmalloc()
Message-ID: <20210513203730.GA212128@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows
that, in the worst scenario, could lead to heap overflows.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/rsxx/dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index 0574f4495755..ed182f3dd054 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -74,9 +74,6 @@ struct dma_tracker {
 	struct rsxx_dma	*dma;
 };
 
-#define DMA_TRACKER_LIST_SIZE8 (sizeof(struct dma_tracker_list) + \
-		(sizeof(struct dma_tracker) * RSXX_MAX_OUTSTANDING_CMDS))
-
 struct dma_tracker_list {
 	spinlock_t		lock;
 	int			head;
@@ -808,7 +805,8 @@ static int rsxx_dma_ctrl_init(struct pci_dev *dev,
 
 	memset(&ctrl->stats, 0, sizeof(ctrl->stats));
 
-	ctrl->trackers = vmalloc(DMA_TRACKER_LIST_SIZE8);
+	ctrl->trackers = vmalloc(struct_size(ctrl->trackers, list,
+					     RSXX_MAX_OUTSTANDING_CMDS));
 	if (!ctrl->trackers)
 		return -ENOMEM;
 
-- 
2.27.0

