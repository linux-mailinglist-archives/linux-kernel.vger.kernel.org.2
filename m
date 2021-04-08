Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06037358BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhDHSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:16:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:25158 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:16:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210408181555euoutp01ebf4529dc381855139d2091e39071f4d~z9LZyK-T-3080330803euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 18:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210408181555euoutp01ebf4529dc381855139d2091e39071f4d~z9LZyK-T-3080330803euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617905755;
        bh=0uyvun3hXjGOfRclQCyL0vzuaCp8dE6ZPnjosni0owM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=CUZ+/5colCvLRakvBXUESt05s8jUXdinutFToDZPmEBp3Js/BADOh/tC+DSIeqFKe
         jZWrYRghlq/2UBKhtKZA8K5nHHKqSwXnZNYL0B3D3o7CZW/W5rDySI7koOJObD6NHF
         eazYyciHjeMfqcN84ZPryVvSp5vt+Ksg1LHhf5cU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210408181555eucas1p2d4828728c4dd724e0b278ffd29dec9f5~z9LZpebNO0213002130eucas1p29;
        Thu,  8 Apr 2021 18:15:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.85.09452.B584F606; Thu,  8
        Apr 2021 19:15:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210408181554eucas1p25a1785a238c47011c0986c63284dfc92~z9LZG2BiN0213102131eucas1p2y;
        Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210408181554eusmtrp1877280da06aba8f7f73402b7cd719466~z9LZGDcLw2528825288eusmtrp1L;
        Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-55-606f485b67c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.6A.08696.A584F606; Thu,  8
        Apr 2021 19:15:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210408181554eusmtip108693558663ceb8597dd8399ff28df5e~z9LY4sYuK1990619906eusmtip1s;
        Thu,  8 Apr 2021 18:15:54 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 8 Apr 2021 19:15:53 +0100
Date:   Thu, 8 Apr 2021 20:15:53 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408181553.jlqsq664av2vs65u@mpHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408121538.GA12948@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rRHvkJBhO/CFnMuv2axeLum/cs
        FitXH2WymHToGqPF5V1z2CzmL3vK7sDmsWlVJ5vH5iX1HrtvNrB5fN4k59F+oJvJ49XF9ewB
        bFFcNimpOZllqUX6dglcGa+Xf2Iq+MdbcfPbYvYGxlbuLkZODgkBE4l9v/4ydTFycQgJrGCU
        uDzjOzOE84VRYsvyJYwQzmdGiWvHNzHBtKz/MReqZTmjxOFrjaxwVZOuTAerEhLYwigxe20O
        iM0ioCJx5+plVhCbTcBe4tKyW8wgtoiAksTTV2fBVjALbGOUeHLgLTtIQlggVuLH1BNgDbwC
        ThJ3pq9kgrAFJU7OfMICYjMLWEl0fmgCquEAsqUllv/jgAjLSzRvnQ02n1NAR+L8kfvsICUS
        AsoSy6f7QjxQK7H22Bl2kLUSAl84JJaee8oMkXCR2Ns1lxHCFpZ4dXwLO4QtI3F6cg8LREMz
        o8SZNVeYIZweRok/k1YwQmywlug7kwPR4Cix9cw8Nogwn8SNt4IQt/FJTNo2nRkizCvR0SY0
        gVFlFpLHZiF5bBbCY7OQPLaAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYAo6/e/4
        px2Mc1991DvEyMTBeIhRgoNZSYR3R292ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeVbPXxAsJ
        pCeWpGanphakFsFkmTg4pRqYXDe2navU5m/rtOeyjInlcvcpXO4ZHj3PJk/0q97H5+LTu75m
        Llfr5LyZGrze5YRk6YI71pv1VLxb8k8f1uWWYlVbufPEbDfnExtc1d7EZsnf2uiyZRvj75fT
        PfpbxK9vXhCtETahKzX9rYuA4pM5G9Qy+ZXM5iyXf3Hk17VvJz9u6P6qPVM9Tdlf/q1aUdOa
        2HU/Tl6/vZc7LeITS/9a4U9xAnKP9y37N6/5o+nFCTwzJi7f3u1YbHRWPGGa4Zquq3zPVqTd
        vC0tXf9MSiNZ1yg3Youm0bpDJ2VahcrvKNQuY9jtszPTQOllQo+6/MP0iBQHi6cXvneZCGil
        n3nRP2mtsvxCngn7LdsKFUqVWIozEg21mIuKEwHwsgrqsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7pRHvkJBvdX6FnMuv2axeLum/cs
        FitXH2WymHToGqPF5V1z2CzmL3vK7sDmsWlVJ5vH5iX1HrtvNrB5fN4k59F+oJvJ49XF9ewB
        bFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ga+X
        f2Iq+MdbcfPbYvYGxlbuLkZODgkBE4n1P+YydTFycQgJLGWUeNl3lhUiISPx6cpHdghbWOLP
        tS42iKKPjBL7ji5lgXC2MErMuDqRDaSKRUBF4s7Vy2DdbAL2EpeW3WIGsUUElCSevjrLCNLA
        LLCNUeLJgbdgY4UFYiV+TD0B1sAr4CRxZ/pKqDtuMkt0XOqHSghKnJz5hAXEZhawkJg5/zzQ
        JA4gW1pi+T8OiLC8RPPW2WDLOAV0JM4fuc8OUiIhoCyxfLovxAe1Eq/u72acwCgyC8nQWUiG
        zkIYOgvJ0AWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3TbsZ9bdjCufPVR7xAjEwfj
        IUYJDmYlEd4dvdkJQrwpiZVVqUX58UWlOanFhxhNgUE0kVlKNDkfmCTySuINzQxMDU3MLA1M
        Lc2MlcR5TY6siRcSSE8sSc1OTS1ILYLpY+LglGpgMvX389K8dLfmxKJ529YpCVro90pODjcJ
        uxfTbGbLpiP9z0XzYH2U06u7OfmXpjMwWYhd0py+74v4kq0Mp1nD/MIap8tledj8YF3Zuo3X
        ItrJx2Cb7Rq/C7PVpV6cmnTo4ds5S+bqNTu/U//8uWPLQf2jpU72384v2ZlVF/bjy0smlZk/
        txVZPHauer1Ze6/iV5ugoz4+l44ES6YyRgltj5n5cOP3Tx8uV3AJycy4dWwGH9P+3YYrZ7KL
        sy7pf3x2qpbM8cWCn2b6qIi7BG5ksREXenzzf5NE5dv2uT4X7RdulXnA+O/XnhipGQmH5ZZu
        /3eY4dXzCUwucZYvnfnTLtx2F4ie+mV5qtzqVW7LipVYijMSDbWYi4oTAftm+mBaAwAA
