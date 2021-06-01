Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19099396E68
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhFAIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:00:45 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:52740 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhFAIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:00:43 -0400
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 93191601D6F2;
        Tue,  1 Jun 2021 10:58:55 +0300 (EEST)
Received: from localhost.localdomain ([172.24.252.62]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 1 Jun 2021 10:59:00 +0300
Subject: Re: [PATCH v4 2/4] nvmem: bootcount: add bootcount driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
 <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
 <b973f433-5aa6-5c93-4d60-1017495ae0a7@linaro.org>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <a456396b-3950-7bd2-8f5c-af2699276f82@vaisala.com>
Date:   Tue, 1 Jun 2021 10:58:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b973f433-5aa6-5c93-4d60-1017495ae0a7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2021 07:59:00.0348 (UTC) FILETIME=[FB2AD3C0:01D756BB]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and thanks for your answers.


On 5/28/21 11:23 AM, Srinivas Kandagatla wrote:
> 
> 
> On 05/05/2021 11:42, Nandor Han wrote:
>> In order to have a robust system we want to be able to identify and take
>> actions if a boot loop occurs. This is possible by using the bootcount
>> feature, which can be used to identify the number of times device has
>> booted since bootcount was last time reset. Bootcount feature (1)
>> requires a collaboration between bootloader and user-space, where
>> the bootloader will increase a counter and user-space reset it.
>> If the counter is not reset and a pre-established threshold is reached,
>> bootloader can react and take action.
>>
>> This is the kernel side implementation, which can be used to
>> identify the number of times device has booted since bootcount was
>> last time reset.
>>
> 
> If I understand this correctly, this driver is basically exposing a 
> nvmem cell via sysfs.
> 
> Firstly, This sounds like totally a generic functionality that needs to 
> go into nvmem core rather than individual drivers.
> 
> Do you see any reason for this not be in core?

I agree that exposing a NVMEM cell via sysfs does look as a generic 
functionality. However, the bootcount feature contains also a magic
value that needs to be taken in consideration when extracting the
bootcount value. The size of the field storing the magic and value combo
is configurable as well. The driver will handle this values 
transparentlry for the user and expose only the validated
bootcount value. In case we will only use a generic implementation for
exposing a NVMEM cell via sysfs the aformention functionality will have
to be handled by userspace and this will force the userspace to have
knolwdge about bootcount value format and magic since they will have
to implement it's own functionality about this. In the current solution
the user only have to reset the value to 0 and that's it, the driver
will take care of the rest.

> 
> Secondly, creating sysfs entries like this in probe will race with 
> userspace udev. udev might not notice this new entry in such cases.

Thanks for point this out. I will have a look how to fix this. I'll 
appriciate any advice.

> 
> Thirdly, You would need to document this in Documentation/ABI/
> 

I'll do that.


> Finally I noticed that the changes to snvs_lpgpr.c  have not been cced 
> to the original author.
> 

Sorry, my mistake. I will add it in the next patch-set.
<snip>

-- 
Regards,
    Nandor
