Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924E230F2BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhBDLxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:53:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47295 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhBDLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:53:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210204115252euoutp01e4d2d06a630e907ad7b15660ae9b981c~giT_f43Rv1316513165euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:52:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210204115252euoutp01e4d2d06a630e907ad7b15660ae9b981c~giT_f43Rv1316513165euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612439572;
        bh=CrNgGnBdM3NHfovieeL3wYXRz6hRRA0BSDq+Zhi40gc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=opQRrg4yNliSwPvrTcw9NCGBZaU5+ib/zuJTVeAg8PuVl5TeCSC98Wclq2+i+a7lP
         lS1J42MSY0lOXPwDA8TCO6bqefWMNBzLfLfNKj40M0JNbMEXMMOqaWvYGV5Rj9ZuY3
         KLNUS5qXBGrZe5f2qSs0F7ze1GTRXv22j4R5xO0g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210204115252eucas1p1687ce7461fd73e9919d4d03153359a52~giT_HgnrA0326603266eucas1p1L;
        Thu,  4 Feb 2021 11:52:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.75.27958.410EB106; Thu,  4
        Feb 2021 11:52:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c~giT9p1X5J0269002690eucas1p2C;
        Thu,  4 Feb 2021 11:52:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210204115252eusmtrp12f62cfd97065c534ade5377020fb5da9~giT9pCph30897708977eusmtrp1I;
        Thu,  4 Feb 2021 11:52:52 +0000 (GMT)
