Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C040BD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhIOCFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:05:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9870 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhIOCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:05:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8NgW5h64z8yXP;
        Wed, 15 Sep 2021 09:59:19 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 10:03:46 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 10:03:45 +0800
Subject: Re: [PATCH -next] irqdomain: fix overflow error
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <john.wanghui@huawei.com>
References: <20210908014623.61357-1-cuibixuan@huawei.com>
 <87o88vcqvh.ffs@tglx>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <4f614b66-ad85-7fa3-6e6e-2a672e8148e3@huawei.com>
Date:   Wed, 15 Sep 2021 10:03:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87o88vcqvh.ffs@tglx>
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



On 2021/9/14 19:56, Thomas Gleixner wrote:
> On Wed, Sep 08 2021 at 09:46, Bixuan Cui wrote:
>> In function ‘kmalloc_node’,
>>     inlined from ‘kzalloc_node.constprop’ at ./include/linux/slab.h:743:9,
>>     inlined from ‘__irq_domain_add’ at kernel/irq/irqdomain.c:153:9:
>> ./include/linux/slab.h:618:9: error: argument 1 value ‘18446744073709551615’ exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
>>   return __kmalloc_node(size, flags, node);
>>
>> The 'size' can be negative here, which will then get turned into a giant
>> size argument for kzalloc_node(). Changing the size to 'unsigned int'
>> instead seems more appropriate.
> What's more appropriate about that?
We call struct_size(domain, revmap, size) in __irq_domain_add() for calculations.

The struct_size() is implemented in include/linux/overflow.h
static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
{
        size_t bytes;

The 'size' is passed to __ab_c_size(), the input parameter is 'size_t'(unsigned int).


On the other hand, I looked at all the code that calls __irq_domain_add(), such as:
include/linux/irqdomain.h:
static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
                                         unsigned int size,
                                         const struct irq_domain_ops *ops,
                                         void *host_data)
{
        return __irq_domain_add(fwnode, size, size, 0, ops, host_data);

or
static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_node,
                                         unsigned int size,
                                         const struct irq_domain_ops *ops,
                                         void *host_data)
{
        return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);

And kernel/irq/irqdomain.c
struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
                                            unsigned int size,
                                            unsigned int first_irq,
                                            const struct irq_domain_ops *ops,
                                            void *host_data)
{
        struct irq_domain *domain;

        domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);

All 'size' passed to __irq_domain_add() are unsigned int.

So I think it's more appropriate to replace it with unsigned int.


Thanks,
Bixuan Cui
