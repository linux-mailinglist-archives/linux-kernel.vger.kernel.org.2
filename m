Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19490442333
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 23:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhKAWOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 18:14:39 -0400
Received: from foss.arm.com ([217.140.110.172]:48506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhKAWOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 18:14:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98688D6E;
        Mon,  1 Nov 2021 15:12:01 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C65D03F5A1;
        Mon,  1 Nov 2021 15:11:59 -0700 (PDT)
Message-ID: <3e42ae24-8db4-fb11-edf2-a25bca47ecae@arm.com>
Date:   Mon, 1 Nov 2021 22:11:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate +
 mux composites
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     sboyd@kernel.org, heiko@sntech.de, knaerzche@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
 <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
 <04a58d50-634b-fa20-95b4-eb6831f77e85@collabora.com>
 <CAFBinCAEt9_EfLYWZEzTBK6iN97+Wacho7pNd2LYDPX3+goMzg@mail.gmail.com>
 <b6468523-a730-6a44-f4b9-3fd5b9ea2354@arm.com>
In-Reply-To: <b6468523-a730-6a44-f4b9-3fd5b9ea2354@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-01 21:59, Robin Murphy wrote:
> On 2021-11-01 20:58, Martin Blumenstingl wrote:
>> Hi Guillaume,
>>
>> On Mon, Nov 1, 2021 at 9:19 PM Guillaume Tucker
>> <guillaume.tucker@collabora.com> wrote:
>>>
>>> Hi Martin,
>>>
>>> Please see the bisection report below about a boot failure on
>>> rk3328-rock64.
>>>
>>> Reports aren't automatically sent to the public while we're
>>> trialing new bisection features on kernelci.org but this one
>>> looks valid.
>>>
>>> Some more details can be found here:
>>>
>>>    https://linux.kernelci.org/test/case/id/617f11f5c157b666fb3358e6/
>>>
>>> Here's what appears to be the cause of the problem:
>>>
>>> [    0.033465] CPU: CPUs started in inconsistent modes
>>> [    0.033557] Unexpected kernel BRK exception at EL1
>>> [    0.034432] Internal error: BRK handler: f2000800 [#1] PREEMPT SMP
> 
> What's weird is that that's really just the same WARN that's also 
> present in 'successful' logs, except for some reason it's behaving as if 
> the break handler hasn't been registered, despite that having happened 
> long before we got to smp_init(). At this point we're also still some 
> way off getting as far as initcalls, so I'm not sure that the clock 
> driver would be in the picture at all yet.
> 
> Is the bisection repeatable, or is this just random flakiness misleading 
> things? I'd also note that you need pretty horrifically broken firmware 
> to hit that warning in the first place, which might cast a bit of doubt 
> over the trustworthiness of that board altogether.

Ah, on closer inspection it might be entirely repeatable for a given 
kernel build, but with the behaviour being very sensitive to code/data 
segment layout changes...

...
23:44:24.457917  Filename '1007060/tftp-deploy-dvdnydcw/kernel/Image'.
23:44:24.460178  Load address: 0x2000000
...
23:44:27.180962  Bytes transferred = 33681920 (201f200 hex)
...
23:44:27.288135  Filename 
'1007060/tftp-deploy-dvdnydcw/ramdisk/ramdisk.cpio.gz.uboot'.
23:44:27.288465  Load address: 0x4000000
...

Yeah, that'll be a problem ;)

Cheers,
Robin.

>>> There doesn't appear to be any other platform in KernelCI showing
>>> the same issue.
>> That's a strange error for the changes from my patch.
>> At first glance I don't see any relation to clk-composite code:
>> - the call trace doesn't have any references to CCF or rockchip clock 
>> drivers
>> - clk-rk3328.c uses drivers/clk/rockchip/clk-cpu.c to register the CPU
>> clock which does not use clk-composite
>>
>> Chen-Yu has tested this patch (plus [0]) on RK3399 and didn't observe
>> any problems.
>> So maybe this is a RK3328 specific issue?
>> Anyways, I am interested in fixing this issue because reverting is
>> becoming more and more complex (since I think we're at eight commits
>> which would need to be reverted in total).
>>
>>> Please let us know if you need help debugging the issue or if you
>>> have a fix to try.
>> Could you please try [0] which is the second patch in the series which
>> finally made it upstream.
>> This second patch is not in 5.15 because I believed that it's only
>> something to make the code in clk-composite.c more future-proof. It's
>> not a condition that I am aware of.
>>
>> I don't have any Rockchip boards myself.
>> So I am thankful for any help I can get.
>>
>>
>> Best regards,
>> Martin
>>
>>
>> [0] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=6594988fd625ff0d9a8f90f1788e16185358a3e6 
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
