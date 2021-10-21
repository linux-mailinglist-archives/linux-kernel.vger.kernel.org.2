Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB8435B59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJUHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhJUHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:10:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CAC06161C;
        Thu, 21 Oct 2021 00:08:00 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g125so12610621oif.9;
        Thu, 21 Oct 2021 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qnA6O70e1LuYhU7fgkZRdfz5J+Ye7mlPGRlnJgpbv9g=;
        b=nOddENDZy80naePjdyp2GDupN0K3efVspkrQP1+DDac/mz+8tD7NZefk6C8Y6yxojw
         WuMz1TDJhq31G98C7W51VcGkOBvxj55gMdJE/bj4Wxnx+zCNLQTGK9Q9IUalouWEYjeV
         oaw5jbv6YTG8AIlHOmAZpPpi+UPT9NGii/ZHlwWjEXxHWU3RmU2n439hABD7IxqqV9lS
         kKwxOJpt/KSi49xb2SKC8lmXbo4kTqylFZnu2NDRJRLjaIUxt5EMdOXcFSHX/emVp71v
         TuH1l7sv2dvsFR90GCwdptTGgmYMLPGYWemrd590nDROvMSuWNSK1+fm4XZGySC/XRFp
         jF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qnA6O70e1LuYhU7fgkZRdfz5J+Ye7mlPGRlnJgpbv9g=;
        b=3QsTh7ofyhcdV3ri6YTiu08I9z816Gyc/eobW7sNTszeps1R3zjmWhcdzodpV5RvHx
         KzqfctZ3PtOX13fsi1cNFX75c/eyS6SFX1vrtU0AuzsRP+NiBOkLGWATKYRGGFNLsf1J
         kmKT5Z+iRZQ4NXSWDLTAYdJQSuugwJEPwHkGdWJf32+DsS87OMCv45Dw4sRBLHuegg/9
         W59Z1ZPpHC2J+FnCb4zC9s7nKtz9xTZKY/owf9f56tnqNIFRVhU16rfs3IsLdJIQNmN+
         U5nUOk5ocOyTSgiXHzC9Kb6iYCr0kxFVadEkVhfHGq7SKuZ6zd0qKFduG91GduechFmi
         2X8g==
X-Gm-Message-State: AOAM530fRqU+Zq0/oeLN3ZS5VscecxTPk1eXRR5TTFEhiy+b6gQauQUC
        N1zrjkESWLiXqYGKjPpgwQv+QIVyWQo=
X-Google-Smtp-Source: ABdhPJyeZ1OPMaMhXneq9yMegJbaKYIGfkgk3EqWYTsL3fydnpsabYc77D8X8CJrGEy8+XhLqBNYfA==
X-Received: by 2002:a05:6808:56e:: with SMTP id j14mr2952969oig.177.1634800079516;
        Thu, 21 Oct 2021 00:07:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q15sm899706otm.15.2021.10.21.00.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:07:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
 <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
 <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Message-ID: <8485a422-31b2-6d9f-516c-29d60fd13490@roeck-us.net>
Date:   Thu, 21 Oct 2021 00:07:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SA1PR09MB7440DE6CE6882186ECDE3401E7BE9@SA1PR09MB7440.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 10/20/21 10:37 PM, Wilson, David T. (GSFC-5870) wrote:
> Guenter,
> 
> I updated several files and applied the lm90.c and tmp401.c patches. It should be noted that my target platform only supports v5.4, so
> I had to update additional files (i.e. hwmon.c/.h) in order to successfully compile and apply the patch to lm90.c, which could suggest
> that some of my findings may have been due to poor updating of files.
> 
> In regards to testing, I got temp1_input and temp2_input values that look good from a glance and that steadily increased after booting
> my target platform. There were three areas of possible concern.
> 1. The lm90.c patch includes  "+#define TMP461_REG_DFC 0x23". If this define is referring to the address of the digital filter control,
>      then the value should be 0x24, since 0x23 is the n-Factor Correction register

Good catch. That is a bug. Thanks a lot for noticing.

> 2. The values I recorded had a resolution of 0.125 deg resolution (e.g., 30625, 25250, etc...). However, the datasheet for the tmp461
>      notes that the resolution is 0.0625 deg for local and remote channels, so I was wondering if that would also be supported in lm90.c

