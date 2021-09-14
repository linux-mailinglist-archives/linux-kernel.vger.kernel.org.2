Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DC40A698
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbhINGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:16:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43005 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbhINGQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:16:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210914061512euoutp029616e7cd1a465b4f5b382065d133c758~km6hVHsrx0737207372euoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210914061512euoutp029616e7cd1a465b4f5b382065d133c758~km6hVHsrx0737207372euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631600112;
        bh=I/edZr8BlUd40McbMEg2zkIzCis5wLjFNkkfSzTLxDs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZE/kJC+s8qEQq71PV18U7t18oZmYdoCF3gMfhUmQ6GsDIqs7/CQX0GPYgDapQEkCt
         EJRsTU5k+B7X9uNRNcgdsM13B7/cQ+IsanFL2jlI4Qswt2cZBOvNmaEBJmc84geBOX
         Dyhga28Jkkf58UiMn+mCfcv1RVFrVbeJwjdJCz5A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210914061512eucas1p2726973d3a03900bae53ae3287cdb345d~km6hGpJy30039100391eucas1p2k;
        Tue, 14 Sep 2021 06:15:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.A4.45756.FED30416; Tue, 14
        Sep 2021 07:15:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210914061511eucas1p10de5aebb4af7a87b0cbdfc0cf62df8fa~km6gnGtDh1504015040eucas1p1t;
        Tue, 14 Sep 2021 06:15:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210914061511eusmtrp2a2211ce0378ec4420989e16cc236dd14~km6gmcrE00957209572eusmtrp2n;
        Tue, 14 Sep 2021 06:15:11 +0000 (GMT)
X-AuditID: cbfec7f2-7d5ff7000002b2bc-4b-61403def8af2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.BF.31287.FED30416; Tue, 14
        Sep 2021 07:15:11 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210914061511eusmtip1a1ee091206dfdc1d20a65223eed8ca64~km6gKhJAm0142701427eusmtip1P;
        Tue, 14 Sep 2021 06:15:11 +0000 (GMT)
Subject: Re: [PATCH v1] RFC: of: property: fix phy-hanlde issue
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bb2fbc94-9afd-07f4-9bce-bd40516f196a@samsung.com>
Date:   Tue, 14 Sep 2021 08:15:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-qDPETtsSPKyW+6i=c=x2LG-tcJ+zCu40jCa9FwA-bEA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87rvbR0SDZ7utbKYf+Qcq8XMN//Z
        LHZsF7G4vGsOm0Xr3iPsFl2H/rI5sHls272N1WPnrLvsHgs2lXpsWtXJ5vF5k1wAaxSXTUpq
        TmZZapG+XQJXxuSGfYwFnwQr1q68x9zAuJevi5GTQ0LARGJO7wzWLkYuDiGBFYwSj5YsZAVJ
        CAl8YZTYcr4EIvGZUeLdlbnMMB0P9x5khkgsZ5SY/vIJVMdHRomvG426GDk4hAXsJVaeMwcJ
        iwhoSWy69pgFpJ5ZYBGjxPwPtxlBEmwChhJdb7vYQGxeATuJSc8egi1gEVCVWLh0GzuILSqQ
        LDHtbxMzRI2gxMmZT1hAbE6BQInLk8+D2cwC8hLb385hhrDFJW49mc8EskxC4AqHxIwV/xkh
        rnaRmDL/GZQtLPHq+BZ2CFtG4v9OmIZmRomH59ayQzg9jBKXm2ZAdVhL3Dn3iw3kNWYBTYn1
        u/RBTAkBR4n5U3whTD6JG28FIW7gk5i0bTozRJhXoqNNCGKGmsSs4+vgth68cIl5AqPSLCSf
        zULyzSwk38xCWLuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMo5/e/4px2Mc199
        1DvEyMTBeIhRgoNZSYR32xvbRCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8q2aviRcSSE8sSc1O
        TS1ILYLJMnFwSjUwOSwRTo3v9l07jf1ErD+LUI3KuwyDb8fPCKtW1mw84TPzyHGpl9NWsq41
        5klemrXj7ZnE6V8Db5/aobaMXznn1ucHh9LiZrnylK3d9XXbVSFeV7MX73urfy3fvMK6vHvR
        jrCihwqOMz6UPwiJ+m5a/XR9wONI//rvZq35rNs9pGrPrLy2zu343xdH9q3WlVW63Vn9+B+f
        zZWvMbktr3Pm+13U31AVP0F4m3rf5fDcRu7CUCUfj4bymh/K+X3WX9ZyKXsunOBy5r41+41v
        R8tE+NmiT79XdMnbsDdCq09r1sO1UpPWHwhqOn+s/baf7lWdg3fSzyyesnvbubm/j30IPPrF
        3Tun33u3465kZzbnR0osxRmJhlrMRcWJAGTL/82oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7rvbR0SDTY0yljMP3KO1WLmm/9s
        Fju2i1hc3jWHzaJ17xF2i65Df9kc2Dy27d7G6rFz1l12jwWbSj02repk8/i8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY3LDPsaCT4IV
        a1feY25g3MvXxcjJISFgIvFw70FmEFtIYCmjxN8vFhBxGYmT0xpYIWxhiT/Xutggat4zSsw5
        lN3FyMEhLGAvsfKcOUhYREBLYtO1xyxdjFwczAKLGCWmv2xgB3GEBC4xSXQuWssOUsUmYCjR
        9RZiEK+AncSkZw/BFrMIqEosXLoNrEZUIFni7evvTBA1ghInZz5hAbE5BQIlLk8+D2YzC5hJ
        zNsM0cssIC+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07M
        LS7NS9dLzs/dxAiMsm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeLe9sU0U4k1JrKxKLcqPLyrN
        SS0+xGgK9M9EZinR5HxgnOeVxBuaGZgamphZGphamhkrifNunbsmXkggPbEkNTs1tSC1CKaP
        iYNTqoHJuUd/+crFXOItVgbSguverTXw/dum4e9zoM6yu+jG6oknrz/UyzPMfdCb91bC3GO2
        3Ol21bksbD2zJA9oP1jwUjrD5b6qxpWUJ7Pd35a9S62d6vGg51N3OMPDMK+9IWVmn3IumApL
        zfp4NY9hZ0SV0oSOxWvFijf9luGfc5zvMIt2v1kPW9sd79d3xWZ3nzDMfv064nnoEdb9S353
        7HZjONKr+C/h3aGvPJeXOPb8kL93+MSzE3sEpu1tyZu84NDluSyN9/2+HfKvOfqL+8rNexGK
        n9br5sgxf9zME/MoQDpdODl3+ovmfaxlN/uY3xyPN3tTGXz9v1H1vSfPHZvKbSTPyC97XT0h
        on2SbDWfEktxRqKhFnNRcSIAPuSRoTsDAAA=
