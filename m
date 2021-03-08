Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA193308CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhCHH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:29:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:28159 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCHH24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:28:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210308072854euoutp019a0805c9f4046b396a397859f3c2a543~qTWoxy1jk0843408434euoutp01a
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210308072854euoutp019a0805c9f4046b396a397859f3c2a543~qTWoxy1jk0843408434euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615188534;
        bh=oBpZln5qiDejv5kQaND8AYIWrqvXLzr/UBBUs/vZ4To=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GeIdGtf7GbqdQXp2+9offQThsT8Hca4RWDC6GVXPeFGCXuBRrlg86+qIEZuzgerTg
         qSxRIMa/yR0ZJYi0yxR0Vh6jn9lyZHtB5jMaQXHAVqVym9+95bsfTe/ppihzfYXwDj
         quSagANoyYKUL8K3/qf5c5c2JH8XAShZH0A0v/js=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210308072854eucas1p2b7c0c00616da71ed45206e1c1ec79036~qTWoM3gon2297222972eucas1p2D;
        Mon,  8 Mar 2021 07:28:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.E0.09439.632D5406; Mon,  8
        Mar 2021 07:28:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210308072853eucas1p20558eaf4a2e231806b5fdac206afc03f~qTWnqsjIQ0292002920eucas1p2g;
        Mon,  8 Mar 2021 07:28:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210308072853eusmtrp2964d578e9e1afa5fe9c0402202b63063~qTWnp4Ukn1966019660eusmtrp2y;
        Mon,  8 Mar 2021 07:28:53 +0000 (GMT)
X-AuditID: cbfec7f5-c1bff700000024df-2d-6045d2363dfd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.D9.08696.532D5406; Mon,  8
        Mar 2021 07:28:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210308072852eusmtip1f385660e11b584c7118cc8680649f583~qTWm-phSn2288922889eusmtip1i;
        Mon,  8 Mar 2021 07:28:52 +0000 (GMT)
Subject: Re: [PATCH v3] amba: Remove deferred device addition
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <077fcc5b-cd09-d587-6906-d10bcc991eaf@samsung.com>
Date:   Mon, 8 Mar 2021 08:28:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx87v5=jDqCmdJL9VShAv+OzOGyF43mahxdk9A-RzNJYkA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7pml1wTDCY95rCYO3sSo8WZ37oW
        O7aLWEz5s5zJ4vKuOWwWh6buZbTYNms5m8XdeydYLP7v2cFu0XXoL5vF8lM7WCyOrw134PHY
        tnsbq8eaeWsYPS5fu8jsMfGsrseCTaUem1Z1snncubaHzaP/r4HH5tPVHp83yQVwRXHZpKTm
        ZJalFunbJXBlnL1/lK1gqVzFwy37WRoYT0t0MXJySAiYSCw9NJW9i5GLQ0hgBaPEt81drBDO
        F0aJCfsXQGU+M0q8X7iPEa5l3RMWiMRyRonWsyuZIZyPQC3f5rOCVAkL2Eq82/8crENEQEti
        07XHYB3MAieZJXqb1oMl2AQMJbredrGB2LwCdhKXG1cxgdgsAioSi3smM4PYogJJEn9/32SC
        qBGUODkTZDUnB6dAoETr6R9gNrOAvMT2t3OYIWxxiVtP5jOBLJMQmM8pcfF4MzPE3S4SX7su
        sEHYwhKvjm9hh7BlJP7vhGloZpR4eG4tO4TTwyhxuWkG1NfWEnfO/QLq5gBaoSmxfpc+RNhR
        Yt/958wgYQkBPokbbwUhjuCTmLRtOlSYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRaS12YheWcW
        kndmIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzC9nf53/OsOxhWvPuodYmTi
        YDzEKMHBrCTC29vjnCDEm5JYWZValB9fVJqTWnyIUZqDRUmcd9fWNfFCAumJJanZqakFqUUw
        WSYOTqkGpvzfS75NvLCodeW0Vxq1569/+DhV817gvcaJv29aHy4ptSs8f2/hkovnJpsZVZ7h
        YXv4dPtyhqmT5wkqCP5j4ziTWXbm/pTrXC7LT1wpXMmn+605MMAnmdlS4DrLqpeXV5yq2/ZB
        eEGwftKLr0IXZsS0Xj1Ws3qPg3qsrPWnvCNKeZoifCEXOQ2fnE8TVBHTlGRJeFTKwVxlecZc
        7WPSG7umKR856/nWiua+yHTdGZr4/f2qeUVHQz1SKkL15hRNrQ/el8vWyrWt5Itf+16GNNWK
        CnbLK8sPbVfStFb4f6eq41oL/zrBK0HizLESkcJ5jXE5ObHyNsn/olcaZDq+Kd2fwpS1565u
        ldEVt3xfJZbijERDLeai4kQANXXg+d4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7qml1wTDFb1K1vMnT2J0eLMb12L
        HdtFLKb8Wc5kcXnXHDaLQ1P3Mlpsm7WczeLuvRMsFv/37GC36Dr0l81i+akdLBbH14Y78Hhs
        272N1WPNvDWMHpevXWT2mHhW12PBplKPTas62TzuXNvD5tH/18Bj8+lqj8+b5AK4ovRsivJL
        S1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyzt4/ylawVK7i
        4Zb9LA2MpyW6GDk5JARMJJaue8LSxcjFISSwlFHix+UWFoiEjMTJaQ2sELawxJ9rXWwQRe8Z
        Jb59mc8EkhAWsJV4t/85I4gtIqAlsenaY7BJzAKnmSV+r3nNDpIQEuhmkvjfrQBiswkYSnS9
        BZnEycErYCdxuXEV2CAWARWJxT2TmUFsUYEkifXTbzJB1AhKnJz5BOwiToFAidbTP8BsZgEz
        iXmbHzJD2PIS29/OgbLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzAaN527OeWHYwrX33UO8TIxMF4iFGCg1lJhLe3xzlBiDclsbIqtSg/vqg0
        J7X4EKMp0D8TmaVEk/OB6SSvJN7QzMDU0MTM0sDU0sxYSZzX5MiaeCGB9MSS1OzU1ILUIpg+
        Jg5OqQYmvn2bt0WfPHLO837AqxV+K+qPHy2TLbeRMFB+Wh9Z1rDn6vZD3tuvbbK+pzzj7TED
        mz17zockeEeY7WdOuxXwp3l/56P/K868v2r0MiFB8pPFtH0mXkaMBQmdcSy6MjZz93x67qf0
        XmEGe7VV8PnCSymeP4T9XZoVneU/dr/4+y2ppF7iybknTxMrHpWKmXh/WOnWLVZ9+d3qqdOb
        uw2/9WpbKDGX+mr7id0ULy0//EbgttEy/muZecezW7/vTGdWF9DfelRqWk//EZMv9qI9nk/z
        917KYG4MYl7lGLGcMYeHi7Pists5WTcuwblmJXeqZGUyeLf25zFdVGK7v5Yh8WHG2xl79/Un
        rF0YN0uJpTgj0VCLuag4EQCnP/3jbwMAAA==
