Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385FE3D0BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhGUIuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:50:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3441 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbhGUIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:43:36 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GV8s41q2Hz6D8mK;
        Wed, 21 Jul 2021 17:08:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 11:23:41 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 10:23:41 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com> <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
Date:   Wed, 21 Jul 2021 10:23:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YPd7IGFZrsTRfUxE@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2021 02:40, Ming Lei wrote:
>> I think that you should see a significant performance boost.
> There is build issue, please check your tree:
> 
>    MODPOST vmlinux.symvers
>    MODINFO modules.builtin.modinfo
>    GEN     modules.builtin
>    LD      .tmp_vmlinux.btf
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o: in function `smmu_test_store':
> /root/git/linux/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3892: undefined reference to `smmu_test_core'
>    BTF     .btf.vmlinux.bin.o
> pahole: .tmp_vmlinux.btf: No such file or directory
>    LD      .tmp_vmlinux.kallsyms1
> .btf.vmlinux.bin.o: file not recognized: file format not recognized
> make: *** [Makefile:1177: vmlinux] Error 1

Ah, sorry. I had some test code which was not properly guarded with 
necessary build switches.

I have now removed that from the tree, so please re-pull.

Thanks,
John
