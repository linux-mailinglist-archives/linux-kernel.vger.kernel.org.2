Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBD40C2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhIOJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:39:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16213 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhIOJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:39:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H8Zr76nrBz1DH1g;
        Wed, 15 Sep 2021 17:37:27 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:38:28 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:38:27 +0800
Subject: Re: [PATCH -next] irqdomain: fix overflow error
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <john.wanghui@huawei.com>
References: <20210908014623.61357-1-cuibixuan@huawei.com>
 <87o88vcqvh.ffs@tglx> <4f614b66-ad85-7fa3-6e6e-2a672e8148e3@huawei.com>
 <87pmtab7no.ffs@tglx>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <1fe1aa97-97dc-4f55-186e-7aace630c8f1@huawei.com>
Date:   Wed, 15 Sep 2021 17:38:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87pmtab7no.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/15 15:49, Thomas Gleixner wrote:
> On Wed, Sep 15 2021 at 10:03, Bixuan Cui wrote:
>> On 2021/9/14 19:56, Thomas Gleixner wrote:
>>
>> And kernel/irq/irqdomain.c
>> struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
>>                                             unsigned int size,
>>                                             unsigned int first_irq,
>>                                             const struct irq_domain_ops *ops,
>>                                             void *host_data)
>> {
>>         struct irq_domain *domain;
>>
>>         domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
>>
>> All 'size' passed to __irq_domain_add() are unsigned int.
>>
>> So I think it's more appropriate to replace it with unsigned int.
> Appropriate is not really a technical reason. Making the code consistent
> is.
> 
> But that has nothing to do with the completely bogus compiler warning in
> the changelog you provided.
Hello,
It is a real compilation warning, It occurs when compiled with
.config(https://syzkaller.appspot.com/text?tag=KernelConfig&x=4d196bb8b1e038c0).

This is my compile log:
// cp .config from https://syzkaller.appspot.com/text?tag=KernelConfig&x=4d196bb8b1e038c0
$ make menuconfig
$ make kernel/irq/irqdomain.o
  SYNC    include/config/auto.conf.cmd
  DESCEND objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC      kernel/irq/irqdomain.o
In file included from ./include/linux/resource_ext.h:11:0,
                 from ./include/linux/acpi.h:14,
                 from kernel/irq/irqdomain.c:5:
In function ‘kmalloc_node’,
    inlined from ‘kzalloc_node.constprop’ at ./include/linux/slab.h:743:9,
    inlined from ‘__irq_domain_add’ at kernel/irq/irqdomain.c:153:9:
./include/linux/slab.h:618:9: warning: argument 1 value ‘18446744073709551615’ exceeds maximum object size 9223372036854775807 [-Walloc-size-larger-than=]
  return __kmalloc_node(size, flags, node);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/slab.h: In function ‘__irq_domain_add’:
./include/linux/slab.h:455:7: note: in a call to allocation function ‘__kmalloc_node’ declared here
 void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_slab_alignment __malloc;
       ^~~~~~~~~~~~~~

Thanks,
Bixuan Cui




