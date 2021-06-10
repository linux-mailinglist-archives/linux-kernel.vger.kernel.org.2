Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98C3A2851
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:36:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22272 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:36:31 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210610093434epoutp02812de31ec7426b660e241f09e6398634~HLtLuKj7D2701827018epoutp02i
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210610093434epoutp02812de31ec7426b660e241f09e6398634~HLtLuKj7D2701827018epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623317674;
        bh=tka+wauzcwrxN6frgRaLl2DI37frHB5OBI/dmYS0S7w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W8ZD4SSRV7I1MDThsNfrxw+/I8GXuhVamYnqH0Jcofc+1MotvGpbqYSEcCn31LKG0
         oc10J85PxSBUpzUo8RWWu81RDA+bS3hvwOhBWb/GE7yoETLr6KG6Ffq6l3LteWA5bD
         tJo+7aEOzRYBitRN45dwjWL3kzsIhDGoWZnjasvk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210610093433epcas1p4d2333a2fd28e81435e0dc6d26a04741b~HLtLZrqt72237822378epcas1p4x;
        Thu, 10 Jun 2021 09:34:33 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G0zMV66SPz4x9Pv; Thu, 10 Jun
        2021 09:34:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.26.10258.6ACD1C06; Thu, 10 Jun 2021 18:34:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210610093430epcas1p10555aa78d768a5d20d10d6e1d9f84c29~HLtIH3Lau0538205382epcas1p1M;
        Thu, 10 Jun 2021 09:34:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210610093430epsmtrp17e90aced3f027f0768204fa8423d9d54~HLtIHJ18S0176301763epsmtrp1h;
        Thu, 10 Jun 2021 09:34:30 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-59-60c1dca62d6d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.DC.08637.6ACD1C06; Thu, 10 Jun 2021 18:34:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210610093430epsmtip2e08d80518fc33e325709d96a658b41c5~HLtH42RX60486304863epsmtip2N;
        Thu, 10 Jun 2021 09:34:30 +0000 (GMT)
