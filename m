Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309E41ED4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbhJAM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJAM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:26:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAADC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:25:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x7so33042419edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wf1MmBNmIAfZmULUjfzH8CC2xLhdOMWrEvNVMzW+P8I=;
        b=E73JQ3x0ZNVZ6IJLAWgXAYdU8MTUU1HrJwQPmGgXWqQVHe0UkZRVyFJvImOgcmtolY
         nthddNvtNB5aL5qPEjooyqBEV2RpvF8meSi2tTPhdKWiXkbilNCBoCMtfBkRXhNYF299
         s11OW/PCi4puqmBd+/7glS/VkLLXdxuFtmfW5psHTM1e/tk8A/xDZHgyjvml58uKJZ36
         RZzSWj3jhviqMSIIux6uzweOtmg/9RV61J8QA7ui40kM8WsoRNKaoJdoh3FNvwFIVF5F
         sxhu5oclG4CLRWO6Eo8VYUs5BnW0HWwFEVy9NjjvxLF6y6d+FrYt9V54rfNtFvzOpDRZ
         Mk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wf1MmBNmIAfZmULUjfzH8CC2xLhdOMWrEvNVMzW+P8I=;
        b=hl94XEpad5i0AQdlE5MYmzxW9YyFY8wppc/1B5n0ORtABXbBg3OJFX5kL4PVBl/h8v
         kCYeO2VkGavAfzeWYsXtFCg7hZefKqV2Q1v5mB8bYWePmT3jR1oHPqQNA0DVUKF5LWZQ
         JT1Ut1L8KAk4HbU+XmgJxsGG/5QJpyo10QbtxJQ1Rzkq0nnPpNv2+EjShM3NKVutuyQn
         Il9rtGv+2330kpwUWOf7y8vgnAnoexDpU6SXfTQW5rMIJYBSx7qQgUxNCDAXAPD8QPE/
         P4cOPKCzQSz2ww4rF1hYJvgqEEUsqFBp1GgaS4Q2NOubjuqlV5+sn0Dn125r/erxLY4A
         Ji3g==
X-Gm-Message-State: AOAM533ZBpu0UXNH+JObZZVaVEhjKtqOz9/NThD6fzRqo9hS4h+eD+HZ
        QZIQQbmh/Y7drulhZBb9N0wOD30h8LyCNwCm11uX451SVp6mFA==
X-Google-Smtp-Source: ABdhPJz4DELVYtVhwAFXFNmRq1jD79KzbANwjAv6bZ7l0nXoZUTlGHRFmD1tuP/vP6q+SIu717KXYglUryg/frU/MT0=
X-Received: by 2002:a17:906:f899:: with SMTP id lg25mr5795071ejb.134.1633091106946;
 Fri, 01 Oct 2021 05:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 2 Oct 2021 01:24:54 +1300
Message-ID: <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 5:14 PM Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>
> Hi Joerg/Jason/Christoph et all,
>
> The current in-kernel supervisor PASID support is based on the SVM/SVA
> machinery in sva-lib. Kernel SVA is achieved by extending a special flag
> to indicate the binding of the device and a page table should be performed
> on init_mm instead of the mm of the current process.Page requests and other
> differences between user and kernel SVA are handled as special cases.
>
> This unrestricted binding with the kernel page table is being challenged
> for security and the convention that in-kernel DMA must be compatible with
> DMA APIs.
> (https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
> There is also the lack of IOTLB synchronization upon kernel page table updates.
>
> This patchset is trying to address these concerns by having an explicit DMA
> API compatible model while continue to support in-kernel use of DMA requests
> with PASID. Specifically, the following DMA-IOMMU APIs are introduced:
>
> int iommu_dma_pasid_enable/disable(struct device *dev,
>                                    struct iommu_domain **domain,
>                                    enum iommu_dma_pasid_mode mode);
> int iommu_map/unmap_kva(struct iommu_domain *domain,
>                         void *cpu_addr,size_t size, int prot);
>
> The following three addressing modes are supported with example API usages
> by device drivers.
>
> 1. Physical address (bypass) mode. Similar to DMA direct where trusted devices
> can DMA pass through IOMMU on a per PASID basis.
> Example:
>         pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
>         /* Use the returning PASID and PA for work submission */
>
> 2. IOVA mode. DMA API compatible. Map a supervisor PASID the same way as the
> PCI requester ID (RID)
> Example:
>         pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_IOVA);
>         /* Use the PASID and DMA API allocated IOVA for work submission */

