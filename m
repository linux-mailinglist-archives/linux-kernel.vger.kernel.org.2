Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B73760EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhEGHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:08:04 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:48936 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhEGHID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:08:03 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d51 with ME
        id 1j6x2500721Fzsu03j6xMG; Fri, 07 May 2021 09:07:02 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 May 2021 09:07:02 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] usb: fotg210-hcd: Fix an error message
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org, vulab@iscas.ac.cn,
        john453@faraday-tech.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
 <1620354030.10796.6.camel@mhfsdcap03>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <75002e1a-bca7-8726-de2e-56905f255693@wanadoo.fr>
Date:   Fri, 7 May 2021 09:06:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620354030.10796.6.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/05/2021 à 04:20, Chunfeng Yun a écrit :
> On Thu, 2021-05-06 at 22:39 +0200, Christophe JAILLET wrote:
>> 'retval' is known to be -ENODEV here.
>> This is a hard-coded default error code which is not useful in the error
>> message. Moreover, another error message is printed at the end of the
>> error handling path. The corresponding error code (-ENOMEM) is more
>> informative.
>>
>> So remove simplify the first error message.
>>
>> While at it, also remove the useless initialization of 'retval'.
>>
>> Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/usb/host/fotg210-hcd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
>> index 6cac642520fc..9c2eda0918e1 100644
>> --- a/drivers/usb/host/fotg210-hcd.c
>> +++ b/drivers/usb/host/fotg210-hcd.c
>> @@ -5568,7 +5568,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
>>   	struct usb_hcd *hcd;
>>   	struct resource *res;
>>   	int irq;
>> -	int retval = -ENODEV;
>> +	int retval;
>>   	struct fotg210_hcd *fotg210;
>>   
>>   	if (usb_disabled())
>> @@ -5588,7 +5588,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
>>   	hcd = usb_create_hcd(&fotg210_fotg210_hc_driver, dev,
>>   			dev_name(dev));
>>   	if (!hcd) {
>> -		dev_err(dev, "failed to create hcd with err %d\n", retval);
>> +		dev_err(dev, "failed to create hcd\n");
>>   		retval = -ENOMEM;
> How about moving this line before dev_err()? then could keep error log
> unchanged.
> 

Mostly a matter of taste.
I don't think it add any useful information (this is not something 
coming from a call chain or that can have different values, it is just a 
hard-coded constant) and the line after we will already have:
	dev_err(dev, "init %s fail, %d\n", dev_name(dev), retval);
where retval = -ENOMEM

So the -ENOMEM error code is already reported.

Moreover, having error code reported or not is already not consistent in 
the function. For example "failed to enable PCLK\n" where 'retval' could 
be reported as well.



BTW, is it useful to have 'dev_name(dev)' in a dev_err?

CJ

>>   		goto fail_create_hcd;
>>   	}
> 

