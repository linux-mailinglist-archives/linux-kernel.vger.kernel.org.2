Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF113A2835
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFJJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:24:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11410 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFJJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:24:23 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210610092225epoutp02ae14299ec75dc2cd9004cccafd400165~HLilMwpyb1753717537epoutp02w
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210610092225epoutp02ae14299ec75dc2cd9004cccafd400165~HLilMwpyb1753717537epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623316945;
        bh=xXooL45n33EyaEMwLnoPedEM/SJsxiSfMdAfatMlYZY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WL8YdQIYx7JAL6k7K4pUoZCc+NjxYlccsxLnKm+yx3KJc4Zj9u5zmazTlrFzV3XmN
         F5hxfW8IBh9Dl5oK6WUZ1xWeqaOUH7LEZ0IY4qledJ1vrwPAv/0Hz1PCJJBSolPB9K
         r1rblWphWGc9pLpgaAh/KCz0vfRIKKrttuhCQXBs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210610092224epcas1p1f17ec6c8ccfb05afcc2c64cf529c0600~HLij1RcXW1262112621epcas1p1z;
        Thu, 10 Jun 2021 09:22:24 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G0z5T3Xmvz4x9Q1; Thu, 10 Jun
        2021 09:22:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.2E.09736.DC9D1C06; Thu, 10 Jun 2021 18:22:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210610092220epcas1p47b3b3c56ef3388cf3718613628a4e18d~HLigmQt5k2932229322epcas1p4V;
        Thu, 10 Jun 2021 09:22:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210610092220epsmtrp2ccb5762bd590779e229eae635e488d0d~HLiglkR4o1235412354epsmtrp2A;
        Thu, 10 Jun 2021 09:22:20 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-01-60c1d9cdcb70
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.7A.08637.CC9D1C06; Thu, 10 Jun 2021 18:22:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210610092220epsmtip10ca80d33a2cfa327df6065c3d4b76d5c~HLigXiLdD1825018250epsmtip1k;
        Thu, 10 Jun 2021 09:22:20 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 2/5] extcon: extcon-max14577: Fix potential
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
Message-ID: <e9e46963-29ed-0358-1f2c-926c3a40686e@samsung.com>
Date:   Thu, 10 Jun 2021 18:41:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ee8545f59ae3a93f0a70f640ecbd7e31cfadbcb9.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmge7ZmwcTDF59lLTYOGM9q8Wb49OZ
        LDa+/cFkcXnXHDaLtUfuslts//aIzWLO0hMsFrcbV7A5cHjMauhl8/h99DG7x85Zd9k93u+7
        yubRt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2
        Si4+AbpumTlABykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1
        kvNzrQwNDIxMgQoTsjNe/HzAUvBZpGJKxzKmBsbpgl2MnBwSAiYSp25vYupi5OIQEtjBKHHy
        6gtWCOcTo8SUJxeZIZxvjBIPp/cww7Qc+nSfDSKxl1HiwuWljBDOe0aJS1emMIFUCQtkSEx+
        +w+sQ0QgVeLppKlgo5gFJjBJdHw6yw6SYBPQktj/4gYbiM0voChx9cdjRhCbV8BO4sHnZywg
        NouAqsTsCU1gtqhAmMTJbS1QNYISJ2c+AYtzAi2btPoc2DJmAQOJI4vmsELY4hK3nsxngrDl
        Jba/nQN2hITASg6JT7MuskL84yLx8vk9RghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dzBK
        bNl/AarZWGL/0slMELaixM7fcxkhtvFJvPvaA1TDARTnlehoE4IoUZa4/OAuVLmkxOL2TrYJ
        jEqzkPwzC8kPs5D8MAvJDwsYWVYxiqUWFOempxYbFpgix/gmRnCC1bLcwTj97Qe9Q4xMHIyH
        GCU4mJVEeMsM9yUI8aYkVlalFuXHF5XmpBYfYjQFBvFEZinR5Hxgis8riTc0NTI2NrYwMTQz
        NTRUEudNd65OEBJITyxJzU5NLUgtgulj4uCUamAy4nz+hl1Btr9d+ZKy6ILligbnArMeB4lv
        Dus3/JTlHSi4KZhVzO1y3ive2lMRb/LSmvY8Vw7IOz5ZtZSnJ2qe4+pAxX6lO5ef63zM4/x7
        e+q1SVP3/FfVOfXAs1V/7+MvJ9dOfTHhcKSWWlrDCdeFVywPc52euHDh0RqG1s7k07FqVyIP
        CO36Zrcra1ei3SuZOgkHCaOYT3dXW3gYr38TcKNps6j23IOb/02y2jThrL56daSzypHjYQUN
        XhMlDb6uabr5WVtq6YY5vhJHMhRyds896F0327Cr14M/8ea0a2LnK0L6X3Z0HhFdULWFb3K1
        393CttK3/iWnl7WFbNZf3j730at6m/5i579dZ+YrsRRnJBpqMRcVJwIAVmv5mDkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTvfMzYMJBt1vFC02zljPavHm+HQm
        i41vfzBZXN41h81i7ZG77Bbbvz1is5iz9ASLxe3GFWwOHB6zGnrZPH4ffczusXPWXXaP9/uu
        snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxoufD1gKPotUTOlYxtTAOF2wi5GTQ0LAROLQ
        p/tsXYxcHEICuxklXtxrZYZISEpMu3gUyOYAsoUlDh8uhqh5yyjxb+kuFpAaYYEMiclv/4HV
        iAikSix6mQtSwywwiUmiY/Z2VoiGb4wSm473s4M0sAloSex/cYMNxOYXUJS4+uMxI4jNK2An
        8eDzM7ChLAKqErMnNIHZogJhEjuXPGaCqBGUODnzCVicE2jxpNXnwA5lFtCT2HH9FyuELS5x
        68l8JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7N
        S9dLzs/dxAiOMS3NHYzbV33QO8TIxMF4iFGCg1lJhLfMcF+CEG9KYmVValF+fFFpTmrxIUZp
        DhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxbV+rZfeaXSI/xO3RZ4otLI0t12oXZnHYd
        vGz2s8UCtaJjtPRPbXyrpZG9d/3yELaT2ntu2E/o1vkRfuffhrXC+hdi9ApOtpTM4Npyff22
        puzkeXeanj7XinjM2cZzV+5JIP+seXdDhayZXLYm7PbT39+26e/bG4byJ9jrHMVD1fY31JZ6
        TjI+N1NjTaPAsmeiBwV/XZpjqLj69Du/fTPvbWNyWs67IHWJzqIwIcYvy5+kWV1IbNqfJ/3W
        /qyf7ay3KzkF1Gwvqf2s/hC1geNRy7Us23CpGoci5XKDfcr565PqAuKc2PZ6PzlavPn2rzVs
        D0oS+6IFnBiXCe2YmTh1s0L5Ltl3E3/NXB/dW6PEUpyRaKjFXFScCAAeT2ENIAMAAA==
