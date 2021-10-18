Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73BA4328A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJRVAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:59:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:57:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s17so17822205ioa.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ln9Olyr7441CbnuK7l3EiQIh9I1kG5vgzPWZ+DafEKg=;
        b=W+UULTZWsYR1lJx8WJ/RKd8Ax8zycwwUskaP9mTOtidUr+UXY1FPP2K0TWFyM3ze5E
         vfPM6L1fmpwMFG+Et5yAxUmhRtGf9drlEc1ZjH/StToTEU3NG9sQAhcnJTXAthCk6PLD
         XpHWcK4jT1LR7y/lykOTl0ko4zp9J5N6Jed0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ln9Olyr7441CbnuK7l3EiQIh9I1kG5vgzPWZ+DafEKg=;
        b=L5vQnkIWIp8hdeRiVAv00h+X3aFT8KJZip7QSgNtke7ExlMLlH8RydvYOYyTRIBrQt
         VUkoltGBg+vcHwT92oeP6piQKqXFX7CaY+v0RIeuKbTKDhRq0I3oe54ymXkGbcSKwikQ
         1SYspttrg0IIwEuQwZZZzu84cIIEuKH6FARePpPxbYyDurbfuWqQqCZCquskz8/73aLi
         n5vU5xnU+ROkHG/FhnAaLg79VkuWYnh3j2t/9GczomNxDnjq1YzYyxfQzN26jxwAymVr
         DVvI8KoMubMNsjLgd1BczyZdYZsNOxKuVay7i5n9zgwIwabPRAOHYdQlzraTOwciFIvx
         sEQg==
X-Gm-Message-State: AOAM532FK9LmtU68wAzklbbM7hss5OEsp8a3L0Ogd0Y3UFlfyqouu+3S
        DYOHGYN/futL8LgWlktsZFtZE7Ue2uuwQA==
X-Google-Smtp-Source: ABdhPJyhQeX4QeJam4H6vz1NIPiXabwTnccRTYfSQMJqXeLGcO2AN+M7bf1xFXlekdU+X0Fi5gYF5g==
X-Received: by 2002:a02:b013:: with SMTP id p19mr1500553jah.38.1634590666497;
        Mon, 18 Oct 2021 13:57:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w11sm7233608ior.40.2021.10.18.13.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 13:57:46 -0700 (PDT)
Subject: Re: [PATCH v2] module: fix validate_section_offset() overflow bug on
 64-bit
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211018173511.26542-1-skhan@linuxfoundation.org>
 <YW3W9t/0axMDXAjv@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e1ef9645-9386-bf68-4e8d-70828e8c95fe@linuxfoundation.org>
Date:   Mon, 18 Oct 2021 14:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YW3W9t/0axMDXAjv@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 2:20 PM, Luis Chamberlain wrote:
> On Mon, Oct 18, 2021 at 11:35:11AM -0600, Shuah Khan wrote:
>> validate_section_offset() uses unsigned long local variable to
>> add/store shdr->sh_offset and shdr->sh_size on all platforms.
>> unsigned long is too short when sh_offset is Elf64_Off which
>> would be the case on 64bit ELF headers.
>>
>> This problem was found while adding an error message to print
>> sh_offset and sh_size. If sh_offset + sh_size exceed the size
>> of the local variable, the checks for overflow and offset/size
>> being too large will not find the problem and call the section
>> offset valid. This failure might cause problems later on.
>>
>> Fix the overflow problem using the right size local variable when
>> CONFIG_64BIT is defined.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> Changes since v1:
>> - Updated commit log to describe the fix clearly. No code
>>    changes.
> 
> Thanks! But the implications of your fix is beyond what is described.
> Although not a real issue today in practice.
> 
> I think we should extend it with something like this, let me know
> what you think (I can just ammend the commit log, no resend would
> be needed):
> 
> Without this fix applied we were shorting the design of modules to
> have section headers placed within the 32-bit boundary (4 GiB) instead of
> 64-bits when on 64-bit architectures (which allows for up to 16,777,216
> TiB). In practice this just meant we were limiting modules to below
> 4 GiB even on 64-bit systems. This then should not really affect any
> real-world use case as modules these days obviously should likely never
> exceed 1 GiB in size. A specially crafted invalid module might succeed to
> skip validation in validate_section_offset() due to this mistake, but in such
> case no impact is observed through code inspection given the correct data
> types are used for the copy of the module when needed on move_module() when
> the section type is not SHT_NOBITS (which indicates no the section
> occupies no space on the file).
> 

Sounds good to me.

thanks,
-- Shuah
