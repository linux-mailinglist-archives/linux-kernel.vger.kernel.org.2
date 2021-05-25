Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904BC38F7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhEYBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhEYBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:50:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AF4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AnzmjFLcr9sazcYYCEVeK6/JyrtHh6pxrkAi8rHdcsU=; b=4rjvtYlUETDolGa3RR0dXrNKLY
        d/Jz1AAyu/o1rAYuVPHUqVhkpnX1FaQOGZd6iGAYvlUXHYZvbVu4+XXCAPWgx/qLR9KWIyC3ZzvmJ
        xqMddlN0dTzGCEw2fXV0gAgoysSVsrzlCYUK/wjxDq/a2HNIADeIxo217pOurvcCxG33sC7pqTSLc
        3mcMJwCo4hSNDM0k7jnv28H2Nz4gpeW7CsP6xGCzpoCp7BM85TjATX16odDXVBF7Ysx9rtLcpgWZm
        UxvqAAWAkt795ATHWZmWp9iZDHGD4NBGnj08NtYVktUHg1Ngdv2PcwOA7qkzyhP6Yl0XSPlJ9e49H
        wC/et3Lg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llMBy-002oGW-Rc; Tue, 25 May 2021 01:49:10 +0000
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
References: <20210523001806.3927609-1-tpiepho@gmail.com>
 <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
 <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org>
 <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
 <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org>
 <CAGS_qxrUGW4uyMUQtEYWX710LxPs23B=uOJfhZSvMV1yaVa6jA@mail.gmail.com>
 <CABVgOSnB2_WVtedhE+EPMM9v+ePOp2KMFze84oxGS9Pgf31HxA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <caaab2dd-b1b6-b105-6b2f-9a2bc8438a82@infradead.org>
Date:   Mon, 24 May 2021 18:49:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSnB2_WVtedhE+EPMM9v+ePOp2KMFze84oxGS9Pgf31HxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 5:42 PM, David Gow wrote:
> On Tue, May 25, 2021 at 7:38 AM Daniel Latypov <dlatypov@google.com> wrote:
>>
>> On Mon, May 24, 2021 at 4:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 5/24/21 3:56 PM, Daniel Latypov wrote:
>>>> On Mon, May 24, 2021 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>
>>>>> On 5/24/21 9:55 AM, Daniel Latypov wrote:
>>>>>> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
>>>>>> index f19bc9734fa7..20460b567493 100644
>>>>>> --- a/lib/math/Kconfig
>>>>>> +++ b/lib/math/Kconfig
>>>>>> @@ -15,3 +15,14 @@ config PRIME_NUMBERS
>>>>>>
>>>>>>  config RATIONAL
>>>>>>         bool
>>>>>> +
>>>>>> +config RATIONAL_KUNIT_TEST
>>>>>> +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
>>>>>> +       # depends on KUNIT && RATIONAL  # this is how it should work, but
>>>>>> +       depends on KUNIT
>>>>>> +       select RATIONAL # I don't grok kconfig enough to know why this
>>>>>
>>>>> Only to set the symbol CONFIG_RATIONAL.
>>>>> Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
>>>>> it will decide to build the binary rational.o.
>>>>>
>>>>> obj-$(CONFIG_RATIONAL)          += rational.o
>>>>>
>>>>
>>>> Ack, I understand that much.
>>>
>>> Oh! Clearly I misunderstood the problem.
>>>
>>> I had to look thru 60 config files before I found one where CONFIG_RATIONAL
>>> was not set.
>>>
>>> And I'm still not sure, but I believe that it's because it has to be set
>>> by some other Kconfig entry doing a 'select' on it.
>>>
>>> Here are the kconfigs that select it (on i386, where I found it not set):
>>>
>>> - COMMON_CLK [=n] && !HAVE_LEGACY_CLK [=n]
>>> - SERIAL_8250_LPSS [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
>>> - SERIAL_8250_MID [=n] && TTY [=n] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && PCI [=n] && (X86 [=y] || COMPILE_TEST [=y])
>>> - SERIAL_IMX [=n] && TTY [=n] && HAS_IOMEM [=y] && (ARCH_MXC || COMPILE_TEST [=y])
>>> - VIDEO_V4L2 [=n] && MEDIA_SUPPORT [=n] && (I2C [=y] || I2C [=y]=n) && VIDEO_DEV [=n]
>>> - SND_SOC_ROCKCHIP_PDM [=n] && SOUND [=n] && !UML && SND [=n] && SND_SOC [=n] && CLKDEV_LOOKUP [=n] && SND_SOC_ROCKCHIP [=n]
>>> - COMMON_CLK_QCOM [=n] && COMMON_CLK [=n] && OF [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
>>>
>>> but my test config has none of those enabled, so I cannot set RATIONAL.
>>>
>>> I guess the easiest solution is to have KUNIT or some sub-KUNIT test
>>> just select RATIONAL.
>>
>> Yeah, the easiest thing would be to keep the `select RATIONAL` that I
>> showed in the example patch.
>>
>> +David Gow +Brendan Higgins as they both particularly wanted to avoid
>> having any tests `select` their dependencies, however.
>>
> 
> This came from a thread[1], and one of the causes behind it was not
> wanting to have KUNIT_ALL_TESTS enable things like filesystems and
> drivers which wouldn't otherwise be built.

Ah yes, I recognize that thread.

> Personally, I think that RATIONAL is probably an okay thing to select
> here: it's not as heavyweight as drivers/filesystems/etc, and our
> general guidance here is "avoid select where sensible to do so", not
> "don't use it under any circumstances".

RATIONAL does not have a prompt string, so depending on it would not
be reliable.  I.e., it is meant to be selected.

> The other option would be to have a separate config entry which just
> selected RATIONAL, but even I think that's probably uglier, however
> nice it is for guaranteeing flexibility.

Yes, that's even worse.

> [1]: https://lore.kernel.org/linux-ext4/52959e99-4105-3de9-730c-c46894b82bdd@infradead.org/T/#t
> 
>>>
>>>> My confusion is why this doesn't work:
>>>>
>>>> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
>>>> CONFIG_KUNIT=y
>>>> CONFIG_RATIONAL=y
>>>> EOF
>>>> ...
>>>> ERROR:root:Provided Kconfig is not contained in validated .config.
>>>> Following fields found in kunitconfig, but not in .config:
>>>> CONFIG_RATIONAL=y
>>>>
>>>> What it's complaining about is that `make  ARCH=um olddefconfig` is
>>>> leaving CONFIG_RATIONAL=y unset.
>>>>
>>>> Stripping out kunit.py, it's this:
>>>>
>>>> $ echo -e 'CONFIG_KUNIT=y\nCONFIG_RATIONAL=y' > .kunit/.config
>>>> $ make ARCH=um olddefconfig O=.kunit
>>>> $ grep RATIONAL .kunit/.config
>>>>
>>>> I'm not versed in Kconfig enough to know why CONFIG_RATIONAL=y is
>>>> getting removed.
>>>>
>>>>>
>>>>>> is necessary
>>>>>> +       default KUNIT_ALL_TESTS
>>>>>> +       help
>>>>>> +               This builds unit tests for the rational number support.
>>>>>> +
>>>>>> +               If unsure, say N.


-- 
~Randy