You are correct, the lm90 driver assumes a 0.125 deg resolution. I'll see what I can do about that.

> 3. For temp1_min and temp2_min, I used "cat temp1_min" to get the value -128000. Assuming that is -128.0 deg, I don't believe the
>      tmp461 should be returning a value underneath -64 deg based on the temp data format if I'm understanding the datasheet correctly.
> 

It is odd, but the tmp461 datasheet does list a default value of 0x80 for the low limit registers.
In 2-complement format, that does translate to -128 degrees C. That doesn't really make much sense,
but it is what the chip reports, and I hesitate to change that.

Thanks,
Guenter

> Thanks,
> David
> 
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@roeck-us.net>
> Sent: Tuesday, October 19, 2021 10:18 AM
> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>
> Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for tmp461 device in tmp401 driver
>   
> David,
> 
> On 10/18/21 10:42 PM, Wilson, David T. (GSFC-5870) wrote:
>> Guenter,
>>
>> I've tried testing the patch by checking out the most recent commit's version for tmp401.c and applying the patch. However, the temperature values seem to be to low <1000 for each read.
>>
>> If I'm understanding the driver code correctly, I believe there's two places of interest that might explain the low values
>> 1. In tmp401_update_device_reg16, the final assignment to data->temp[j][i] overrides the patch's assignment to data->temp[j][i] in the tmp461 branch
>> 2. In SENSOR_DEVICE_ATTR_2_RW, the temp2_offset is at (6, 1), but the newly added LSB array does not contain the LSB address at (6, 1)
>>
> Thanks a lot for the information.
> 
>> Regarding your most recent email, I will try the lm90 by changing the driver tree entry to "ti,tmp451" and I'll let you know if that works for me.
>>
> I just sent two patches, one to remove tmp461 support from the tmp401 driver, and one to add
> tmp461 support to the lm90 driver. Turns out tmp461 is almost identical to tmp451, which was
> already supported by the lm90 driver. Adding support for tmp461 to the lm90 driver makes
> much more sense than trying to fix the tmp401 driver.
> 
> I module tested the lm90 driver for both tmp451 and tmp461 (I was able to find
> register dumps for both chips), so I am reasonably sure that it works.
> 
> Thanks,
> Guenter
> 
>> Thanks,
>> David
>>
>> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@roeck-us.net>
>> Sent: Tuesday, October 19, 2021 12:56 AM
>> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>
>> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>
>> Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp461 device in tmp401 driver
>>     
>> David,
>>
>> On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:
>>> Hi,
>>>
>>> I am reporting what I believe is a potential issue in the tmp401 driver for the tmp461 device specifically. I am new to reporting issues, so I apologize in advance if I've provided insufficient information for an issue report.
>>>
>>> The problem I'm encountering is that when I use the tmp401 linux driver to read temperature values from the tmp461, all of the read temperature values end with 996 (e.g. 33996, 38996, etc...).
>>>
>>> Looking further into the tmp401 commit messages, I see that the driver was changed to use smb word operations instead of separate byte operations. Although the other supported devices (i.e. tmp432, etc...) are noted to support 16-bit read operations in their respective datasheets, I see no indications of 16-bit read support in the tmp461 datasheet, which is supported by my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2Fsensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperature-register-reads&amp;data=04%7C01%7Cdavid.wilson%40nasa.gov%7Ce801cf6c7ac146b0e90908d9930b4794%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C637702498923858681%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gGK9KbA0TWUJ4r3We%2BG9f5LOY7m%2BM5FkYuxhnEZFifY%3D&amp;reserved=0).
>>>
>>> Reverting the driver to the commit before the smb word change, I am then able to read temperature values that do not end only with 996. As a result, I believe that the tmp461 support may be partially broken by the switch to smb word operations.
>>>
>>
>> can you try to instantiate the lm90 driver (instead of the tmp401 driver)
>> and let me know if it works for you ? If your system uses devicetree,
>> you might have to select "ti,tmp451" instead of "ti,tmp461".
>>
>> Thanks,
>> Guenter
>>