X-CMS-MailID: 20210610092220epcas1p47b3b3c56ef3388cf3718613628a4e18d
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101006epcas1p3955e119400f64e4f7f30ea17c8b957c0
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101006epcas1p3955e119400f64e4f7f30ea17c8b957c0@epcas1p3.samsung.com>
        <ee8545f59ae3a93f0a70f640ecbd7e31cfadbcb9.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 7:09 PM, Matti Vaittinen wrote:
> The extcon IRQ schedules a work item. IRQ is requested using devm while
> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
> potential case where the WQ has been emptied (.remove() was ran) but
> devm unwinding of IRQ was not yet done. It is possible the IRQ is triggered
> at this point scheduling new work item to the already flushed queue.
> 
> Use new devm_work_autocancel() to remove the remove() and to kill the bug.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max14577.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index ace523924e58..5476f48ed74b 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -6,6 +6,7 @@
>  // Chanwoo Choi <cw00.choi@samsung.com>
>  // Krzysztof Kozlowski <krzk@kernel.org>
>  
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -673,7 +674,10 @@ static int max14577_muic_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  	mutex_init(&info->mutex);
>  
> -	INIT_WORK(&info->irq_work, max14577_muic_irq_work);
> +	ret = devm_work_autocancel(&pdev->dev, &info->irq_work,
> +				   max14577_muic_irq_work);
> +	if (ret)
> +		return ret;
>  
>  	switch (max14577->dev_type) {
>  	case MAXIM_DEVICE_TYPE_MAX77836:
> @@ -766,15 +770,6 @@ static int max14577_muic_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int max14577_muic_remove(struct platform_device *pdev)
> -{
> -	struct max14577_muic_info *info = platform_get_drvdata(pdev);
> -
> -	cancel_work_sync(&info->irq_work);
> -
> -	return 0;
> -}
> -
>  static const struct platform_device_id max14577_muic_id[] = {
>  	{ "max14577-muic", MAXIM_DEVICE_TYPE_MAX14577, },
>  	{ "max77836-muic", MAXIM_DEVICE_TYPE_MAX77836, },
> @@ -797,7 +792,6 @@ static struct platform_driver max14577_muic_driver = {
>  		.of_match_table = of_max14577_muic_dt_match,
>  	},
>  	.probe		= max14577_muic_probe,
> -	.remove		= max14577_muic_remove,
>  	.id_table	= max14577_muic_id,
>  };
>  
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
