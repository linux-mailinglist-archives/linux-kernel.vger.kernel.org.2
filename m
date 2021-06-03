Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A266399C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFCIFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:05:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 01:03:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t16-20020a05600c1990b02901a0d45ff03aso1754974wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGTUuUf++uwHiEUpZfhT2pKcEjTOJkErHvQn5crRwjM=;
        b=S5e16vNu62dzer1qQ3cJcSDC0M//nivFeGLBGF4KnfmA/NrqjSG8gSUfV7xSCLlUCA
         xvPSUZVfrnBjRcbux0UqhZ+Zbeu3q4H9/WvcR9EpykcVHKDcwWw+Q8Uu1ha91QpygkwM
         SMB931+6LfQD45yAQO2gigT0f1O/EB+irUAYXB7xLdNk/JlgyAzjY1EmkdBSPUbtSB57
         yRBAnNSC9WAEYBMDoGsTvHLypmyytKFzNXES2qc0Lm6Q9fj2spfOmPKsT8e1M+852jTU
         UnsoF1rqZpwNrYFW9JNwmBzIVTq0PukwUGGKSuDiyQJWGVrxrOS3qjSVPuEqbSYAbO6+
         8o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGTUuUf++uwHiEUpZfhT2pKcEjTOJkErHvQn5crRwjM=;
        b=V5RZL4j/oZyACuSDB5GClI1xaW3ADUZI6F9Ti6qN6je8CM939sMVVoC084mY5Pg/cF
         +oU8cGIUsxp3KE4KBImxIIHmHDD/vlOWwM7URO6ii3+IyelhEPnbb2bV3lwCQMI9B2Ai
         RTftYYuvV6OtNemRpdcZ18PQVndb/WnE/OttNq+WnDi+7VNqr2kCnoDOC6AXMslsiuhz
         ZvRXSBsajxWHvXJzwOU1BHi9/Njo2nnvv1XJJeBcNUOpFSmvXLBLwNklpxk8QzsVrxkZ
         x5uj6nv2DyXbOTo+2EWRLR+NbfTVuuvkWGyP0RUpAhMoIRsOoXo22BzuLQWSUdBQW8BY
         5rSA==
X-Gm-Message-State: AOAM532g0W2IQdO1g9x/gfP2smwkHt23LntlSkx+6JkNc/AR+nYRmEO3
        Lc5KEbkqzzSqW9yw4qtaiZSnPQ==
X-Google-Smtp-Source: ABdhPJxkpZubE33cVuHKuAxAAy/Tp7QqD1UrHyJjxrReWhZ3BOInha8oib7kcBJJs+ySvan+sAD8xg==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr18421968wmk.181.1622707397928;
        Thu, 03 Jun 2021 01:03:17 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m65sm1975644wmm.19.2021.06.03.01.03.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 01:03:17 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] nvmem: bootcount: add bootcount driver
To:     Nandor Han <nandor.han@vaisala.com>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>,
        Tomas Melin <tomas.melin@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
 <43e36704e9acbf89b3b29113554d3a79417d42db.1620211180.git.nandor.han@vaisala.com>
 <b973f433-5aa6-5c93-4d60-1017495ae0a7@linaro.org>
 <a456396b-3950-7bd2-8f5c-af2699276f82@vaisala.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <78af96b3-b07b-342b-edf2-c898c31e956e@linaro.org>
Date:   Thu, 3 Jun 2021 09:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a456396b-3950-7bd2-8f5c-af2699276f82@vaisala.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2021 08:58, Nandor Han wrote:
> Hi and thanks for your answers.
> 
> 
> On 5/28/21 11:23 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 05/05/2021 11:42, Nandor Han wrote:
>>> In order to have a robust system we want to be able to identify and take
>>> actions if a boot loop occurs. This is possible by using the bootcount
>>> feature, which can be used to identify the number of times device has
>>> booted since bootcount was last time reset. Bootcount feature (1)
>>> requires a collaboration between bootloader and user-space, where
>>> the bootloader will increase a counter and user-space reset it.
>>> If the counter is not reset and a pre-established threshold is reached,
>>> bootloader can react and take action.
>>>
>>> This is the kernel side implementation, which can be used to
>>> identify the number of times device has booted since bootcount was
>>> last time reset.
>>>
>>
>> If I understand this correctly, this driver is basically exposing a 
>> nvmem cell via sysfs.
>>
>> Firstly, This sounds like totally a generic functionality that needs 
>> to go into nvmem core rather than individual drivers.
>>
>> Do you see any reason for this not be in core?
> 
> I agree that exposing a NVMEM cell via sysfs does look as a generic 
> functionality. However, the bootcount feature contains also a magic
> value that needs to be taken in consideration when extracting the
> bootcount value. The size of the field storing the magic and value combo
> is configurable as well. The driver will handle this values 
> transparentlry for the user and expose only the validated
> bootcount value. In case we will only use a generic implementation for
> exposing a NVMEM cell via sysfs the aformention functionality will have
> to be handled by userspace and this will force the userspace to have
> knolwdge about bootcount value format and magic since they will have
> to implement it's own functionality about this. In the current solution
> the user only have to reset the value to 0 and that's it, the driver
> will take care of the rest.

Should this not live in userspace HAL, kernel would provide an abstract 
interface. User space in this case which is programming the bootcount is 
already aware of this, so am hoping that it would be able to encapsulate 
the magic as well with in.

Instead of accessing sysfs directly, its always recommended to access it 
via a some abstraction HAL programs, so as to not break the userspace 
across kernel releases, more info at 
./Documentation/admin-guide/sysfs-rules.rst

Other problem with having this in kernel is that we would endup with 
endless number of drivers for each nvmem cell which is totally not 
necessary.

Personally I do not want to endup in such a situation where people start 
writing drivers for each cell.



> 
>>
>> Secondly, creating sysfs entries like this in probe will race with 
>> userspace udev. udev might not notice this new entry in such cases.
> 
> Thanks for point this out. I will have a look how to fix this. I'll 
> appriciate any advice.
> 

There is a good document from Greg KH, 
http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/


--srini
>>
>> Thirdly, You would need to document this in Documentation/ABI/
>>
> 
> I'll do that.
> 
> 
>> Finally I noticed that the changes to snvs_lpgpr.c  have not been cced 
>> to the original author.
>>
> 
> Sorry, my mistake. I will add it in the next patch-set.
> <snip>
> 
