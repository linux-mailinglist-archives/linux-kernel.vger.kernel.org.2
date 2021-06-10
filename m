Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC93A218F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFJApZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:45:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50955 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFJApX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:45:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210610004326epoutp043a591272c1d67ef3837d8ac8e0cbb561~HEdc9WSDu2901229012epoutp04l
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:43:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210610004326epoutp043a591272c1d67ef3837d8ac8e0cbb561~HEdc9WSDu2901229012epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623285806;
        bh=iil+4bwuaFvTLS4uLxtnrvWYR0Z++YjdVcRlz2j+Lzo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XPyQMv5CK5cKnklksBRQbmNt1Zo4QZJ8oAx5P44MvXNkb9CH/PPLu6+G2Xvj615AK
         htS4jmqI/pi+DO20/1pZerw5VEgLPdMhIbRS18MzIO8VifQWKCPVRmQTREThp3HXsE
         B8z7Tq8RXm04UFzz7aRJ3ocqjRcCQAHt1CIMb5mY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210610004326epcas1p393d91a4007208feb97d4749e441fffd8~HEdcRroVs1651816518epcas1p3e;
        Thu, 10 Jun 2021 00:43:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G0lZg641Hz4x9Pw; Thu, 10 Jun
        2021 00:43:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.6F.09701.B2061C06; Thu, 10 Jun 2021 09:43:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210610004321epcas1p38f1237c711b31276959135f63f449977~HEdYUKVdV2367623676epcas1p3K;
        Thu, 10 Jun 2021 00:43:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210610004321epsmtrp196ec646175c571474a8ad3c985776ac2~HEdYTUHNk1261612616epsmtrp1V;
        Thu, 10 Jun 2021 00:43:21 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-34-60c1602bc5d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.E5.08163.92061C06; Thu, 10 Jun 2021 09:43:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210610004321epsmtip2fcf317621e1ad7d54f137a9606f32f69~HEdX9nNP00257602576epsmtip2Y;
        Thu, 10 Jun 2021 00:43:21 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 0/5] Add devm helper for work-queue
 initialization
To:     Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5bcb6af7-21d3-b319-36c2-b2a201118df8@samsung.com>
Date:   Thu, 10 Jun 2021 10:02:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2ab1589e-a14b-3058-5582-ac5c304f7e80@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmvq52wsEEg58tXBYbZ6xntXhzfDqT
        xca3P5gsLu+aw2ax9shddovt3x6xWcxZeoLF4nbjCjYHDo9ZDb1sHr+PPmb32DnrLrvH+31X
        2Tz6tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
        ycUnQNctMwfoICWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpe
        cn6ulaGBgZEpUGFCdsb6jhfMBaekKi6ce8PewDhDtIuRk0NCwETib1MPexcjF4eQwA5GiW1N
        P5ggnE+MEke+nYZyPjNK7OndwQ7T8mXtShaIxC5GiSXtr6D63zNKfHzwnw2kSlggSOLZwj2s
        IAkRgR5GiT83/oLNYhZ4zShx78oJRpAqNgEtif0vboB18AsoSlz98RgszitgJ/F7znkmEJtF
        QFXi76bNzCC2qECYxMltLVA1ghInZz5hAbE5geoXLzsJVsMsYCBxZNEcVghbXOLWk/lMELa8
        xPa3c5hBjpAQWMshMX/hIjaIh1wk5jxazARhC0u8Or4F6lEpiZf9bVB2tcTKk0fYIJo7GCW2
        7L/ACpEwlti/dDJUs6LEzt9zGSG28Um8+9oDVMMBFOeV6GgTgihRlrj84C5UuaTE4vZOtgmM
        SrOQ/DMLyQ+zkPwwC8kPCxhZVjGKpRYU56anFhsWGCFH+SZGcIrVMtvBOOntB71DjEwcjIcY
        JTiYlUR4ywz3JQjxpiRWVqUW5ccXleakFh9iNAUG8URmKdHkfGCSzyuJNzQ1MjY2tjAxNDM1
        NFQS5013rk4QEkhPLEnNTk0tSC2C6WPi4JRqYCoxU5ufE75HLaXA86nnxFci6x/ILS5qt98s
        nZ539G9kfN7MQ5t40ksVzq3ump9rpx/1QD/l4E3lvmN7l2/pYFCoEeX7tPHk42Mf7T/Izmw3
        qdl78PePvxHb5Zeq7Pto+lH2hfQy/l+VP89q7djS+dhO6vvH+PMTNUWuB304MGvTCs/Xcy7W
        Bvu/CPglNFWUJ//t7ciqhcJ97zQyZTTfr7VZZ+CjFSL4XuA6V/1M8eoLF8+rvb7kPzPEjcvc
        eY/Q1iUnnz09YaJhL9/ZvW3TX+6pEe1r8vJrO1e92pnCsv/I6ninoKu3mnxOLdOsuXC6TfoG
        d8mn9rMWc3+aVu1UnLuex1R7U1aEWZlQfZz5mltKLMUZiYZazEXFiQA1rpRbOgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXlcz4WCCwbxbGhYbZ6xntXhzfDqT
        xca3P5gsLu+aw2ax9shddovt3x6xWcxZeoLF4nbjCjYHDo9ZDb1sHr+PPmb32DnrLrvH+31X
        2Tz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY33HC+aCU1IVF869YW9gnCHaxcjJISFgIvFl
        7UqWLkYuDiGBHYwSHeefMEMkJCWmXTwKZHMA2cIShw8XQ9S8ZZRY+uoGE0iNsECQxLOFe1hB
        EiICPYwSBydOZQNxmAVeM0rMfPSQEaLlDKPEsQVTWUBa2AS0JPa/uMEGYvMLKEpc/fGYEcTm
        FbCT+D3nPNhYFgFVib+bNoOdISoQJrFzyWMmiBpBiZMzn4DN4QSqX7zsJFgNs4CexI7rv1gh
        bHGJW0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFi
        bnFpXrpecn7uJkZwnGlp7WDcs+qD3iFGJg7GQ4wSHMxKIrxlhvsShHhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCaE3G+NkeGNZF11d+VXlwBdYybFtUm
        5vxvejZ5djsX07xvT5xae05LznHquRMbY/j7hcRrNZn4u4vWnLLg8/0QvNm412yW/Y39V5Xm
        8PFICVo6LbpxSL994zId22aNP7+Pa8xoE71byTX/6INYx5eTd0YlLWgSLXq273rtvbLKb3L5
        yU6P3/3ev9FDw/TBBauHVSLXT2cJbZW47vpDdv6kW2bS+m11L+9t9Ip01XU3mGAwP1/LIJVx
        2zE7tzMvNq7susQtxHRe8FTCs1tZX6qYA/4v4zZe/ctPjeWH4I7zDVUBMakfWFjWfPH+LdhU
        rHkm8VJ5096lp2avPH2jxV1RblbiM6W9aXP5JxZNbTFQYinOSDTUYi4qTgQA0iJdFSIDAAA=
