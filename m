Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC60343B89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCVISl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:18:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33735 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCVISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:18:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210322081810euoutp01ba95a6a47959402b0bcca3213004d0e6~unDo5Sk562139621396euoutp01S
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:18:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210322081810euoutp01ba95a6a47959402b0bcca3213004d0e6~unDo5Sk562139621396euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616401090;
        bh=WWLnRveoSexcMr1G8FOvWmuA8rg9YanbigGdPc/WPy4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=CEWYqXDWk7iSuohATj7LvZ7zk72KQIxPY0iARSXR9Fr51J4oS/TTtNrCfX/BmmBqS
         77Dbsk/Zr8U5TreMPBdCIx3Z/dCdBAP0ritPPWcZlgg90rKzyhyXHM822sqyM9K/a1
         nxmrxXvfRXz6cJliMF/z27dqOkIAkkgdfUs4m3wg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322081809eucas1p119c2380faf8cfc0acc5d2fd7fe264fa9~unDopfU3j2851828518eucas1p1Q;
        Mon, 22 Mar 2021 08:18:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.CE.09439.1C258506; Mon, 22
        Mar 2021 08:18:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210322081809eucas1p2fb22c71a8f5f00cbe6882980b424c64d~unDoSjZUP2264722647eucas1p2q;
        Mon, 22 Mar 2021 08:18:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210322081809eusmtrp281280425d010e2de545d97ad1026e071~unDoRyzHv2784327843eusmtrp2Q;
        Mon, 22 Mar 2021 08:18:09 +0000 (GMT)
X-AuditID: cbfec7f5-c03ff700000024df-53-605852c1f4fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.6A.08705.1C258506; Mon, 22
        Mar 2021 08:18:09 +0000 (GMT)
Received: from [106.210.131.79] (unknown [106.210.131.79]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210322081808eusmtip2908ac486b8e55d9916502a952420942e~unDnsTto_0554705547eusmtip2X;
        Mon, 22 Mar 2021 08:18:08 +0000 (GMT)
Message-ID: <c75441c4-1d77-f7c9-df51-38ad1fd72252@samsung.com>
Date:   Mon, 22 Mar 2021 09:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0)
        Gecko/20100101 Thunderbird/87.0
Subject: Re: [PATCH v2 1/2] driver core: clear deferred probe reason on
 probe retry
Content-Language: en-GB
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, andy.shevchenko@gmail.com,
        stable@kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
