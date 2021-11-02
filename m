Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812DE443033
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhKBOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBOXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:23:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E278C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:20:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o83so30201485oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8cTxA+Y36pQ3QBwG6wilsc9U1gVz8qmBIdVbUMSVsUk=;
        b=nFmVcnjt1FkwOU+fasyNpyPD5kD0OM8YnHm9ZjClEYnh3bZZzy+QLbDf4hCsKV1oNj
         j2FkTRaFdZmb4Lf0kLe21JnvmHFfEt8Su7er+jLjaOnXfRQKHewhU7igoZebuIwVUoMC
         mGudWpww4h2wH6kKVa7EM04yI4WaKS8As7qmtPTE3slwryTlnaTFKrSHxq5mdcWE/wn9
         Nb5VpFdgzYj+tsIvpxLYg1ulo5X/faKVlT1wq8SYd79M/5QmiDGQ9U0E3DO3e7SStER3
         L5lZPk8ysvrAi90UAmXMJ3B5GhvAAapgBne8PvTp0YtCRaFIQQPlb1j41dgQMfhuTyLU
         qpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8cTxA+Y36pQ3QBwG6wilsc9U1gVz8qmBIdVbUMSVsUk=;
        b=c+NirLL5gitqAprX1hpE2x0nT4oVKpNr7WuwypwpYomOhvWyGI+6jr4GRXItjhK/vS
         BIM+RD3FRmk2bPXamJjyOh/mekW1K5JFqG+3hm35n8RtKDVqor3eulLzuwXD0uURID1Q
         N50qk2OMuBnbYdxjGuztTNeMB2Zk11bxUYR3z81MYttnwuFUY/nlm2RZKABi4SQJ+VVG
         A6RCp4PyZEpLKbIU3qPvBI33UyB0oGb8c8QhK6vum4P1VlkwjpIqlJss/2CYe1fkZFyL
         0gGLd+fMzZBjnlHAUtp32rwuzrAvMRRXxtzaOqlzfZgh9oM5wgtx3ZA17LP0fSs9oILg
         x1Xg==
X-Gm-Message-State: AOAM532mZ4o5iccU3mdkIH+v+dYtEM3D/oY6c67rk5Fwzg/h+HjW4FPF
        YBYWcpc6cbXvIs9PlybzDjauLDtAbvA=
X-Google-Smtp-Source: ABdhPJyZR+eLMjzs2tsKiK5ZpsWVaFEo4fi7GOm/W1UQeL9wUwNxxJtdzQ8iADBjtagGEQqhYmz9xg==
X-Received: by 2002:a05:6808:30a1:: with SMTP id bl33mr5422683oib.56.1635862858062;
        Tue, 02 Nov 2021 07:20:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 70sm4840620otn.74.2021.11.02.07.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:20:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] string: uninline memcpy_and_pad
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <20211102043024.449478-1-linux@roeck-us.net>
 <CAMuHMdW_0Q9oGfCqrdj9w=1n0CtTRZErZAeynToMQNrs--+oCg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <de972f31-cf0d-6f68-5664-f965f80fb1b2@roeck-us.net>
Date:   Tue, 2 Nov 2021 07:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW_0Q9oGfCqrdj9w=1n0CtTRZErZAeynToMQNrs--+oCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 12:56 AM, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> Thanks for your patch!
> 
> On Tue, Nov 2, 2021 at 5:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> When building m68k:allmodconfig, recent versions of gcc generate the
>> following error if the length of UTS_RELEASE is less than 8 bytes.
>>
>> In function 'memcpy_and_pad',
>>      inlined from 'nvmet_execute_disc_identify' at
>>          drivers/nvme/target/discovery.c:268:2:
>> arch/m68k/include/asm/string.h:72:25: error:
>>          '__builtin_memcpy' reading 8 bytes from a region of size 7
>>
>> Discussions around the problem suggest that this only happens if an
>> architecture does not provide strlen(), if -ffreestanding is provided as
>> compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
>> for m68k. The exact reasons are unknown, but seem to be related to the
>> ability of the compiler to evaluate the return value of strlen() and
>> the resulting execution flow in memcpy_and_pad(). It would be possible
>> to work around the problem by using sizeof(UTS_RELEASE) instead of
>> strlen(UTS_RELEASE), but that would only postpone the problem until the
>> function is called in a similar way. Uninline memcpy_and_pad() instead
>> to solve the problem for good.
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>   include/linux/string.h | 19 ++-----------------
>>   lib/string.c           | 19 +++++++++++++++++++
>>   2 files changed, 21 insertions(+), 17 deletions(-)
> 
> Given this now conflicts with commit cfecea6ead5f1588 ("lib/string:
> Move helper functions out of string.c"). perhaps you should move this
> to lib/string_helpers.c when respinning?
> 

Will do.

Thanks,
Guenter

