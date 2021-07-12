Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A253C47B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhGLGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhGLGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:30:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732EC0225AD;
        Sun, 11 Jul 2021 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6b848kiCiiuvZu1/50n3PwF2cs6P7Itlc1PU3T/9SiI=; b=VtGJbnG7GuIocAGFB7DZ0Z7WWt
        sMH9cVgC2i/qbMpVt8fnjcvG7egfIXTivsjCjTJcKl8thIu/Rawaz/lgFMYvhwB65YaFwtHTZVjmR
        CSJA2PwocavlvrHigXNtZvhEyc7Id16d7QZ4BRu0uArl6NhxWHzseD9EnphiGSshWrbcSSxjgQ5Vw
        9ziP8A5+byO4L9s5lf+X22JNsCvJ3vUL10DjmlG20urTX2+LB4H/fQO01QO3Qp68tKnm8tDNTHHhv
        eQ9ztaSEwkhSxYffDtjvS/ro6LIO9ABmCnPvC9RFcdLcgCJKe+Y0Et6H+uRoRtX9BQMv1DEYAm9XJ
        t/Wi7iFg==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2pIM-00GxGw-2G; Mon, 12 Jul 2021 06:20:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>
Cc:     Dillon Min <dillon.minfei@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dma-mapping: allow using the global coherent pool for !ARM
Date:   Mon, 12 Jul 2021 08:17:00 +0200
Message-Id: <20210712061704.4162464-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch an ifdef so that the global coherent pool is initialized for
any architecture that selects the DMA_GLOBAL_POOL symbol insted of
hardcoding ARM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 kernel/dma/coherent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 794e76b03b34..67b126afac5a 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -361,7 +361,9 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
+#endif
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
-- 
2.30.2

