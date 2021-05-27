Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189A939371D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhE0UZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhE0UZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:16 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479DDC06138A;
        Thu, 27 May 2021 13:23:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so1449441otl.3;
        Thu, 27 May 2021 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uq1fW06TeRfprNyZLiKWQ7PSggsp1h+x98WGiLpZDdM=;
        b=vh+8ecqg6h89O3GjkhWl6XAWE1GZ66/7s2fiCCrnEimQV1/LomANn0WXpiM0YFA1LA
         9cvMfE2YXyqfkOowZK2B9UfmUNTgm2hwg3T8wej+2m/UYGA1wl5CRvPOCl8wJ/cqziom
         CqzPw7XwZ5rnBSLzmNrVgbRKgHMY1CwAEdWqZHNsNY86LWjIAqn3FsVu7o3/16XVeDU0
         ioCjMLD8MPs5Xl573DDc1OhznutO0MxotkiF5ccxcFfZNJ2kPYtrQK6zLipltGYadUkE
         M+6ImNm3/OIKyUPsr00xCP+74bf7KU47pMA8WK8A8g8Zf0fB40zTUhQWnUSCXpbsgmfY
         5JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uq1fW06TeRfprNyZLiKWQ7PSggsp1h+x98WGiLpZDdM=;
        b=EhZiTKSXUtQd40zEHjhGAfSxnmJrIKQuuk7MVMYRoP3PSZHixwz9ogJLFnzjHiRgGG
         mLDL7NvSnCdZsDoNvsueguH19TEnuGU7uI/8HflFqlE5YylqrEhz8lRp9yYF9UyHZSXu
         4hUqeBlSP0VNv48Y0UFAxkRnCLp1PeYFaWxuyhSMTKPctVFjFwuxE4MWOs+LmHqGnq6p
         PMANqR5mtwt4dSed0nwRCvhbxhEmeqB8dDa+85KNzX2AFB2jAzfzYaordWgH691UoFA5
         3K+AOhUh+VBjDNHADx/yEaOIxpdZCd9WAeB6BQGsNolE8vzZncmsgNcgNpms2wSmRdhS
         q51w==
X-Gm-Message-State: AOAM533Fr28YlRCKfqZInPtI+Aw6cQc8lvDpzF30uVGFmi7PT7FvX3bo
        BvKJs8x4vk0KQoxEEkqnj4w=
X-Google-Smtp-Source: ABdhPJz+chLVm2Ze5tyezU5Tf8gUxNBOkjRQBW2IcZ3L6uAfKNvVH+RnCK2Dixcn7cPD6IKFRCpQdg==
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr4169842otp.249.1622147022659;
        Thu, 27 May 2021 13:23:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10sm729532otp.39.2021.05.27.13.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 13:23:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <CA+HBbNGU4d4g0JrUKBhj07OsC7=s9qoubxNDi3MxPjmV457C+Q@mail.gmail.com>
 <8152a109-d76d-4f85-9da2-fe0a56c2019f@roeck-us.net>
 <CA+HBbNGBirE=Po7q5eUeHho0rBATa_ApWLiU_oPXsGN+6U9U+g@mail.gmail.com>
 <CA+HBbNGZ1axZpRy5UwQP_4eZCA32eyPJVcj6xN4i8AhOQMYeTA@mail.gmail.com>
 <493e4da4-8f2b-9856-b538-6e95e3766d5e@roeck-us.net>
 <CA+HBbNHspA5cZJSHJkLpnP+UODGy7w5i8mKP2NH9JALQ1RqQ_w@mail.gmail.com>
 <7af2d708-7e22-3970-7bf8-1cb23317cb55@roeck-us.net>
 <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
 <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net>
 <CA+HBbNHp2-a-zgUKRLUQVLcs4qcUim=_75YgVZApH1hRrAaP6w@mail.gmail.com>
 <20210527192657.GA3454023@roeck-us.net>
 <CA+HBbNHsgS_ZTf5_n0LDSv=6ztUHJ4sweWJL7=AGeR5nhu6Zrw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <66f76a3d-66ad-1f1e-17d2-5c1581327770@roeck-us.net>
Date:   Thu, 27 May 2021 13:23:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+HBbNHsgS_ZTf5_n0LDSv=6ztUHJ4sweWJL7=AGeR5nhu6Zrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 12:43 PM, Robert Marko wrote:
> On Thu, May 27, 2021 at 9:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, May 27, 2021 at 09:14:03PM +0200, Robert Marko wrote:
>>> On Thu, May 27, 2021 at 6:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 5/27/21 7:58 AM, Robert Marko wrote:
>>>> [ ... ]
>>>>
>>>>>>>>>> I tried applying the block support for mv64xx as well:
>>>>>>>>>> https://patchwork.ozlabs.org/project/linux-i2c/patch/20200118115820.9080-1-fuga@studiofuga.com/
>>>>>>>>
>>>>>>>> That patch would be needed, but it looks buggy to me. This chunk:
>>>>>>>>
>>>>>>>> +               drv_data->effective_length = data+1;
>>>>>>>> +               drv_data->bytes_left = data+1;
>>>>>>>> +               drv_data->msg->len = data+1;
>>>>>>>>
>>>>>>>> should be:
>>>>>>>>
>>>>>>>> +               drv_data->effective_length = data+1;
>>>>>>>> +               drv_data->bytes_left = data;
>>>>>>>> +               drv_data->msg->len = data+1;
>>>>>>>>
>>>>>>>> It should also make sure that 'data' is not larger than I2C_SMBUS_BLOCK_MAX,
>>>>>>>> and bail out if it isn't.
>>>>>>>
>>>>>>> Yeah, I did not check the contents, I just saw 2 reviews and tested it
>>>>>>> since it can't hurt.
>>>>>>
>>>>>> That patch doesn't work at all. Make the above change, and also change
>>>>>> the type of effective_length from u32 to int, and try again.
>>>>>
>>>>> I was just looking and it, and doing the changes you recommended make
>>>>> no difference at all.
>>>>>
>>>>
>>>> Is the i2c controller compatible with marvell,mv78230-i2c ?
>>>> The block transfers would not work in that case. Let me know
>>>> and I'll send you a patch that might fix it.
>>>
>>> Yes, the CPU is Armada 7040 and I can see that compatible is
>>> marvell,mv78230-i2c indeed.
>>>
>>> It would be great if you have the patch,
>>
>> See below.
> 
> I can confirm that this does indeed enable block reads and
> i2c_smbus_read_block_data()
> works now.
> 
> PMBUS_MFR_ID and PMBUS_MFR_MODEL are indeed populated.
> 

Excellent.

Guenter
