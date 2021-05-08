Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3283770FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhEHJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhEHJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620466911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8g0FbMtPR9vOJqczBJQph07+IiVAO0G06d1hPFLBp4=;
        b=aWjbNej+VqLqgzzosPNbISMsucXibFXK7gDzuWPEc0t4TojY5LRJ2bwBpzW11zZ7q73AGn
        CIwnTN2ziT2kTq1qZtEUgBUZK4uELkg7qmPs9+8RxUpSS7LIKSzr5CFdvgrlkeNedO+Fum
        u4KumnA3rUJNgWNactnb68KMUmsHvHg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-t5vemS4_O7GqLa2RwdjNMA-1; Sat, 08 May 2021 05:41:48 -0400
X-MC-Unique: t5vemS4_O7GqLa2RwdjNMA-1
Received: by mail-ed1-f71.google.com with SMTP id u30-20020a50a41e0000b0290385504d6e4eso5879713edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 02:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8g0FbMtPR9vOJqczBJQph07+IiVAO0G06d1hPFLBp4=;
        b=itE1zZeO17ncVCXEJhi4IRHWT48T7D6umd0O+EqL9F439pUP42F9sqAKeoX7Ow3a9v
         nyM5zujxzIyiJK2BWz7/UQ5W/cJMqJ76QEoUI9Vl/GXUU/mfYnN+B6RSBeEpjP2z7DKa
         FK0sseDOB+H+FH2cfkfQSQU/jvuknkLVZY7PaTnVivovCp9U3ba4CgWdiRD5rOrsKjYL
         z57Hc+oxbMTtsHoXOQlgjidZa4tNnGfijwpP2z/5EG/aAIfsO3XrDSG1kvK1l31/VfjQ
         M2htcFu1wyqhNsfCnQWXr6gQ6/7L6jIbS1qVmnizpXOVhoDeTlZM5g4Rn4JtmI2ne0ki
         Zjlw==
X-Gm-Message-State: AOAM531XQHu6r5ACQIff+mVaU9MeMKl8F2rik3tKZXOdfnuNe07NLbvJ
        f9RPoSuP4HE6AI9Do70CJSrrG7itX5Prw2FBbp4RTA890wkR/26QSIweXD5ZsrJCtLKCyKOQn9u
        SpnpPCn37lHqrt+4l0RB0Rq5T
X-Received: by 2002:a17:906:80d6:: with SMTP id a22mr14495186ejx.159.1620466907125;
        Sat, 08 May 2021 02:41:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxri80XuBnxGDuVafu5UlMWlY6ndqQ/BrRSzL1WJ1RXqM0/pLeNgvGYwaJJ07V1m729A99mKw==
X-Received: by 2002:a17:906:80d6:: with SMTP id a22mr14495176ejx.159.1620466906968;
        Sat, 08 May 2021 02:41:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q10sm6026768eds.36.2021.05.08.02.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 02:41:46 -0700 (PDT)
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <20210507103154.00006763@Huawei.com> <20210508030936.GA3879276@roeck-us.net>
 <CAHp75Vfa3GT9bnimxw7EJsJyRF8HZP3PGsUNikSScuNiU4qArg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <294dacb7-aef3-ede0-e46d-5c8fd91e9c17@redhat.com>
Date:   Sat, 8 May 2021 11:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfa3GT9bnimxw7EJsJyRF8HZP3PGsUNikSScuNiU4qArg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/21 9:48 AM, Andy Shevchenko wrote:
> 
> 
> On Saturday, May 8, 2021, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
> 
>     On Fri, May 07, 2021 at 10:31:54AM +0100, Jonathan Cameron wrote:
>     > On Wed,  5 May 2021 20:43:32 -0700
>     > Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>     >
>     > > With CONFIG_ACPI=n and -Werror, 0-day reports:
>     > >
>     > > drivers/iio/chemical/bme680_i2c.c:46:36: error:
>     > >     'bme680_acpi_match' defined but not used
>     > >
>     > > Apparently BME0680 is not a valid ACPI ID. Remove it and with it
>     > > ACPI support from the bme680_i2c driver.
>     > >
>     > > Reported-by: kernel test robot <lkp@intel.com <mailto:lkp@intel.com>>
>     > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com <mailto:andy.shevchenko@gmail.com>>
>     > > Cc: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
>     > > Signed-off-by: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>     >
>     > A note for these is that I'll change the patch titles when applying.
>     > We aren't removing ACPI support from the drivers, we are simply
>     > removing the ACPI ID table entries.  For most of these PRP0001 magic
>     > will work just fine with the OF table.  That's probably the
>     > right way for small companies etc to use these in products without
>     > having to jump through the hoops of getting an ACPI ID.
>     >
> 
>     Below is what Coccinelle tells me about ACPI IDs in drivers/iio.
>     The script (tries) to do a prefix match of all ACPI IDs it finds against
>     the PNP and ACPI ID databases from https://uefi.org/PNP_ACPI_Registry <https://uefi.org/PNP_ACPI_Registry>.
> 
>     Andy, Hans, does that look about right ?
> 
> 
> 
> The result looks nice for the first step!
>  
> 
> 
>     Next question is what to do with the mismatches and with false
>     negatives such as:
> 
>     drivers/iio/accel/stk8312.c
>       STK8312: match (prefix) against STK (SANTAK CORP.)
>     drivers/iio/light/isl29018.c
>       ISL29018: match (prefix) against ISL (Isolation Systems)
>       ISL29023: match (prefix) against ISL (Isolation Systems)
>       ISL29035: match (prefix) against ISL (Isolation Systems)
>     drivers/iio/gyro/bmg160_i2c.c
> 
> 
>  
> 
>       BMI055B: match (prefix) against BMI (Benson Medical Instruments Company)
>       BMI088B: match (prefix) against BMI (Benson Medical Instruments Company)
> 
> 
> These I think the real ones from the existing devices.

No that is wrong, these are Bosch sensors, so the BOSC0200 entry for
the companion accelerometer is the only entry using the official company
prefix. At least "BMA" ("BMA250E") and "BSG" ("BSG1160", "BSG2150") are
also know to be used as prefixes for ACPI HIDs which are in active
use for Bosch sensors :|

And Benson Medical Instruments Company has nothing to do with these
sensors :|

Regards,

Hans

