Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C13CE9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357137AbhGSRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:00:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3433 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGSPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:33:52 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GT6Br4p9Qz6FD8x;
        Tue, 20 Jul 2021 00:05:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 18:14:26 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 17:14:26 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>, Robin Murphy <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
Date:   Mon, 19 Jul 2021 17:14:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YOhcOv1oOwm6fco+@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2021 15:24, Ming Lei wrote:
>> associated compromises.
> Follows the log of 'perf report'
> 
> 1) good(run fio from cpus in the nvme's numa node)

Hi Ming,

If you're still interested in this issue, as an experiment only you can 
try my rebased patches here:

https://github.com/hisilicon/kernel-dev/commits/private-topic-smmu-5.14-cmdq-4

I think that you should see a significant performance boost.

Thanks
John

> 
> -   34.86%     1.73%  fio       [nvme]              [k] nvme_process_cq                                                      ▒
>     - 33.13% nvme_process_cq                                                                                                  ▒
>        - 32.93% nvme_pci_complete_rq                                                                                          ▒
>           - 24.92% nvme_unmap_data                                                                                            ▒
>              - 20.08% dma_unmap_sg_attrs                                                                                      ▒
>                 - 19.79% iommu_dma_unmap_sg                                                                                   ▒
>                    - 19.55% __iommu_dma_unmap                                                                                 ▒
>                       - 16.86% arm_smmu_iotlb_sync                                                                            ▒
>                          - 16.81% arm_smmu_tlb_inv_range_domain                                                               ▒
>                             - 14.73% __arm_smmu_tlb_inv_range                                                                 ▒
>                                  14.44% arm_smmu_cmdq_issue_cmdlist                                                           ▒
>                               0.89% __pi_memset                                                                               ▒
>                               0.75% arm_smmu_atc_inv_domain                                                                   ▒
>                       + 1.58% iommu_unmap_fast                                                                                ▒
>                       + 0.71% iommu_dma_free_iova                                                                             ▒
>              - 3.25% dma_unmap_page_attrs                                                                                     ▒
>                 - 3.21% iommu_dma_unmap_page                                                                                  ▒
>                    - 3.14% __iommu_dma_unmap_swiotlb                                                                          ▒
>                       - 2.86% __iommu_dma_unmap                                                                               ▒
>                          - 2.48% arm_smmu_iotlb_sync                                                                          ▒
>                             - 2.47% arm_smmu_tlb_inv_range_domain                                                             ▒
>                                - 2.19% __arm_smmu_tlb_inv_range                                                               ▒
>                                     2.16% arm_smmu_cmdq_issue_cmdlist                                                         ▒
>              + 1.34% mempool_free                                                                                             ▒
>           + 7.68% nvme_complete_rq                                                                                            ▒
>     + 1.73% _start
> 
> 
> 2) bad(run fio from cpus not in the nvme's numa node)
> -   49.25%     3.03%  fio       [nvme]              [k] nvme_process_cq                                                      ▒
>     - 46.22% nvme_process_cq                                                                                                  ▒
>        - 46.07% nvme_pci_complete_rq                                                                                          ▒
>           - 41.02% nvme_unmap_data                                                                                            ▒
>              - 34.92% dma_unmap_sg_attrs                                                                                      ▒
>                 - 34.75% iommu_dma_unmap_sg                                                                                   ▒
>                    - 34.58% __iommu_dma_unmap                                                                                 ▒
>                       - 33.04% arm_smmu_iotlb_sync                                                                            ▒
>                          - 33.00% arm_smmu_tlb_inv_range_domain                                                               ▒
>                             - 31.86% __arm_smmu_tlb_inv_range                                                                 ▒
>                                  31.71% arm_smmu_cmdq_issue_cmdlist                                                           ▒
>                       + 0.90% iommu_unmap_fast                                                                                ▒
>              - 5.17% dma_unmap_page_attrs                                                                                     ▒
>                 - 5.15% iommu_dma_unmap_page                                                                                  ▒
>                    - 5.12% __iommu_dma_unmap_swiotlb                                                                          ▒
>                       - 5.05% __iommu_dma_unmap                                                                               ▒
>                          - 4.86% arm_smmu_iotlb_sync                                                                          ▒
>                             - 4.85% arm_smmu_tlb_inv_range_domain                                                             ▒
>                                - 4.70% __arm_smmu_tlb_inv_range                                                               ▒
>                                     4.67% arm_smmu_cmdq_issue_cmdlist                                                         ▒
>              + 0.74% mempool_free                                                                                             ▒
>           + 4.83% nvme_complete_rq                                                                                            ▒
>     + 3.03% _start

