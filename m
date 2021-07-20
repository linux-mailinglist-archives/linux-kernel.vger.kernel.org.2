Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46B3CFAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhGTNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231288AbhGTM6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:58:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A76611CE;
        Tue, 20 Jul 2021 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788320;
        bh=IMx3IbZKVqWumlzk+zzCwsBjRHxMO3KKzzyWrJuP4hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWQtqGYkEIpAvbvqwuj9mdWRgtJu9R68msQKV1qtpcN/wsj1wj55RxLL39COKvDn+
         qMJmJXjgi/ohYEaf3TO0ZSniwMh+/CgrQpIosyyJsWW/eUQudlm4YwiALtnlGORJRh
         Uq07gOuLGQGbu1gXxGo3Ge0jNf+6fpdsmKQETkLgU4/fFm9zTe4sWnJMcedKCDRt4X
         g1JDVr2oNvT1P8TiiIJiRavMW7XJmR8xblWCMtLuxpMaeLNYfdCbrPfW57GupWI4hY
         51bIm5xUIT2pr28+KYFZmf18JTBUscU1kxiPctR7y64vKjqykK58NgtGcqMNZKWZDG
         Syi8UTjoqhZuw==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 3/4] swiotlb: Emit diagnostic in swiotlb_exit()
Date:   Tue, 20 Jul 2021 14:38:25 +0100
Message-Id: <20210720133826.9075-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
References: <20210720133826.9075-1-will@kernel.org>
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
Tested-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

