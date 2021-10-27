Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8410243D017
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhJ0Ruq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:50:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59054 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbhJ0Ru2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=ixLSC4o+uhsNJFfM+3WjU/KW6d5SsHJCs8Tnj6YC5pw=; b=okyWYXdfSdHHJ5UP8SDWqAugiu
        PNPBruGGXoL5gOPZZFve7iL8xSnqUboGitotenc2EGldMrHEPhsCmQpeuKRsPiyFfL1rxPYHxP+bI
        qx91AlufbsY9c6CzEP1UoU0D4W37kM79WlgDnWL+I/O6/zs3J95MqLOYZrp1OlGJHw4Gvlpmv4KMq
        pXGuSD2AWOVu7WdJtvQ6oFX8cJ0qRKOxxM18074DQ3yV4IuuGZvupWg+KFylymBtlDTQne5hk7xux
        xOcJtPeOmkuEOHbr/ltyTBGHg4atELLPHTBBxVq+++6kTUVKOl9WBMUmKn+ja+vsK9FgliI2XdPcE
        EeACUFOA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mfn1t-000kp8-0E; Wed, 27 Oct 2021 11:48:02 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mfn1s-000VAK-Jp; Wed, 27 Oct 2021 11:48:00 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Marshall Midden <marshallmidden@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Date:   Wed, 27 Oct 2021 11:47:57 -0600
Message-Id: <20211027174757.119755-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de, logang@deltatee.com, marshallmidden@gmail.com, joro@8bytes.org, will@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,MYRULES_URI_HASH autolearn=no autolearn_force=no
        version=3.4.6
Subject: [PATCH] iommu/dma: fix incorrect error return on iommu deferred attach
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scsi_dma_map() was reporting a failure during boot on an AMD machine
with the IOMMU enabled.

  scsi_dma_map failed: request for 36 bytes!

The issue was tracked down to a mistake in logic: should not return
an error if iommu_deferred_attach() returns zero.

Reported-by: Marshall Midden <marshallmidden@gmail.com>
Fixes: dabb16f67215 ("iommu/dma: return error code from iommu_dma_map_sg()")
Link: https://lore.kernel.org/all/CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

If possible, this fix should really get into Linus's tree before the
v5.15 release.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 896bea04c347..3e5a21b0bb24 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1016,7 +1016,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,

 	if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
 		ret = iommu_deferred_attach(dev, domain);
-		goto out;
+		if (ret)
+			goto out;
 	}

 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))

base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
--
2.30.2
