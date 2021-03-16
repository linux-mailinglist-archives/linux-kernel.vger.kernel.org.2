Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E433CCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCPEvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhCPEub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:50:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A6C06174A;
        Mon, 15 Mar 2021 21:50:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w125so8315524oib.13;
        Mon, 15 Mar 2021 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7aZXmupN+jRlLlTHvxpFyGrHuGdrFwnOVcxm2OfwVA=;
        b=n+rqU6vkNR3A3aJXKCkyio8CRh8YS5Tc7WWeG3sGK9790kWhltZllXELGPW9GkGZLe
         gW2L0q0wcg7NGc4mfB1ie9Jg+XwXaGT+64JM+UndwPo3XDB2PPuZti5wNhtkN7Bm9ZB/
         cg9VMi41AKMb4/a1J/KowADfYrHPGDX0AsPsQAkGOOIQENNviwqYGakD1zxOaPCBMvj7
         uBydBzWS6eJtSVP35Mi5ACRPc4Us7XdhiiUzqaME5uaW96HeraqFbjJt+g1aYPKazzbs
         4oQX7HAus/b0AjA2YXGmrobvBt+ic1SQY7ru4oqMvBcANF9+C3WRNj9P6T7ukx0DQQQw
         Anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F7aZXmupN+jRlLlTHvxpFyGrHuGdrFwnOVcxm2OfwVA=;
        b=t5+heyDoonaS/6Q8PcOLv8a7AfwBMftWUY/R9DqIXXedb4/HPxqI/BZgh7Nkgwf78H
         rFGmDTTfvxX4x+Y/rkQNUHjTI9tucjKi1OurpRBWA+jCaM29GT8kE0FXjGhaCBCnLYWT
         dH3hRNF/bqauHlgcRQKTNjXPfRJTkpdrE6JdQM4gYgkMDPuF66hefGE+tacv2VF5IDSX
         K/bBg0GRUrara+Phnzq9jQgiL0iiOYER33DBHx1VSPPEynHsdZMO9exkRz/rPo+dmUW7
         89SxA2+2YQUnteeYRLGmk5hgh8flqrtM0tyv51k6YsUZSs51Q+w+61B3n6M4yR/DcLsd
         MsbA==
X-Gm-Message-State: AOAM530hFG13ZiSWnOF7TYhyPdVx3fpBdnQVHKq9xQiXULSe7BJIQ9ee
        eroHTAmFKEFNWXWo6KNrrMDIOHFlTcg=
X-Google-Smtp-Source: ABdhPJx1t7fxE/iVR4QlVQNarK0SefebiFe73cNS8hE/XH5hgxiUaZot8hY7U2QLBHjzYg+SwSVmjw==
X-Received: by 2002:aca:fd13:: with SMTP id b19mr2019491oii.139.1615870230071;
        Mon, 15 Mar 2021 21:50:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2sm7405532ool.18.2021.03.15.21.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 21:50:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for BluTek BPA-RS600
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210316023524.12574-1-chris.packham@alliedtelesis.co.nz>
 <20210316023524.12574-2-chris.packham@alliedtelesis.co.nz>
 <46a69700-ae1f-a441-2399-0e8c8e2a588d@roeck-us.net>
 <ea648b3d-f6ac-d7ec-fc5b-2b15c827c3dc@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dff0a92c-a888-2b96-a51c-c5efb3e977af@roeck-us.net>
Date:   Mon, 15 Mar 2021 21:50:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ea648b3d-f6ac-d7ec-fc5b-2b15c827c3dc@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 9:21 PM, Chris Packham wrote:
> 
> On 16/03/21 4:43 pm, Guenter Roeck wrote:
>> On 3/15/21 7:35 PM, Chris Packham wrote:
>>> The BPA-RS600 is a compact 600W AC to DC removable power supply module.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
> <snip>
>>> +
>>> +static int bpa_rs600_read_word_data(struct i2c_client *client, int page,
>>> +		int phase, int reg)+{
>>> +	int ret;
>>> +
>>> +	if (page > 0)
>>> +		return -ENXIO;
>>> +
>>> +	switch (reg) {
>>> +	case PMBUS_VIN_UV_FAULT_LIMIT:
>>> +	case PMBUS_VIN_OV_FAULT_LIMIT:
>>> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
>>> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
>>> +		ret = -ENXIO;
>> Is that needed ? Why not -ENODATA ?
> 
> Basically these commands get responses on the bus but they don't have 
> valid data (nor are they documented in the datasheet). I'll add a 
> comment to that effect.
> 
> If I'm reading things correctly -ENODATA is a signal to 
> _pmbus_read_word_data use the "normal" read operation. So I need to 

Correct.

> return something other than that. I found another driver (mp2975.c) 
> doing the same thing for what I assume are similar reasons so I went 
> with -ENXIO.
> 
-ENXIO is ok, but please document it.

Thanks,
Guenter
