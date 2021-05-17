Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4C38295D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhEQKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:07:11 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:20054 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhEQKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:04:29 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d20 with ME
        id 5m2P2500Z21Fzsu03m2PcA; Mon, 17 May 2021 12:02:27 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 May 2021 12:02:27 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH 1/2] misc/pvpanic: Fix error handling in
 'pvpanic_pci_probe()'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, pizhenwei@bytedance.com,
        pbonzini@redhat.com, linqiheng@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
 <YKIi1hljnjvqMCVA@smile.fi.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <ada55e25-5eb3-9b6b-5783-d2303db9bf83@wanadoo.fr>
Date:   Mon, 17 May 2021 12:02:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKIi1hljnjvqMCVA@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/05/2021 à 10:01, Andy Shevchenko a écrit :
> On Sun, May 16, 2021 at 04:36:55PM +0200, Christophe JAILLET wrote:
>> There is no error handling path in the probe function.
>> Switch to managed resource so that errors in the probe are handled easily
>> and simplify the remove function accordingly.
> 
> Yes, that's what I suggested earlier to another contributor.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks!
> 
> P.S. You may consider the following things as well:
>   1) converting to use pci_set_drvdata() / pci_get_drvdata()

I can send a patch for that if you want.
But it looks really low value for a driver that is already very short 
and clean.

>   2) providing devm_pvpanic_probe() [via devm_add_action() /
>      devm_add_action_or_reset()]

I don't follow you here.
The goal would be to avoid the remove function and "record" the needed 
action directly in the probe?

If this is it, I would only see an unusual pattern and a harder to 
follow logic.

Did I miss something?
What would be the benefit?

CJ

> 
>> Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/misc/pvpanic/pvpanic-pci.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
>> index 9ecc4e8559d5..046ce4ecc195 100644
>> --- a/drivers/misc/pvpanic/pvpanic-pci.c
>> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
>> @@ -78,15 +78,15 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
>>   	void __iomem *base;
>>   	int ret;
>>   
>> -	ret = pci_enable_device(pdev);
>> +	ret = pcim_enable_device(pdev);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	base = pci_iomap(pdev, 0, 0);
>> +	base = pcim_iomap(pdev, 0, 0);
>>   	if (!base)
>>   		return -ENOMEM;
>>   
>> -	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
>> +	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_ATOMIC);
>>   	if (!pi)
>>   		return -ENOMEM;
>>   
>> @@ -107,9 +107,6 @@ static void pvpanic_pci_remove(struct pci_dev *pdev)
>>   	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
>>   
>>   	pvpanic_remove(pi);
>> -	iounmap(pi->base);
>> -	kfree(pi);
>> -	pci_disable_device(pdev);
>>   }
>>   
>>   static struct pci_driver pvpanic_pci_driver = {
>> -- 
>> 2.30.2
>>
> 