X-CMS-MailID: 20210408181554eucas1p25a1785a238c47011c0986c63284dfc92
X-Msg-Generator: CA
X-RootMTR: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
References: <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
        <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
        <20210311104712.GA16218@lst.de>
        <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
        <20210323083749.r272grolxozf3w2f@mpHalley.local>
        <20210323123121.GA31105@lst.de>
        <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
        <20210408103016.5girhv5ctkucovmd@mpHalley.local>
        <20210408121538.GA12948@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.2021 14:15, Christoph Hellwig wrote:
>On Thu, Apr 08, 2021 at 12:30:16PM +0200, Javier González wrote:
>>>> Aligning to MDTS is our current behavior, although all kernels up to
>>>> 5.11 had a bug in the calculation.
>>>
>>> I see. Let me check internally and see what's going on with
>>> write-zeroes on this model.
>>
>> We still need to confirm, but it seems like MDTS for write-zeroes is
>> reported wrong in the FW that Dmitry is using. We can at least reproduce
>> it.
>>
>> Would it be a possibility to add quirk infrastructure to hardcode MDTS
>> for FW versions prior TP4040?
>>
>> Another possibility is to add quirks to the TP4040 support patches to
>> enable this - it might also help reduce the list of models currently
>> blacklisted for write-zeroes.
>
>I'm not sure I understand you.  Before TP4040 there is only the MDTS,
>which only applies to data transfer commands, although we also
>"volunarily" apply it to Write Zeroes.  If MDTS is wrong this would
>also affect normal I/O, so we really either need a firmware update
>or a quirk.  Or is the Write Zeroes limit even smaller than MTDS?

The latter. The Write Zeroes limit is smaller than MDTS.

>I'd rather not add another quirk with a specific limit in that case,
>as well grow way too many of those.

This is what I had in mind - a structure with the quirks that would set
the write zeroes limit for the cases prior to TP4040 and where this is
lower than MDTS. But fair enough; I can see how painful it can be to
maintain this.

>TP4040 is the way to go for that case.

I agree TP4040 is the way to move forward.

Here I have one question: How do you envision adding support for FW
updates that add TP4040 support (or fix MDTS) with regards with existing
quirks.

