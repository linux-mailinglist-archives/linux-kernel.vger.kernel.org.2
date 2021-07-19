Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7600E3CD4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhGSLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236883AbhGSLvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1406113B;
        Mon, 19 Jul 2021 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626697914;
        bh=Fvlwqxv6dtBkcuTBN0WukWjl7VtfhFwYgJ4yPUmzFCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7wgN6ozs+p72UTrZkw6fhSq0QhpUUI4leSgu0mSjM8QMdiSylyU8awgzAWqm8kmp
         ga0vRqnkiA8AsBPwTt/8mOnK3LlJ3MNJG5INTapxgUb0awST0q/+iVXPTnuOSFvWTs
         MzkhTZZv1a4PyUX0hUEfRqin2fT0um8r4dUODY47Kcm7DdOfD2ub4xGn3dqNrt94wM
         KkeGOGa78YmV1BBPVBctQY2VGpZI15y/xHYSKJ7158D+Zmhw5FeUn29AXeG4/sJtqK
         /HLmGeoFgRMPVOD3a9aEUvxuMqcLsswyBSaOlTQuicPEg6ja7kCl/HvooIe+MXnads
         kkMYe6vFiBP2w==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 4/5] swiotlb: Emit diagnostic in swiotlb_exit()
Date:   Mon, 19 Jul 2021 13:30:53 +0100
Message-Id: <20210719123054.6844-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719123054.6844-1-will@kernel.org>
References: <20210719123054.6844-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent debugging session would have been made a little bit easier if
we had noticed sooner that swiotlb_exit() was being called during boot.

Add a simple diagnostic message to swiotlb_exit() to complement the one
from swiotlb_print_info() during initialisation.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20210705190352.GA19461@willie-the-truck
Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7948f274f9bb..b3c793ed9e64 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -334,6 +334,7 @@ void __init swiotlb_exit(void)
 	if (!mem->nslabs)
 		return;
 
+	pr_info("tearing down default memory pool\n");
 	size = array_size(sizeof(*mem->slots), mem->nslabs);
 	if (mem->late_alloc)
 		free_pages((unsigned long)mem->slots, get_order(size));
-- 
2.32.0.402.g57bb445576-goog

