Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB030A2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhBAIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:06:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35609 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBAIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:06:19 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210201080536euoutp0202e6153bcdb56950f382d4edbefe4cad~fkRru_gvL3203632036euoutp02s
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:05:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210201080536euoutp0202e6153bcdb56950f382d4edbefe4cad~fkRru_gvL3203632036euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612166736;
        bh=SxwVmfqCCfL4H/OUmMQD5znpVUctJNDjmNZ1Kb7+vWE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Avmrn6E4mJjgNLQKRf0JLkxps8qca0lL2ZSm+/cjjZqf9Qcog3PGsMfiYw1ObPGmi
         Q48XZQr4X6Dakv6VmjGe2oj7nl6TPQv5yPt1b8SgXdczvs3acIf7KWPBBPJfDtryVv
         dyhgBDK/gXxDmXmNrgUBBHFc5X8KbNkQzFh1R4i4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210201080536eucas1p14c66537f97e67f8f8a712927de8641b3~fkRrfhm242588325883eucas1p1C;
        Mon,  1 Feb 2021 08:05:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D3.EE.27958.056B7106; Mon,  1
        Feb 2021 08:05:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210201080535eucas1p10a057322737f1c0d435312dc5a18f624~fkRrHiZqg1111011110eucas1p16;
        Mon,  1 Feb 2021 08:05:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210201080535eusmtrp1044271b3057bdf5c2be3bc2325ac4a6e~fkRrG2dXD1468214682eusmtrp1v;
        Mon,  1 Feb 2021 08:05:35 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-40-6017b650897d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.D1.21957.F46B7106; Mon,  1
        Feb 2021 08:05:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210201080535eusmtip18cb15051d2ce504939039e516eedc5a1~fkRqdovg51412814128eusmtip1j;
        Mon,  1 Feb 2021 08:05:35 +0000 (GMT)
Subject: Re: [PATCH v1 0/2] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ca582e9f-bc4d-bb94-f700-1cf9dc897b57@samsung.com>
Date:   Mon, 1 Feb 2021 09:05:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87oB28QTDL71sVt8mXuKxeLZrb1M
        Fs2L17NZ7NguYjHlz3Imi8u75rBZ7JxzktVi7pepzBZdh/6yWXxc4uDA5bFt9zZWj/c3Wtk9
        Fmwq9di0qpPN4861PWwehw53MHrsn7uG3ePOj6WMHp83yQVwRnHZpKTmZJalFunbJXBl7DrW
        ylzQIVxx4clBpgbGufxdjJwcEgImEg+W/GDrYuTiEBJYwSjx9F0DI4TzhVHi6PyrzBDOZ0aJ
        5qanzDAtDbf3Q1UtZ5RYsPI/VNVHRomua9PAqoQFbCWmX13ACGKLCNxjkph6sAzEZhaIkLhw
        6jtYDZuAoUTX2y42EJtXwE5iw9UT7CA2i4CKxNNDd1hBbFGBJIm7dw4zQdQISpyc+YQFxOYU
        CJQ4+vI1E8RMeYntb+cwQ9jiEreezGcCOUhCoJtTomVZFwvE2S4S21feZYSwhSVeHd/CDmHL
        SJye3MMC0dDMKPHw3Fp2CKeHUeJy0wyoDmuJO+d+AZ3KAbRCU2L9Ln2IsKNE89Q3LCBhCQE+
        iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRaS12YheWcWkndmIexdwMiy
        ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzCNnf53/NMOxrmvPuodYmTiYDzEKMHBrCTC
        e2qSWIIQb0piZVVqUX58UWlOavEhRmkOFiVx3lWz18QLCaQnlqRmp6YWpBbBZJk4OKUamIJi
        JjRlLS1daLv+y8eK0OIHtbf1PBcZyk3om3Ft3oYJQV93OKQ/kZZ652MdbbJ1DYfz1ltempu+
        pzsYJ+xUaPjTrb7hfL2tTrDupB1+BfttHNllp8qslz/1wuXNiQ2blG+dPr/+zPlvfYv6ynfH
        Wb9Z8CZX+ZPiZ7m4tv26Uy8mcLlfDF9516tI104ljJ3998vI9x8cjgr1h3dvFmx8GH5hp1Bf
        xQRvjk/tE59sm8Vcn7P4Wa7h8oLM85z7OpauKJfJvswZ4t1+U6GmcsaUepmQ+VonD70t5hK3
        fxM4Y+9ujjmKzs5/bj4+e3rPxU8Kb2tOOy+/5Bn6+8K7F41Pp/nOOfUr7mRuoNp6VxUlswIl
        luKMREMt5qLiRAAFK1KB0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7r+28QTDPY81Lb4MvcUi8WzW3uZ
        LJoXr2ez2LFdxGLKn+VMFpd3zWGz2DnnJKvF3C9TmS26Dv1ls/i4xMGBy2Pb7m2sHu9vtLJ7
        LNhU6rFpVSebx51re9g8Dh3uYPTYP3cNu8edH0sZPT5vkgvgjNKzKcovLUlVyMgvLrFVija0
        MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL2HWslbmgQ7jiwpODTA2Mc/m7GDk5
        JARMJBpu72fsYuTiEBJYyiix4tpRZoiEjMTJaQ2sELawxJ9rXWwQRe8ZJW42vmMDSQgL2EpM
        v7qAEcQWEXjEJNG2NAXEZhaIkJizYh8zRMM1RomH986CNbAJGEp0ve0Cs3kF7CQ2XD3BDmKz
        CKhIPD10B2ybqECSxIlZn5ghagQlTs58wgJicwoEShx9+ZoJYoGZxLzND5khbHmJ7W/nQNni
        EreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg3G47
        9nPzDsZ5rz7qHWJk4mA8xCjBwawkwntqkliCEG9KYmVValF+fFFpTmrxIUZToH8mMkuJJucD
        E0deSbyhmYGpoYmZpYGppZmxkjjv1rlr4oUE0hNLUrNTUwtSi2D6mDg4pRqYGk7vfyjFY7yt
        TuzHK+8PvoumKIfJXUz1SMmxmP6QQT3cNCVgQ0uSrtX73PjCaXxbe0ttMjIWNjBMnM/eKy7w
        v+iC7q9k85UV65SKHnQd2Nfs82ybi9m74zc05/8XMzj2nbUocPr3H5pJgqI1e/j+fK+q0HNS
        ONR6zrr7Xe+BN3/uTrK9sfnyIb1J7696zZL8sWe+PttvhT4ONrvOb9smVB4wOPm683zsj8he
        Yf7eBS4WIku5JZpDDvp0qmVtXPjA7mKmR9/nDx+Zv2ddn/EuaKl30HbR9v5d0SpabH0ejbU/
        z3OpXpVT2LfpwCnTqLAgs2CPU38rLZ5FbLrG7NVvVOm9bsLvC0wcm7ZGT76rxFKckWioxVxU
        nAgAfis1PmQDAAA=
