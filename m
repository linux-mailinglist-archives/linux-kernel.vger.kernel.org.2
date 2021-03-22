Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8BF343B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:21:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35867 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:20:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210322082044euoutp01366d2c0389014abe2332abe2bb25d3b8~unF4Q8Rfj2638726387euoutp01l
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:20:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210322082044euoutp01366d2c0389014abe2332abe2bb25d3b8~unF4Q8Rfj2638726387euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616401244;
        bh=D6AiqK7yBJFYzMeiP666JuopnIMFMyq5IhY76w5e7bQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=u7j27y4EDq7XEpbhCJ9VB82yd1Cj7nncnCvj+yyINtwLrhC+qwUCMGKzPEKUNPrs3
         mBRpickNUTRE4ex13PlDYbtAL8zBHUJx5/h0T4qz5glTztoNBe/4HWnGE+qo85D1Fi
         5UgxARDmRd3hM6Bx9vf1Mz1iOvSnCycypUJo3zTY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322082043eucas1p1c7e828ba11929b17009ff3bd8a91b5cd~unF367n8x2379023790eucas1p1P;
        Mon, 22 Mar 2021 08:20:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1C.5C.09452.B5358506; Mon, 22
        Mar 2021 08:20:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210322082043eucas1p18a721a72186c82e406267d6203f46e0e~unF3Yq6ae2773627736eucas1p1o;
        Mon, 22 Mar 2021 08:20:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322082043eusmtrp142f9ad8fbff2c3004dc784e6fbe53013~unF3Vrm1K2533925339eusmtrp1g;
        Mon, 22 Mar 2021 08:20:43 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-3b-6058535bc4a4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.EA.08705.A5358506; Mon, 22
        Mar 2021 08:20:43 +0000 (GMT)
Received: from [106.210.131.79] (unknown [106.210.131.79]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210322082042eusmtip2a0575179c0bea17dd04cde8546adad8c~unF2-mlNg0834408344eusmtip2n;
        Mon, 22 Mar 2021 08:20:42 +0000 (GMT)
Message-ID: <ce5a505b-d79c-c8c5-4561-7b8961cfa9d4@samsung.com>
Date:   Mon, 22 Mar 2021 09:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0)
        Gecko/20100101 Thunderbird/87.0
Subject: Re: [PATCH 2/2] driver core: add helper for deferred probe reason
 setting
Content-Language: en-GB
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
In-Reply-To: <20210318073921.13093-2-a.fatoum@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3o4IgEg2m/1CwWftjBZNG8eD2b
        xaqpO1ksLu+aw2Yx98tUZgdWj02rOtk89s9dw+7R/9fA4/MmuQCWKC6blNSczLLUIn27BK6M
        9TsusRfcFKr4urqZsYFxDn8XIyeHhICJxIoXC9m6GLk4hARWMEr0XelmgXC+MEq0Pf7EDuF8
        ZpT4vHEzO0zL5rsXmSESyxklvs9dyQjhvGeUeLf+JgtIFa+AncSZWzOZQGwWAVWJB7/+M0LE
        BSVOznwCViMqkCDxuLsbrEZYIESioXUGWJxZQFyi6ctKVpChIgJtjBKbG1cwQyTMJdpW3QQb
        xCagKfF38002EJtTwFbi3Y9HbBA18hLNW2eDnSchcIRD4nLbYyCHA8hxkXi2WQHiBWGJV8e3
        QL0jI3F6cg8LhF0vcX9FC1RvB6PE1g07mSES1hJ3zv1iA5nDDLR4/S59iLCjxOrrU9ggxvNJ
        3HgrCHECn8SkbdOhtvJKdLQJQVQrStw/uxVqoLjE0gtf2SYwKs1CCpVZSL6fheSZWQh7FzCy
        rGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMMqf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ
        8J5IDkkQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrtq9pp4IYH0xJLU7NTUgtQimCwTB6dUA5P8
        zrkdh7/4bJP+nV2+5KX7/9qT6np7rBcm6R73Dr1YKyTN9MG81shiyeLwH4vfZ+k9Zl5l482j
        GNbX33wqcYNqf0KFYHh78/VD7FnGIvrH45btlpFa9fxw5MGdB6VDFpVI/OI4XBX79ljDuUW7
        haMi1hhaWcs9/Nr5VEFCb/O/bX2JNbyzOf5nn7B//9Yl6/BRhgdcdhziT/jmaPeohX/dFrx9
        7Q2V1oPVez9NWvXx+vIz17+Imdjem5+2QOP59535b8U7XpyKnC9QWfL/SFfV+yNzvjyabXlh
        4sK+M9b7bd5PjN7tNe3mwzVrOHcvypW8dblszUHZmZPE/R2nr8n80ZRV/0XhB+uU647SLJMO
        KbEUZyQaajEXFScCAPrzkgyhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7rRwREJBk2PmCwWftjBZNG8eD2b
        xaqpO1ksLu+aw2Yx98tUZgdWj02rOtk89s9dw+7R/9fA4/MmuQCWKD2bovzSklSFjPziElul
        aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M9TsusRfcFKr4urqZsYFxDn8X
        IyeHhICJxOa7F5m7GLk4hASWMkpsWLuTHSIhLrF7/ltmCFtY4s+1LjaIoreMEptv32ECSfAK
        2EmcuTUTzGYRUJV48Os/I0RcUOLkzCcsILaoQILE0dYtYLawQIhEQ+sMMJsZaEHTl5WsIENF
        BDoYJd4fX8MOkTCXaFt1kxFi22FGiZOHF7GCJNgENCX+br7JBmJzCthKvPvxiA2iwUyia2sX
        I4QtL9G8dTbzBEahWUgOmYVk4SwkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GFnbjv3cvINx3quPeocYmTgYDzFKcDArifCeSA5JEOJNSaysSi3Kjy8qzUktPsRoCgyNicxS
        osn5wNjOK4k3NDMwNTQxszQwtTQzVhLn3Tp3TbyQQHpiSWp2ampBahFMHxMHp1QD0y734qv/
        xC6/7cvZuidY4NQd1kUnCgsuKa7wytJUXb6r4G7mC2tVGQ7m23fYXl4Ib5w26RWrROT17W5e
        dvNXyKne/X5let07qU+7vNgq7adaZ3gdSfe2uHr8tuKSH9/6HtjOcnGzTHgy693pRpMH7xsk
        eHJP3G7acKRXYUlTQGr7jv+RqsYbH8ocbw7QjAjdK353YqutiErL9HWRwh/6W7eKzWE/5l6b
        WnG7YN5Fxrwr9ZHLt3y58XDth8tVB/t6pU6/Mxd108q5Pyelt6xSaerOLjkDp5RJN5N1l+xS
        iX4ldfpezfu6M60nNAOWzGNLv3bV0na1RJT5rDi7CV8OZWl7Bc1+EOdtZLzq+U3PFCWW4oxE
        Qy3mouJEAC7Nb0c1AwAA
