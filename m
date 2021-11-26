Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653FC45F162
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378386AbhKZQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:16:04 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:53781 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354425AbhKZQOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:14:01 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J108l2YfHz9sSM;
        Fri, 26 Nov 2021 17:10:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k7gFLdaq-XHi; Fri, 26 Nov 2021 17:10:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J108l1pGXz9sSL;
        Fri, 26 Nov 2021 17:10:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EFE28B781;
        Fri, 26 Nov 2021 17:10:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ttGKRtCaua7U; Fri, 26 Nov 2021 17:10:47 +0100 (CET)
Received: from [192.168.204.6] (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABD9E8B763;
        Fri, 26 Nov 2021 17:10:46 +0100 (CET)
Message-ID: <39ec092d-428c-7fce-7291-a88a4caf8b9f@csgroup.eu>
Date:   Fri, 26 Nov 2021 17:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] w1: Misuse of get_user()/put_user() reported by sparse
Content-Language: fr-FR
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
References: <2163689da6544c289254b3c69848acc36db998f5.1637313047.git.christophe.leroy@csgroup.eu>
 <YaEEqeKyWPfUP7vM@kroah.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <YaEEqeKyWPfUP7vM@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/11/2021 à 17:00, Greg Kroah-Hartman a écrit :
> On Fri, Nov 19, 2021 at 10:15:09AM +0100, Christophe Leroy wrote:
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *_pu_addr @@     got char *buf @@
>>     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [noderef] __user *_pu_addr
>>     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>>>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *_gu_addr @@     got char const *buf @@
>>     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected char const [noderef] __user *_gu_addr
>>     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>>
>> The buffer buf is a failsafe buffer in kernel space, it's not user
>> memory hence doesn't deserve the use of get_user() or put_user().
>>
>> Access 'buf' content directly.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/lkml/202111190526.K5vb7NWC-lkp@intel.com/T/
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   drivers/w1/slaves/w1_ds28e04.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
>> index e4f336111edc..d75bb16fb7a1 100644
>> --- a/drivers/w1/slaves/w1_ds28e04.c
>> +++ b/drivers/w1/slaves/w1_ds28e04.c
>> @@ -339,10 +339,7 @@ static BIN_ATTR_RW(pio, 1);
>>   static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
>>   			     char *buf)
>>   {
>> -	if (put_user(w1_enable_crccheck + 0x30, buf))
>> -		return -EFAULT;
>> -
>> -	return sizeof(w1_enable_crccheck);
>> +	return sprintf(buf, "%d", w1_enable_crccheck);
> 
> This should be sysfs_emit(), right?

Ok

> 
>>   }
>>   
>>   static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
>> @@ -353,11 +350,8 @@ static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
>>   	if (count != 1 || !buf)
>>   		return -EINVAL;
>>   
>> -	if (get_user(val, buf))
>> -		return -EFAULT;
>> -
>>   	/* convert to decimal */
>> -	val = val - 0x30;
>> +	val = *buf - 0x30;
> 
> Why not use a proper function that can parse a string and turn it into a
> number?

I wanted to keep the change minimal. But I can also replace it with some 
scanf.

But don't we have any generic function to read and store a bool after all ?

Thanks
Christophe
