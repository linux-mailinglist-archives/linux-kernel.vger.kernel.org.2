Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C538AE75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhETMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbhETMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:38:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8AC03CCC3;
        Thu, 20 May 2021 04:50:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h24so1080565qtm.12;
        Thu, 20 May 2021 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIpAeHQj1489Aib8qHXvSwda7NmAe2Giti3bFOAd6iA=;
        b=nQWEwNuMMp0jbs8ldsiaASBDCAoiuHTVC2ChzIjwn4shXs2FM2WHU8EpGDx95OqNkK
         rYEXOfnLLjfjXuKrMUZjwCccJM2JQENjDrCeRVBMq4BoH6uOQjtMI/yZcwRb1YNNzo2c
         FBYbZOxymiaNyncJbeO/gr+5hQvi61bvfD9d5Egn7eKXsTmxGo9RKDTHoyV/3h3fn8F8
         S5/ygqfS4YwMI8M7NXZKHbDQY0/sbzQGihBwBCG6IdOKaos2SN+g0LH4h/Ekk8CWVDet
         5vdHdVz5pwWZH3qCUwoWFnWJdu2VpT0aSKTg7G0+iO8c2yYwKvCjlUaiC1RAmHFGPN4T
         n5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIpAeHQj1489Aib8qHXvSwda7NmAe2Giti3bFOAd6iA=;
        b=IjjVyHo2pfEXFIYl0OdczjbeB2qbl8sIFeD12nUdg0F0u6CRTO6eJAH6J7ukpOuO7S
         6RDY8EqfKjEqASV/NV20ZJsXyFeQ8PVSgsPuJ7AFD2rFTQN+ObzlM1wASx6zN342VBtg
         mqAPtL2b5NR8zrzabgh6P+eUS6BBjGWxbvUxDU8rVm/gmP1YbBlCQXkEJ5KZCM/3f4QH
         i0uJAVMV4OEe0ZkQS0IjvXgGxtN4vPyWHBmIIJ/RH+YzQQk8rWhWRXAKaY0xDYPAPoZB
         02I0JVxiJV95Tw97LXMsJlb1pZszt7uh7n+EGa1bn++Y0ODgTWidI48vw5/SjO5vkcjg
         OksQ==
X-Gm-Message-State: AOAM533uodDfEMC3SeL1sOH49l6q00gki2hH7pUPBjCQY82dOw5bVR6M
        IiO/wFyRZ1GL+Ina8rBTrG452U7XrVI=
X-Google-Smtp-Source: ABdhPJyT9gkogVw4a49O7WKLOm56N0u+cp7go/2KFXTehjZlUUa+WB9mrpZwbtZC1xQev9IbvkeVMQ==
X-Received: by 2002:a05:622a:40f:: with SMTP id n15mr4725837qtx.10.1621511445490;
        Thu, 20 May 2021 04:50:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11sm1590036qtq.93.2021.05.20.04.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 04:50:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat@cesnet.cz>,
        =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210518211609.GA3532746@roeck-us.net>
 <6f256c72-df4d-4f9a-ba5f-eabfd9f2365f@cesnet.cz>
 <76619e11-3999-1e89-de93-fb5942970844@roeck-us.net>
 <9bbdc7a7-f34d-4e3a-8e64-c20810456d11@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Message-ID: <f91af3c7-5173-ca65-7846-bbeaf69eac71@roeck-us.net>
Date:   Thu, 20 May 2021 04:50:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9bbdc7a7-f34d-4e3a-8e64-c20810456d11@cesnet.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 4:29 AM, Jan Kundrát wrote:
>> As for fan[7-12]_enable, I don't even know if those can be enabled
>> separately. I see two options: Drop those attributes entirely (
>> assuming that those fan inputs are always enabled if the associated
>> pins are configured as inputs), or align them with fan[1-6]_enable.
> 
> I think we need to decide first who provides the initial configuration for this chip. There's always at least six TACH inputs, and then there's six more pins where each can be either a PWM output or a TACH input. Who decides that? Is the kernel supposed to export six knobs to the userspace? So far, I've assumed that this should be driven via sysfs. But perhaps you would you like to rely on the FW (?) to set this up properly? (On our board, that would be a few random calls to `i2cset` from a U-Boot boot script. Not pretty, but doable. Just one more place to keep track of.)
> 

It has to be done by firmware or with devicetree properties.
It can not be done with sysfs attributes.

> It's proabably "tricky" to do this at runtime -- and I don't expect to see many boards where you have such a big freedom of reconnecting the actual fans once manufactured, anyway. So, either some DT parameters, or an autodetection based on whatever is in the registers at power up, which would make an explicit assumption that "something" has set up the nPWM/TACH bits properly in the Fan Configuration Register. OK, that might work, but the kernel must not ever reset that chip afterwards.
> 
> There's also the Fan Fault Mask register, which controls which fans propagate their failures to the nFAN_FAIL output pin. This one requires a semi-independent control than the nPWM/TACH bit above. It's feasible that not all TACH inputs have an actual fan connected, and this can well vary between products. For example, ours has just four fan connectors, so we don't want "failures" of fans 5 and 6 to assert the nFAN_FAIL pin. Also, there should be a check which prevents unmasking these failures for those TACH channels which are configured as PWM outputs. Or we can once again ignore this one and rely on the FW.
> 

Power-up default is that all faults are masked. If that is not the case,
some entity must have unmasked some bits. Assuming that is the case, we
can as well assume that the same entity is able to configure bit 0
of the configuration register as needed.

> The current kernel code in max31790_read_fan() reads beyond the end of data->fan_dynamics, hitting the content of `fault_status` or `tach` fields instead, and therefore returning garbage. Not a big deal, just a missing % operator I guess, but to me, that's a pretty strong suggestion that nobody has used or even tested monitoring more than six fans on this chip, ever. (And yeah, the datasheet is not clear on how it's supposed to work anyway. Using a modulo is just a guess.)
> 

Probably it has not been tested, but that is not an argument for removal.

> Neither Vaclav nor me have any way of testing this feature -- hence my proposal to only improve what we need, and ignore TACH channels 7-12. But I guess it's not OK from your point of view?
> 

No, that is not acceptable.

FWIW, the evaluation board, including shipping, cost about $130 at Mouser.
I should get it no late than early next week. Arguing about it was more
expensive (in terms of time spent) than just buying it. Once I have the
board and had a chance to test the code I'll submit a set of changes
to fix all the problems I have found so far using module test code and
code inspection.

- Fix fan speed reporting for fan7..12
- Report correct current pwm duty cycles
- Fix pwmX_enable attributes

Guenter