Subject: Re: [PATCH RESEND v2 4/5] extcon: extcon-max8997: Fix IRQ freeing
 at error path
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
Message-ID: <769ba891-288b-be62-c80a-d382b9d6bf0c@samsung.com>
Date:   Thu, 10 Jun 2021 18:53:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <27ee4a48ee775c3f8c9d90459c18b6f2b15edc76.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmge6yOwcTDP4eMrDYOGM9q8Wb49OZ
        LDa+/cFkcXnXHDaLtUfuslts//aIzWLO0hMsFrcbV7A5cHjMauhl8/h99DG7x85Zd9k93u+7
        yubRt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2
        Si4+AbpumTlABykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1
        kvNzrQwNDIxMgQoTsjP+vG1lLmjgqlh76TlbA+Nkji5GTg4JAROJTfMXM3UxcnEICexglFg/
        9QEjhPOJUWLDnA3sEM43RomTO1aywrTsuDOJDSKxl1Hiwrq1LBDOe0aJaz2r2UGqhAWiJPZ3
        NTKC2CICqRJPJ01lBiliFpjAJNHx6SxYEZuAlsT+FzfYQGx+AUWJqz8egzXwCthJ9HRsBVvH
        IqAq8fvvXjBbVCBM4uS2FqgaQYmTM5+wgNicAhkSl1+fAathFjCQOLJoDpQtLnHryXwmCFte
        YvvbOWBHSAis5JA4c3EbE8Q/LhKPfq2HsoUlXh3fwg5hS0m87G+DsqslVp48wgbR3MEosWX/
        BWhgGEvsXzoZqllRYufvuYwQ2/gk3n3tAarhAIrzSnS0CUGUKEtcfnAXqlxSYnF7J9sERqVZ
        SP6ZheSHWUh+mIXkhwWMLKsYxVILinPTU4sNC0yQY3wTIzjBalnsYJz79oPeIUYmDsZDjBIc
        zEoivGWG+xKEeFMSK6tSi/Lji0pzUosPMZoCg3gis5Rocj4wxeeVxBuaGhkbG1uYGJqZGhoq
        ifOmO1cnCAmkJ5akZqemFqQWwfQxcXBKNTBFzBPv83/P9Trqo/WFp4vLcq3meVj67/+cIvVu
        58HTa+t+tro67qu8Zf5SZK25yx3GLY9nmuk+bPoyNXXvJo1L7S8vbvE3k/5uY8dRpyqz4saP
        LNnZKSaZzvt+PCzS9VUu3bnzTEP9EcHy82f+vJ3Z47nlwY6fR1Yp818M/7/bMHJLVs32IFch
        zsKoXVkrnh23jlp0LOhf6+PKeTtzF4a5S67Y8ZU9ZOGFuy5yRrPdq25aSRw71mC+f4O20W8H
        ph+WMs+LasuEJVMCxRh/1k1gLrK4eX3GBy1Dne62fyuv8M55xZPkNOn/F+6Z7Us/TzC8d6bT
        7+W/v/OeN/UEZEuXfJ8+ec0hrgXMti907u+arsRSnJFoqMVcVJwIAKlbI/45BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXnfZnYMJBjdf8VlsnLGe1eLN8elM
        Fhvf/mCyuLxrDpvF2iN32S22f3vEZjFn6QkWi9uNK9gcODxmNfSyefw++pjdY+esu+we7/dd
        ZfPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujD9vW5kLGrgq1l56ztbAOJmji5GTQ0LARGLH
        nUlsXYxcHEICuxklvr2axAiRkJSYdvEocxcjB5AtLHH4cDFEzVtGie+PjzCB1AgLREn8vzCV
        BaRGRCBVYtHLXJAaZoFJTBIds7ezQjR8Y5S4+G8ZK0gDm4CWxP4XN9hAbH4BRYmrPx6DLeMV
        sJPo6dgKVsMioCrx++9eMFtUIExi55LHTBA1ghInZz5hAbE5BTIkLr8+A1bDLKAnseP6Lyhb
        XOLWk/lMELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhb
        XJqXrpecn7uJERxjWpo7GLev+qB3iJGJg/EQowQHs5IIb5nhvgQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamC5I5RWrtFQFPnXQK5Xdodim/pXdYMV6
        3+W5Luu+fmqZtX2vzQrLywsYumz5Jh+4maEQEKRlfabPY/l7iU/iZtNNwnXivhr3+67Wtlno
        Wtaf67xsm9/BSW82TvrRcI2h00p+h+2lCnWW80flp3ekT7M51nTo5sJursrezvbmZPaD2l6O
        UgrLFy7b9lsuIu5nhjMXlz+XRfWLsN8vV7Y3tt+IdfnX9T6+UXQje8ueyykZ81ImOrx0NvI4
        Vc0X06dm9ZH3aqlOfu6OHSXeqpvKBe23ljXERZ2rNw68cd3kUdP+kIXSvGHTLgpN33Zv6eNM
        hgij6afD1kYmzQ24nsJcoHW4+4J18d4syQihyVpKLMUZiYZazEXFiQCkN+6fIAMAAA==
X-CMS-MailID: 20210610093430epcas1p10555aa78d768a5d20d10d6e1d9f84c29
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210608101044epcas1p1da70e58b0ffdcc1657744195f1654849
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
        <CGME20210608101044epcas1p1da70e58b0ffdcc1657744195f1654849@epcas1p1.samsung.com>
        <27ee4a48ee775c3f8c9d90459c18b6f2b15edc76.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 7:10 PM, Matti Vaittinen wrote:
> If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
> without freeing the requested IRQs.
> 
> Free the IRQs prior returning if reading the status fails.
> 
> Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive probe")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changelog:
>  v2:
>    - new patch (avoid backporting devm_wq just to fix IRQ freeing)
> ---
>  drivers/extcon/extcon-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index e1408075ef7d..c15a612067af 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -733,7 +733,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  				2, info->status);
>  	if (ret) {
>  		dev_err(info->dev, "failed to read MUIC register\n");
> -		return ret;
> +		goto err_irq;
>  	}
>  	cable_type = max8997_muic_get_cable_type(info,
>  					   MAX8997_CABLE_GROUP_ADC, &attached);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
