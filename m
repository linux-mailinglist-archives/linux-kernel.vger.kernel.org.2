Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA23AC0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhFRCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:13:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12590 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:13:28 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210618021118epoutp02c3aa898052a1d46c50be7353b579b592~Ji0ccz4h71419114191epoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:11:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210618021118epoutp02c3aa898052a1d46c50be7353b579b592~Ji0ccz4h71419114191epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623982278;
        bh=wryMPHay5RfxaGjnFPF+MtZem4z8xDgt52w3R9Osrqs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iz68c2STG3PNpy93saRWqnZ+8LYeFxQLEyUpP5+a9TdSazA2yQwbQq8Yq9PuuiHlh
         s++ZVlF4jX8UmpAkY8eOdzWUNcGZ6nzGKeiTrz8ba4AejYy8eZTgCkNmW6wXuX/IW0
         37pDIQTYqKIm327vaIm1tPvOV13eCn7GcmgLt3qs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210618021117epcas1p22aa610d01c942f03b1662e736fb46f63~Ji0brTJmj2466424664epcas1p2x;
        Fri, 18 Jun 2021 02:11:17 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G5j8M0X07z4x9Q9; Fri, 18 Jun
        2021 02:11:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.D9.09701.2C00CC06; Fri, 18 Jun 2021 11:11:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210618021114epcas1p43d0d60144168535a092cfd0e5286041d~Ji0Y2L5w-1886218862epcas1p4Q;
        Fri, 18 Jun 2021 02:11:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210618021114epsmtrp1aa590c1252d9c460a6eee77230c02b81~Ji0Y1UWFP1041710417epsmtrp1k;
        Fri, 18 Jun 2021 02:11:14 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-03-60cc00c2cf62
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.AE.08163.2C00CC06; Fri, 18 Jun 2021 11:11:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210618021114epsmtip1b07040362b24d71eccc7f8c44737a00a~Ji0YjqMAd1059010590epsmtip1z;
        Fri, 18 Jun 2021 02:11:13 +0000 (GMT)
Subject: Re: [GIT PULL] Immutable branch between drivers/platform/x86 and
 drivers/extcon due for the v5.14 merge window
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cde62fb0-835b-11a4-871b-e140019a2f58@samsung.com>
Date:   Fri, 18 Jun 2021 11:30:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <667247a0-e40a-84d9-889b-8ecf51e5d453@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmge4hhjMJBjO32li8OT6dyWLj2x9M
        Fpd3zWGz2P7tEZvFnKUnWCxuN65gc2DzmNXQy+bx++hjdo+ds+6ye7zfd5XNo2/LKkaPz5vk
        Atiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
        UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIV
        JmRnbNtxgb3gI3/FvFm1DYwfeLoYOTkkBEwkzm7rYwKxhQR2MEps/SPbxcgFZH9ilFj+5iwb
        ROIzo8TSztguRg6whv17aiFqdjFKzGhtZYNw3jNKrG38CjZJWKBS4u35lWC2iIC6xNSOHrAi
        ZoF2JokF256AJdgEtCT2v7gBtoFfQFHi6o/HjCA2r4CdxO+121lAbBYBVYl//6eB1YgKhEmc
        3NYCVSMocXLmE7AaTpD6p/NZQWxmAXGJW0/mM0HY8hLb385hBlksITCTQ+LCkhusEC+4SByb
        GQPxvrDEq+Nb2CFsKYmX/W1QdrXEypNH2CB6Oxgltuy/wAqRMJbYv3QyE8gcZgFNifW79CHC
        ihI7f89lhNjLJ/Huaw/UKl6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8s0sJB/MQvLBLIRl
        CxhZVjGKpRYU56anFhsWGCFH9SZGcPrUMtvBOOntB71DjEwcjIcYJTiYlUR4dYtPJAjxpiRW
        VqUW5ccXleakFh9iNAWG70RmKdHkfGACzyuJNzQ1MjY2tjAxNDM1NFQS593JdihBSCA9sSQ1
        OzW1ILUIpo+Jg1OqgWn97Gt+uk7691/v+9nt1vB2lZhculWTQ3ncq8ILzevrFGb/aJ8sf2bW
        8ksFcvV85+ZE7LvBWHni0oRVH1mSJxs7+f42TVn4Jmb1nApfwynvL9WwC19WOPPk1kepr0rP
        ghxl+ksCDzTsnxs8mzfLba1+MKvbF8/HnNcX3zoyY6msts3tc4pe1mKMnmZzc20EblxR2Hqt
        fWtkT6Xak8j9jKtCTxj9W/3/8f5q9XavvYL8Z2ayGOjf+rR3x6yP1hseuzipPd21abPu57Tg
        R4JLLCyrNvq5W8Y+rFj3zVPrwnum0o8PrFX4BLmjt/x4ZbigONZ5SVFv6e0936ve5fFoRhxU
        9jtoFbB+qoLApp1//+sosRRnJBpqMRcVJwIA35NLLSgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTvcQw5kEg7knuSzeHJ/OZLHx7Q8m
        i8u75rBZbP/2iM1iztITLBa3G1ewObB5zGroZfP4ffQxu8fOWXfZPd7vu8rm0bdlFaPH501y
        AWxRXDYpqTmZZalF+nYJXBnbdlxgL/jIXzFvVm0D4weeLkYODgkBE4n9e2q7GLk4hAR2MEqs
        e7WYsYuREyguKTHt4lFmiBphicOHiyFq3jJKbHi9jx2kRligUuLt+ZVMILaIgLrE1I4eNpAi
        ZoF2Jokl966yQnRMZJT4t28+2FQ2AS2J/S9usIHY/AKKEld/PAaL8wrYSfxeu50FxGYRUJX4
        938aWI2oQJjEziWPmSBqBCVOznwCVsMJUv90PiuIzQy0+c+8S8wQtrjErSfzmSBseYntb+cw
        T2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4mrS0
        djDuWfVB7xAjEwfjIUYJDmYlEV7d4hMJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTC15CZy3N+2IUxVdq18yLrrlTP/35iRIrx59YaZvC6rdTSUuh2Z
        pnky/z0t/+WY8/6Mg8VR00rEPuVcWV289NYT15XvXsh9i5rIpKLWzyP5wH8Tv7HuvkOt39o2
        N9ez7tKdMPvMCiX1E3zrOVcd3TzdmmsZE2vkVhHpHQ3bwm3+pB469en5H9H0hQ+lfO9mWagt
        5Jv/Z//f/TK/mBwErdwjc7iC5O68+Paf9/KZDz9nHWZuE37lNaE28YRtUpH49B8aCwQOBe9+
        FpL98m914+XNR5RvqZxmW6Bd/bX2GNvr1al5Rn/bPrIzNcdlM3dd/zht3vvOOQ55Sq7rb2iz
        5d+OjprPrC3h7PLY9OC2nRM7lViKMxINtZiLihMBZYF0OxUDAAA=
