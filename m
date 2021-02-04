Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA87030FF15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBDVKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:10:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52168 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBDVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:10:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id CA9DC1F4648D
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
 <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com>
 <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <d1122a0f-8881-0686-46eb-46930fb52efb@collabora.com>
Date:   Thu, 4 Feb 2021 21:09:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 16:01, Ard Biesheuvel wrote:
> On Thu, 4 Feb 2021 at 16:53, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> On 04/02/2021 15:42, Ard Biesheuvel wrote:
>>> On Thu, 4 Feb 2021 at 12:32, Guillaume Tucker
>>> <guillaume.tucker@collabora.com> wrote:
>>>>
>>>> On 04/02/2021 10:33, Guillaume Tucker wrote:
>>>>> On 04/02/2021 10:27, Ard Biesheuvel wrote:
>>>>>> On Thu, 4 Feb 2021 at 11:06, Russell King - ARM Linux admin
>>>>>> <linux@armlinux.org.uk> wrote:
>>>>>>>
>>>>>>> On Thu, Feb 04, 2021 at 10:07:58AM +0100, Ard Biesheuvel wrote:
>>>>>>>> On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
>>>>>>>> <guillaume.tucker@collabora.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Ard,
>>>>>>>>>
>>>>>>>>> Please see the bisection report below about a boot failure on
>>>>>>>>> rk3288 with next-20210203.  It was also bisected on
>>>>>>>>> imx6q-var-dt6customboard with next-20210202.
>>>>>>>>>
>>>>>>>>> Reports aren't automatically sent to the public while we're
>>>>>>>>> trialing new bisection features on kernelci.org but this one
>>>>>>>>> looks valid.
>>>>>>>>>
>>>>>>>>> The kernel is most likely crashing very early on, so there's
>>>>>>>>> nothing in the logs.  Please let us know if you need some help
>>>>>>>>> with debugging or trying a fix on these platforms.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks for the report.
>>>>>>>
>>>>>>> Ard,
>>>>>>>
>>>>>>> I want to send my fixes branch today which includes your regression
>>>>>>> fix that caused this regression.
>>>>>>>
>>>>>>> As this is proving difficult to fix, I can only drop your fix from
>>>>>>> my fixes branch - and given that this seems to be problematical, I'm
>>>>>>> tempted to revert the original change at this point which should fix
>>>>>>> both of these regressions - and then we have another go at getting rid
>>>>>>> of the set/way instructions during the next cycle.
>>>>>>>
>>>>>>> Thoughts?
>>>>>>>
>>>>>>
>>>>>> Hi Russell,
>>>>>>
>>>>>> If Guillaume is willing to do the experiment, and it fixes the issue,
>>>>>
>>>>> Yes, I'm running some tests with that fix now and should have
>>>>> some results shortly.
>>>>
>>>> Yes it does fix the issue:
>>>>
>>>>   https://lava.collabora.co.uk/scheduler/job/3173819
>>>>
>>>> with Ard's fix applied to this test branch:
>>>>
>>>>   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/
>>>>
>>>>
>>>> +clang +Nick
>>>>
>>>> It's worth mentioning that the issue only happens with kernels
>>>> built with Clang.  As you can see there are several other arm
>>>> platforms failing with clang-11 builds but booting fine with
>>>> gcc-8:
>>>>
>>>>   https://kernelci.org/test/job/next/branch/master/kernel/next-20210203/plan/baseline/
>>>>
>>>> Here's a sample build log:
>>>>
>>>>   https://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/build.log
>>>>
>>>> Essentially:
>>>>
>>>>   make -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
>>>>
>>>> I believe it should be using the GNU assembler as LLVM_IAS=1 is
>>>> not defined, but there may be something more subtle about it.
>>>>
>>>
>>>
>>> Do you have a link for a failing zImage built from multi_v7_defconfig?
>>
>> Sure, this one was built from a plain next-20210203:
>>
>>   http://storage.staging.kernelci.org/gtucker/next-20210203-ard-fix/v5.10-rc4-24722-g58b6c0e507b7-gtucker_single-staging-33/arm/multi_v7_defconfig/clang-11/zImage
>>
>> You can also find the dtbs, modules and other things in that same
>> directory.
>>
>> For the record, here's the test job that used it:
>>
>>   https://lava.collabora.co.uk/scheduler/job/3173792
>>
> 
> Thanks.
> 
> That zImage boots fine locally. Unfortunately, I don't have rk3288
> hardware to reproduce.
> 
> Could you please point me to the list of all the other platforms that
> failed to boot this image?

This is the list of platforms from kernelci.org I've gathered
which appeared to be impacted:

imx6q-sabrelite
imx6q-var-dt6customboard
imx6dl-riotboard
imx6qp-wandboard-revd1
imx7ulp-evk
odroid-xu3
rk3288-rock2-square
rk3288-veyron-jaq
stm32mp157c-dk2
sun4i-a10-olinuxino-lime
sun5i-a13-olinuxino-micro
sun7i-a20-cubieboard2
sun7i-a20-olinuxino-lime2
sun8i-a33-olinuxino
sun8i-a83t-bananapi-m3
sun8i-h2-plus-libretech-all-h3-cc
sun8i-h2-plus-orangepi-r1
sun8i-h2-plus-orangepi-zero
sun8i-h3-libretech-all-h3-cc
sun8i-h3-bananapi-m2-plus
sun8i-h3-orangepi-pc
sun8i-r40-bananapi-m2-ultra

They were all booting next-20210203 with gcc-8 but not with
clang-11.  I've run checks on a good share of them with your
patch applied and they're now booting with clang-11, just like
the rk3288 and imx6q platforms that were used for the bisections.


> To be honest, I am slightly annoyed that a change that works fine with
> GCC but does not work with Clang version
> 
> 11.1.0-++20210130110826+3a8282376b6c-1~exp1~20210130221445.158
> 
> (where exp means experimental, I suppose) is the reason for this

Well it's the standard one from the LLVM Debian package repo:

  deb http://apt.llvm.org/buster/ llvm-toolchain-buster-11 main

There's a slightly newer version, I doubt it would make any
difference in this respect unless there's a particular fix in
ld.lld:

# apt policy clang-11
clang-11:
  Installed: 1:11.1.0~++20210130110826+3a8282376b6c-1~exp1~20210130221445.158
  Candidate: 1:11.1.0~++20210204120158+1fdec59bffc1-1~exp1~20210203230823.159

> discussion, especially because the change is in asm code. Is it
> possible to build with Clang but use the GNU linker?

As mentioned by Nick, it is using everything from LLVM except the
assembler - so not the GNU linker.  I've now built a new Docker
container with the latest LLVM package version (.159) as well as
gcc-8-arm-linux-gnueabihf to try with the GNU linker and see if
that makes any difference.  More on that shortly...

Guillaume
