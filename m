Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983B934239C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:46:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE5C06174A;
        Fri, 19 Mar 2021 10:46:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z15so5609941oic.8;
        Fri, 19 Mar 2021 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YakdWIu64kDD/ZVtQtDeaVyuSwu5hpVOGVrs/1fRWa0=;
        b=bhsZCm5RfKc96EIVn99epEivo2nuktWHpEaIfjiX/fRw8xuCz5s3RQCuopJ+tiTomZ
         yC6GyeQ2zMZ1WLfBgHC1+JAxYSwrA+cklHIhkb5uEC4gOSmLRsP08cDQRd+E0qAPq3VS
         X1bNQ7Iw3erCGxIhg41SCl6a+69DP/VxJyVICwRcc4oICTYxUeYcy9M+y+u/ywNSjI34
         X5JUntMbWMcAJ6foAoD1H1gmKFk204JWYxyEV0hgk4QJJEHvjxJvm+p2DLGT2Vyjh8gF
         oDzh0U+NObgNb//kpPWGTckIwM6TbBm0kIhEgDpDhBlFlzoYGdrMVoFJqeRO/SUnefbO
         KPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YakdWIu64kDD/ZVtQtDeaVyuSwu5hpVOGVrs/1fRWa0=;
        b=qj7Wy54aLFoI1mFdl+AcXhbhqXogq+TA+EwiVfLdOa70GLYQ/js0P9ypdc1SlaRrVo
         rYo4E9x+6oxwfVgUHB+jMOOcPOfgJcTTTNbHKbAetUXSxOACFkbsB6JMv8Mo9zUzguju
         9DT8bvsxuOFyVCMS3ZgyWupwfbwPg4jF9Id5rZSCmpbMzt657h+pJpzdMI2/tehAQ/BD
         so8Kw7fWe9s87vS0nuQo1U6rBmEJW59pZFCgQ9/OFSEzjhv5ulVIbWCuQRW+ER8aHkJJ
         YfdrWskdKyYKZUqkVjCw70Fn25yKEr6A428WTwPQOca7BAtmk85NQwx5Yn37CdXg/hMZ
         4dpQ==
X-Gm-Message-State: AOAM532iv25aT3zwUdMmdLV5hDM4IAfUXdvTc1JxEZ+Pj2UwNd0Lw7d6
        6ClbhpocRGl+WNHKPr+THjapKG8yKmI=
X-Google-Smtp-Source: ABdhPJywsEayGuw3Zzno54b37Mzr5O6agNyN79RmZxh/77uoXGtHZpbTaE4BRxGX/smJiqcAfJE2ig==
X-Received: by 2002:aca:ea8a:: with SMTP id i132mr1803228oih.68.1616175999294;
        Fri, 19 Mar 2021 10:46:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e62sm1268546otb.74.2021.03.19.10.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:46:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4] hwmon: corsair-psu: add support for critical values
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YFNg6vGk3sQmyqgB@monster.powergraphx.local>
 <20210318190150.GA152326@roeck-us.net>
 <20210319095805.378b7e0e@monster.powergraphx.local>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e38779c5-900b-6d04-98c6-2e501a9fd3c5@roeck-us.net>
Date:   Fri, 19 Mar 2021 10:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319095805.378b7e0e@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 1:58 AM, Wilken Gottwalt wrote:
> On Thu, 18 Mar 2021 12:01:50 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Thu, Mar 18, 2021 at 03:17:14PM +0100, Wilken Gottwalt wrote:
>>> Adds support for reading the critical values of the temperature sensors
>>> and the rail sensors (voltage and current) once and caches them. Updates
>>> the naming of the constants following a more clear scheme. Also updates
>>> the documentation and fixes some typos. Updates is_visible and ops_read
>>> functions to be more readable.
>>>
>>> The new sensors output of a Corsair HX850i will look like this:
>>> corsairpsu-hid-3-1
>>> Adapter: HID adapter
>>> v_in:        230.00 V
>>> v_out +12v:   12.14 V  (crit min =  +8.41 V, crit max = +15.59 V)
>>> v_out +5v:     5.03 V  (crit min =  +3.50 V, crit max =  +6.50 V)
>>> v_out +3.3v:   3.30 V  (crit min =  +2.31 V, crit max =  +4.30 V)
>>> psu fan:        0 RPM
>>> vrm temp:     +46.2°C  (crit = +70.0°C)
>>> case temp:    +39.8°C  (crit = +70.0°C)
>>> power total: 152.00 W
>>> power +12v:  108.00 W
>>> power +5v:    41.00 W
>>> power +3.3v:   5.00 W
>>> curr +12v:     9.00 A  (crit max = +85.00 A)
>>> curr +5v:      8.31 A  (crit max = +40.00 A)
>>> curr +3.3v:    1.62 A  (crit max = +40.00 A)
>>>
>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>
>> Applied.
> 
> Thank very much. Hmm, I actually could calculate the in_curr value from total
> power and the ac input as a replacement if the value can not be read. What do
> you think?
> 

No, we better leave that up to userspace. While one might argue that it makes sense
here, unfortunately others will use it as argument to calculate other values not
provided by chips in the kernel (eg power if only voltage and current are supported).
I'd rather not create a precedence.

Guenter