X-CMS-MailID: 20210322082043eucas1p18a721a72186c82e406267d6203f46e0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210318073959eucas1p195d40385903d059d0fcf17785c76a587
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210318073959eucas1p195d40385903d059d0fcf17785c76a587
References: <20210318073921.13093-1-a.fatoum@pengutronix.de>
        <CGME20210318073959eucas1p195d40385903d059d0fcf17785c76a587@eucas1p1.samsung.com>
        <20210318073921.13093-2-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W dniu 18.03.2021 o 08:39, Ahmad Fatoum pisze:
> We now have three places within the same file doing the same operation
> of freeing this pointer and setting it anew. A helper make this
> arguably easier to read, so add one.
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards

Andrzej

> ---
>   drivers/base/dd.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e2cf3b29123e..4201baa1cc13 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -69,6 +69,12 @@ static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
>    */
>   static bool defer_all_probes;
>   
> +static void __device_set_deferred_probe_reason(const struct device *dev, char *reason)
> +{
> +	kfree(dev->p->deferred_probe_reason);
> +	dev->p->deferred_probe_reason = reason;
> +}
> +
>   /*
>    * deferred_probe_work_func() - Retry probing devices in the active list.
>    */
> @@ -97,8 +103,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>   
>   		get_device(dev);
>   
> -		kfree(dev->p->deferred_probe_reason);
> -		dev->p->deferred_probe_reason = NULL;
> +		__device_set_deferred_probe_reason(dev, NULL);
>   
>   		/*
>   		 * Drop the mutex while probing each device; the probe path may
> @@ -140,8 +145,7 @@ void driver_deferred_probe_del(struct device *dev)
>   	if (!list_empty(&dev->p->deferred_probe)) {
>   		dev_dbg(dev, "Removed from deferred list\n");
>   		list_del_init(&dev->p->deferred_probe);
> -		kfree(dev->p->deferred_probe_reason);
> -		dev->p->deferred_probe_reason = NULL;
> +		__device_set_deferred_probe_reason(dev, NULL);
>   	}
>   	mutex_unlock(&deferred_probe_mutex);
>   }
> @@ -220,11 +224,12 @@ void device_unblock_probing(void)
>   void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
>   {
>   	const char *drv = dev_driver_string(dev);
> +	char *reason;
>   
>   	mutex_lock(&deferred_probe_mutex);
>   
> -	kfree(dev->p->deferred_probe_reason);
> -	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +	reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +	__device_set_deferred_probe_reason(dev, reason);
>   
>   	mutex_unlock(&deferred_probe_mutex);
>   }
