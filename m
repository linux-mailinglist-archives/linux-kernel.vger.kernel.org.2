Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F55439ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhJYPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhJYPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:47:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A36C061745;
        Mon, 25 Oct 2021 08:45:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so15553756otk.3;
        Mon, 25 Oct 2021 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ujlx4wfLYPueW24jpZRfY/g27GgtZ5oGMyOWeD/ycv8=;
        b=JT2Lgw4CCBCu9ImEJyxrEhlbJHDWR0WuWioDBLNs+7wPd4Maonu5I39cXhR02Xp/27
         dR8+IA5gsX8M0rNzomT8PK9afT4ZO5wk/Jn9hdzUFi+SiJYqFoBvqZLVjsunHR+uB6cN
         cDj5cO5+j5KoCcKs8dDXcC3l2Pb+gAwENgkb6KpsZmdt+X8AwsEKtMS2hhk5EuZFHDxk
         LNEgqDM5pDZ/R64KCPZHj6oI8AbHvxwcCSPsVRxtBO7hYjZxTOyaWUtG6BxZ8SCTnCIL
         QLFf4bLaE8NXJwXLUuWQs4DCoygNyiokm94zRdUSO+matPSA1Rxtd5/O9dNFti/SI7Dp
         fTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujlx4wfLYPueW24jpZRfY/g27GgtZ5oGMyOWeD/ycv8=;
        b=ldmmN7q1X33DqzxmxxI7JxAqFGcbWWEZrMN4W2mjURjVdiL9q6J5hlPIfJBIbYSo6V
         eeBYZgQ5ttgQZpUY4bK6OLaYX8r7h+e4KZ0F8rZZGiTz1vmzoidzi4zjS3l/1TW9ig+F
         V5wMAfx+cx8Y9OSqZhVKu/HssuBH4f9A6G4PGmQLr4Z4aglfMuqrOtOoVeko3Hg7kRsM
         M4h18HPcwFmbskPzvyPu0Jbj/Qlgd+ka8OQNBj2q8l6v764TGoVAVMDtI0ar1EtQ6oOX
         9H58RbQ9vJlOubSxq9AuduJGAFdqS62Cfqq1t/9NSZPQbFjXpMu3Ue/RG4DB5h7GtpOK
         DWQw==
X-Gm-Message-State: AOAM530to6a7zDFq6fLsS1LtzWxTGQwr1ohvRWI5IHBSUTsWmVa7vR9Z
        Si451Qz6FU2OljcN+Qi22K1tYNCnSBk=
X-Google-Smtp-Source: ABdhPJw6nJn6KmEHdnx/mL/gtcHolDK6i4wtFHnBmuy7Z6mL1mwK1JF7sUy9aoDYAeeZh3GrVoakQA==
X-Received: by 2002:a9d:6ada:: with SMTP id m26mr14527860otq.373.1635176731455;
        Mon, 25 Oct 2021 08:45:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb39sm3898645oib.28.2021.10.25.08.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:45:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211025025805.618566-0-nathan@nathanrossi.com>
 <20211025025805.618566-2-nathan@nathanrossi.com>
 <7297bf4c-2f8e-f217-0153-c2224a1c56b3@roeck-us.net>
 <CA+aJhH0yPZ=3LEPDm0GkWx9bLtHJ+QRbRo33HiCXM5FH6nzPFA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: Driver for Texas Instruments INA238
Message-ID: <2f5aecd2-55a1-9382-46eb-f4ff48663b30@roeck-us.net>
Date:   Mon, 25 Oct 2021 08:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+aJhH0yPZ=3LEPDm0GkWx9bLtHJ+QRbRo33HiCXM5FH6nzPFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/21 11:27 PM, Nathan Rossi wrote:
[ ... ]
>> Is there reason to believe that the shunt register value needs to be visible
>> and writeable with sysfs attributes ? This is quite unusual nowadays.
>> If so, please provide a use case.
> 
> I do not have a specific use case for being able to change the shunt
> resistor at run time. The only reason this behaviour is here is to
> mirror the api that is provided by the ina2xx driver. Since as you
> mention its unusual should I remove the write and leave the read?
> Being able to determine the resistor value is useful if manually using
> the shunt voltage. Though the shunt information could be obtained from
> the device tree node?
> 

Please drop the attribute. There is already probe noise displaying it,
and it is contained in the devicetree data. If there is a use case,
the attribute can always be added later.

[ ... ]

>> Those preinitializations make me wonder if there should be devicetree
>> properties for at least some of the data.
> 
> Yes, I did consider adding configuration for the conversion time and
> sampling average as device tree properties. The existing ina2xx driver
> handles configuring sampling average via the "update_interval" sysfs
> attribute. Our use case does not require changing these at runtime so
> did not implement the update_interval and was unsure if changes to
> device tree bindings would make sense. Should these be device tree
> properties? If yes, should the other ina drivers be updated to support
> the properties?
> 

I wasn't specifically thinking about conversion time or sampling average,
but I do think it would be desirable to be able to configure all those
values via devicetree. The datasheet says "... allows for robust operation
in a variety of noisy environments", and that is definitely a system property.
ADCRANGE should also be configurable via devicetree. The same applies to MODE,
but that would add some complexity so I am not sure if you'd want to get
into that (it would require per-channel entries in devicetree to be able
to enable/disable each channel). FWIW, you _could_ also do that with
standard sysfs attributes if you want to ({in,curr,temp}X_enable, or
hwmon_{temp,in,curr}_enable in the with_info API). That can also be added
later if needed, so there is no need to do it now if it is not required
for your use case.

As for other ina drivers - that is a different question. I would not touch
those unless you have a use case (and a means to test the code). I'd also
consider it more important to convert those drivers to use the _with_info
API before implementing any other changes. There is also the added
complexity that we already have two drivers for those other chips (see
drivers/iio/adc/ina2xx-adc.c), and I'd rather have a better API
between IIO and HWMON and drop drivers/hwmon/ina2xx.c entirely than
making changes to it.

Can you possibly send me a register dump for the INA238 ? That would
enable me to write a module test for the driver.

Thanks,
Guenter
