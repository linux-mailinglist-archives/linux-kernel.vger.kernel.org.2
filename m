Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787B539BFEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFDSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:55:25 -0400
Received: from foss.arm.com ([217.140.110.172]:45884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFDSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:55:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDE71063;
        Fri,  4 Jun 2021 11:53:37 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB173F73D;
        Fri,  4 Jun 2021 11:53:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210524224159.32807-1-namit@vmware.com>
 <YLpI7tKtsf4l5MlN@8bytes.org>
 <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2ea809ef-beb5-a2c9-0739-cb236cab196b@arm.com>
Date:   Fri, 4 Jun 2021 19:53:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-04 18:10, Nadav Amit wrote:
> 
> 
>> On Jun 4, 2021, at 8:38 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>
>> Hi Nadav,
>>
>> [Adding Robin]
>>
>> On Mon, May 24, 2021 at 03:41:55PM -0700, Nadav Amit wrote:
>>> Nadav Amit (4):
>>>   iommu/amd: Fix wrong parentheses on page-specific invalidations
>>
>> This patch is already upstream in v5.13-rc4. Please rebase to that
>> version.
> 
> I guess it would be rc5 by the time I send it.
> 
>>
>>>   iommu/amd: Selective flush on unmap
>>>   iommu/amd: Do not sync on page size changes
>>>   iommu/amd: Do not use flush-queue when NpCache is on
>>
>> And I think there have been objections from Robin Murphy on Patch 3,
>> have those been worked out?
> 
> I am still waiting for Robin’s feedback on my proposed changes. If he does not respond soon, I will drop this patch for now.

Apologies, it feels like I've spent most of this week fighting fires,
and a great deal of email got skimmed and mentally filed under "nothing
so wrong that I need to respond immediately"...

FWIW I would have written the simpler patch below, but beyond that I
think it might start descending into bikeshedding - if you still prefer
your more comprehensive refactoring, or something in between, then don't
let my personal preference in style/complexity trade-offs stand in the
way of getting a useful functional change into the AMD driver. Whichever
way, though, I *am* now sold on the idea of having some kerneldoc to
clarify these things.

Thanks,
Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: Improve iommu_iotlb_gather helpers

The Mediatek driver is not the only one which might want a basic
address-based gathering behaviour, so although it's arguably simple
enough to open-code, let's factor it out for the sake of cleanliness.
Let's also take this opportunity to document the intent of these
helpers for clarity.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/mtk_iommu.c |  6 +-----
  include/linux/iommu.h     | 32 ++++++++++++++++++++++++++++++++
  2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..cd457487ce81 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -521,12 +521,8 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
  			      struct iommu_iotlb_gather *gather)
  {
  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	unsigned long end = iova + size - 1;
  
-	if (gather->start > iova)
-		gather->start = iova;
-	if (gather->end < end)
-		gather->end = end;
+	iommu_iotlb_gather_add_range(gather, iova, size);
  	return dom->iop->unmap(dom->iop, iova, size, gather);
  }
  
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..5f036e991937 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -497,6 +497,38 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
  	iommu_iotlb_gather_init(iotlb_gather);
  }
  
+/**
+ * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build arbitrarily-sized invalidation commands
+ * where only the address range matters, and simply minimising intermediate
+ * syncs is preferred.
+ */
+static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
+						unsigned long iova, size_t size)
+{
+	unsigned long end = iova + size - 1;
+
+	if (gather->start > iova)
+		gather->start = iova;
+	if (gather->end < end)
+		gather->end = end;
+}
+
+/**
+ * iommu_iotlb_gather_add_page - Gather for page-based TLB invalidation
+ * @domain: IOMMU domain to be invalidated
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build invalidation commands based on individual
+ * pages, or with page size/table level hints which cannot be gathered if they
+ * differ.
+ */
  static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
  					       struct iommu_iotlb_gather *gather,
  					       unsigned long iova, size_t size)
-- 
2.25.1
