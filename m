Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59903FBDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhH3VIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhH3VIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:08:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86566C061575;
        Mon, 30 Aug 2021 14:07:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j18so21830274ioj.8;
        Mon, 30 Aug 2021 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g5yL003HMqaHRo5YL2Nf3KKbD13P3l8kcGs2AKGZYpU=;
        b=ne5M+gmNn5PcZlSCwY8qx+B1r3x/aMhF5+tk4L36/MsSzTr3CGARYRr1tsJgJGpXpW
         NjrWiOWa3A+DGrGCqvqOLVY/639iQIP1X9ErnP8XVLWtrIgyK7skDbttJ3Uz2prvdccC
         Ji/vbZ7cfy8AtUCdPUJwqFNWbCotzkaEqRRnDhxYW+UlCzRw+xheESBu6APh+4IShKrl
         g5l3SGieySjJB6INSaP6K36wQz+iupSrfvzsY08t36TJj8NzZ/TtpeWc+sOv8BrH702/
         fpDOvw0ek826WbTCxeIy1VLr2TCrPGLb8pkspCNOK1zHNNUzKr+iMownqMZo3P1s087w
         tFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g5yL003HMqaHRo5YL2Nf3KKbD13P3l8kcGs2AKGZYpU=;
        b=OzS9E4N0iFGwBI689kt7NeXlSYMJGvxGjeOAup2qGhIATcRajdZbP8dho49nlS7AI3
         4D9OcoLDv+J8t6ejRCOmgRn0GyaiF+G9e+u9nha7CVVjbdaXsdbkixhGtZ+HdRXd+P3u
         5quHREfw/SGliXXESzKSXB80a0+RwhXHuiRQens9yac1O5S5pAMSK1EBjmzjn9rCNXHF
         guGdWanqtc5CBZi+WpABurMjXE5FvEUg2oLDucHVRLlXQIoufgUTyuqFHbnn61giiIF1
         TokSxSHnXAEAf+CwhMyKkfKrGWhiMu3v/0E8UunbsdwEh7aXDyzfq/v/4PK6JE3pwgyr
         mrzA==
X-Gm-Message-State: AOAM532h/Ltgle52rAr/KxXySBQWLPLcUab5+jsXrLp3D+4Ni0CDjwSq
        oSu/BoBVwTq5iTtn7cdiu0SYorSscJL3bA==
X-Google-Smtp-Source: ABdhPJyY/fXXZi//wASNXGJl8Ch8FW63ZZ4b1Fkl9cJohC1YS/+m4kBZW8Neyxb8M3NZi0WOr/bjQw==
X-Received: by 2002:a05:6638:d85:: with SMTP id l5mr342434jaj.2.1630357662375;
        Mon, 30 Aug 2021 14:07:42 -0700 (PDT)
Received: from [192.168.4.31] (199-48-94-117.rochmnaa.metronetinc.net. [199.48.94.117])
        by smtp.gmail.com with ESMTPSA id b10sm8947921ils.13.2021.08.30.14.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 14:07:41 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Do not swap max_power_out
To:     Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827230433.3596370-1-bjwyman@gmail.com>
 <20210828155250.GA820265@roeck-us.net>
 <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
From:   Brandon Wyman <bjwyman@gmail.com>
Message-ID: <cac545d4-3840-898c-4950-8262fea9e2ab@gmail.com>
Date:   Mon, 30 Aug 2021 16:07:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e9de99d88fb9e2e34552806fa47efa488332325c.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-08-30 08:50, Eddie James wrote:
> On Sat, 2021-08-28 at 08:52 -0700, Guenter Roeck wrote:
>> On Fri, Aug 27, 2021 at 11:04:33PM +0000, Brandon Wyman wrote:
>>> The bytes for max_power_out from the ibm-cffps devices do not need
>>> to be
>>> swapped.
>>>
>>> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
>> Eddie, can you confirm this ?
> This can't be true for all the power supplies supported by this driver,
> no. I think we need to check the version first. Brandon, I tested this
> on witherspoon (which is psu version 1) and get 3148 watts. If it's not
> swapped, that would be 19468 watts...
>
> Thanks,
> Eddie
I had tested this on a variety of systems with a variety of different 
power supplies, but I did *NOT* test this on the Witherspoon power supplies.

This apparently requires a bit more thought to figure out how to handle 
the other types and also not get Witherspoon wrong.

Thanks for checking Eddie.

>> Thanks,
>> Guenter
>>
>>> ---
>>>   drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c
>>> b/drivers/hwmon/pmbus/ibm-cffps.c
>>> index df712ce4b164..29b77f192c9e 100644
>>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
>>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
>>> @@ -171,7 +171,7 @@ static ssize_t ibm_cffps_debugfs_read(struct
>>> file *file, char __user *buf,
>>>   		cmd = CFFPS_SN_CMD;
>>>   		break;
>>>   	case CFFPS_DEBUGFS_MAX_POWER_OUT:
>>> -		rc = i2c_smbus_read_word_swapped(psu->client,
>>> +		rc = i2c_smbus_read_word_data(psu->client,
>>>   						 CFFPS_MAX_POWER_OUT_CM
>>> D);
>>>   		if (rc < 0)
>>>   			return rc;
>>> -- 
>>> 2.25.1
>>>
