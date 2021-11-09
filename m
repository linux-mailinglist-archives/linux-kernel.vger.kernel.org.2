Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3D449F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhKIAIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKIAIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:08:20 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC2C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:05:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so1890016pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jz2KzTNbXrHHsy+Pm9sqGOU2Ds+KEEkeTlq7Y20EBzg=;
        b=gmzpWCOl+6r+T6HSQ4AzKgWJcY5HnGQT0kvInRVUX0/RrFlRdXAZAPFfNgAeJeoiK4
         dt7v56DTua9VcTLMAk2twgFjEHSLr0T+2LGNOiBMSKAYeLgAAAPJWQT6WzUx1aXhhwx8
         HcNHbL04PQ0PcT+4K1NxRvQxY+bmJhlEyjlkX0txQ2xrUUMIUDO1pBVOzRmh+/yRi/Pr
         pyjPEHblICl9sUUhQ7HHXvzP7wFJRzq7LS7Z2ylIZszCarhlzKCT8Gtgyvb713CB3wFo
         Ujdf+OIE6D5XevhfkmHbm8eNgM/wdoZuqYn9dUzqZP31M5dtkOMXsqULfK87ij4DDElX
         sJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jz2KzTNbXrHHsy+Pm9sqGOU2Ds+KEEkeTlq7Y20EBzg=;
        b=58TYU0xkMEZZkEsOuEvBeqpkrGX+0h0UgjgFV3M+OEc3G5m0X8iXj+Vw8GzsizjDb8
         80t8KCFBaF1312Yv4/J64Y8OXKphtz7uUDTIComOzU61UR5tP+qWgQ3ARafrsMT+LQ6w
         5lZoR8ptAXAuGVy/KD8vus5LydIwKmvB/SaPRbwt2uZD7OUmHiSzTJF6WeWd7tAn1ocM
         JvJSQ83a0R4rX7xr0t8oJOT0ghDkp/VIB75sKwGJOdQKWy1pWV1w/HQNzmIlkmjvrHnk
         xd+zmYph3XxJZCxt2J2UKEG5tpa2923rZlHWqlia09Vz93Yij9mNLMKQy0q8Z2FfK12K
         k+kA==
X-Gm-Message-State: AOAM533iQKd/IpDvZcCx4FVGXNvd083oD67pfzehyW8EvBbOIMYyd+B7
        a+UkSGCpkOc3VegW0bnBJdrZmA==
X-Google-Smtp-Source: ABdhPJxLNiLslorRQE+S4xoihyO5pNo7Y+BC5j67+KLinvlVZEQNYi/pgtMpEF+0n4/9H7Jkg0JrEg==
X-Received: by 2002:a05:6a00:8d0:b0:44c:26e6:1c13 with SMTP id s16-20020a056a0008d000b0044c26e61c13mr3121962pfu.28.1636416334478;
        Mon, 08 Nov 2021 16:05:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1205:53ca:e5c0:1a50])
        by smtp.gmail.com with ESMTPSA id k13sm17859826pfc.197.2021.11.08.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 16:05:33 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:05:31 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] x86/purgatory: remove -nostdlib compiler flag
Message-ID: <20211109000531.k23mgrfjn5tomevv@google.com>
References: <20211107162641.324688-1-masahiroy@kernel.org>
 <20211107162641.324688-2-masahiroy@kernel.org>
 <CAKwvOdmCaXAMvouD7bsWqmgOUxQ9vpdt3LY7qWpzTVm-2gddEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmCaXAMvouD7bsWqmgOUxQ9vpdt3LY7qWpzTVm-2gddEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-08, Nick Desaulniers wrote:
>On Sun, Nov 7, 2021 at 8:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> The -nostdlib option requests the compiler to not use the standard
>> system startup files or libraries when linking. It is effective only
>> when $(CC) is used as a linker driver.
>
>Is that right? ld.lld recognizes --nostdlib and has --help text for it.

GCC/Clang driver -nostdlib != ld.bfd/ld.lld -nostdlib.

ld.lld -nostdlib just ignores SEARCH_DIR in a linker script.
I think ld.bfd's -nostdlib is more complex than that which also has
something to do with its internal linker script location.
Anyway, getting of the obscure ld -nostdlib is a good idea.

>>
>> $(LD) is directly used for linking purgatory.{ro,chk} here, hence
>> -nostdlib is unneeded.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>  arch/x86/purgatory/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
>> index 95ea17a9d20c..ae53d54d7959 100644
>> --- a/arch/x86/purgatory/Makefile
>> +++ b/arch/x86/purgatory/Makefile
>> @@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>>
>>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
>> -PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
>> +PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
>>  LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
>>  LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
>>  targets += purgatory.ro purgatory.chk
>> --
>> 2.30.2
>
>-- 
>Thanks,
>~Nick Desaulniers
