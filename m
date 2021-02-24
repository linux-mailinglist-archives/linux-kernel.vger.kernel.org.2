Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF332396C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhBXJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:27:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhBXJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:27:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 81E931F45AAE
Subject: Re: mainline/master bisection: baseline.login on
 meson-sm1-khadas-vim3l
To:     maz@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Remi Denis-Courmont <remi.denis.courmont@huawei.com>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <6033a5da.1c69fb81.9be93.66e6@mx.google.com>
 <00e098ec-671b-1117-c9c6-7f8fa96519f7@collabora.com>
 <87blca27fy.wl-maz@kernel.org>
 <d9156098-f512-09bc-fa42-7a0f0bdee978@collabora.com>
 <877dmx26gh.wl-maz@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <a7bfc0a6-19a8-9691-f206-76212849d108@collabora.com>
Date:   Wed, 24 Feb 2021 09:26:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <877dmx26gh.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2021 08:52, Marc Zyngier wrote:
> On Tue, 23 Feb 2021 21:03:52 +0000,
> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>
>> On 23/02/2021 14:18, Marc Zyngier wrote:
>>> Hi Guillaume,
>>>
>>> On Tue, 23 Feb 2021 09:46:30 +0000,
>>> Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>>>>
>>>> Hello Marc,
>>>>
>>>> Please see the bisection report below about a boot failure on
>>>> meson-sm1-khadas-vim3l on mainline.  It seems to only be
>>>> affecting kernels built with CONFIG_ARM64_64K_PAGES=y.
>>>>
>>>> Reports aren't automatically sent to the public while we're
>>>> trialing new bisection features on kernelci.org but this one
>>>> looks valid.
>>>>
>>>> There's no output in the log, so the kernel is most likely
>>>> crashing early.  Some more details can be found here:
>>>>
>>>>   https://kernelci.org/test/case/id/6034bed3b344e2860daddcc8/
>>>>
>>>> Please let us know if you need any help to debug the issue or try
>>>> a fix on this platform.
>>>
>>> Thanks for the heads up.
>>>
>>> There is actually a fundamental problem with the patch you bisected
>>> to: it provides no guarantee that the point where we enable the EL2
>>> MMU is in the idmap and, as it turns out, the code we're running from
>>> disappears from under our feet, leading to a translation fault we're
>>> not prepared to handle.
>>>
>>> How does it work with 4kB pages? Luck.
>>
>> There may be a fascinating explanation for it, but luck works
>> too.  It really seems to be booting happily with 4k pages:
>>
>>   https://kernelci.org/test/plan/id/60347b358de339d1b7addcc5/
> 
> Oh, I know it boots fine with 4k, that's what I used everywhere.
> We're just lucky that the bit of code that deals with the MMU happens
> to *also* be in the idmap. With 64k pages, it gets pushed further down
> the line, and bad things happen. Short of explicit statements in the
> code, luck rules.

OK I see that now, thanks for the explanation.

>>> Do you mind giving the patch below a go? It does work on my vim3l and
>>> on a FVP, so odds are that it will solve it for you too.
>>
>> Sure, and that worked here as well:
>>
>>   http://lava.baylibre.com:10080/scheduler/job/752416
>>
>> and here's the test branch where I applied your fix, for
>> completeness:
>>
>>   https://gitlab.collabora.com/gtucker/linux/-/commits/v5.11-vim3l-vhe/
> 
> Awesome. thanks for having tested it.
> 
>> As always, if you do send a patch with the fix, please give some
>> credit to the bot:
>>
>>   Reported-by: "kernelci.org bot" <bot@kernelci.org> 
> 
> Will do. Mind if I credit you too for the testing?

Sure:

  Tested-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Thanks,
Guillaume
