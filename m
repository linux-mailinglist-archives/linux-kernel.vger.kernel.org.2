Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81763A2881
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhFJJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:40:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27763 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:40:44 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210610093846epoutp038e87d745b154366e455ad0c2573d48da~HLw2XzVFt1332813328epoutp03i
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:38:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210610093846epoutp038e87d745b154366e455ad0c2573d48da~HLw2XzVFt1332813328epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623317926;
        bh=PTI4PtnZOuipvVd7cbT2wMvXlmDRHUPNouVGViN78Qs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QSAYu7xnNBpONmfDnMlMn4AeW5wU7jg8RvJtweLHfqqfSRzTqHCFSka7RIKdLjIdt
         eTikXshyM61JmeJZh7jkZ1UOHP1p5hbPdUMn98etVi7nfuSn3GEr3G8qRiGlQIDpkM
         Lj40v9Kzkc2tw8CpK7eBEfKXFmXtoO+C2/8lrYE8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210610093845epcas1p13e17520609d5bbecd12a600a2e5512ad~HLw2Fpxss0828108281epcas1p1p;
        Thu, 10 Jun 2021 09:38:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G0zSM0tKrz4x9Q4; Thu, 10 Jun
        2021 09:38:43 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.F6.10258.2ADD1C06; Thu, 10 Jun 2021 18:38:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210610093842epcas1p4e258b5a4a96657b8fae89e43dad8b8f2~HLwy_FsQz1590215902epcas1p4z;
        Thu, 10 Jun 2021 09:38:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210610093842epsmtrp1ad3091e2990bfe3d9e9556b258e2fccc~HLwy85Aj_0361803618epsmtrp1O;
        Thu, 10 Jun 2021 09:38:42 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-22-60c1dda28a88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.C8.08163.2ADD1C06; Thu, 10 Jun 2021 18:38:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210610093842epsmtip21bb2eeb6578711b2adc4604fb57b8bae~HLwypjf580764707647epsmtip2J;
        Thu, 10 Jun 2021 09:38:42 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 5/5] extcon: extcon-max8997: Simplify driver
 using devm
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
Message-ID: <41f6604b-c3b9-4f67-ee30-e1303dd46c95@samsung.com>
Date:   Thu, 10 Jun 2021 18:57:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <61190cc280a63baeb05ec570282bb3677bee8e7b.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmru7iuwcTDBbfZ7LYOGM9q8Wb49OB
        rLc/mCwu75rDZrH2yF12i+3fHrFZzFl6gsXiduMKNgcOj1kNvWwev48+ZvfYOesuu8f7fVfZ
        PPq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+ggJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2xufnfxgL/slXPLi4lq2BcZpkFyMnh4SAicTpb9cYuxi5OIQEdjBKvHj8
        ix0kISTwiVFiwW8ViMRnRok/1+8zwXR03jzFApHYxSix/2YTM0THe0aJ/5utQWxhgXCJ27+X
        MILYIgKpEk8nTWUGaWAWmMAk0fHpLNgKNgEtif0vbrCB2PwCihJXfzwGa+AVsJP42b4TbCiL
        gKrE4i07wTaLCoRJnNzWAlUjKHFy5hMWEJtTIENiwXOIOLOAgcSRRXNYIWxxiVtP5jNB2PIS
        29/OATtCQmAth8TDFTsYId5xkTh0rJsNwhaWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9
        F1ghEsYS+5dOhoaLosTO33OhruCTePe1B6iGAyjOK9HRJgRRoixx+cFdqHJJicXtnWwTGJVm
        IflnFpIfZiH5YRaSHxYwsqxiFEstKM5NTy02LDBBju9NjODkqmWxg3Hu2w96hxiZOBgPMUpw
        MCuJ8JYZ7ksQ4k1JrKxKLcqPLyrNSS0+xGgKDOKJzFKiyfnA9J5XEm9oamRsbGxhYmhmamio
        JM6b7lydICSQnliSmp2aWpBaBNPHxMEp1cDkyhEx/0r1tS/pW7kCbmged/YSOb5EPsDzzBWH
        GVbS04UbF02qWlra/KhKZdNV95blixlKVa4+/rvy4CuTQ6IiavXrPM73Xd64aP3BWe+0Tlma
        9aam/Z3CLh3/s0WiyLGST2F9u3UHu1li0LO4F+o/zsuufThbYvm8vOJ1e++JbwnrzFwt+fLE
        kkuCYQryJpf5sxOC76XdZPuf1qu3Y7sl/zSvhMB534p97E4lyrbsWvpsd2dy0gynTf9q5mcf
        6ORmPxI++8Lxjadstv7948M6icH/82+mI4e9135dc19V5m6j+IFNW49/ErPndvGJ/dxeuqy2
        OeH4ppTUKf88F4uwTJz+seD2rNXJPhbHD2n+U2Ipzkg01GIuKk4EAOIOR7I3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXnfR3YMJBquOCVpsnLGe1eLN8elM
        Fhvf/mCyuLxrDpvF2iN32S22f3vEZjFn6QkWi9uNK9gcODxmNfSyefw++pjdY+esu+we7/dd
        ZfPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujM/P/zAW/JOveHBxLVsD4zTJLkZODgkBE4nO
        m6dYuhi5OIQEdjBKnJ55nA0iISkx7eJR5i5GDiBbWOLw4WKImreMEu+XHgCrERYIl7j9ewkj
        SI2IQKrEope5IDXMApOYJDpmb2eFaPjGKNG/7iZYA5uAlsT+FzfAbH4BRYmrPx4zgti8AnYS
        P9t3MoPYLAKqEou37GQCsUUFwiR2LnnMBFEjKHFy5hMWEJtTIENiwfMWsF5mAT2JHdd/sULY
        4hK3nsxngrDlJba/ncM8gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjOAY09Lawbhn1Qe9Q4xMHIyHGCU4mJVEeMsM9yUI8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwFSasjXI4vBXhkAt1z6WRQ5zzlodDD63
        QdZmYfU5gXupnksZY2SNo56HVR27Zb7zvKRAy0HuOP3YjQXxvK6d5vv6groCQq4bGofe/LMq
        famwynOGwKPrHhfqesdEZe1+xCD6uHmtotLGZ6v79Zp7n5zW/7qubvX5CPmn4l1nPy+vPsk1
        i7dw7gohs8sKdnkrUxznTGbvSLz3te76nx0uvwMa3kypLUmoe6grXM25ojs5fZbwHT3+ybND
        9uV+n7e0YvbVOUVHPeqkl2z588Hnc+X6IlWe/R2XHy3Y0qz4rWx947P4k2GHH810tp03w1Fs
        vWf4l7+KGXsun5ujUZg7P3jXocICnT2Hw3QntR0NEFFiKc5INNRiLipOBADfO2GhIAMAAA==
