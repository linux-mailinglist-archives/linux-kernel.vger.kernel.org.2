Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5653FBAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhH3RU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:20:56 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53873 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhH3RUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:20:55 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d19 with ME
        id ntKx2500P3riaq203tKypR; Mon, 30 Aug 2021 19:19:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Aug 2021 19:19:59 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH v1 3/4] char: xillybus: Remove usage of remaining
 deprecated pci_ API
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
 <19d67ac0208a609aef1e28278b3f2477aa714029.1630083668.git.christophe.jaillet@wanadoo.fr>
 <20210830094810.GC12231@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ab15e5e9-f296-5e71-1fb2-f66ac9ea2c8b@wanadoo.fr>
Date:   Mon, 30 Aug 2021 19:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210830094810.GC12231@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/08/2021 à 11:48, Dan Carpenter a écrit :
> On Fri, Aug 27, 2021 at 07:17:47PM +0200, Christophe JAILLET wrote:
>> diff --git a/drivers/char/xillybus/xillybus.h b/drivers/char/xillybus/xillybus.h
>> index 7c71bdef7ccb..55d47cb13a7b 100644
>> --- a/drivers/char/xillybus/xillybus.h
>> +++ b/drivers/char/xillybus/xillybus.h
>> @@ -87,7 +87,6 @@ struct xilly_channel {
>>   };
>>   
>>   struct xilly_endpoint {
>> -	struct pci_dev *pdev;
>>   	struct device *dev;
>>   	struct xilly_endpoint_hardware *ephw;
>>   
>> diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
>> index 931d0bf4cec6..0ced9ec6977f 100644
>> --- a/drivers/char/xillybus/xillybus_core.c
>> +++ b/drivers/char/xillybus/xillybus_core.c
>> @@ -1783,7 +1783,7 @@ struct xilly_endpoint *xillybus_init_endpoint(struct pci_dev *pdev,
>>   	if (!endpoint)
>>   		return NULL;
>>   
>> -	endpoint->pdev = pdev;
>> +	(void)pdev;	// silence a compiler warning, will be removed
> 
> Just out of curiousity which compiler warning is this?  I don't think
> GCC will complain.  I think there are other compilers which complain but
> I don't know which.
> 
>>   	endpoint->dev = dev;
>>   	endpoint->ephw = ephw;
>>   	endpoint->msg_counter = 0x0b;
> 
> regards,
> dan carpenter
> 
> 

Well, I first did something like:
 > -	endpoint->pdev = pdev;
 > +	pdev;

in order to avoid a *potential* warning about unused parameter.
gcc (10.3.0) complains about it.
So I added the (void) to please gcc.

But, you are right, removing all uses of 'pdev' is just fine for gcc and 
the warning I wanted to avoid just does not exist :(

CJ
