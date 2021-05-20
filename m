Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B562E389B96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhETDGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:06:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55400 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhETDGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:06:42 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210520030520epoutp02d019f6b0c23ce0f2202fcf3a61fef43e~Ap2V5FkWs1414114141epoutp02Y
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:05:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210520030520epoutp02d019f6b0c23ce0f2202fcf3a61fef43e~Ap2V5FkWs1414114141epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621479920;
        bh=jb3KJfS/X8dXGdV81EXzwNDOtuSOAbEpzKHE65nBnGk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pSXTlDSzsDwK3xRZb9PL8uj1PNWR4l8ODKzW3fxw/1CfWUMZyi7vDCJJtC3/6dh6M
         uYSNban8HNFaMTXmYB740Zj3114d1qeG2nMvqpd6Dyi1K/diQcy6fSBQSpIteR6A1m
         rnauCchbYB/MFkBJU835l1UMtZeoXPAi0s/X5rUY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210520030519epcas1p23b8981c5eb9e1c226e9de8c498643ae3~Ap2VnOIsq0394503945epcas1p2_;
        Thu, 20 May 2021 03:05:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Flvk54vlwz4x9Q3; Thu, 20 May
        2021 03:05:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.3F.09736.DE1D5A06; Thu, 20 May 2021 12:05:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210520030517epcas1p3586043c0cdd598fec40b72bf607105f7~Ap2TXAz7b3039530395epcas1p3U;
        Thu, 20 May 2021 03:05:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210520030517epsmtrp2bc7abc110557bb3fdb47ca1248c4e967~Ap2TWWOk30430504305epsmtrp2r;
        Thu, 20 May 2021 03:05:17 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-7e-60a5d1ed86dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.49.08637.DE1D5A06; Thu, 20 May 2021 12:05:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210520030517epsmtip2b0627b31b8485c1f5994fcac482612ef~Ap2TNa-Q50888008880epsmtip2o;
        Thu, 20 May 2021 03:05:17 +0000 (GMT)
Subject: Re: [PATCH] extcon: max8997: Add missing modalias string
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <681ff9c4-e4d2-0c5e-9eec-e83d0b7b8494@samsung.com>
Date:   Thu, 20 May 2021 12:23:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210423204624.10398-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmru7bi0sTDI79UbO4vGsOm8XaI3fZ
        LW43rmBzYPbo27KK0ePzJrkApqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3Ml
        hbzE3FRbJRefAF23zBygHUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE
        3OLSvHS95PxcK0MDAyNToMKE7IyWI5NYC+6yVzydc4a1gfE4WxcjJ4eEgInExDOtTF2MXBxC
        AjsYJfbMWMoEkhAS+MQo8fp+DkTiG6PE74aZrF2MHGAdB8/wQNTsZZRYPd0aouY9o8SxN5dY
        QRLCAo4SR+bvZgGpFxHwl7j0uxAkzCygLXHqzkRmEJtNQEti/4sbYEfwCyhKXP3xmBHE5hWw
        kzjUfoUZpJVFQFXiycYSkLCoQJjEyW0tUCWCEidnPmEBsTmByme1dzJBjBeXuPVkPpQtL7H9
        7RxmkNMkBO6xS7ROv8MO8bCLxNHF6xghbGGJV8e3QMWlJD6/2wsNlGqJlSePsEE0dzBKbNl/
        gRUiYSyxf+lkJpDjmAU0Jdbv0ocIK0rs/D2XEWIxn8S7rz3QoOKV6GgTgihRlrj84C4ThC0p
        sbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgSlyTG9iBKc9LcsdjNPfftA7
        xMjEwXiIUYKDWUmEd7v34gQh3pTEyqrUovz4otKc1OJDjKbA8J3ILCWanA9MvHkl8YamRsbG
        xhYmhmamhoZK4rzpztUJQgLpiSWp2ampBalFMH1MHJxSDUw7n10OrHrn3Rd/s+pLm8PRW92F
        +9PEFD9GHJp/8uJ85s8//PxVFm2r/+J55ohT0n6TiPLZ31VvFvCv27Wq+eU/lmvvjZ7+DjeP
        /TnnwyvmCIXTk19Ofay3YBLruSOf7qn/nMIm/dplw8eUDpHprrfmBb3Kyzr058NGveXdYjPO
        bV2whFN07rRay1O/nLbeue13mn+t5Dy3nhtH5j5eevlEQNw3xsglRWkRVaJ/PjEVqfZquzJx
        pZxWnxnGtUzmpNXMdftP5HTOmc8gOvHEj94jkY9rXIIeH6pquPkqvGiO1CETazVd/4n5abUv
        dJLii/8VvTwXdTTv362nbpZ387/0OGTfW7tYp0L0ZpzGZxu550osxRmJhlrMRcWJAAc1ijIE
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO7bi0sTDPZ0ilhc3jWHzWLtkbvs
        FrcbV7A5MHv0bVnF6PF5k1wAUxSXTUpqTmZZapG+XQJXRsuRSawFd9krns45w9rAeJyti5GD
        Q0LAROLgGZ4uRi4OIYHdjBIf7s8EinMCxSUlpl08ygxRIyxx+HAxRM1bRoknX1YygdQICzhK
        HJm/mwXEFhHwlejtmcAIYjMLaEucujORGaJhIqPEzj/rwRrYBLQk9r+4AbaAX0BR4uqPx2AN
        vAJ2Eofar4AtYxFQlXiysQQkLCoQJrFzyWMmiBJBiZMzn4Dt4gQqn9XeyQSxS13iz7xLzBC2
        uMStJ/Oh4vIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5x
        aV66XnJ+7iZGcBRoae5g3L7qg94hRiYOxkOMEhzMSiK8270XJwjxpiRWVqUW5ccXleakFh9i
        lOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAlJZ7I/TClKznQhO3/JhoM7nWgOfqYtHe
        d0vTVO785/nox9s4w0qnonX1F6OThzpuMnj1sXT9mqAyc/pC0SVHpz46m1+xoeRTxyPGju1q
        CcetTvAH/F1/tyklTd9FL/+ZitED9+oTYjfF5KW6r/2caMjCWc1zZ+3slID+2k2vXU++6S2u
        35DFbD216+ztvK3Xi5ZIT9ki2jThXb7xgbaFSQdmh3n/9egyP5ay4LJ+yGFO4wy5ZqP83P6f
        1YqT8u/PDupiXHK+2sn5iPj0oiTBp+dzmVedORjVebI0TX5JTfvFY89f9cevO2V4nFd8zVyP
        M4wGRgpuAswqH4TDW+qMklaVX3vFFP1Wy/Mv4zJDJZbijERDLeai4kQAcLgMq/ECAAA=
X-CMS-MailID: 20210520030517epcas1p3586043c0cdd598fec40b72bf607105f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f
References: <CGME20210423204633eucas1p2f5178b2cb85dc63e780b81deebf0700f@eucas1p2.samsung.com>
        <20210423204624.10398-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/21 5:46 AM, Marek Szyprowski wrote:
> The platform device driver name is "max8997-muic", so advertise it
> properly in the modalias string. This fixes automated module loading when
> this driver is compiled as a module.
> 
> Fixes: b76668ba8a77 ("Extcon: add MAX8997 extcon driver")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index e1408075ef7d..633597a6081a 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -788,3 +788,4 @@ module_platform_driver(max8997_muic_driver);
>  MODULE_DESCRIPTION("Maxim MAX8997 Extcon driver");
>  MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:max8997-muic");
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
