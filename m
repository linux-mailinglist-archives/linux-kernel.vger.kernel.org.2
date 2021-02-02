Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF430B949
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhBBINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:13:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43110 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhBBINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:13:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210202081220euoutp028cbc2bf837aeb3fa12defd2d04be32b9~f4A15oSnF1861618616euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210202081220euoutp028cbc2bf837aeb3fa12defd2d04be32b9~f4A15oSnF1861618616euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612253540;
        bh=5CbKb7BP0ZcXNMXDhaSeQRwjXPkKpPBkU4CWzRy1xLI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V/Uy11c3uip3RExeFZs8KmOLzdYaDxUGHxNQCjHVlL1Hz4Ze+i/KG5Tjx/gTXZvfB
         nhOAEi40AsR3HbIhGMor3xJKeJMdftRHde6de379h6FpotYf/pSjDpORbe80mOCjtU
         aZyMLSBeE3r5+s/J/YD8clo92I1nYBP7Xua39+xQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210202081219eucas1p2d203459c65530140380eb51e154813f4~f4A1ll5NW1858818588eucas1p2F;
        Tue,  2 Feb 2021 08:12:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.71.27958.36909106; Tue,  2
        Feb 2021 08:12:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210202081219eucas1p1c8dd3fd50e3a1de35b004fd0a3331188~f4A1E40581867718677eucas1p1F;
        Tue,  2 Feb 2021 08:12:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210202081219eusmtrp2d8ba45ae9c13ca39f535446d199300e3~f4A1EIZBt1855418554eusmtrp2r;
        Tue,  2 Feb 2021 08:12:19 +0000 (GMT)
X-AuditID: cbfec7f2-efdff70000006d36-2b-601909630e37
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.AD.21957.36909106; Tue,  2
        Feb 2021 08:12:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210202081218eusmtip147424111a3478f9920489199ee182cba~f4A0eH8Wh0264402644eusmtip1t;
        Tue,  2 Feb 2021 08:12:18 +0000 (GMT)
