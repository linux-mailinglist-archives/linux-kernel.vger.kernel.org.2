Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B573AFD04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhFVGZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:25:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53061 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:25:36 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210622062319epoutp04657ff5335fe58b20e4c8beed68b73719~K01ol40_F0812608126epoutp04j
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210622062319epoutp04657ff5335fe58b20e4c8beed68b73719~K01ol40_F0812608126epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624342999;
        bh=B5z09/jpAcw3Z5ncRM22BSwJpQkB+5ESwenPC5uXYOI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=po0YOfJCQvSShvuuaxxcYeuxMRQKi3G52MFA3qz4ac7FJhZ+96NKTnrICpTgMwQWR
         WNQHmcRCyZXAD9SqiIvo0izEM8NfhiKB0wP8ySUiHebUm2/DSFp9XNxqMJLoRqihyG
         KNaU9e5rKeDz+KqwDi+jov0btf5Gj0L4QYw/vIOo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210622062319epcas1p240b4418ba34ee11aa8c439729c30f5a5~K01oDVxmF0403304033epcas1p2L;
        Tue, 22 Jun 2021 06:23:19 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G8GYG74JJz4x9Q6; Tue, 22 Jun
        2021 06:23:14 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.8C.09468.EC181D06; Tue, 22 Jun 2021 15:23:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210622062309epcas1p37ac8ec81df7fbbf4f3e3e95a614a85bc~K01fRiRUf2085420854epcas1p3w;
        Tue, 22 Jun 2021 06:23:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210622062309epsmtrp27d9a4feb7b59da5af263f4fc4cbcef0e~K01fQyMrN1699516995epsmtrp2T;
        Tue, 22 Jun 2021 06:23:09 +0000 (GMT)
X-AuditID: b6c32a37-66505a80000024fc-9e-60d181cea55d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.C1.08394.DC181D06; Tue, 22 Jun 2021 15:23:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210622062309epsmtip1b8e42aec48c2e2f1e90d25979cd36569~K01fBXEDF0264802648epsmtip1R;
        Tue, 22 Jun 2021 06:23:09 +0000 (GMT)
Subject: Re: [PATCH 1/2] clocksource/drivers/exynos_mct: Prioritise Arm arch
 timer on arm64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4084b547-0bd2-4309-0948-384b81f1026f@samsung.com>
Date:   Tue, 22 Jun 2021 15:42:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1f4d7943-c540-bafd-b372-0d0ed8172f33@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmvu65xosJBsd3i1rM+yxrcf78BnaL
        jW9/MFlsenyN1eLyrjlsFmuP3GW32LxpKrNFyx1TBw6PWQ29bB6bVnWyedy5tofN4925c+we
        m5fUe/RtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtBJSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8
        dL3k/FwrQwMDI1OgwoTsjHufFzIXHOSu+N4Z18A4gbOLkZNDQsBE4teTBYxdjFwcQgI7GCWe
        TdzECuF8YpToPnOPGcL5xihx8sQidpiWe6u+QlXtZZTY+aiVBcJ5zyix8uIsoAwHh7BArMT1
        pcogDSIC/hKz2w6yg9QwC/xnlPj4+jPYJDYBLYn9L26wgdj8AooSV388ZgSxeQXsJOZcusQM
        YrMIqEp8PPAWrF5UIEzi5LYWqBpBiZMzn7CA2JxA9dNuXACbwywgLnHryXwmCFteYvvbOWAv
        SAis5ZBY+GoxI8QLLhJ/Jv1mgrCFJV4d3wL1mpTE53d72SDsaomVJ4+wQTR3MEps2X+BFSJh
        LLF/6WQmkC+ZBTQl1u/ShwgrSuz8PZcRYjGfxLuvPeCAkBDglehoE4IoUZa4/OAu1FpJicXt
        nWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC4yRY3sTIzi5apnvYJz29oPeIUYm
        DsZDjBIczEoivC+yLyYI8aYkVlalFuXHF5XmpBYfYjQFBvBEZinR5Hxges8riTc0NTI2NrYw
        MTQzNTRUEufdyXYoQUggPbEkNTs1tSC1CKaPiYNTqoGJy+pK4Z2NuV9zD/1vc1qW0aW6/UmH
        iPHalaz/viXveJUc27yx17Y9SXLixWiBfbbq66/O9RFdPu3OhQPpgbpsU14l9yRN2/aT64nv
        XJVlh1uM5y7JnNNQNC3N8+NzZ1GVrEuFM3zWMFmVLDXyOfnax+vSXqXnSa9/xccePTmzevat
        u48/Z6Y7iT3ykZ8v9vgO39q9ARkzgv18H3E18Gn0ZjzvCshgW8w80/QC02t15f9uew1U3sv+
        ZXq1I3KxSw7/qglXZff90Vx4xurKglecN2pf9KVpr+GfaLV+x2Uhs/xC0R0vRRg5vK1jKhOl
        m044Bxc7XL/F09o+leXIgreuq0Nis3TLVtpUe346dN1ciaU4I9FQi7moOBEAC6FdHTcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTvds48UEg54jqhbzPstanD+/gd1i
        49sfTBabHl9jtbi8aw6bxdojd9ktNm+aymzRcsfUgcNjVkMvm8emVZ1sHneu7WHzeHfuHLvH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJVx7/NC5oKD3BXfO+MaGCdwdjFyckgImEjc
        W/WVtYuRi0NIYDejxOHvt9kgEpIS0y4eZe5i5ACyhSUOHy4GCQsJvGWU2D3fGSQsLBArcX2p
        MkhYRMBX4v+Da+wgY5gFGpkkni+cwA4x8xeLxJqlE5hBqtgEtCT2v7gBNp9fQFHi6o/HjCA2
        r4CdxJxLl8BqWARUJT4eeMsOYosKhEnsXPKYCaJGUOLkzCcsIDYnUP20GxfA5jALqEv8mQfR
        yywgLnHryXwmCFteYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcr
        TswtLs1L10vOz93ECI4xLc0djNtXfdA7xMjEwXiIUYKDWUmE90X2xQQh3pTEyqrUovz4otKc
        1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamJh7vj3Q8nl0eKPttG3Pp36ou7h6
        isrUjXMXpu1PDW52Cpyr+89Juq7N9qrhlTkqbmdDZA2Fev//W/yq0LPitVxCjvH5bP/dS66x
        sdsLcOalzPrftyFC4Ym+110F3tyb7qfrOOruHGCv4GHrPWPG/DjCeuWDv+f7zQy+fWTYumvL
        udtC+W88MtfGFb0uapEM+fqruFrq55VT0VrHWou9bQtzKvYbb1xRlLe++puF79/SiyLtDX6e
        V5YZx5+99+xuvky0Ucm9hPszMy35t+3XW7JmseLrleZvXrZqr/TkP+h7qubw81Vy8Y94nK98
        udx8wKB+VcmtK3OKsgXXVl14wPeVS7v1mRjHi8dnmTTEhJVYijMSDbWYi4oTAXRXaykgAwAA
