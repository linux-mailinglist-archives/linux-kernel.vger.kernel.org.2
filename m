Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF2238085E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhENLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:23:00 -0400
Received: from smtp112.iad3b.emailsrvr.com ([146.20.161.112]:56647 "EHLO
        smtp112.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbhENLW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:22:58 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2021 07:22:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1620990973;
        bh=2sYSS/owVjhPm2nwLibmZ4nWXD6lTDPIrrADWO3KLHU=;
        h=Subject:To:From:Date:From;
        b=JkV+/YF232cwM3KFdnEBzsiiKClC1sxD6BRfqJpJ/ZSI5E9CzFvSnvJNRn1hiX7AC
         q+fQO6Ztd44vZ7rcBlgeQovdc4IRVC1Bmo7czjJQlV8ksipkTThpEV5OW19fl2mU6i
         C/p5lkJg/dDoNSrTKUHywwQoLRIfpHYLlP19jJgM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9CECFA0142;
        Fri, 14 May 2021 07:16:12 -0400 (EDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_-next_v2=5d_staging=3a_comedi=3a_Remove_un?=
 =?UTF-8?Q?used_variable_=e2=80=98min=5ffull=5fscale=e2=80=99_and_function_?=
 =?UTF-8?B?J2dldF9taW5fZnVsbF9zY2FsZXMn?=
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
        grandmaster@al2klimov.de
References: <20210514085214.53941-1-cuibixuan@huawei.com>
 <YJ4sLVlncZoQkNJm@kroah.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <25e0e925-cc90-3e88-a3bd-15b70cb7b4ec@mev.co.uk>
Date:   Fri, 14 May 2021 12:16:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJ4sLVlncZoQkNJm@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: d6d13588-2c1a-439d-b384-9e5ba8a02ae3-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 08:52, Greg KH wrote:
> On Fri, May 14, 2021 at 04:52:14PM +0800, Bixuan Cui wrote:
>> The variable ‘min_full_scale’ and function 'get_min_full_scales' are
>> not used, So delete them.
>>
>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>> ---
>> Changes from v2:
>> * Delete function 'get_min_full_scales'
>>
>>   drivers/comedi/drivers/jr3_pci.c | 15 ---------------
>>   1 file changed, 15 deletions(-)
>>
>> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
>> index 7a02c4fa3cda..f963080dd61f 100644
>> --- a/drivers/comedi/drivers/jr3_pci.c
>> +++ b/drivers/comedi/drivers/jr3_pci.c
>> @@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
>>   	set_s16(&sensor->command_word0, 0x0a00);
>>   }
>>   
>> -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
>> -{
>> -	struct six_axis_t result;
>> -
>> -	result.fx = get_s16(&sensor->min_full_scale.fx);
>> -	result.fy = get_s16(&sensor->min_full_scale.fy);
>> -	result.fz = get_s16(&sensor->min_full_scale.fz);
>> -	result.mx = get_s16(&sensor->min_full_scale.mx);
>> -	result.my = get_s16(&sensor->min_full_scale.my);
>> -	result.mz = get_s16(&sensor->min_full_scale.mz);
>> -	return result;
> 
> Are you _SURE_ that this is ok to do?  You are reading from the
> hardware, and that is sometimes required depending on the
> internal-to-the-device state machine.
> 
> Have you tested to verify that not doing these reads does not break
> something?
> 
> This is a constant theme in these "remove variables that are not being
> used" patches, please be aware that how hardware works is very specific
> and when you mess with how it is accessed, that has the chance of
> causing problems.

I don't think removing this would do any harm.  The `get_s16` function 
is just a simple wrapper around `readl` that converts the type of the 
returned value to `s16`.  The registers for minimum full scale and 
maximum full scale are just informational, and there is nothing in the 
manual[1] about reading registers in a particular order.  The driver 
used to print these values to the kernel log, but that code was removed 
in commit a1d16659538a ("staging: comedi: jr3_pci: remove noisy printk").

[1] 5907E - Legacy PCI Receiver Manual
<https://www.jr3.com/component/phocadownload/category/6-product-manuals?download=36:5907e-legacy-pci-receiver-manual>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
