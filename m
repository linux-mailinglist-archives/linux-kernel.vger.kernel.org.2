Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAEC39341E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhE0Qj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhE0QjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:39:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB1C061574;
        Thu, 27 May 2021 09:37:50 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j75so1332404oih.10;
        Thu, 27 May 2021 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tbaGejzn8q8uB1o7wU9OHplgpPZiIv19pAT7ms12ifA=;
        b=emMat2JGS1mwG2NDSEM+B2hurHmJhHzASt2OOWYgG10zIyn/MHIZ/J1paPfCxYswru
         evLbkupjnPARKSD6TeN8b37M36+NOnVILsdYyAHupy/NiuZ1bF/ptSrUA87mUcCRxl12
         Z6mupC3iL9gQ9/6QpBYUh9+R3wJ2loL8SsRJR0hnoKKc23Fy6BNvjSnuoDj7NVr5zmYs
         DrbLcnr5LX+j2fpwYCDwkk1y9zP8c9MceELkaxymPlpof2Pf0DF5LD73TIXZUFIJCC4i
         HCQsL6G21HLPXzrJ16iLVBXM09Y05ApY/iXKiTOmSUD9eQbPSAPCRPzxa8+4PM2MXqxt
         ASrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tbaGejzn8q8uB1o7wU9OHplgpPZiIv19pAT7ms12ifA=;
        b=BLUJqP1HuVlfXgoprmCug6PyeuGkIBqRkFO7QbkbzAuWARsSQ+dJCMjiJ0eovA0/Nl
         JJt3sQVlg0A/ej96mW3Xw7Sk1NO3LXkLZ9iJmuVgqj4W5D3ibGJWaNDpPP/oMch2lWdt
         kX5++nLu4SJmomqyQ7hYCRKjlfY/n1Y8wizNLG4sDJUGRJzGjDP39Xd9OlTAfDPvDIFq
         B9unx6tqwPj0+FKlyUZPOxI5WywAOUb9dkRUT1jVwwX/Iu2eHklluS0maestCwwiFXJq
         aSRRpCd9Ia5cFzhj4SCW27RRMrIMPbefyN0LSXkZ1VDK7Nqs1eYDWaUyCEffr/FC4tR6
         sjZg==
X-Gm-Message-State: AOAM530qtGyg3H5B9vZdNjBkZ0V3tNJUStSRR3v7gutBtLRRmsLVBg+R
        o50O9w/OlOg+wJKM5Pi2GrznVFHsDAg=
X-Google-Smtp-Source: ABdhPJzhI8tpvObBfO6PqTIvKtbbD8pgJYJVAcb1oOdcuOkolE/4SYfSboX7C9eD20hhubbsIMbCtw==
X-Received: by 2002:a54:4011:: with SMTP id x17mr2973033oie.112.1622133469498;
        Thu, 27 May 2021 09:37:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15sm579194otp.20.2021.05.27.09.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 09:37:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net>
 <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net>
 <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
 <2a1a63c7-c9b0-e38d-df1d-7643ad493aba@roeck-us.net>
 <CA+HBbNF62xzBt2r60qfzn9iveiusLKp6R-T4KU-NgoHaE6c3kQ@mail.gmail.com>
 <dec7d641-2954-29f0-124b-d0020866bf7b@roeck-us.net>
 <CA+HBbNGU4d4g0JrUKBhj07OsC7=s9qoubxNDi3MxPjmV457C+Q@mail.gmail.com>
 <8152a109-d76d-4f85-9da2-fe0a56c2019f@roeck-us.net>
 <CA+HBbNGBirE=Po7q5eUeHho0rBATa_ApWLiU_oPXsGN+6U9U+g@mail.gmail.com>
 <CA+HBbNGZ1axZpRy5UwQP_4eZCA32eyPJVcj6xN4i8AhOQMYeTA@mail.gmail.com>
 <493e4da4-8f2b-9856-b538-6e95e3766d5e@roeck-us.net>
 <CA+HBbNHspA5cZJSHJkLpnP+UODGy7w5i8mKP2NH9JALQ1RqQ_w@mail.gmail.com>
 <7af2d708-7e22-3970-7bf8-1cb23317cb55@roeck-us.net>
 <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net>
Date:   Thu, 27 May 2021 09:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 7:58 AM, Robert Marko wrote:
[ ... ]

>>>>>> I tried applying the block support for mv64xx as well:
>>>>>> https://patchwork.ozlabs.org/project/linux-i2c/patch/20200118115820.9080-1-fuga@studiofuga.com/
>>>>
>>>> That patch would be needed, but it looks buggy to me. This chunk:
>>>>
>>>> +               drv_data->effective_length = data+1;
>>>> +               drv_data->bytes_left = data+1;
>>>> +               drv_data->msg->len = data+1;
>>>>
>>>> should be:
>>>>
>>>> +               drv_data->effective_length = data+1;
>>>> +               drv_data->bytes_left = data;
>>>> +               drv_data->msg->len = data+1;
>>>>
>>>> It should also make sure that 'data' is not larger than I2C_SMBUS_BLOCK_MAX,
>>>> and bail out if it isn't.
>>>
>>> Yeah, I did not check the contents, I just saw 2 reviews and tested it
>>> since it can't hurt.
>>
>> That patch doesn't work at all. Make the above change, and also change
>> the type of effective_length from u32 to int, and try again.
> 
> I was just looking and it, and doing the changes you recommended make
> no difference at all.
> 

Is the i2c controller compatible with marvell,mv78230-i2c ?
The block transfers would not work in that case. Let me know
and I'll send you a patch that might fix it.

Guenter
