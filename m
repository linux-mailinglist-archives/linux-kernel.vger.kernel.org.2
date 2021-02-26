Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011923269BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBZV4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:55:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F544C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:55:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s24so11215881iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TbbG+K21OJksMSriRBsOnkJNEbaTjI1alnvlyWlecpQ=;
        b=PgkgDjZa97MDV9/Y8FaGFSjOFOKXBpNT06a5oxs2Czk9XCjecD+COXpqVKv844w6CB
         gAOfjg2mIaQFtRaW/ECx/j3YWKsMqhi7ev/2c8a6NMfX9hG+xl1eY+JBWSekfUsMVF1X
         eZZMhPhIMT57mfWIHBORF8HW0lTc+BQpQx7AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbbG+K21OJksMSriRBsOnkJNEbaTjI1alnvlyWlecpQ=;
        b=FtGdybxZBWskXcd17jynhmV/UvV8sekGoJvtkK/X/nQR9gWD+Z510uAgNeCcTyE8O7
         jfwMfz0XE3sNLejxq1qG46hhRU4xjf0GONwDLy9d45g1uTIjGB/PzKjyYckTVbnJSWq+
         3ivpyWwsh7VD5+/NNXoLRBjShGtnwU6Ogf9Oy/nkAjnqgM6sM9ALGXabTjI3f9jRnj7U
         azcRuLvaxPE1KDYnVRkl8TvUfxO+Zx2ayT3zEmgTsTYOg3eVs+9lT2LdTVgGznr3Were
         WSRHVkUg6jk1+u9VkIUZoJqzcFs/5WAG8FHE2qcC5EZ7lgZzDH725QEckV+FuJVpRzSW
         KYmA==
X-Gm-Message-State: AOAM532AKW8YRXY+v+mIo2JszDsy02xN7qkVdzeE8dGsD67W8ncHg9Kt
        xoogSZzrhRgFQVc9NcJuZA5kug==
X-Google-Smtp-Source: ABdhPJzu77gtIIuiUcz9cXqvS/WNpBNLjZbJf8JWOBHfSvJRNrkLY3fbuksgVXKop3px+qiLCwJylA==
X-Received: by 2002:a02:4087:: with SMTP id n129mr5042155jaa.143.1614376517727;
        Fri, 26 Feb 2021 13:55:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x17sm5298087ilm.40.2021.02.26.13.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:55:17 -0800 (PST)
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Alexander Monakov <amonakov@ispras.ru>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Coe <david.coe@live.co.uk>,
        Joerg Roedel <joro@8bytes.org>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
 <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
 <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
 <4aba4c61-1878-3d4e-d52e-3ccac9715010@molgen.mpg.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4e0861a-0a27-3765-5b63-161bb9bdb775@linuxfoundation.org>
Date:   Fri, 26 Feb 2021 14:55:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4aba4c61-1878-3d4e-d52e-3ccac9715010@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 2:44 PM, Paul Menzel wrote:
> [cc: +suravee, +jörg]
> 
> Dear Alex, dear Shuah, dear Suravee, dear Jörg,
> 
> 
> Am 03.06.20 um 08:54 schrieb Alexander Monakov:
>> On Tue, 2 Jun 2020, Shuah Khan wrote:
>>
>>> I changed the logic to read config to get max banks and counters
>>> before checking if counters are writable and tried writing to all.
>>> The result is the same and all of them aren't writable. However,
>>> when disable the writable check and assume they are, I can run
>> [snip]
>>
>> This is similar to what I did. I also noticed that counters can
>> be successfully used with perf if the initial check is ignored.
>> I was considering sending a patch to remove the check and adjust
>> the event counting logic to use counters as read-only, but after
>> a bit more investigation I've noticed how late pci_enable_device
>> is done, and came up with this patch. It's a path of less resistance:
>> I'd expect maintainers to be more averse to removing the check
>> rather than fixing it so it works as intended (even though I think
>> the check should not be there in the first place).
>>
>> However:
>>
>> The ability to modify the counters is needed only for sampling the
>> events (getting an interrupt when a counter overflows). There's no
>> code to do that for these AMD IOMMU counters. A solution I would
>> prefer is to not write to those counters at all. It would simplify or
>> even remove a bunch of code. I can submit a corresponding patch if
>> there's general agreement this path is ok.
>>
>> What do you think?
> 
> I like this idea. Suravee, Jörg, what do you think?
> 
> Commit 6778ff5b21b (iommu/amd: Fix performance counter initialization) 
> delays the boot up to 100 ms, which is over 20 % on fast systems, and 
> also just a workaround, and does not seem to work always. The delay is 
> also not mentioned in the commit message.
> 
>

Sounds good to me. I can test this out on my system.

thanks,
-- Shuah