X-CMS-MailID: 20210914061511eucas1p10de5aebb4af7a87b0cbdfc0cf62df8fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb
References: <CGME20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb@eucas1p1.samsung.com>
        <20210908215806.2748361-1-saravanak@google.com>
        <75889ceb-343b-161f-0280-13df347e6628@samsung.com>
        <CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com>
        <CAGETcx-qDPETtsSPKyW+6i=c=x2LG-tcJ+zCu40jCa9FwA-bEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 14.09.2021 06:44, Saravana Kannan wrote:
> On Mon, Sep 13, 2021 at 5:54 PM Saravana Kannan <saravanak@google.com> wrote:
>> On Thu, Sep 9, 2021 at 1:03 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> On 08.09.2021 23:58, Saravana Kannan wrote:
>>>> This is a test patch. I'll split it up into multiple commits and clean
>>>> it up once it's shown to help.
>>>>
>>>> Marek, can you please test this and let me know if it helps?
>>> I've just checked and nope, it doesn't help for my case. Ethernet is
>>> still not probed on Amlogic G12A/B SoC based boards. :(
>> Hi Marek,
>>
>> Thanks for testing out the patch. Turns out the issue was a lot more
>> complicated than I thought. Thanks to a bunch of debug logs that Rob
>> provided off-list, I was able to root cause the actual issue.
>>
>> Looks like the problem is cyclic dependency between the mdio-multiplexer and the
>> ethernet:
>> ethmac -(phy-handle)-> external_phy -(parent) ->
>> mdio-multiplexer -(mdio-bus-parent)-> mdio0 -(parent)-> ethmac
>>
>> Relevant parts of the DT combined from multiple files and trimmed and
>> pasted below.
>>
>> If fw_devlink sees a cycle, it'll stop enforcing ordering between all
>> the devices in the cycle since it can't figure out which one of the
>> dependencies isn't real. So, the confusing part was that, when Andrew
>> Lunn gave the patch for adding support for "mdio-bus-parent", that
>> should have allowed fw_devlink to see the cycle and stop enforcing the
>> dependencies. But that didn't happen because of a bug in fw_devlink
>> cycle handling (it worked for most cases, but not for this specific
>> ordering in DT). I'll send out a fix for that soon.
> Here's the fix I promised:
> https://lore.kernel.org/lkml/20210914043928.4066136-2-saravanak@google.com/
>
>> That combined with
>> Andrew's "mdio-bus-parent" patch should fix things for you.
> Fairly certain the fix above and Andrew's patch should fix it for you
> if you want to test it. Rob already verified a very similar patch for me.

Right. Those both patches finally fixed the ethernet issue. Feel free to 
add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

