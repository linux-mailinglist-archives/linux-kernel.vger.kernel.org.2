Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF44072EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhIJV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIJV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:29:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2557BC061574;
        Fri, 10 Sep 2021 14:28:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso4115533otv.3;
        Fri, 10 Sep 2021 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YG4d0aep/TNMRw1KpckESI6vf67MLwQR2wy0QWQ9xXs=;
        b=Yt6MAy9qjGRokXhzTVtFUySrBahi6qUNswM4Ai7zmBfl3fA9MMDMQi0y3zMQfPxFtZ
         CaS7JF9Kr4Tt9ZFA3tp7zz3jbpQoUkk8Lfa9dKhA7hPCgcFAYT+eEZr4BCNJ6nNdik+D
         qOwieIHXFg2YsgMh1OhlnDX/wXFwnTU+64sWPx9NW9uJKYJDslUP73nEDpXuZtsdWqSQ
         st3C7sYwrBmphnH3EnqI+40kLzw2hF9mrv0fyy46V/i8jvAsw/fEgvRyATCvDJjkFZ9B
         fl7/Q1mOfMkh/iWRzJcw6VFEAwrx2Py2fTghMTLh24yYu6HKV/wrjdr7FMi1QgtwyZjv
         T+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YG4d0aep/TNMRw1KpckESI6vf67MLwQR2wy0QWQ9xXs=;
        b=U1DZOKFJKlRvZGxuNSkqVXmqdNEej2sItTC8Q/qSvMj2dxg5J3kdVur9lTHiuo2Si4
         VrbBZ/Xz/axSzZ2NeNHQTquNfSfh25es2GQY7SX5Vb2greWuUJ3zNdwGz2/wZYmIy1c7
         9d4LSnpO6xnSy20i+RpgJHRx5guHw90422kRnshSvfcoWSy9vlgZngdAYpwbdCx3JanF
         ZBuMOUcGzcmqZ5P6FChUNmU5OO+vHwUl/f/ldlA2JP/XNGIVBr5NDHx4ymRFcwhFNrjF
         LMSzLUmjHOUfmXTNE96obgPCcGDe+r+o3M/o65z7OZS60j14Ow4WD5OurRMXEsfuQaNX
         s91Q==
X-Gm-Message-State: AOAM530GRorxP7wtyBbIcC2cTDuRGJtpZoc5LF8e4CMa1hIOwlDNKU2N
        +MNlDpcIIV+3VUTi40wACmY=
X-Google-Smtp-Source: ABdhPJwtlgQ1EzbFfdB2WCs6X/FMYznXip+dyso2iEI++wARyt5EpMirfWTmjXSAtYeXsBNS9KkXsA==
X-Received: by 2002:a9d:2037:: with SMTP id n52mr6209112ota.361.1631309296325;
        Fri, 10 Sep 2021 14:28:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm1479651ooa.42.2021.09.10.14.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:28:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210910130337.2025426-1-osk@google.com>
 <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
Date:   Fri, 10 Sep 2021 14:28:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 1:44 PM, Oskar Senft wrote:
> Hi Guenter
> 
> Thanks for the quick feedback!
> 
>>> +  nuvoton,rtd-modes:
>>> +    description: |
>>> +      Select modes for the three RTDs.
>>> +
>> At the very least, "RTD" should be defined. The datasheet doesn't say explicitly,
>> but I suspect it means "Remote Temperature Diode".
> Ha, good point. As I understand, RTD means "Resistance Temperature
> Detector". But TBH, I'm not sure how that squares with Nuvoton's use
> of "LTD" for the local sensor ... sigh.
> 
>>> +      Valid values for RTD1 and RTD2 are:
>>> +        "closed",
>>> +        "current",
>>> +        "thermistor",
>>> +        "voltage"
>> I am not sure what "closed" means (the datasheet doesn't say), but I suspect it means
>> that the sensor is disabled (?). For the other modes, the translation to the standard
>> ABI is:
> Thanks for that pointer, I now found that in
> Documentation/hwmon/sysfs-interface. Given that there's no definition
> for "disabled", I guess I'll just leave that out of the device tree
> binding for now? That way we'll stay consistent with the sysfs ABI.
> 

Sure there is. A possible set of bindings - in that case for tmp421 -
is suggested with the series at
https://lore.kernel.org/linux-hwmon/cover.1631021349.git.krzysztof.adamski@nokia.com/

That specifically includes the ability to enable or disable channels
using the standard 'status' property. While that series is primarily
for the n-factor property supported by the tmp421, the same approach
can be used for [temperature] sensor properties on other chips as well.

I put [temperature] in [] because we'd need to find a means to express
if the sub-nodes are for temperature, voltage, or something else, but
I think the basic principle is sound.

Guenter

> That gives us the following mapping for sysfs / device tree -> nct7802 HW:
> 2 (3904 transistor) -> 3 (voltage)
> 3 (thermal diode) -> 1 (current)
> 4 (thermistor) -> 2 (thermistor)
> 
> I'll update the device tree binding to be an array then. I also update
> the temp_type functions to support all 3 values.
> 
> Oskar.
> 