X-CMS-MailID: 20210610093842epcas1p4e258b5a4a96657b8fae89e43dad8b8f2
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101106epcas1p38b461f84c4b77f775b249c9f8011ca01
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101106epcas1p38b461f84c4b77f775b249c9f8011ca01@epcas1p3.samsung.com>
        <61190cc280a63baeb05ec570282bb3677bee8e7b.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 7:10 PM, Matti Vaittinen wrote:
> Simplify driver by switching to use the resource managed IRQ
> requesting and resource managed work-queue initialization.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changelog:
>  v2:
>   - IRQ freeing fix splitted in own patch
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max8997.c | 47 +++++++++++----------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index c15a612067af..bbc592823570 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -5,6 +5,7 @@
>  //  Copyright (C) 2012 Samsung Electronics
>  //  Donggeun Kim <dg77.kim@samsung.com>
>  
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -650,27 +651,30 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  	mutex_init(&info->mutex);
>  
>  	INIT_WORK(&info->irq_work, max8997_muic_irq_work);
> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> +				   max8997_muic_irq_work);
> +	if (ret)
> +		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
>  		struct max8997_muic_irq *muic_irq = &muic_irqs[i];
>  		unsigned int virq = 0;
>  
>  		virq = irq_create_mapping(max8997->irq_domain, muic_irq->irq);
> -		if (!virq) {
> -			ret = -EINVAL;
> -			goto err_irq;
> -		}
> +		if (!virq)
> +			return -EINVAL;
> +
>  		muic_irq->virq = virq;
>  
> -		ret = request_threaded_irq(virq, NULL,
> -				max8997_muic_irq_handler,
> -				IRQF_NO_SUSPEND,
> -				muic_irq->name, info);
> +		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> +						max8997_muic_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						muic_irq->name, info);
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"failed: irq request (IRQ: %d, error :%d)\n",
>  				muic_irq->irq, ret);
> -			goto err_irq;
> +			return ret;
>  		}
>  	}
>  
> @@ -678,14 +682,13 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  	info->edev = devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
>  	if (IS_ERR(info->edev)) {
>  		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
> -		ret = PTR_ERR(info->edev);
> -		goto err_irq;
> +		return PTR_ERR(info->edev);
>  	}
>  
>  	ret = devm_extcon_dev_register(&pdev->dev, info->edev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register extcon device\n");
> -		goto err_irq;
> +		return ret;
>  	}
>  
>  	if (pdata && pdata->muic_pdata) {
> @@ -733,7 +736,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  				2, info->status);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read MUIC register\n");
> -		goto err_irq;
> +		return ret;
>  	}
>  	cable_type = max8997_muic_get_cable_type(info,
>  					   MAX8997_CABLE_GROUP_ADC, &attached);
> @@ -756,23 +759,6 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  			delay_jiffies);
>  
>  	return 0;
> -
> -err_irq:
> -	while (--i >= 0)
> -		free_irq(muic_irqs[i].virq, info);
> -	return ret;
> -}
> -
> -static int max8997_muic_remove(struct platform_device *pdev)
> -{
> -	struct max8997_muic_info *info = platform_get_drvdata(pdev);
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++)
> -		free_irq(muic_irqs[i].virq, info);
> -	cancel_work_sync(&info->irq_work);
> -
> -	return 0;
>  }
>  
>  static struct platform_driver max8997_muic_driver = {
> @@ -780,7 +766,6 @@ static struct platform_driver max8997_muic_driver = {
>  		.name	= DEV_NAME,
>  	},
>  	.probe		= max8997_muic_probe,
> -	.remove		= max8997_muic_remove,
>  };
>  
>  module_platform_driver(max8997_muic_driver);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
