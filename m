Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBB3C25E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhGIO2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhGIO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625840719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUy8DLM98BygG4ir4jGUsZKL/eD5/NIvpxp3p9erFnw=;
        b=It1uB2gTKVvanYP91qzr/FGczjKndV5dqlBjh3NrJkmL19tPV7BXQdB0/wNh5qF/B/x8ao
        HWuvUCfYcI1bylLfMU2i7kqvqaTCKhPhWA3eNhBqem1G+F/fhyvAMWB/koDVYzfBcyF0bt
        wohG/pttadctH42l1sXQ5WioTzZBiYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-KgxKnMkSORqNXMmSA8aypw-1; Fri, 09 Jul 2021 10:25:15 -0400
X-MC-Unique: KgxKnMkSORqNXMmSA8aypw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2845074C;
        Fri,  9 Jul 2021 14:25:14 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A378710016F7;
        Fri,  9 Jul 2021 14:25:03 +0000 (UTC)
Date:   Fri, 9 Jul 2021 22:24:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YOhcOv1oOwm6fco+@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 11:26:53AM +0100, Robin Murphy wrote:
> On 2021-07-09 09:38, Ming Lei wrote:
> > Hello,
> > 
> > I observed that NVMe performance is very bad when running fio on one
> > CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> > 
> > Please see the test result[1] 327K vs. 34.9K.
> > 
> > Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
> > 1111 nsecs vs 25437 nsecs.
> 
> Are you able to dig down further into that? iommu_dma_unmap_sg() itself
> doesn't do anything particularly special, so whatever makes a difference is
> probably happening at a lower level, and I suspect there's probably an SMMU
> involved. If for instance it turns out to go all the way down to
> __arm_smmu_cmdq_poll_until_consumed() because polling MMIO from the wrong
> node is slow, there's unlikely to be much you can do about that other than
> the global "go faster" knobs (iommu.strict and iommu.passthrough) with their
> associated compromises.

Follows the log of 'perf report'

1) good(run fio from cpus in the nvme's numa node)

-   34.86%     1.73%  fio       [nvme]              [k] nvme_process_cq                                                      ▒
   - 33.13% nvme_process_cq                                                                                                  ▒
      - 32.93% nvme_pci_complete_rq                                                                                          ▒
         - 24.92% nvme_unmap_data                                                                                            ▒
            - 20.08% dma_unmap_sg_attrs                                                                                      ▒
               - 19.79% iommu_dma_unmap_sg                                                                                   ▒
                  - 19.55% __iommu_dma_unmap                                                                                 ▒
                     - 16.86% arm_smmu_iotlb_sync                                                                            ▒
                        - 16.81% arm_smmu_tlb_inv_range_domain                                                               ▒
                           - 14.73% __arm_smmu_tlb_inv_range                                                                 ▒
                                14.44% arm_smmu_cmdq_issue_cmdlist                                                           ▒
                             0.89% __pi_memset                                                                               ▒
                             0.75% arm_smmu_atc_inv_domain                                                                   ▒
                     + 1.58% iommu_unmap_fast                                                                                ▒
                     + 0.71% iommu_dma_free_iova                                                                             ▒
            - 3.25% dma_unmap_page_attrs                                                                                     ▒
               - 3.21% iommu_dma_unmap_page                                                                                  ▒
                  - 3.14% __iommu_dma_unmap_swiotlb                                                                          ▒
                     - 2.86% __iommu_dma_unmap                                                                               ▒
                        - 2.48% arm_smmu_iotlb_sync                                                                          ▒
                           - 2.47% arm_smmu_tlb_inv_range_domain                                                             ▒
                              - 2.19% __arm_smmu_tlb_inv_range                                                               ▒
                                   2.16% arm_smmu_cmdq_issue_cmdlist                                                         ▒
            + 1.34% mempool_free                                                                                             ▒
         + 7.68% nvme_complete_rq                                                                                            ▒
   + 1.73% _start


2) bad(run fio from cpus not in the nvme's numa node)
-   49.25%     3.03%  fio       [nvme]              [k] nvme_process_cq                                                      ▒
   - 46.22% nvme_process_cq                                                                                                  ▒
      - 46.07% nvme_pci_complete_rq                                                                                          ▒
         - 41.02% nvme_unmap_data                                                                                            ▒
            - 34.92% dma_unmap_sg_attrs                                                                                      ▒
               - 34.75% iommu_dma_unmap_sg                                                                                   ▒
                  - 34.58% __iommu_dma_unmap                                                                                 ▒
                     - 33.04% arm_smmu_iotlb_sync                                                                            ▒
                        - 33.00% arm_smmu_tlb_inv_range_domain                                                               ▒
                           - 31.86% __arm_smmu_tlb_inv_range                                                                 ▒
                                31.71% arm_smmu_cmdq_issue_cmdlist                                                           ▒
                     + 0.90% iommu_unmap_fast                                                                                ▒
            - 5.17% dma_unmap_page_attrs                                                                                     ▒
               - 5.15% iommu_dma_unmap_page                                                                                  ▒
                  - 5.12% __iommu_dma_unmap_swiotlb                                                                          ▒
                     - 5.05% __iommu_dma_unmap                                                                               ▒
                        - 4.86% arm_smmu_iotlb_sync                                                                          ▒
                           - 4.85% arm_smmu_tlb_inv_range_domain                                                             ▒
                              - 4.70% __arm_smmu_tlb_inv_range                                                               ▒
                                   4.67% arm_smmu_cmdq_issue_cmdlist                                                         ▒
            + 0.74% mempool_free                                                                                             ▒
         + 4.83% nvme_complete_rq                                                                                            ▒
   + 3.03% _start


Thanks, 
Ming

