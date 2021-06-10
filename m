Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5493A2839
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFJJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:26:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42519 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFJJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:26:30 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210610092433epoutp01d3e7c57e19e0fab95b0e6386b27eff94~HLkb3CKt70756707567epoutp01M
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:24:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210610092433epoutp01d3e7c57e19e0fab95b0e6386b27eff94~HLkb3CKt70756707567epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623317073;
        bh=XhpqEP4lzej/4JATTPIl7haf73Ar9bT8dZGKPIg9ZEI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GmATH796mUl3PMZJ8OH4bPfAr5dRz2I17NRwKE6o77HXoNV0zd56H9Ura3FYghxAs
         6AMQ+VVyicB1l+soX7ltIFZqku27vl506K7V8vviSL/xZJHHl0dbEDJdSNk594XCKf
         n56G7QFmTFciVE1ZddLsutwyrUmUTK2Mzjo1RNCM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210610092432epcas1p240f6788afd83635761ed95f980f1b561~HLkbah8nT2716427164epcas1p2a;
        Thu, 10 Jun 2021 09:24:32 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4G0z7y0d41z4x9Pw; Thu, 10 Jun
        2021 09:24:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.86.09701.D4AD1C06; Thu, 10 Jun 2021 18:24:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210610092429epcas1p1704a3e074129c1dc171e3286f36b29b4~HLkYvB-wN0670606706epcas1p1i;
        Thu, 10 Jun 2021 09:24:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210610092429epsmtrp26fd1d22fe12ed509fe5939fe01a189ae~HLkYuUOIC1340113401epsmtrp2g;
        Thu, 10 Jun 2021 09:24:29 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-b9-60c1da4db27b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.EA.08637.D4AD1C06; Thu, 10 Jun 2021 18:24:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210610092429epsmtip12a5ac40b011164e4ff31c25a53657dde~HLkYa3caZ2021120211epsmtip1_;
        Thu, 10 Jun 2021 09:24:29 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7f39c731-b644-0122-d68f-7da7e78b4252@samsung.com>
