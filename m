Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0F3C7B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhGNCNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:13:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6922 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGNCNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:13:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPgqH2Q7yz7Bwh;
        Wed, 14 Jul 2021 10:06:51 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 10:10:23 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 14 Jul
 2021 10:10:22 +0800
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
To:     James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
 <20210713132612.gvx7xpdp3tjcmxxu@bogus>
 <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <93e6b13b-10b3-f371-d905-ba114df803fd@huawei.com>
Date:   Wed, 14 Jul 2021 10:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2021/7/14 1:38, James Morse wrote:
> Hello,
> 
> On 13/07/2021 14:26, Sudeep Holla wrote:
>> On Tue, Jul 13, 2021 at 08:46:19PM +0800, Xiongfeng Wang wrote:
>>> On 2021/7/13 19:33, Sudeep Holla wrote:
>>>> On Tue, Jul 13, 2021 at 11:47:38AM +0800, Xiongfeng Wang wrote:
>>>>> On ARM64, when PPTT(Processor Properties Topology Table) is not
>>>>> implemented in ACPI boot, we will goto 'free_ci' with the following
>>>>> print:
>>>>>   Unable to detect cache hierarchy for CPU 0
>>>>>
>>>>
>>>> The change itself looks good and I am fine with that. However,...
>>>>
>>>>> But some other codes may still use 'num_leaves' to iterate through the
>>>>
>>>> Can you point me exactly where it is used to make sure there are no
>>>> other issues associated with that.
>>>>
>>>>> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
>>>>> would crash. So clear 'num_leaves' in free_cache_attributes().
>>>>>
>>>>
>>>> And can you provide the crash dump please ? If we are not hitting any
>>>> issue and you just figured this with code inspection, that is fine. It
>>>> helps to determine if this needs to be backport or just good to have
>>>> clean up.
> 
>>> There is no issue in the mainline kernel. get_cpu_cacheinfo_id() is only called
>>> on x86. I didn't hit any issue using the mainline kernel.
> 
>>> Actually, it's our own code that crashed. My colleague Shaobo(CCed) tried to add
> 
> Seems to have dropped off the CC list.

Yes. I don't know why I didn't CC him success. CCed again.

> 
>>> MPAM support on ARM64.
> 
> Do you want me to CC either of you on the series that refactor the resctrl code? This is
> the bit that needs doing to get MPAM working upstream

It would be nice if you could CC him. His email address is
bobo.shaobowang@huawei.com. Thanks a lot !

Below is the (openEuler version) MPAM support code he wrote based on your
private version in linux-arm.org repo:
https://gitee.com/openeuler/kernel/tree/openEuler-1.0-LTS/arch/arm64/kernel/mpam
It would be appreciated if you could give some advice.

console display:
[root@localhost ~]# mount -t resctrl resctrl /sys/fs/resctrl/ -o
cdpl3,caPbm,mbHdl,mbMax
[root@localhost ~]# cd /sys/fs/resctrl/
[root@localhost resctrl]# cat schemata
L3CODEPBM:0=7fff;1=7fff;2=7fff;3=7fff
L3DATAPBM:0=7fff;1=7fff;2=7fff;3=7fff
MBHDL:0=1;1=1;2=1;3=1
MBMAX:0=100;1=100;2=100;3=100

Thanks,
Xiongfeng

> 
> (I copy Shameerali, but I've not heard from him in a while.)
> 
> 
>>> His code called get_cpu_cacheinfo_id() and crashed when
>>> PPTT is not implemented. Maybe he should check whether PPTT is implemented
>>> before calling get_cpu_cacheinfo_id(), but we think it is also better to clear
>>> cache_leaves(cpu) in free_cache_attributes().
>>> Sorry for not clearly expressed.
> 
> The ACPI tables for MPAM reference the PPTT, so you're going to need one.
> 
> 
>> Thanks for detailed explanation. In this case I would drop the Fixes: tag
>> as it is not fixing anything in the commit mentioned in the tag.
>>
>> Also not sure if we can tag this as fixes
>> 709c4362725a ("cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file")
>> as that is introducing the possible access that could crash. @James ?
> 
> If you like. If there is nothing broken its hard to care.
> I guess this helps people doing backports.
> 
> 
> 
> Thanks,
> 
> James
> .
> 