In-Reply-To: <20210319110459.19966-1-a.fatoum@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7oHgyISDKbeM7BY+GEHk8XLCYcZ
        LaY+fMJm0bx4PZvFwmnLGS1WTd3JYnF51xw2i7lfpjJbfDp/gc2B02PnrLvsHptWdbJ57J+7
        ht2j/6+Bx/t9V9k8Pm+SC2CL4rJJSc3JLEst0rdL4Mp4O3MtW8FunorJm28zNjD+4+xi5OSQ
        EDCROD5hMVsXIxeHkMAKRok3K9czQzhfGCUmXpwD5XxmlLg9cyk7TEtz02p2iMRyRon3b98y
        gSSEBN4zSpzc6t7FyMHBK2AnMa03FiTMIqAqseroZTYQm1dAUOLkzCcsILaoQILE4+5usFZh
        gVCJGRu/MYPYzALiEk1fVrKCzBcRuMUoMWnTdyaIRLrE9NnrWEFsNgFNib+bb4IN5RSwlWg6
        CLGAWUBeonnrbGaIQ79wSKw5zAhhu0h8fDUHKi4s8er4FqhnZCT+75zPBGHXS9xf0QL2sYRA
        B6PE1g07oRqsJe6c+8UG8hgz0OL1u/Qhwo4S6x+tYgYJSwjwSdx4KwhxAp/EpG3TocK8Eh1t
        QhDVihL3z26FGigusfTCV7YJjEqzkEJlFpLvZyF5ZhbC3gWMLKsYxVNLi3PTU4uN81LL9YoT
        c4tL89L1kvNzNzECk9Ppf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrwnkkMShHhTEiurUovy44tK
        c1KLDzFKc7AoifPu2romXkggPbEkNTs1tSC1CCbLxMEp1cBk1LH9qN6LaaXr05JTX1753dr8
        xMHj/LW2/XdCu5eESTcfm1pw1f3F8eq5x87Wu51tyy1xcFzRp1Slf/ydUcWLnTI/pzecLmVT
        3PGiOOunZH65okFs3QSfdYJd3h9FF7c3xZuyvDzU4prEHcvlttlE81JXgb3ls1z+0Igjb9od
        WXpv3UqbW6CzZy3P72U3Utbt/a6z7VPBrqNMMbzT33WEhCdGd/7Wis+qq3B8X9H5W70rzUnP
        psldhfXaar7VaQ/3VEXlstvKs75ZtSFGou4N96x1S0rfvHxWF9H2MWWq2lXbjY9K9p64kJhh
        U3hWhcctL8R+5iX2yHfZDvtCxG1uF5z4kjTrYx6Di6yGkRJLcUaioRZzUXEiABNVNC69AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7oHgyISDLr6RS0WftjBZPFywmFG
        i6kPn7BZNC9ez2axcNpyRotVU3eyWFzeNYfNYu6XqcwWn85fYHPg9Ng56y67x6ZVnWwe++eu
        Yffo/2vg8X7fVTaPz5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DLezlzLVrCbp2Ly5tuMDYz/OLsYOTkkBEwkmptWs3cxcnEICSxllOjd
        sY4ZIiEusXv+WyhbWOLPtS42iKK3jBKHji4E6uDg4BWwk5jWGwtSwyKgKrHq6GU2EJtXQFDi
        5MwnLCC2qECCxNHWLWC2sECoRPu8KawgNjPQ/KYvK1lBZooI3GGUuDvxKTNEIl1i0ateRohl
        Exglvq96BjaVTUBT4u/mm2A2p4CtRNNBiG3MAmYSXVu7GCFseYnmrbOZJzAKzUJyyCwkC2ch
        aZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwJjcduzn5h2M81591DvEyMTBeIhR
        goNZSYT3RHJIghBvSmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OByaFvJJ4QzMDU0MTM0sDU0sz
        YyVx3q1z18QLCaQnlqRmp6YWpBbB9DFxcEo1MO2ZvmHFiq3Xp8U/5/G94FZgrXx0YYPsTqsK
        5T8vnTQ+L2IxCv61NjFINGhi6q3sFem3bAXNt752WmBXySCzUKjVz2a1ov3ltVwOS9f9VzDZ
        dYBNoTjrotehUCvRhYvNltl3qq81n5I3t2ua75kcxzQz99wNPPsXrmJQmFY5TeD8GRXTi2wH
        FHREPlTYPeLw7vnlv655rn745Sf7l5xbcOa4yid2cafG7UJ3ylfsLlzzV75LWijJp1RY9jPf
        Hk+Nq8W3v3GXxcdOP+t05VMCu9idfZeTJn3d8Nq3yOFArkJ1F/v+2vxFK2c32Vz5skyhu2zt
        5J+515rlryYEXC9Ufhls8nlf0r/7O29OP9W554cSS3FGoqEWc1FxIgDEHkpdUgMAAA==
X-CMS-MailID: 20210322081809eucas1p2fb22c71a8f5f00cbe6882980b424c64d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210319110516eucas1p1d4e5152af8a1873f192f4edba8cfbb8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210319110516eucas1p1d4e5152af8a1873f192f4edba8cfbb8f
References: <CGME20210319110516eucas1p1d4e5152af8a1873f192f4edba8cfbb8f@eucas1p1.samsung.com>
        <20210319110459.19966-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

W dniu 19.03.2021 o 12:04, Ahmad Fatoum pisze:
> When retrying a deferred probe, any old defer reason string should be
> discarded. Otherwise, if the probe is deferred again at a different spot,
> but without setting a message, the now incorrect probe reason will remain.
>
> This was observed with the i.MX I2C driver, which ultimately failed
> to probe due to lack of the GPIO driver. The probe defer for GPIO
> doesn't record a message, but a previous probe defer to clock_get did.
> This had the effect that /sys/kernel/debug/devices_deferred listed
> a misleading probe deferral reason.
>
> Cc: stable@kernel.org
> Fixes: d090b70ede02 ("driver core: add deferring probe reason to devices_deferred property")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Regards

Andrzej


> ---
> v1 -> v2:
>   - reworded commit message (Andy)
>   - collected Andy's Reviewed-by
> ---
>   drivers/base/dd.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..e2cf3b29123e 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -97,6 +97,9 @@ static void deferred_probe_work_func(struct work_struct *work)
>   
>   		get_device(dev);
>   
> +		kfree(dev->p->deferred_probe_reason);
> +		dev->p->deferred_probe_reason = NULL;
> +
>   		/*
>   		 * Drop the mutex while probing each device; the probe path may
>   		 * manipulate the deferred list
