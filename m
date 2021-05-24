Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85138F640
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhEXXbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhEXXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:31:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=825KHTAJ6S5hmvjoq/3MHUuy0wqdt4KWOS5cZHU37N8=; b=BLRN0gbYyGLk4jZKOqDQJ4Q6MI
        +wlelqt/qEFqZPeqZutZSLlBu1zyPjnfIQGSmdJWoTN6O+OOrOYYFqfHbu6yfvPC1f+nwRJcVkctZ
        lDvjsKBdlyuIsX/qlE+Ql4T5bzrRy7b6KNehCUOvk/s0HuSldO96/GTPCaHZoFe9sTjyFOp2KMhed
        OqLws/PRUk85mlsrHiuHlcE1VgdJ9CBc2Vl16kS99OA3KDcdOuZl7eIkysU85RDkSXqfVpbpp80AW
        vz+5QBd4bp8TYQyzkmduBkZ1fcfvsOef8rcIqCaloFc58wnqMH7B85yW984PazEu1+4K7ce7en2UJ
        O18gGx0w==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llK1J-002LXi-Rt; Mon, 24 May 2021 23:30:02 +0000
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
References: <20210523001806.3927609-1-tpiepho@gmail.com>
 <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
 <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org>
 <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org>
Date:   Mon, 24 May 2021 16:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 3:56 PM, Daniel Latypov wrote:
> On Mon, May 24, 2021 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 5/24/21 9:55 AM, Daniel Latypov wrote:
>>> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
>>> index f19bc9734fa7..20460b567493 100644
>>> --- a/lib/math/Kconfig
>>> +++ b/lib/math/Kconfig
>>> @@ -15,3 +15,14 @@ config PRIME_NUMBERS
>>>
>>>  config RATIONAL
>>>         bool
>>> +
>>> +config RATIONAL_KUNIT_TEST
>>> +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
>>> +       # depends on KUNIT && RATIONAL  # this is how it should work, but
>>> +       depends on KUNIT
>>> +       select RATIONAL # I don't grok kconfig enough to know why this
>>
>> Only to set the symbol CONFIG_RATIONAL.
>> Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
>> it will decide to build the binary rational.o.
>>
>> obj-$(CONFIG_RATIONAL)          += rational.o
>>
> 
> Ack, I understand that much.

Oh! Clearly I misunderstood the problem.

I had to look thru 60 config files before I found one where CONFIG_RATIONAL
was not set.

And I'm still not sure, but I believe that it's because it has to be set
by some other Kconfig entry doing a 'select' on it.

Here are the kconfigs that select it (on i386, where I found it not set):

- COMMON_CLK [=n] && !HAVE_LEGACY_CLK [=n]
- SERIAL_8250_LPSS [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
- SERIAL_8250_MID [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
- SERIAL_IMX [=n] && TTY [=n] && HAS_IOMEM [=y] && (ARCH_MXC || COMPILE_TEST [=y])
- VIDEO_V4L2 [=n] && MEDIA_SUPPORT [=n] && (I2C [=y] || I2C [=y]=n) && VIDEO_DEV [=n]
- SND_SOC_ROCKCHIP_PDM [=n] && SOUND [=n] && !UML && SND [=n] && SND_SOC [=n] && CLKDEV_LOOKUP [=n] && SND_SOC_ROCKCHIP [=n]
- COMMON_CLK_QCOM [=n] && COMMON_CLK [=n] && OF [=y] && (ARCH_QCOM || COMPILE_TEST [=y])

but my test config has none of those enabled, so I cannot set RATIONAL.

I guess the easiest solution is to have KUNIT or some sub-KUNIT test
just select RATIONAL.

> My confusion is why this doesn't work:
> 
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_RATIONAL=y
> EOF
> ...
> ERROR:root:Provided Kconfig is not contained in validated .config.
> Following fields found in kunitconfig, but not in .config:
> CONFIG_RATIONAL=y
> 
> What it's complaining about is that `make  ARCH=um olddefconfig` is
> leaving CONFIG_RATIONAL=y unset.
> 
> Stripping out kunit.py, it's this:
> 
> $ echo -e 'CONFIG_KUNIT=y\nCONFIG_RATIONAL=y' > .kunit/.config
> $ make ARCH=um olddefconfig O=.kunit
> $ grep RATIONAL .kunit/.config
> 
> I'm not versed in Kconfig enough to know why CONFIG_RATIONAL=y is
> getting removed.
> 
>>
>>> is necessary
>>> +       default KUNIT_ALL_TESTS
>>> +       help
>>> +               This builds unit tests for the rational number support.
>>> +
>>> +               If unsure, say N.


-- 
~Randy

