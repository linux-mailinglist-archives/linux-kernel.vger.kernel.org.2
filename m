Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31A3EDA79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhHPQEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:04:14 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14262 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhHPQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:04:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GpJqN1lHcz86tW;
        Tue, 17 Aug 2021 00:03:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 00:03:24 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 00:03:23 +0800
Subject: Re: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
 <bef20bf2-538d-1319-ba22-6774efa10ebc@huawei.com>
 <d9d9f764-2bc7-ddf4-2353-dac323e4416d@canonical.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <ae98dc9e-6892-49c2-24f5-1578b5d4a410@huawei.com>
Date:   Tue, 17 Aug 2021 00:03:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d9d9f764-2bc7-ddf4-2353-dac323e4416d@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/16 23:52, Heinrich Schuchardt wrote:
> On 8/16/21 5:30 PM, Kefeng Wang wrote:
>>
>> On 2021/8/16 22:47, Heinrich Schuchardt wrote:
>>> For analyzing memory blocks we can either use the memblock=debug 
>>> command
>>> line argument which creates massive output or a debug file system.
>>>
>>> Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
>>> /sys/kernel/debug/memblock to analyze memory blocks. The
>>> same is already done for arm, arm64, mips, powerpc.
>>>
>>> The actual provisioning of the file system depends on CONFIG_DEBUG_FS.
>>
>> Hi，for riscv, it don't use memblock(eg, no provide pfn_valid to use 
>> memblock),
>>
>> we could call memblock_discard() to discard memblock private memory 
>> to save
>>
>> some memory, right?  So I think we don't need this config for now.
>
> What do you mean by "it don't use memblock?

Sorry, it should be  "the riscv don't use memblock after the page 
allocator is initialized"