Hi Jacob,
might be stupid question, what is the performance benefit of this IOVA
mode comparing
with the current dma_map/unmap_single/sg API which have enabled IOMMU like
drivers/iommu/arm/arm-smmu-v3? Do we still need to flush IOTLB by sending
commands to IOMMU  each time while doing dma_unmap?

>
> 3. KVA mode. New kva map/unmap APIs. Support fast and strict sub-modes
> transparently based on device trustfulness.
> Example:
>         pasid = iommu_dma_pasid_enable(dev, &domain, IOMMU_DMA_PASID_KVA);
>         iommu_map_kva(domain, &buf, size, prot);
>         /* Use the returned PASID and KVA to submit work */
> Where:
>         Fast mode: Shared CPU page tables for trusted devices only
>         Strict mode: IOMMU domain returned for the untrusted device to
>         replicate KVA-PA mapping in IOMMU page tables.

a huge bottleneck of IOMMU we have seen before is that dma_unmap will
require IOTLB
flush, for example, in arm_smmu_cmdq_issue_cmdlist(), we are having
serious contention
on acquiring lock and delay on waiting for iotlb flush completion in
arm_smmu_cmdq_poll_until_sync() while multi-threads run.

I assume KVA mode can avoid this iotlb flush as the device is using
the page table
of the kernel and sharing the whole kernel space. But will users be
glad to accept
this mode?
It seems users are enduring the performance decrease of IOVA mapping
and unmapping
because it has better security. dma operations can only run on some
specific dma buffers
which have been mapped in the current dma-map/unmap with IOMMU backend.
some drivers are using bouncing buffer to overcome the performance loss of
dma_map/unmap as copying is faster than unmapping:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907676b130711fd1f

BTW, we have been debugging on dma_map/unmap performance by this
benchmark:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/map_benchmark.c
you might be able to use it for your benchmarking as well :-)

>
> On a per device basis, DMA address and performance modes are enabled by the
> device drivers. Platform information such as trustability, user command line
> input (not included in this set) could also be taken into consideration (not
> implemented in this RFC).
>
> This RFC is intended to communicate the API directions. Little testing is done
> outside IDXD and DMA engine tests.
>
> For PA and IOVA modes, the implementation is straightforward and tested with
> Intel IDXD driver. But several opens remain in KVA fast mode thus not tested:
> 1. Lack of IOTLB synchronization, kernel direct map alias can be updated as a
> result of module loading/eBPF load. Adding kernel mmu notifier?
> 2. The use of the auxiliary domain for KVA map, will aux domain stay in the
> long term? Is there another way to represent sub-device granu isolation?
> 3. Is limiting the KVA sharing to the direct map range reasonable and
> practical for all architectures?
>
>
> Many thanks to Ashok Raj, Kevin Tian, and Baolu who provided feedback and
> many ideas in this set.
>
> Thanks,
>
> Jacob
>
> Jacob Pan (7):
>   ioasid: reserve special PASID for in-kernel DMA
>   dma-iommu: Add API for DMA request with PASID
>   iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
>   dma-iommu: Add support for DMA w/ PASID in KVA
>   iommu/vt-d: Add support for KVA PASID mode
>   iommu: Add KVA map API
>   dma/idxd: Use dma-iommu PASID API instead of SVA lib
>
>  drivers/dma/idxd/idxd.h                       |   4 +-
>  drivers/dma/idxd/init.c                       |  36 ++--
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
>  drivers/iommu/dma-iommu.c                     | 123 +++++++++++++-
>  drivers/iommu/intel/iommu.c                   | 154 +++++++++++++++++-
>  drivers/iommu/ioasid.c                        |   2 +
>  drivers/iommu/iommu-sva-lib.c                 |   1 +
>  drivers/iommu/iommu.c                         |  63 +++++++
>  include/linux/dma-iommu.h                     |  14 ++
>  include/linux/intel-iommu.h                   |   7 +-
>  include/linux/ioasid.h                        |   4 +
>  include/linux/iommu.h                         |  13 ++
>  12 files changed, 390 insertions(+), 33 deletions(-)
>
> --
> 2.25.1
>

Thanks
barry