X-AuditID: cbfec7f2-efdff70000006d36-85-601be014fb48
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.12.21957.310EB106; Thu,  4
        Feb 2021 11:52:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210204115251eusmtip1b345e76e5f3e7e4261b975491b6070cb~giT81Cnlj0653106531eusmtip1g;
        Thu,  4 Feb 2021 11:52:51 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] of: property: Add fw_devlink support for
 interrupts
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9692dfc9-4c63-71c9-b52b-d0feba466695@samsung.com>
Date:   Thu, 4 Feb 2021 12:52:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210121225712.1118239-3-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7oiD6QTDGb+lrH4MvcUi8X8I+dY
        LWa++c9m8ezWXiaL5sXr2SxaZi1isdixXcTiZ/sWJospf5YzWVzeNYfNovPLLDaLnXNOslq0
        7j3CbvF/zw52i65Df9ksbv/mcxDw2LZ7G6vH+xut7B47Z91l91iwqdRj06pONo871/aweRw6
        3MHosX/uGnaP3uZ3bB6fN8kFcEVx2aSk5mSWpRbp2yVwZfw8Poup4A57xY8Le5kbGHexdTFy
        cEgImEjcWmTZxcjFISSwglFi+Y6dTBDOF0aJBW2T2SCcz4wSR/b1wHW8eJgCEV/OKLHh/A2o
        jo+MEid7r7F3MXJyCAsESnS1HmIGsUVA5l756wJSxCywl1li85dbjCAJNgFDia63XWwgNq+A
        ncTOG+vAmlkEVCSuTtkCFhcVSJJYfvMPE0SNoMTJmU9YQGxOARuJPwuPg9nMAvIS29/OYYaw
        xSVuPZkPdpGEwGFOicNX/rCCJCQEXCQudO9jh7CFJV4d3wJly0icntzDAtHQzCjx8Nxadgin
        h1HictMMRogqa4k7536BA4BZQFNi/S59iLCjxN3fz1gh4cInceOtIMQRfBKTtk1nhgjzSnS0
        CUFUq0nMOr4Obu3BC5eYJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YW
        l+al6yXn525iBKbC0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4E9ukEoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzrpq9Jl5IID2xJDU7NbUgtQgmy8TBKdXAlLcoMjD4wIyTW2LvrTrsYh8/7YFP
        y7Vvy+sZtnK1v98onlp7vn/vq8XfrQq4N75sOKh46LlL9Imy+anNLDpJIo+Wrtu2JO+75pKH
        nUf2n3FrMd+g3r1XbJXig4oma/nMN3JvjbL/1YheU1CrM2+6pn0q5c2Dg3Ls6+PVVsyf51st
        kpBrZSFpF272SPmzmYhIv4DPG4290lXXnGQYVUSna7182MiQl/booaWjhIQAB/P9A6apRz5t
        U2S7tHfBKcWevqufOGd/EV1s+eO6qCvDmr0T7qrs9jzBttTi/9bnkY0+uR/vvZt3dPvNnLi/
        mtUaXDvSQ/dLOLrkGPPtZLLauKV3+81L1fl3GKv6ggIdlViKMxINtZiLihMBSKReA/QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7rCD6QTDO4dtbD4MvcUi8X8I+dY
        LWa++c9m8ezWXiaL5sXr2SxaZi1isdixXcTiZ/sWJospf5YzWVzeNYfNovPLLDaLnXNOslq0
        7j3CbvF/zw52i65Df9ksbv/mcxDw2LZ7G6vH+xut7B47Z91l91iwqdRj06pONo871/aweRw6
        3MHosX/uGnaP3uZ3bB6fN8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZ
        Kunb2aSk5mSWpRbp2yXoZfw8Poup4A57xY8Le5kbGHexdTFycEgImEi8eJjSxcjFISSwlFFi
        64+drF2MnEBxGYmT0xqgbGGJP9e62CCK3jNKrNnWzwaSEBYIlOhqPcQMkhARWMEoMe9sEzuI
        wyywl1li28TTTCArhARyJY718II0sAkYSnS97QJr5hWwk9h5Yx07iM0ioCJxdcoWsLioQJLE
        41v3mSBqBCVOznzCAmJzCthI/Fl4HMxmFjCTmLf5ITOELS+x/e0cKFtc4taT+UwTGIVmIWmf
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM/W3Hfm7ewTjv1Ue9Q4xM
        HIyHGCU4mJVEeBPbpBKEeFMSK6tSi/Lji0pzUosPMZoC/TORWUo0OR+YfPJK4g3NDEwNTcws
        DUwtzYyVxHm3zl0TLySQnliSmp2aWpBaBNPHxMEp1cC0starKl/3doP3+Z7Y5jB55ResgqKn
        k4Ki73w6u6Fi+4uJjJs2MlZXybt0KLx1mcaW6N2psGHxSvt75/ZcnqGctpH9tJqlSPsN/95I
        vayf0XebvY42v97uO68zcMpO9ZuVMz+uCi7ekuhYcttG7+Rc1tWK72ZqXNA2yrf1cXtvf77+
        UGX11llqL46kFR291HZg3W4XjthrG6LyL3hvjzOsupe09tXOOQa/N221Xfy478D1Vec/iVt/
        O9g82VM/5BVP7da53EaBV1m4YniP/jc9Ua3xnEvt7QWuFqvPrxafPSDDm7tljsnus/ZL7rFm
        lF+QfLRq9ZKOqTZGArIGU7eavz/pb+22NfrgjPm2esa3lViKMxINtZiLihMBbyoRwIYDAAA=
X-CMS-MailID: 20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c
References: <20210121225712.1118239-1-saravanak@google.com>
        <20210121225712.1118239-3-saravanak@google.com>
        <CGME20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 21.01.2021 23:57, Saravana Kannan wrote:
> This allows fw_devlink to create device links between consumers of an
> interrupt and the supplier of the interrupt.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This patch landed some time ago in linux-next as commit 4104ca776ba3 
("of: property: Add fw_devlink support for interrupts"). It breaks MMC 
host controller operation on ARM Juno R1 board (the mmci@50000 device 
defined in arch/arm64/boot/dts/arm/juno-motherboard.dtsi). I didn't 
check further what's wrong there as without MMC mounting rootfs fails in 
my test system.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

