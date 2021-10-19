Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2743383D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhJSOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:20:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDFC06161C;
        Tue, 19 Oct 2021 07:18:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so3007397ote.6;
        Tue, 19 Oct 2021 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hhG0o0niXpZ9xrXNzK6RD8QobJPpdUVy19TJ+MLrsqM=;
        b=S0sbNJP5xJzz5Ulw+/9C6nSf+q1fWPmjwZ1sqhjo7ViK3xEBQNTyLJu6qhRpimQjyt
         SJQq1l7mPyDi9tyLvLtiAizMQODawP6gUvtcbMzQ6H9OEYz8YtLv3V9V4L/agb2aEPUq
         YG5Ym9d8b7z8deQJxPNKuQFWxpCwB63hQVFeYBkjtF3MySD8U3gukngNyhmbAWjO8JAp
         sUaDNmDRTrgkUZhGO5ik3roxysKnVhNpcPFx9s7XZZ/UwkM5sSdE4d3oV/4o+MK2xtFS
         QPsoHkFgjNjKZA4gbpyey503/gWwC4AOIXuy/rO97+4/Q7WSsialWI4XgyHtL11jeBL8
         9oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhG0o0niXpZ9xrXNzK6RD8QobJPpdUVy19TJ+MLrsqM=;
        b=4njohn36PICdWOdb0B4RZm7z7A6b1KevYFe/fUKplxMyus/XPt7UTyf8+jO3mrsL9r
         84h/BOA9uXZ5nzS/5ZTdZ18oYvjWZWja4KvNJWL3HDYSev4VtAx+9get/DBtp0gP7laO
         1HU4vnfEfI+BOfeQ1Y65tXgGVwMW9aqrkw9Pl+Gz5LXaRKjaSG19VRdQsC4lDDCgFL58
         2Cp2EnNSIl6KlagOqrtqAZ+KpU++PtzxZxEwvwMgWaDNMMI+lemzF8N31XILa9KJNJU1
         DEKvYIz8EeMT0lDvFQhCngQv2TJx3rFg0W9kpNi+qQdAnsWEuEo6yFoyJiqSCC8thjds
         ApMw==
X-Gm-Message-State: AOAM533zhsBemBIu1XPbTC0QCvYZ0NTwaGrGEHZ2ZekqvY967/YUlipU
        m39aF0o8RmXooFITe7NAlUZKIgr9E/s=
X-Google-Smtp-Source: ABdhPJwt/1srRZBRCemyR45sHNCaOJJOG2Nd2p7ffYW8cSfywRC23otEuX8SJwE0LTNYddGGrVp4Yg==
X-Received: by 2002:a05:6830:2b10:: with SMTP id l16mr5716871otv.287.1634653085814;
        Tue, 19 Oct 2021 07:18:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w9sm3616267otp.64.2021.10.19.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 07:18:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
 <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
Message-ID: <3923f61f-031c-f293-dfbd-8db7efbce2cb@roeck-us.net>
Date:   Tue, 19 Oct 2021 07:18:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SA1PR09MB74408633E36AE3C97B4D2CA7E7BD9@SA1PR09MB7440.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On 10/18/21 10:42 PM, Wilson, David T. (GSFC-5870) wrote:
> Guenter,
> 
> I've tried testing the patch by checking out the most recent commit's version for tmp401.c and applying the patch. However, the temperature values seem to be to low <1000 for each read.
> 
> If I'm understanding the driver code correctly, I believe there's two places of interest that might explain the low values
> 1. In tmp401_update_device_reg16, the final assignment to data->temp[j][i] overrides the patch's assignment to data->temp[j][i] in the tmp461 branch
> 2. In SENSOR_DEVICE_ATTR_2_RW, the temp2_offset is at (6, 1), but the newly added LSB array does not contain the LSB address at (6, 1)
> 
Thanks a lot for the information.

> Regarding your most recent email, I will try the lm90 by changing the driver tree entry to "ti,tmp451" and I'll let you know if that works for me.
> 
I just sent two patches, one to remove tmp461 support from the tmp401 driver, and one to add
tmp461 support to the lm90 driver. Turns out tmp461 is almost identical to tmp451, which was
already supported by the lm90 driver. Adding support for tmp461 to the lm90 driver makes
much more sense than trying to fix the tmp401 driver.

I module tested the lm90 driver for both tmp451 and tmp461 (I was able to find
register dumps for both chips), so I am reasonably sure that it works.

Thanks,
Guenter

> Thanks,
> David
> 
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@roeck-us.net>
> Sent: Tuesday, October 19, 2021 12:56 AM
> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>
> Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp461 device in tmp401 driver
>   
> David,
> 
> On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:
>> Hi,
>>
>> I am reporting what I believe is a potential issue in the tmp401 driver for the tmp461 device specifically. I am new to reporting issues, so I apologize in advance if I've provided insufficient information for an issue report.
>>
>> The problem I'm encountering is that when I use the tmp401 linux driver to read temperature values from the tmp461, all of the read temperature values end with 996 (e.g. 33996, 38996, etc...).
>>
>> Looking further into the tmp401 commit messages, I see that the driver was changed to use smb word operations instead of separate byte operations. Although the other supported devices (i.e. tmp432, etc...) are noted to support 16-bit read operations in their respective datasheets, I see no indications of 16-bit read support in the tmp461 datasheet, which is supported by my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2Fsensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperature-register-reads&amp;data=04%7C01%7Cdavid.wilson%40nasa.gov%7C2bf9c7234976452dd4a808d992bcc836%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C637702161780144423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JerajTZnSdtQgGlVrfm3IOLNpQcoVKeg5haNU8h1aDs%3D&amp;reserved=0).
>>
>> Reverting the driver to the commit before the smb word change, I am then able to read temperature values that do not end only with 996. As a result, I believe that the tmp461 support may be partially broken by the switch to smb word operations.
>>
> 
> can you try to instantiate the lm90 driver (instead of the tmp401 driver)
> and let me know if it works for you ? If your system uses devicetree,
> you might have to select "ti,tmp451" instead of "ti,tmp461".
> 
> Thanks,
> Guenter
> 

