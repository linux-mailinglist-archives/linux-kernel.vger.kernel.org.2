Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976FA39D2D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGCPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 22:15:19 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4325 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:15:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FyxcM5BTdz1BJhS;
        Mon,  7 Jun 2021 10:08:35 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:13:24 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 10:13:24 +0800
Subject: Re: [PATCH] Documentation: dt-bindings: Fix incorrect statement
To:     Rob Herring <robh@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <wanghaibin.wang@huawei.com>
References: <20210521095720.5592-1-wangyanan55@huawei.com>
 <20210604194159.GA3781429@robh.at.kernel.org>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <ee384af8-bdbe-db06-ce56-1c1f5bb7b49d@huawei.com>
Date:   Mon, 7 Jun 2021 10:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210604194159.GA3781429@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/5 3:41, Rob Herring wrote:
> On Fri, May 21, 2021 at 05:57:20PM +0800, Yanan Wang wrote:
>> It's found when reading the Doc.
> Please improve the subject so we have some clue as to what the change is
> and what it applies to.
>   
Ok, I will improve the subject to make it more readable.
>> In a SMP system, the hierarchy of CPUs now can be defined through
>> four not three entities (socket/cluster/core/thread), so correct
>> the statement to avoid possible confusion.
>>
>> Since we are already there, also drop an extra space and tweak
>> the title alignment. No real context change at all.
> Since already here, converting to schema would be preferred over trivial
> fixes.
With pleasure to do this. I will send a v2 including this part of work.

Thanks,
Yanan
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   Documentation/devicetree/bindings/cpu/cpu-topology.txt | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpu/cpu-topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> index 9bd530a35d14..8b23a98c283c 100644
>> --- a/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>> @@ -6,7 +6,7 @@ CPU topology binding description
>>   1 - Introduction
>>   ===========================================
>>   
>> -In a SMP system, the hierarchy of CPUs is defined through three entities that
>> +In a SMP system, the hierarchy of CPUs is defined through four entities that
>>   are used to describe the layout of physical CPUs in the system:
>>   
>>   - socket
>> @@ -75,7 +75,7 @@ whose bindings are described in paragraph 3.
>>   
>>   The nodes describing the CPU topology (socket/cluster/core/thread) can
>>   only be defined within the cpu-map node and every core/thread in the
>> -system must be defined within the topology.  Any other configuration is
>> +system must be defined within the topology. Any other configuration is
>>   invalid and therefore must be ignored.
>>   
>>   ===========================================
>> @@ -91,9 +91,9 @@ cpu-map child nodes which do not share a common parent node can have the same
>>   name (ie same number N as other cpu-map child nodes at different device tree
>>   levels) since name uniqueness will be guaranteed by the device tree hierarchy.
>>   
>> -===========================================
>> +============================================
>>   3 - socket/cluster/core/thread node bindings
>> -===========================================
>> +============================================
>>   
>>   Bindings for socket/cluster/cpu/thread nodes are defined as follows:
>>   
>> -- 
>> 2.19.1
> .

