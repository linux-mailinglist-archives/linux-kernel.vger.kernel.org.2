Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7634CE51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhC2Kzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhC2KzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617015303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKCyskMlsmbTpkY4SXTZWdPC7qqwWfpAUhexnJWGoa8=;
        b=V6qp6R9GoIHhjq6ARee7xZ51P8HrAxeFikLghNln6sO6qUDgLy5IUw6HrmMr8Ajp/Xl2Js
        ubSCDFVwEcMlO5FpDscNrEHkyKzI2SMpad8xMjHYMi4aGQJKqyWeIeghDstEn5QpS5LMU+
        xRs42Zsq41/FvO+QjOBsQb1K7tjzqXE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-EHsp0TJ0McSU0rUiY1mLFg-1; Mon, 29 Mar 2021 06:55:01 -0400
X-MC-Unique: EHsp0TJ0McSU0rUiY1mLFg-1
Received: by mail-ed1-f70.google.com with SMTP id h2so8377333edw.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKCyskMlsmbTpkY4SXTZWdPC7qqwWfpAUhexnJWGoa8=;
        b=M9ZN1+EEq2e5yYQdDDXGeVS2edo9pqykJQAn3gVbaZHRNWf3dQEZwtCdIG+hlNO+CG
         qmcHP/IAkChwkyx/rbMJrg8Yx61mUpb6vQnx0zJuRlPIrZpDk29aCuEcGO5JT7I8PRvf
         eMiOs4NYMVNIVrNkrNzZ97kic1v1eB0VlpgV50tMdyvQ33hwCnI1RgEdVfEqIIjXUEkP
         BIlwfi7vW2z8ihYk3oai0OnI0t5lJuFdCbPZRzbNkE5OPqqkie/YUfAx6XyLWQltE1f/
         r+pVAlrQ3VioeqjIMJo5+NZB6/78dCTkPgSw/zT12FmkGNABn8JBbIvQn5KF1+fa5F7K
         20PQ==
X-Gm-Message-State: AOAM530Zwajc9H0SnKEYV57jSQ5QbrZECX1ixDhr77THuf+dIrxLFdOe
        CsuTY+QGYCjzSQHe7OHxSUNCF/6A9+YDrdSSqE7//tYqHRhlqzZtlq/UuwtcQ0THdV+5svxx6wU
        60Q9afCFwT+huqokThgXSh6sjHniviboFEk1Aa3EOwg59XP8wPiVZnbQM50EK6ljBR1RSS/VvZe
        N0
X-Received: by 2002:a17:906:2551:: with SMTP id j17mr27804810ejb.441.1617015299949;
        Mon, 29 Mar 2021 03:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLDVKlU1nE06MXPNjUU2FEhoX53rqvBwZJt1V7jycBPhjJUAbo6I+QExzDCiEi1TQTlvLv3Q==
X-Received: by 2002:a17:906:2551:: with SMTP id j17mr27804792ejb.441.1617015299807;
        Mon, 29 Mar 2021 03:54:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hd37sm7827305ejc.114.2021.03.29.03.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 03:54:59 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: da280: Drop unnecessarily used braces
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210328180124.8762-1-dmugil2000@gmail.com>
 <CAHp75Vdv4zAsn_v1TaUcYgY_PpQrfhfGNsc8=QTbPY=oFN_xbA@mail.gmail.com>
 <CAHp75VdS=Px4MdhA5mzzqaQEsMs3ur76m+tYb1inVqBFfu_CRA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <57e6f6b4-8c8d-3039-a1fc-a8774110678d@redhat.com>
Date:   Mon, 29 Mar 2021 12:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdS=Px4MdhA5mzzqaQEsMs3ur76m+tYb1inVqBFfu_CRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/21 12:52 PM, Andy Shevchenko wrote:
> +Cc: Hans (just for your opinion)
> 
> On Sun, Mar 28, 2021 at 10:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Sunday, March 28, 2021, Mugilraj Dhavachelvan <dmugil2000@gmail.com> wrote:
>>>
>>> As per linux kernel coding style braces are not needed for single
>>> statement.
>>> Checkpatch
>>> warning: braces {} are not necessary for any arm of this statement
>>> 128: FILE: drivers/iio/accel/da280.c:128:
>>>
>>
>> While it’s the correct patch, I would rather recommend making the driver non-ACPI centric. I.e.:
>> - replace that custom function by device_get_match_data() call
>>
>> - replace that condition by something like
>> type = device_get_match_data();
>>
>> - drop ACPI_PTR()
>>
>> - replace acpi.h by mod_devicetable.h and property.h
>>
>> - convert to use ->probe_new()
>>
>>
>>  Everything, except the last one is in one patch, the last one is another patch.

I agree that *carefully* converting to driver to device_get_match_data() would be good.

Regards,

Hans


>>
>>
>>
>>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
>>> ---
>>>  drivers/iio/accel/da280.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
>>> index 227bea2d738b..31f290ae4386 100644
>>> --- a/drivers/iio/accel/da280.c
>>> +++ b/drivers/iio/accel/da280.c
>>> @@ -125,11 +125,10 @@ static int da280_probe(struct i2c_client *client,
>>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>>         indio_dev->channels = da280_channels;
>>>
>>> -       if (ACPI_HANDLE(&client->dev)) {
>>> +       if (ACPI_HANDLE(&client->dev))
>>>                 chip = da280_match_acpi_device(&client->dev);
>>> -       } else {
>>> +       else
>>>                 chip = id->driver_data;
>>> -       }
>>>
>>>         if (chip == da226) {
>>>                 indio_dev->name = "da226";
> 