X-CMS-MailID: 20210308072853eucas1p20558eaf4a2e231806b5fdac206afc03f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3
References: <CGME20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3@eucas1p1.samsung.com>
        <20210304195101.3843496-1-saravanak@google.com>
        <30b4141e-11bd-45a2-b890-fddf444548ea@samsung.com>
        <CAGETcx87v5=jDqCmdJL9VShAv+OzOGyF43mahxdk9A-RzNJYkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 05.03.2021 19:02, Saravana Kannan wrote:
> On Fri, Mar 5, 2021 at 3:45 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 04.03.2021 20:51, Saravana Kannan wrote:
>>> The uevents generated for an amba device need PID and CID information
>>> that's available only when the amba device is powered on, clocked and
>>> out of reset. So, if those resources aren't available, the information
>>> can't be read to generate the uevents. To workaround this requirement,
>>> if the resources weren't available, the device addition was deferred and
>>> retried periodically.
>>>
>>> However, this deferred addition retry isn't based on resources becoming
>>> available. Instead, it's retried every 5 seconds and causes arbitrary
>>> probe delays for amba devices and their consumers.
>>>
>>> Also, maintaining a separate deferred-probe like mechanism is
>>> maintenance headache.
>>>
>>> With this commit, instead of deferring the device addition, we simply
>>> defer the generation of uevents for the device and probing of the device
>>> (because drivers needs PID and CID to match) until the PID and CID
>>> information can be read. This allows us to delete all the amba specific
>>> deferring code and also avoid the arbitrary probing delays.
>>>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: John Stultz <john.stultz@linaro.org>
>>> Cc: Saravana Kannan <saravanak@google.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> ---
>>>
>>> v1 -> v2:
>>> - Dropped RFC tag
>>> - Complete rewrite to not use stub devices.
>>> v2 -> v3:
>>> - Flipped the if() condition for hard-coded periphids.
>>> - Added a stub driver to handle the case where all amba drivers are
>>>     modules loaded by uevents.
>>> - Cc Marek after I realized I forgot to add him.
>>>
>>> Marek,
>>>
>>> Would you mind testing this? It looks okay with my limited testing.
>> It looks it works fine on my test systems. I've checked current
>> linux-next and this patch. You can add:
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Hi Marek,
>
> Thanks! Does your test set up have amda drivers that are loaded based
> on uevents? That's the one I couldn't test.

I've checked both, the built-in and all amba drivers compiled as 
modules, loaded by udev. Both works fine here.

>> I've briefly scanned the code and I'm curious how does it work. Does it
>> depend on the recently introduced "fw_devlink=on" feature? I don't see
>> other mechanism, which would trigger matching amba device if pm domains,
>> clocks or resets were not available on time to read pid/cid while adding
>> a device...
> No, it does not depend on fw_devlink or device links in any way.
>
> When a device is attempted to be probed (when it's added or during
> deferred probe), it's matched with all the drivers on the bus.
> When a new driver is registered to a bus, all devices in that bus are
> matched with the driver to see if they'll work together.
> That's how match is called. And match() can return -EPROBE_DEFER and
> that'll cause the device to be put in the deferred probe list by
> driver core.
>
> The tricky part in this patch was the uevent handling and the
> chicken-and-egg issue I talk about in the comments.

Thanks for the explanation. This EPROBE_DEFER support in match() 
callback must be something added after I crafted that periodic retry 
based workaround.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