Subject: Re: [PATCH v1 0/2] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <71b1ee03-830e-750f-5ed6-ccf5e1cc7810@samsung.com>
Date:   Tue, 2 Feb 2021 09:12:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx9FokhX+omo07Tgky_+NPH4uYSMiz2OctvK3L3AsGz8rg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87rJnJIJBkuvqFl8mXuKxeLZrb1M
        Fs2L17NZ7NguYjHlz3Imi8u75rBZ7JxzktVi7pepzBZdh/6yWXxc4uDA5bFt9zZWj/c3Wtk9
        Fmwq9di0qpPN4861PWwehw53MHrsn7uG3ePOj6WMHp83yQVwRnHZpKTmZJalFunbJXBlXD58
        l73gqlLF5E1RDYwLZLoYOTkkBEwktj3bxNTFyMUhJLCCUeLQ/UksEM4XRomPa7YwQjifGSV2
        3F3ICtNy4/YpqKrljBKzji9lh3A+Mkos3X2UGaRKWMBWYvrVBYwgtoiAlsSma4/BOpgFepgl
        9i3bCjaKTcBQouttFxuIzStgJ3F06l52EJtFQEXi8bMHYINEBZIk7t45zARRIyhxcuYTFhCb
        UyBQ4uuSz2A2s4C8RPPW2cwQtrjErSfzwT6SEOjmlGjcegdoAQeQ4yLRMU8K4gVhiVfHt7BD
        2DIS/3fC1DczSjw8t5YdwulhlLjcNIMRospa4s65X2CDmAU0Jdbv0ocIO0o0T33DAjGfT+LG
        W0GIG/gkJm2bzgwR5pXoaBOCqFYDBtY6uLUHL1xinsCoNAvJZ7OQfDMLyTezEPYuYGRZxSie
        Wlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZjETv87/mkH49xXH/UOMTJxMB5ilOBgVhLhPTVJ
        LEGINyWxsiq1KD++qDQntfgQozQHi5I476rZa+KFBNITS1KzU1MLUotgskwcnFINTHIM1XNW
        96VlfllUeMu1vvP5xnrRILX+BMmWgykigUtquRuTEw43Mc45sztMlc2u9mdB+/zGyIcxGu1S
        P60aVHb/Zn2Tc6bHYsJkvc0JllKSGoumvG6PT664fyZHgMvoJ9fnm2EznWsbjpWfdN009/Wz
        t983lHV/WmJhYLq6dLXzZfFZOaFWv04+bipZ1p/3TVtwr3voKY0romaeptZvj54LCzUXtOU6
        ynk23jin8PYp5icbHOyz7a/+OCEd1Ti3OiejUV88acqvB1b/Zbmy/N6JhK+perpuymv2FL/J
        E8U/GU9sc/VKeyzc2HB6/+2s4H3r3NvlvCacObrltsbi5487llYy62l8f+pY5bRciaU4I9FQ
        i7moOBEAr22FVtEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rJnJIJBv9XsVh8mXuKxeLZrb1M
        Fs2L17NZ7NguYjHlz3Imi8u75rBZ7JxzktVi7pepzBZdh/6yWXxc4uDA5bFt9zZWj/c3Wtk9
        Fmwq9di0qpPN4861PWwehw53MHrsn7uG3ePOj6WMHp83yQVwRunZFOWXlqQqZOQXl9gqRRta
        GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlXD58l73gqlLF5E1RDYwLZLoYOTkk
        BEwkbtw+xdLFyMUhJLCUUeLh3gmsEAkZiZPTGqBsYYk/17rYIIreM0pM2bMOLCEsYCsx/eoC
        RhBbREBLYtO1x2CTmAUmMEtsPdvMDNFxiUni8ay7zCBVbAKGEl1vQUZxcvAK2EkcnbqXHcRm
        EVCRePzsAViNqECSxIlZn5ghagQlTs58wgJicwoESnxd8hnMZhYwk5i3+SEzhC0v0bx1NpQt
        LnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExu22
        Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrynJoklCPGmJFZWpRblxxeV5qQWH2I0BfpnIrOUaHI+
        MHHklcQbmhmYGpqYWRqYWpoZK4nzbp27Jl5IID2xJDU7NbUgtQimj4mDU6qBqcagVyd+Xl3x
        Q7W/h37v+xrl9H2de8UM/3zvFXJOJhuOX/BRLSpgMp9kN9PkYdW9rK/z9yzMshSdcvpis4q3
        n2/cmrv/n6q1zhG/uPB2x9a//Ft1khxnTl11v9rddqrKnc05stlBRtlJrzO7tnx+8/tgZ6P5
        Ov5jZp/3rNyr7+n8JL/yZIHnB8nV4jHTZZK7ehSvm3OmrFGt6lh+tKNKRHG9zulJ9dXPN0rl
        hVm9m+JdO/dUx4sQm6stPVKH512s9PP6MDtAM67wdsPEF0J6XmJ/d2vMqrdRTVi0actihdKD
        d76E92iFXjwlyvVs7+9K0zXWryUyvSIfO1Ue2diZ9LDr0POgxRkPXkVcDvR6pcRSnJFoqMVc
        VJwIACQ3/EdkAwAA
X-CMS-MailID: 20210202081219eucas1p1c8dd3fd50e3a1de35b004fd0a3331188
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8
References: <20210130040344.2807439-1-saravanak@google.com>
        <CGME20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8@eucas1p2.samsung.com>
        <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com>
        <ca582e9f-bc4d-bb94-f700-1cf9dc897b57@samsung.com>
        <CAGETcx9FokhX+omo07Tgky_+NPH4uYSMiz2OctvK3L3AsGz8rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 01.02.2021 10:02, Saravana Kannan wrote:
> On Mon, Feb 1, 2021 at 12:05 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 30.01.2021 05:08, Saravana Kannan wrote:
>>> On Fri, Jan 29, 2021 at 8:03 PM Saravana Kannan <saravanak@google.com> wrote:
>>>> This patch series solves two general issues with fw_devlink=on
>>>>
>>>> Patch 1/2 addresses the issue of firmware nodes that look like they'll
>>>> have struct devices created for them, but will never actually have
>>>> struct devices added for them. For example, DT nodes with a compatible
>>>> property that don't have devices added for them.
>>>>
>>>> Patch 2/2 address (for static kernels) the issue of optional suppliers
>>>> that'll never have a driver registered for them. So, if the device could
>>>> have probed with fw_devlink=permissive with a static kernel, this patch
>>>> should allow those devices to probe with a fw_devlink=on. This doesn't
>>>> solve it for the case where modules are enabled because there's no way
>>>> to tell if a driver will never be registered or it's just about to be
>>>> registered. I have some other ideas for that, but it'll have to come
>>>> later thinking about it a bit.
>>>>
>>>> These two patches might remove the need for several other patches that
>>>> went in as fixes for commit e590474768f1 ("driver core: Set
>>>> fw_devlink=on by default"), but I think all those fixes are good
>>>> changes. So I think we should leave those in.
>>>>
>>>> Marek, Geert,
>>>>
>>>> Can you try this series on a static kernel with your OF_POPULATED
>>>> changes reverted? I just want to make sure these patches can identify
>>>> and fix those cases.
>>>>
>>>> Tudor,
>>>>
>>>> You should still make the clock driver fix (because it's a bug), but I
>>>> think this series will fix your issue too (even without the clock driver
>>>> fix). Can you please give this a shot?
>>> Marek, Geert, Tudor,
>>>
>>> Forgot to say that this will probably fix your issues only in a static
>>> kernel. So please try this with a static kernel. If you can also try
>>> and confirm that this does not fix the issue for a modular kernel,
>>> that'd be good too.
>> I've checked those patches on top of linux next-20210129 with
>> c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform
>> driver") commit reverted.
> Hi Marek,
>
> Thanks for testing!
>
>> Sadly it doesn't help.
> That sucks. I even partly "tested" it out on my platform (that needs
> CONFIG_MODULES) by commenting out the CONFIG_MODULES check. And I saw
> some device links getting dropped.

Well, my fault. I've missed the fact that I have to disable 
CONFIG_MODULES to let it work. This is not really a fix for my case, 
because the exynos_defconfig has modules enabled (mainly for WiFi and 
media drivers). However disabling the CONFIG_MODULES indeed helped a 
bit. Most of the devices got finally probed. There are only 4 left in 
the deferred_devices list:

sound
12e20000.sysmmu
12d00000.hdmi
12c10000.mixer

The last two (12c10000.mixer and 12d00000.hdmi) are consumers of the 
12e20000.sysmmu, which is a consumer of the 10023c20.power-domain. That 
power domain in turn is a consumer (child) of another power domain 
(10023c80.power-domain):

# dmesg | grep 10023c20.power-domain
[    0.354435] platform 10023c20.power-domain: Linked as a consumer to 
10023c80.power-domain
[    0.489573] platform 12d00000.hdmi: Linked as a consumer to 
10023c20.power-domain
[    0.497143] platform 12c10000.mixer: Linked as a consumer to 
10023c20.power-domain
[    0.580874] platform 12e20000.sysmmu: Linked as a consumer to 
10023c20.power-domain
[    0.601655] platform 12e20000.sysmmu: probe deferral - supplier 
10023c20.power-domain not ready
[    2.744884] platform 12c10000.mixer: probe deferral - supplier 
10023c20.power-domain not ready
[    2.766726] platform 12d00000.hdmi: probe deferral - supplier 
10023c20.power-domain not ready

...

So a dependency chain of 2 power domains is still not resolved properly.

I didn't have time to check what's wrong with the sound node. Simple 
grepping of the messages for the 'sound' string don't give any results. 
The above tests has been done on the Odroid U3 board 
(arch/arm/boot/dts/exynos4412-odroidu3.dts).

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