X-CMS-MailID: 20210201080535eucas1p10a057322737f1c0d435312dc5a18f624
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8
References: <20210130040344.2807439-1-saravanak@google.com>
        <CGME20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8@eucas1p2.samsung.com>
        <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 30.01.2021 05:08, Saravana Kannan wrote:
> On Fri, Jan 29, 2021 at 8:03 PM Saravana Kannan <saravanak@google.com> wrote:
>> This patch series solves two general issues with fw_devlink=on
>>
>> Patch 1/2 addresses the issue of firmware nodes that look like they'll
>> have struct devices created for them, but will never actually have
>> struct devices added for them. For example, DT nodes with a compatible
>> property that don't have devices added for them.
>>
>> Patch 2/2 address (for static kernels) the issue of optional suppliers
>> that'll never have a driver registered for them. So, if the device could
>> have probed with fw_devlink=permissive with a static kernel, this patch
>> should allow those devices to probe with a fw_devlink=on. This doesn't
>> solve it for the case where modules are enabled because there's no way
>> to tell if a driver will never be registered or it's just about to be
>> registered. I have some other ideas for that, but it'll have to come
>> later thinking about it a bit.
>>
>> These two patches might remove the need for several other patches that
>> went in as fixes for commit e590474768f1 ("driver core: Set
>> fw_devlink=on by default"), but I think all those fixes are good
>> changes. So I think we should leave those in.
>>
>> Marek, Geert,
>>
>> Can you try this series on a static kernel with your OF_POPULATED
>> changes reverted? I just want to make sure these patches can identify
>> and fix those cases.
>>
>> Tudor,
>>
>> You should still make the clock driver fix (because it's a bug), but I
>> think this series will fix your issue too (even without the clock driver
>> fix). Can you please give this a shot?
> Marek, Geert, Tudor,
>
> Forgot to say that this will probably fix your issues only in a static
> kernel. So please try this with a static kernel. If you can also try
> and confirm that this does not fix the issue for a modular kernel,
> that'd be good too.

I've checked those patches on top of linux next-20210129 with 
c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform 
driver") commit reverted. Sadly it doesn't help. All devices that belong 
to the Exynos power domains are never probed and stay endlessly on the 
deferred devices list. I've used static kernel build - the one from 
exynos_defconfig.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

