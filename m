Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2DC409F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhIMVtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhIMVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:49:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AAC061574;
        Mon, 13 Sep 2021 14:47:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso15360336otr.13;
        Mon, 13 Sep 2021 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apTSDtkf3xCJPT5XjaVAYt+yiVOcF3dCZdaHoCu6xjk=;
        b=BLDydiUfWTZWTyUAccxGFsICvHQM1xJWNLDXb/8gWXJ7/5nkE7kh2xKap0gy3hZqdE
         4ypfb6vZEsmd7+FP37VKDLkyju+sLJHOcVGjgUVdnNk6Kw/TTGuUjGgzxyigsW9efJ5P
         AC888P+yisjGKkcLpbFEthhB5pOleXWSEJ06xCdAN3C7MTVg5Rd36X6t4aRERe8vm9/p
         WsoGAP/d3W7cxr+sOSuxi6mbz0E/Yq6OJPsYG+isoU9yFvv1YzniPQS6bn8kkwsjFzAR
         gSriVZGeIJv8nhgmD7iZyk6+HiEVUU0l7syk1dmQaaC+ZOJLpYgHUvs2XiKC4e5fHCQ5
         WPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apTSDtkf3xCJPT5XjaVAYt+yiVOcF3dCZdaHoCu6xjk=;
        b=71Bnea4Mq6fwRID47AO3J4nfmNancrWO0b0T2o0zos/OVscj/bN30WS8dhHstOKEQF
         4pyZjF8pJpT4Mly66jZDYRkYl+SO1lLepI1FKiUVgVk5DoCZ4uYukQtKY/mXUQhUVib0
         BCrsqBXD4o0ardZ+SaLRyT3UzOQHoCdctWdf3O0FENaaKiZWiqqPL45uVnIBxPnNe3wa
         J5QK0ozc/QW18Ck/+6FJV52mGGunwCsHtFjf0WFmCdqtyM76CG7pGDDrVt9msnv9d6Qw
         khu+OWSE5+XTdPAU0Yn1WBaOMxfZBwiqhqNh1nbGfXnOXgd5pdXI8DBw862XEW/UHA5H
         yqRQ==
X-Gm-Message-State: AOAM531WG3k61g2Yx2OrhwmlFgOTe1v2rDKm9UIuFHQu1Y3Vak+g2/h/
        2c/GNz84G1BRAMvqdhMPe+y/KJnv7y4=
X-Google-Smtp-Source: ABdhPJw7eEEIwThqq3t25FP9w1+u3+z9BXC+cnh6yxP/BqL5Vl+1MMxDaHP6ILqgJSBGUVrscRaGvg==
X-Received: by 2002:a9d:468d:: with SMTP id z13mr11714784ote.31.1631569676082;
        Mon, 13 Sep 2021 14:47:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2sm2179892ook.46.2021.09.13.14.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 14:47:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 1/2] hwmon: (nct6775) Use sio_data in superio_*().
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210912214716.GA2362393@roeck-us.net>
 <20210913235847.0935af08@penguin.lxd>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f5651d03-f3ca-e5f9-244c-e4c584d26dc8@roeck-us.net>
Date:   Mon, 13 Sep 2021 14:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913235847.0935af08@penguin.lxd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 1:58 PM, Denis Pauk wrote:
[ ... ]
>>>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>>> +	if (!res)
>>> +		return -EBUSY;
>>> +
>>
>> The probe function is triggerered from the init function,
>> which always sets the resource. Please provide evidence explaining
>> why this added check is needed.
> 
> Nothing special, because platform_get_resource can return error I have
> added check for result. It can be dropped from patch.
> Should I remove it?
>   

Yes: It is unrelated. If needed (ie if a path is shown where platform_get_resource()
returns NULL), it should be a separate patch. Note though that -EBUSY is wrong
either case: The function only returns NULL if it doesn't find the resource.
That is not a "busy" situation.

Thanks,
Guenter