X-CMS-MailID: 20210618021114epcas1p43d0d60144168535a092cfd0e5286041d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617140425epcas1p146979efb16135032d9c2bc7666ecd825
References: <CGME20210617140425epcas1p146979efb16135032d9c2bc7666ecd825@epcas1p1.samsung.com>
        <667247a0-e40a-84d9-889b-8ecf51e5d453@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for immutable branch.
I think again that you better apply them via your tree
for merging them to linus tree finally without extcon tree.
I'm sorry about change of my opinion.

Thanks.
Chanwoo Choi

On 6/17/21 11:04 PM, Hans de Goede wrote:
> Hi Chanwoo,
> 
> As discussed here is a pull-req from an immutable branch with the
> devm-helper changes from Matti for you to merge into the extcon tree.
> 
> I have already merged this into my review-hans branch and once the
> builders had a chance to play with this I will push this
> branch to platform-drivers-x86/for-next.
> 
> Regards,
> 
> Hans
> 
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/devm-helpers-v5.14-1
> 
> for you to fetch changes up to 87ee8de23c9df3a368504f34cf3d7f9be9207717:
> 
>   extcon: extcon-max8997: Simplify driver using devm (2021-06-17 13:22:27 +0200)
> 
> ----------------------------------------------------------------
> Signed tag for the immutable devm-helpers branch for merging
> into the extcon and pdx86 trees.
> 
> ----------------------------------------------------------------
> Matti Vaittinen (5):
>       devm-helpers: Add resource managed version of work init
>       extcon: extcon-max14577: Fix potential work-queue cancellation race
>       extcon: extcon-max77693.c: Fix potential work-queue cancellation race
>       extcon: extcon-max8997: Fix IRQ freeing at error path
>       extcon: extcon-max8997: Simplify driver using devm
> 
>  drivers/extcon/extcon-max14577.c | 16 +++++---------
>  drivers/extcon/extcon-max77693.c | 17 +++++----------
>  drivers/extcon/extcon-max8997.c  | 45 ++++++++++++++--------------------------
>  include/linux/devm-helpers.h     | 25 ++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 53 deletions(-)
> 
> 
> 
