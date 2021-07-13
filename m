Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854F3C75D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhGMRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:41:08 -0400
Received: from foss.arm.com ([217.140.110.172]:48104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGMRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:41:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB781FB;
        Tue, 13 Jul 2021 10:38:17 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D9D3F7D8;
        Tue, 13 Jul 2021 10:38:16 -0700 (PDT)
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
 <20210713132612.gvx7xpdp3tjcmxxu@bogus>
From:   James Morse <james.morse@arm.com>
Message-ID: <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
Date:   Tue, 13 Jul 2021 18:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210713132612.gvx7xpdp3tjcmxxu@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 13/07/2021 14:26, Sudeep Holla wrote:
> On Tue, Jul 13, 2021 at 08:46:19PM +0800, Xiongfeng Wang wrote:
>> On 2021/7/13 19:33, Sudeep Holla wrote:
>>> On Tue, Jul 13, 2021 at 11:47:38AM +0800, Xiongfeng Wang wrote:
>>>> On ARM64, when PPTT(Processor Properties Topology Table) is not
>>>> implemented in ACPI boot, we will goto 'free_ci' with the following
>>>> print:
>>>>   Unable to detect cache hierarchy for CPU 0
>>>>
>>>
>>> The change itself looks good and I am fine with that. However,...
>>>
>>>> But some other codes may still use 'num_leaves' to iterate through the
>>>
>>> Can you point me exactly where it is used to make sure there are no
>>> other issues associated with that.
>>>
>>>> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
>>>> would crash. So clear 'num_leaves' in free_cache_attributes().
>>>>
>>>
>>> And can you provide the crash dump please ? If we are not hitting any
>>> issue and you just figured this with code inspection, that is fine. It
>>> helps to determine if this needs to be backport or just good to have
>>> clean up.

>> There is no issue in the mainline kernel. get_cpu_cacheinfo_id() is only called
>> on x86. I didn't hit any issue using the mainline kernel.

>> Actually, it's our own code that crashed. My colleague Shaobo(CCed) tried to add

Seems to have dropped off the CC list.

>> MPAM support on ARM64.

Do you want me to CC either of you on the series that refactor the resctrl code? This is
the bit that needs doing to get MPAM working upstream

(I copy Shameerali, but I've not heard from him in a while.)


>> His code called get_cpu_cacheinfo_id() and crashed when
>> PPTT is not implemented. Maybe he should check whether PPTT is implemented
>> before calling get_cpu_cacheinfo_id(), but we think it is also better to clear
>> cache_leaves(cpu) in free_cache_attributes().
>> Sorry for not clearly expressed.

The ACPI tables for MPAM reference the PPTT, so you're going to need one.


> Thanks for detailed explanation. In this case I would drop the Fixes: tag
> as it is not fixing anything in the commit mentioned in the tag.
> 
> Also not sure if we can tag this as fixes
> 709c4362725a ("cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file")
> as that is introducing the possible access that could crash. @James ?

If you like. If there is nothing broken its hard to care.
I guess this helps people doing backports.



Thanks,

James
