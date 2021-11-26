Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D745F291
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKZRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:03:20 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:47861 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKZRBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:01:17 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J11CH0hFBz9sSM;
        Fri, 26 Nov 2021 17:58:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6oxPbBvnfkz3; Fri, 26 Nov 2021 17:58:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J11CC2T7lz9sSL;
        Fri, 26 Nov 2021 17:57:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 458848B781;
        Fri, 26 Nov 2021 17:57:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KJ3vvRA5g6Hk; Fri, 26 Nov 2021 17:57:59 +0100 (CET)
Received: from [192.168.204.6] (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B98428B763;
        Fri, 26 Nov 2021 17:57:58 +0100 (CET)
Message-ID: <8e5493ac-dd05-9bad-c9ae-169114e0fdcf@csgroup.eu>
Date:   Fri, 26 Nov 2021 17:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] w1: Misuse of get_user()/put_user() reported by sparse
Content-Language: fr-FR
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
References: <926b572075a26835f4e39d05710cd1b75fd4d5a4.1637945194.git.christophe.leroy@csgroup.eu>
 <YaERVtyYpJ+BTQ/f@kroah.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <YaERVtyYpJ+BTQ/f@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/11/2021 à 17:54, Greg Kroah-Hartman a écrit :
> On Fri, Nov 26, 2021 at 05:47:58PM +0100, Christophe Leroy wrote:
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
>> v2: Use sysfs_emit() and kstrtobool()
>> ---
>>   drivers/w1/slaves/w1_ds28e04.c | 25 +++----------------------
>>   1 file changed, 3 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
>> index e4f336111edc..98f80f412cfd 100644
>> --- a/drivers/w1/slaves/w1_ds28e04.c
>> +++ b/drivers/w1/slaves/w1_ds28e04.c
>> @@ -32,7 +32,7 @@ static int w1_strong_pullup = 1;
>>   module_param_named(strong_pullup, w1_strong_pullup, int, 0);
>>   
>>   /* enable/disable CRC checking on DS28E04-100 memory accesses */
>> -static char w1_enable_crccheck = 1;
>> +static bool w1_enable_crccheck = true;
>>   
>>   #define W1_EEPROM_SIZE		512
>>   #define W1_PAGE_COUNT		16
>> @@ -339,32 +339,13 @@ static BIN_ATTR_RW(pio, 1);
>>   static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
>>   			     char *buf)
>>   {
>> -	if (put_user(w1_enable_crccheck + 0x30, buf))
>> -		return -EFAULT;
>> -
>> -	return sizeof(w1_enable_crccheck);
>> +	return sysfs_emit(buf, "%d\n", w1_enable_crccheck);
>>   }
>>   
>>   static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
>>   			      const char *buf, size_t count)
>>   {
>> -	char val;
>> -
>> -	if (count != 1 || !buf)
>> -		return -EINVAL;
>> -
>> -	if (get_user(val, buf))
>> -		return -EFAULT;
>> -
>> -	/* convert to decimal */
>> -	val = val - 0x30;
>> -	if (val != 0 && val != 1)
>> -		return -EINVAL;
>> -
>> -	/* set the new value */
>> -	w1_enable_crccheck = val;
>> -
>> -	return sizeof(w1_enable_crccheck);
>> +	return kstrtobool(buf, &w1_enable_crccheck) ? : count;
> 
> Please spell this line out, using ? : is unreadable at times.
> 

You prefer something like:

	int err = kstrtobool(buf, &w1_enable_crccheck);

	return err ? err : count;


Or

	int err = kstrtobool(buf, &w1_enable_crccheck);

	if (err)
		return err;

	return count;

?