Date:   Thu, 10 Jun 2021 18:43:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmnq7vrYMJBp0/bSw2zljPavHm+HQm
        i41vfzBZXN41h81i7ZG77Bbbvz1is5iz9ASLxe3GFWwOHB6zGnrZPH4ffczusXPWXXaP9/uu
        snn0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqt
        kotPgK5bZg7QQUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS9
        5PxcK0MDAyNToMKE7IwrrUsZC3aLViw9N4G5gfGQYBcjJ4eEgInEnXtn2LsYuTiEBHYwSpza
        uQLK+cQo0df5lwXC+cYosWnKMmaYlv0LPoLZQgJ7GSUan4ZCFL1nlHixuJUdJCEskCXx7sFG
        JhBbRCBV4umkqcwgRcwCE5gkOj6dBStiE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7i1qtdLCA2
        i4CqxOZ3r1hBbFGBMImT21qgagQlTs58AlbDKZAh0fvnOFgNs4CBxJFFc6BscYlbT+YzQdjy
        EtvfzgE7QkJgJYfE7yXH2SHecZH48WwD1GvCEq+Ob4GKS0l8freXDcKullh58ggbRHMHo8SW
        /RdYIRLGEvuXTmaCsBUldv6eywixjU/i3dceoBoOoDivREebEESJssTlB3ehyiUlFrd3sk1g
        VJqF5J9ZSH6YheSHWUh+WMDIsopRLLWgODc9tdiwwAg5wjcxgtOrltkOxklvP+gdYmTiYDzE
        KMHBrCTCW2a4L0GINyWxsiq1KD++qDQntfgQoykwiCcyS4km5wMTfF5JvKGpkbGxsYWJoZmp
        oaGSOG+6c3WCkEB6YklqdmpqQWoRTB8TB6dUA5OfxCM7KavFOqF+vJempV6337n+qYTN6g9/
        rdzeltXF8rNfDc+00/4oHLJx+3TjB3Xno2UFmUqSBerOprsKfavm5Fwav2fav/CddlJbRA65
        WzBL7vDViJVKE1+aKjbxkedkwa3a+u7f1XudLs9byr1o5bwFvVly905ZLHkappX8/8UbX8mP
        kdGTVmQ/+nAt/8iPSuPyE79ZZWeuuM4e0FvkLsR5+MMO5VmsZ2Yd7yr4NEH36d5/6m+v3p92
        9fnP7LSHR4pS/1kr5skceqzwS93wq2q+j8ok74PiG2zL26d/3i4840QLP7ukYcRmmb4pgWdU
        FsSxLlUrXlD//lafvjPX2YaTej23svvuyLrMUlViKc5INNRiLipOBACCBJ3hOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTtf31sEEg9+v5Sw2zljPavHm+HQm
        i41vfzBZXN41h81i7ZG77Bbbvz1is5iz9ASLxe3GFWwOHB6zGnrZPH4ffczusXPWXXaP9/uu
        snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxpXWpYwFu0Urlp6bwNzAeEiwi5GTQ0LARGL/
        go/MXYxcHEICuxklzs45wAKRkJSYdvEoUIIDyBaWOHy4GKLmLaPE/Ydr2UFqhAWyJN492MgE
        UiMikCqx6GUuSA2zwCQmiY7Z21khGr4xSsx4sQNsKJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2
        Erde7QKrYRFQldj87hUriC0qECaxc8ljJogaQYmTM5+A1XAKZEj0/jkOVsMsoCex4/ovKFtc
        4taT+UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHGNamjsYt6/6oHeIkYmD8RCjBAezkghvmeG+BCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYVCYy7Lm+tMLC+1trpNdC/j9ptckeEWy5
        HSGleqH6NdV9RrcNLJfn/txy3Ev7zxSmxsB1a4/bLj5xR7d8mcbDDh+Zuf5bAi+92jvp4VYD
        FVnLgh7r91fvnp2o3PTTUsy754/j15X33i1jz1y8Mb6rgp+z6O8NeYH1KV+rpuX61+YruvJp
        PsgP+z7rwJaQ/+FX4gosA8+WWKX+955Z1nS86da56hPhF+9Gbt3StPsv44xJHY3mGsd1upck
        pnNkzIh4dGX1RdOmkOXm9zpmHWNqFz71+q7d+/0iX/89vufid6YvQfl6sU1sfmbRrqe+2WfW
        5Ly9+M6JW2L+u3NVcvntB3w+R+zJVvBfqDLlyqJPSizFGYmGWsxFxYkAsEgO1iADAAA=
X-CMS-MailID: 20210610092429epcas1p1704a3e074129c1dc171e3286f36b29b4
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101022epcas1p1c1623dfb74f412153706d3986b373a03
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101022epcas1p1c1623dfb74f412153706d3986b373a03@epcas1p1.samsung.com>
        <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 7:10 PM, Matti Vaittinen wrote:
> The extcon IRQ schedules a work item. IRQ is requested using devm while
> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
> potential case where the WQ has been emptied (.remove() was ran) but
> devm unwinding of IRQ was not yet done. It may be possible the IRQ is
> triggered at this point scheduling new work item to the already flushed
> queue.
> 
> According to the input documentation the input device allocated by
> devm_input_allocate_device() does not need to be explicitly unregistered.
> Use the new devm_work_autocancel() and remove the remove() to simplify the
> code.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max77693.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index 92af97e00828..1f1d9ab0c5c7 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -5,6 +5,7 @@
>  // Copyright (C) 2012 Samsung Electrnoics
>  // Chanwoo Choi <cw00.choi@samsung.com>
>  
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  	mutex_init(&info->mutex);
>  
> -	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> +				   max77693_muic_irq_work);
> +	if (ret)
> +		return ret;
>  
>  	/* Support irq domain for MAX77693 MUIC device */
>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
> @@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int max77693_muic_remove(struct platform_device *pdev)
> -{
> -	struct max77693_muic_info *info = platform_get_drvdata(pdev);
> -
> -	cancel_work_sync(&info->irq_work);
> -	input_unregister_device(info->dock);

I think that you have to keep the input_unregister_device().

> -
> -	return 0;
> -}
> -
>  static struct platform_driver max77693_muic_driver = {
>  	.driver		= {
>  		.name	= DEV_NAME,
>  	},
>  	.probe		= max77693_muic_probe,
> -	.remove		= max77693_muic_remove,
>  };
>  
>  module_platform_driver(max77693_muic_driver);
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
