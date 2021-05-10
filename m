Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214BB377E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEJImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:42:05 -0400
Received: from verein.lst.de ([213.95.11.211]:57650 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEJImE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:42:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D61467373; Mon, 10 May 2021 10:40:57 +0200 (CEST)
Date:   Mon, 10 May 2021 10:40:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julien Grall <julien@xen.org>
Cc:     f.fainelli@gmail.com, Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        osstest service owner <osstest-admin@xenproject.org>,
        hch@lst.de, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
Message-ID: <20210510084057.GA933@lst.de>
References: <osstest-161829-mainreport@xen.org> <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
> The pointer dereferenced seems to suggest that the swiotlb hasn't been 
> allocated. From what I can tell, this may be because swiotlb_force is set 
> to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on top 
> of Xen.
>
> I am not entirely sure what would be the correct fix. Any opinions?

Can you try something like the patch below (not even compile tested, but
the intent should be obvious?


diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 16a2b2b1c54d..7671bc153fb1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -44,6 +44,8 @@
 #include <asm/tlb.h>
 #include <asm/alternative.h>
 
+#include <xen/arm/swiotlb-xen.h>
+
 /*
  * We need to be able to catch inadvertent references to memstart_addr
  * that occur (potentially in generic code) before arm64_memblock_init()
@@ -482,7 +484,7 @@ void __init mem_init(void)
 	if (swiotlb_force == SWIOTLB_FORCE ||
 	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		swiotlb_init(1);
-	else
+	else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
 		swiotlb_force = SWIOTLB_NO_FORCE;
 
 	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
