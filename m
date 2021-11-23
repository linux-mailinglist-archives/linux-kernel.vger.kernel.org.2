Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2349845AEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhKWWKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhKWWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:10:17 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17056C061574;
        Tue, 23 Nov 2021 14:07:08 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t19so1092292oij.1;
        Tue, 23 Nov 2021 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VKP0fGjOEYuq7Hje5dQHI5YNfCM++rNLlYokc12lVfg=;
        b=ZdLi6E2Gk+D5/Oimi5pKjbfQuVf2n4e1cBfNuMYYBxtPPozE2J4lbDY0vmhecveKb7
         DSyoBc4mexcJsfbY9nXn67478RdYc/ks4NID+1iL/hvQTAuRJWVlmCwP86G5boQMGdAY
         gCGadX9RUrD4x0CbLlAwazSRIlGEKH04MH9zbMQa/ggluG4GXGuCfUWGOioc47Frpvne
         BgEBJ0939sGLx0SQTwgfRczF3kcQF7xHC7w6uhAuZ3FFtumHALJQXcw7oAhGELBLJO0V
         qmD0hNcjJtN5RZHgAzkAlR81nABWw2KoYmq4jABMKyCZidpEd9jcNTbeLD6jU8kpQwEU
         LshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VKP0fGjOEYuq7Hje5dQHI5YNfCM++rNLlYokc12lVfg=;
        b=LhtwJ/RxlcrJ4wuj0WxzZrbBzLeCmYRWmHWgam6jKvXdYljhEbdOqVN88ey9BXIUoH
         r2nwCzEc/9wWuE3Ny4nQF0q6Hl6PV0S1P18AgR5sSmSlV2++VI7GVSz7O5DxWumhwb/v
         iwLdzsOh34Q+6XIftQvfa6ad8fibs65NoZhRfEVMNLco+F6xh/6qzZ06MP2PJJ1oiGDN
         VqHK+zbyyef9Tl6ynN+FNJE+641eJBLJHB2y7GipB+mydLUgkLx/wCOynitq3VtC2osA
         08ZqhP+Pergq0OIZA+X+9BfGA+xxps5Tf6t/oIy/0zs5ItN1T2dTZUq0e46/GFZ8ddPT
         FAOw==
X-Gm-Message-State: AOAM531Kzqre/azaIrlY3TPxFZAL0EjnOIxwrFJ10sxguEdVRYfSbN+4
        GNZ5Zqnw10oObgouB5tNlvLENcRWu+s=
X-Google-Smtp-Source: ABdhPJwMQRWKnsudaG3LXYKW2n7nxswGAHBC2jRu8KaThdMBOB+cgGDXON/ioPsqaIc56NabU7txdA==
X-Received: by 2002:aca:1b15:: with SMTP id b21mr771592oib.64.1637705228086;
        Tue, 23 Nov 2021 14:07:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a3sm2375143oti.29.2021.11.23.14.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 14:07:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
 <937b305c-c61d-e754-c86f-7019b57dd737@roeck-us.net>
 <6e22cf38-39b6-6cd4-1435-c9a9f2e50230@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: (k10temp) Move the CCD limit info inside
 k10temp_data structure
Message-ID: <b5741cbd-f94b-a405-72c3-699338d6a232@roeck-us.net>
Date:   Tue, 23 Nov 2021 14:07:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6e22cf38-39b6-6cd4-1435-c9a9f2e50230@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 1:52 PM, Moger, Babu wrote:
> 
> 
> On 11/23/2021 3:40 PM, Guenter Roeck wrote:
>> On 11/23/21 1:16 PM, Babu Moger wrote:
>>> It seems appropriate to move the CCD specific information inside the
>>> k10temp_data structure.
>>>
>>
>> Why ? I don't see it used outside k10temp_get_ccd_support().
> 
> Thought it will be cleaner to have it all together at one structure. If
> you feel otherwise I can remove it.

I don't see the point of having a value in a data structure that isn't
used anywhere outside probing but nevertheless lives forever.

I also don't see how it is "cleaner" to assign a value to a variable
in a data structure only to dereference it in a single called function,
when it can be just as easily be passed as argument to that function.
I would call that just the opposite, since it creates the impression
that the variable is needed outside probing when that is not the case.

Guenter
