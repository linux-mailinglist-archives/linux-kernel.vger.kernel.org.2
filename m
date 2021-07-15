Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2783C95CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGOCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:06:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6929 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGOCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:06:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQHd66V24z7ByX;
        Thu, 15 Jul 2021 10:00:10 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 10:03:38 +0800
Received: from [10.174.179.191] (10.174.179.191) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 10:03:37 +0800
Subject: Re: [PATCH] mm/vmalloc: fix wrong behavior in vread
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <serapheim.dimitro@delphix.com>, <urezki@gmail.com>,
        <wangkefeng.wang@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20210714015959.3204871-1-chenwandun@huawei.com>
 <20210714162910.4cb5434f7745dcf7ce9d85c2@linux-foundation.org>
From:   Chen Wandun <chenwandun@huawei.com>
Message-ID: <1789353e-8507-a748-644c-cd3a34b5412b@huawei.com>
Date:   Thu, 15 Jul 2021 10:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714162910.4cb5434f7745dcf7ce9d85c2@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/15 7:29, Andrew Morton 写道:
> On Wed, 14 Jul 2021 09:59:59 +0800 Chen Wandun <chenwandun@huawei.com> wrote:
>
>> commit f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread()
>> lookups") use rb_tree instread of list to speed up lookup, but function
>> __find_vmap_area is try to find a vmap_area that include target address,
>> if target address is smaller than the leftmost node in vmap_area_root,
>> it will return NULL, then vread will read nothing. This behavior is
>> different from the primitive semantics.
> What is "the primitive semantics"?  Does this refer to behaviour prior
> to f608788cd2d6?

If address is smaller than the leftmost node in vmap_area_root and

the read size is big enough when reading [addr, addr + count),

"the primitive semantics" will fill holes by zero and copy valid vmap_area.

In such scenario,  f608788cd2d6 will read noting.

>
>> The correct way is find the first vmap_are that bigger than target addr,
>> that is what function find_vmap_area_exceed_addr does.
> Is this problem observable from userspace?  If so, what are the effects
> and what must an application do to trigger it?

Reading /proc/kcore will be affected.

Thanks,

Wandun

> .
