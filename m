Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDD30F253
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhBDLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhBDLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:32:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8199C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:32:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 19BB81F46091
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com>
Message-ID: <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
Date:   Thu, 4 Feb 2021 11:32:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 10:33, Guillaume Tucker wrote:
> On 04/02/2021 10:27, Ard Biesheuvel wrote:
>> On Thu, 4 Feb 2021 at 11:06, Russell King - ARM Linux admin
>> <linux@armlinux.org.uk> wrote:
>>>
>>> On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
>>>> On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
>>>> <guillaume.tucker@collabora.com> wrote:
>>>>>
>>>>> Hi Ard,
>>>>>
>>>>> Please see the bisection report below about a boot failure on
>>>>> rk3288 with next-20210203.  It was also bisected on
>>>>> imx6q-var-dt6customboard with next-20210202.
>>>>>
>>>>> Reports aren't automatically sent to the public while we're
>>>>> trialing new bisection features on kernelci.org but this one
>>>>> looks valid.
>>>>>
>>>>> The kernel is most likely crashing very early on, so there's
>>>>> nothing in the logs.  Please let us know if you need some help
>>>>> with debugging or trying a fix on these platforms.
>>>>>
>>>>
>>>> Thanks for the report.
>>>
>>> Ard,
>>>
>>> I want to send my fixes branch today which includes your regression
>>> fix that caused this regression.
>>>
>>> As this is proving difficult to fix, I can only drop your fix from
>>> my fixes branch - and given that this seems to be problematical, I'm
>>> tempted to revert the original change at this point which should fix
>>> both of these regressions - and then we have another go at getting rid
>>> of the set/way instructions during the next cycle.
>>>
>>> Thoughts?
>>>
>>
>> Hi Russell,
>>
>> If Guillaume is willing to do the experiment, and it fixes the issue,
> 
> Yes, I'm running some tests with that fix now and should have
> some results shortly.

Yes it does fix the issue:

  https://lava.collabora.co.uk/scheduler/job/3173819

with Ard's fix applied to this test branch:

  https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/


+clang +Nick

It's worth mentioning that the issue only happens with kernels
built with Clang.  As you can see there are several other arm
platforms failing with clang-11 builds but booting fine with
gcc-8:

  https://kernelci.org/test/job/next/branch/master/kernel/next-20210203/plan/baseline/

Here's a sample build log:

  https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/build.log

Essentially:

  make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage

I believe it should be using the GNU assembler as LLVM_IAS=1 is
not defined, but there may be something more subtle about it.

Thanks,
Guillaume


>> it proves that rk3288 is relying on the flush before the MMU is
>> disabled, and so in that case, the fix is trivial, and we can just
>> apply it.
>>
>> If the experiment fails (which would mean rk3288 does not tolerate the
>> cache maintenance being performed after cache off), it is going to be
>> hairy, and so it will definitely take more time.
>>
>> So in the latter case (or if Guillaume does not get back to us), I
>> think reverting my queued fix is the only sane option. But in that
>> case, may I suggest that we queue the revert of the original by-VA
>> change for v5.12 so it gets lots of coverage in -next, and allows us
>> an opportunity to come up with a proper fix in the same timeframe, and
>> backport the revert and the subsequent fix as a pair? Otherwise, we'll
>> end up in the situation where v5.10.x until today has by-va, v5.10.x-y
>> has set/way, and v5.10y+ has by-va again. (I don't think we care about
>> anything before that, given that v5.4 predates any of this)
>>
>> But in the end, I'm happy to go along with whatever works best for you.
> 
> Thanks,
> Guillaume
> 