X-CMS-MailID: 20210610004321epcas1p38f1237c711b31276959135f63f449977
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210609152330epcas1p1fdf700b679879bbed8e5db58a9711663
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210609152330epcas1p1fdf700b679879bbed8e5db58a9711663@epcas1p1.samsung.com>
        <2ab1589e-a14b-3058-5582-ac5c304f7e80@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, 

On 6/10/21 12:23 AM, Hans de Goede wrote:
> Hi All,
> 
> On 6/8/21 12:09 PM, Matti Vaittinen wrote:
>> This series adds new devm_work_autocancel() helper.
>>
>> Note:
>> "The beef" of this series is the new devm-helper. This means that
>> normally it would be picked-up by Hans. In this case Hans asked if this
>> series could be taken in extconn tree:
>> https://lore.kernel.org/lkml/fbbfba71-bdcc-b78f-48be-d7c657adce61@redhat.com/
> 
> Yes, and given that most of the changes are in the extcon code I still
> believe this is best.
> 
> Alternatively I can create an immutable branch with these 5 patches on
> top of 5.13-rc1 and then send a pull-req to Chanwoo and MyongJoo.

Right. After creating the immutable branch, please send pull-request to me.
I'll merge them. Thanks.

> 
> Chanwoo and/or MyongJoo can you please let us know how you want to proceed
> with this series?
> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> Many drivers which use work-queues must ensure the work is not queued when
>> driver is detached. Often this is done by ensuring new work is not added and
>> then calling cancel_work_sync() at remove(). In many cases this also requires
>> cleanup at probe error path - which is easy to forget (or get wrong).
>>
>> Also the "by ensuring new work is not added" has a gotcha.
>>
>> It is not strange to see devm managed IRQs scheduling work.
>> Mixing this with manual wq clean-up is hard to do correctly because the
>> devm is likely to free the IRQ only after the remove() is ran. So manual
>> wq cancellation and devm-based IRQ management do not mix well - there is
>> a short(?) time-window after the wq clean-up when IRQs are still not
>> freed and may schedule new work.
>>
>> When both WQs and IRQs are managed by devm things are likely to just
>> work. WQs should be initialized before IRQs (when IRQs need to schedule
>> work) and devm unwinds things in "FILO" order.
>>
>> This series implements wq cancellation on top of devm and replaces
>> the obvious cases where only thing remove call-back in a driver does is
>> cancelling the work. There might be other cases where we could switch
>> more than just work cancellation to use managed version and thus get rid
>> of remove or mixed (manual and devm) resource management.
>>
>> Changelog v2:
>>   - rebased on v5.13-rc2
>>   - split the extcon-max8997 change into two. First a simple,
>>     back-portable fix for omitting IRQ freeing at error path, second
>>     being the devm-simpification which does not need backporting.
>>
>> ---
>>
>> Matti Vaittinen (5):
>>   devm-helpers: Add resource managed version of work init
>>   extcon: extcon-max14577: Fix potential work-queue cancellation race
>>   extcon: extcon-max77693.c: Fix potential work-queue cancellation race
>>   extcon: extcon-max8997: Fix IRQ freeing at error path
>>   extcon: extcon-max8997: Simplify driver using devm
>>
>>  drivers/extcon/extcon-max14577.c | 16 ++++--------
>>  drivers/extcon/extcon-max77693.c | 17 ++++--------
>>  drivers/extcon/extcon-max8997.c  | 45 +++++++++++---------------------
>>  include/linux/devm-helpers.h     | 25 ++++++++++++++++++
>>  4 files changed, 50 insertions(+), 53 deletions(-)
>>
>>
>> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
