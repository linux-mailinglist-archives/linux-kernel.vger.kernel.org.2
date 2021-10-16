Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26E342FFED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhJPDdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbhJPDds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:33:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D600C061570;
        Fri, 15 Oct 2021 20:31:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso592574otl.4;
        Fri, 15 Oct 2021 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IwHvS3IWWHySTzB3mOmra9H/OseXRFGz6kRwUjQHAFk=;
        b=BJG2xShTHx1k/LW5uYlzvCOTt3Frba3JfaPtENQxwIQteZCmruyT0gAlrSwNpQwjcA
         HBrc1E4PV5pNtgJUsfkqhVna+BJU9CAW6S+BiSWntWh+I/bglzVEEYW6OE9X+h+z4K59
         C8cAhBAMThg+ZMrr2/OmhL5T1gyuigpkX7y7wzpJMDfGcLYhIU64uAmDkPRfb/PXKrde
         7Kq3LTA9PCsGmc3wOeChnPgwq/AwfYUhtpw/mNlTjE5VCtv5nxRbVo6APt/opUs6uuT+
         mjWD4Ao8bxG/R0HwBB92b249J7L+iqFddPapSTsTPV2aUAuongpzKPEVjP+KrVPRTcQo
         DhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IwHvS3IWWHySTzB3mOmra9H/OseXRFGz6kRwUjQHAFk=;
        b=dcesvjJquDoc2AdHyTZeEO54Rc6HEcMnyePlvIaLvdYLtpKCahi7Rtsn4OBZ/eu72s
         FECHCKMB3FJ4vGprEAA2VAE+mHUwPXRVDAOfiZ+cPzZOprCLRFWKvTF4pZLxqNbg9Ts4
         HPSUY4d9Ua5OWavGJqDreDXkS6VX6WcA0iQ/g/Nxfr7YsToPZxhuAOg5KE51eX/fWa8E
         uIGvHF3LDRqQ1PDsan6746cZVxOvul9SDWU/RAUeW2mE8tuUqGmW2X7N84CkqWLuK8Tv
         Yy3216hl/lm3LrCYmgpJGrLoa8HMhKvFyxR29qdEBLzdOaCBuaVJSCqhNnM9MIHz/RbG
         /3og==
X-Gm-Message-State: AOAM532k/N3HS17ZauQ+zCCVWs1HbvvMQRrlQmrOXyPTONtNfzpNu1rh
        wcxjeG3/LmjJrrpiP790eQL14Wrj0Xo=
X-Google-Smtp-Source: ABdhPJyCHgRnf4cN9RyesqBbq1RpOc2VLVpJ6/eX5YDWGhLS6jAXG81Wm3gHW3+KDd29dHff6iEqiA==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr11203835otk.284.1634355099855;
        Fri, 15 Oct 2021 20:31:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13sm1635717oto.65.2021.10.15.20.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 20:31:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [EXTERNAL] Re: Potential issue with smb word operations for
 tmp461 device in tmp401 driver
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
 <20211015222719.GG1480361@roeck-us.net>
 <SA1PR09MB74400883EDB78A26DF16CD8CE7BA9@SA1PR09MB7440.namprd09.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7be30cc3-f67d-351f-cce9-94952bc4405d@roeck-us.net>
Date:   Fri, 15 Oct 2021 20:31:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SA1PR09MB74400883EDB78A26DF16CD8CE7BA9@SA1PR09MB7440.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 7:33 PM, Wilson, David T. (GSFC-5870) wrote:
> On my target platform, I do not believe the i2c-tools are completely supported, so i2c-dump is unable to provide me a register dump for the connected tmp461.
> 

No problem. That means though that I won't be able to run a module test,
and I'll have to wait for you or someone else to test my patch
before I can apply it.

Thanks,
Guenter

> If you have any other suggested methods of achieving the i2c register dump, I could try those as well.
> 
> I see on a different email chain that you have already submitted a patch to resolve this tmp461 issue.
> 
> Thanks for looking into this issue!
> David
> 
> 
> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@roeck-us.net>
> Sent: Friday, October 15, 2021 6:27 PM
> To: Wilson, David T. (GSFC-5870) <david.wilson@nasa.gov>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>
> Subject: [EXTERNAL] Re: Potential issue with smb word operations for tmp461 device in tmp401 driver
>   
> Hi,
> 
> On Fri, Oct 15, 2021 at 05:43:54PM +0000, Wilson, David T. (GSFC-5870) wrote:
>> Hi,
>>
>> I am reporting what I believe is a potential issue in the tmp401 driver for the tmp461 device specifically. I am new to reporting issues, so I apologize in advance if I've provided insufficient information for an issue report.
>>
>> The problem I'm encountering is that when I use the tmp401 linux driver to read temperature values from the tmp461, all of the read temperature values end with 996 (e.g. 33996, 38996, etc...).
>>
>> Looking further into the tmp401 commit messages, I see that the driver was changed to use smb word operations instead of separate byte operations. Although the other supported devices (i.e. tmp432, etc...) are noted to support 16-bit read operations in their respective datasheets, I see no indications of 16-bit read support in the tmp461 datasheet, which is supported by my inquiry in the TI forums (https://gcc02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fe2e.ti.com%2Fsupport%2Fsensors-group%2Fsensors%2Ff%2Fsensors-forum%2F1044935%2Ftmp461-linux-driver-support-and-16-bit-temperature-register-reads&amp;data=04%7C01%7Cdavid.wilson%40nasa.gov%7C1d874c8a8c8e471a2c1a08d9902af71b%7C7005d45845be48ae8140d43da96dd17b%7C0%7C0%7C637699336485905564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vwnJOlMAKMn752Vw%2F11KA96%2BPwnen22GvuT6fcitMt8%3D&amp;reserved=0).
>>
>> Reverting the driver to the commit before the smb word change, I am then able to read temperature values that do not end only with 996. As a result, I believe that the tmp461 support may be partially broken by the switch to smb word operations.
>>
> 
> Thanks a lot for the report. Can you send me a register dump for the tmp461 ?
> 
> Thanks,
> Guenter
> 