X-CMS-MailID: 20210622062309epcas1p37ac8ec81df7fbbf4f3e3e95a614a85bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d
References: <20210608154341.10794-1-will@kernel.org>
        <CGME20210608154400epcas1p1b22fd50629611a9475cb4d2b8dd9442d@epcas1p1.samsung.com>
        <20210608154341.10794-2-will@kernel.org>
        <466bfc19-2260-87c6-c458-b43cf23617e3@samsung.com>
        <2a0181ea-a26e-65e9-16f6-cc233b6b296f@linaro.org>
        <fbcd234d-3ea0-d609-1f1d-b557ea329c37@samsung.com>
        <20210617214748.GC25403@willie-the-truck>
        <d79ebd58-1c4e-834c-fc06-482f25f6f3de@linaro.org>
        <20210621101058.GB28788@willie-the-truck>
        <3ba202d9-a679-834a-685f-12c6f9eb9c38@linaro.org>
        <d3e55130-ccfc-4bbc-3c82-91db4ce5113f@samsung.com>
        <1f4d7943-c540-bafd-b372-0d0ed8172f33@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/21 2:21 PM, Daniel Lezcano wrote:
> On 22/06/2021 04:40, Chanwoo Choi wrote:
>> On 6/21/21 7:18 PM, Daniel Lezcano wrote:
>>> On 21/06/2021 12:10, Will Deacon wrote:
>>>
>>> [ ... ]
>>>
>>>>>> exynos4_mct_frc_start() is called unconditionally from probe via
>>>>>> exynos4_clocksource_init() so as long as the mct probes first, then the
>>>>>> arch timer should work, no? The rating shouldn't affect that.
>>>>>
>>>>> How do you ensure the exynos mct is probed before the arch timer ?
>>>>>
>>>>> The Makefile provides the right order, but the dependency is implicit.
>>>>
>>>> Currently, I think it's done by the order of the CPU hotplug notifiers (
>>>> see the hunk of 6282edb72bed which touches cpuhotplug.h).
>>>
>>> Ah, right. Indeed whatever the DT order, the cpuhotplug order solves the
>>> dependency.
>>>
>>> Chanwoo, are fine with this change ?
>>
>> OK about the order.
>>
>> Actually, I have not fully tested the arch timer on Exynos5433 64bit
>> because of the dependency between arch timer and MCT as we knew.
>>
>> If the Krzysztof and Marek have no any objection,
>> I have no any objection anymore. Thanks.
>>
> 
> Shall I consider it as an Acked-by ?
> 

Unfortunately, it is not acked. Just no objection.
I'm not sure that all cases will be working when using arch timer
because as I said, I have only used the exynos mct timer for all of cases.



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
