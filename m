Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50849442907
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhKBIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhKBIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:01:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235CC061714;
        Tue,  2 Nov 2021 00:58:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2431C1F4448D
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate +
 mux composites
To:     Alex Bee <knaerzche@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     sboyd@kernel.org, heiko@sntech.de,
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
 <3e42ae24-8db4-fb11-edf2-a25bca47ecae@arm.com>
 <49a0dda1-8d0f-580c-d92d-de759b51edb3@gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <31d462cb-1158-dd13-0ca8-46d54d2502f5@collabora.com>
Date:   Tue, 2 Nov 2021 07:58:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <49a0dda1-8d0f-580c-d92d-de759b51edb3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Kevin +Corentin

On 01/11/2021 22:41, Alex Bee wrote:
> Hi Guillaume,
> 
> Am 01.11.21 um 23:11 schrieb Robin Murphy:
>> On 2021-11-01 21:59, Robin Murphy wrote:
>>> On 2021-11-01 20:58, Martin Blumenstingl wrote:
>>>> Hi Guillaume,
>>>>
>>>> On Mon, Nov 1, 2021 at 9:19 PM Guillaume Tucker
>>>> <guillaume.tucker@collabora.com> wrote:
>>>>>
>>>>> Hi Martin,
>>>>>
>>>>> Please see the bisection report below about a boot failure on
>>>>> rk3328-rock64.
>>>>>
>>>>> Reports aren't automatically sent to the public while we're
>>>>> trialing new bisection features on kernelci.org but this one
>>>>> looks valid.
>>>>>
>>>>> Some more details can be found here:
>>>>>
>>>>>    https://linux.kernelci.org/test/case/id/617f11f5c157b666fb3358e6/
>>>>>
>>>>> Here's what appears to be the cause of the problem:
>>>>>
>>>>> [    0.033465] CPU: CPUs started in inconsistent modes
>>>>> [    0.033557] Unexpected kernel BRK exception at EL1
>>>>> [    0.034432] Internal error: BRK handler: f2000800 [#1] PREEMPT SMP
>>>
>>> What's weird is that that's really just the same WARN that's also
>>> present in 'successful' logs, except for some reason it's behaving as
>>> if the break handler hasn't been registered, despite that having
>>> happened long before we got to smp_init(). At this point we're also
>>> still some way off getting as far as initcalls, so I'm not sure that
>>> the clock driver would be in the picture at all yet.
>>>
>>> Is the bisection repeatable, or is this just random flakiness
>>> misleading things? I'd also note that you need pretty horrifically
>>> broken firmware to hit that warning in the first place, which might
>>> cast a bit of doubt over the trustworthiness of that board altogether.

The bisection has checks to avoid false positives, so tests that
produce flaky results won't normally lead to a report like this.
Then they're manually triaged, and there were 2 separate
bisections that landed on this same commit.

>> Ah, on closer inspection it might be entirely repeatable for a given
>> kernel build, but with the behaviour being very sensitive to code/data
>> segment layout changes...
>>
>> ...
>> 23:44:24.457917  Filename '1007060/tftp-deploy-dvdnydcw/kernel/Image'.
>> 23:44:24.460178  Load address: 0x2000000
>> ...
>> 23:44:27.180962  Bytes transferred = 33681920 (201f200 hex)
>> ...
>> 23:44:27.288135  Filename
>> '1007060/tftp-deploy-dvdnydcw/ramdisk/ramdisk.cpio.gz.uboot'.
>> 23:44:27.288465  Load address: 0x4000000
>> ...

That is indeed where the remaining false positives are still
likely to be coming from, when the infrastructure consistently
causes test failures following particular kernel revisions.  I
don't think there's an easy way to rule those out, but we can try
to address them one by one at least.

In the case of colliding address ranges in the bootloader, we
could add a check with the "good" revision and extra data in the
kernel image to make it at least as big as the "bad" revision...

> could you try updating u-boot to more recent version: the ramdisk
> address has been moved [1] to 0x06000000 in v2020.01-rc5.

Thanks for investigating this.  The board is in BayLibre's lab.

Corentin, Kevin, could you please take a look?

Thanks,
Guillaume

> I couldn't reproduce this issue with the very same board.
> 
> [1]
> https://github.com/u-boot/u-boot/commit/b2e373d16b0345d3c3f4beefdf0889e83faf173d
> 
> Alex
> 
>>
>> Yeah, that'll be a problem ;)
>>
>> Cheers,
>> Robin.
>>
>>>>> There doesn't appear to be any other platform in KernelCI showing
>>>>> the same issue.
>>>> That's a strange error for the changes from my patch.
>>>> At first glance I don't see any relation to clk-composite code:
>>>> - the call trace doesn't have any references to CCF or rockchip clock
>>>> drivers
>>>> - clk-rk3328.c uses drivers/clk/rockchip/clk-cpu.c to register the CPU
>>>> clock which does not use clk-composite
>>>>
>>>> Chen-Yu has tested this patch (plus [0]) on RK3399 and didn't observe
>>>> any problems.
>>>> So maybe this is a RK3328 specific issue?
>>>> Anyways, I am interested in fixing this issue because reverting is
>>>> becoming more and more complex (since I think we're at eight commits
>>>> which would need to be reverted in total).
>>>>
>>>>> Please let us know if you need help debugging the issue or if you
>>>>> have a fix to try.
>>>> Could you please try [0] which is the second patch in the series which
>>>> finally made it upstream.
>>>> This second patch is not in 5.15 because I believed that it's only
>>>> something to make the code in clk-composite.c more future-proof. It's
>>>> not a condition that I am aware of.
>>>>
>>>> I don't have any Rockchip boards myself.
>>>> So I am thankful for any help I can get.
>>>>
>>>>
>>>> Best regards,
>>>> Martin
>>>>
>>>>
>>>> [0]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=6594988fd625ff0d9a8f90f1788e16185358a3e6
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>>
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

