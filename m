Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37E44447D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCSGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:06:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B2C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:03:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x70so4946106oix.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VqGAbaXG+T49SN5pybSkY1Ja1algJQRENNlaGOQ5K8g=;
        b=f90i8zA6319i0701THsNUJpI7enkuXD9N5bQjvL2dHyNpQDtUNOUoT1zD+hXj2f1TF
         XOPKTw3BVIz+wunSxb9igd51yyqbouq6f4AST/JE99ymERCoUy6zWdCG75c9umnXxXHB
         0O+gWfxQJqrn9MTVSimfMJAyJhVDJgs+1hPUmnk7Dfqquxted2U7+QIjlbzpF2hPbT9t
         wBs8KGtzJ1jzsONP/NX2g0u1uS80lgY5WuZTVATtN5OLYzoQRcfRJGr11HEw0A3ncplu
         EjYog4j/VvLFH570+hXovYag2+30OEka/eG4kuuIKRXtHq9OFLXfMOK/XAqRAvqOd1+5
         8OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VqGAbaXG+T49SN5pybSkY1Ja1algJQRENNlaGOQ5K8g=;
        b=yW3YHPupE5fLefCoB0WaqcYaBj7EsAqPOqUZAQw+I0a0Vtg9fHFMnihVtZ0jTn4vaG
         ckEXKj0FuLwlQWPsO72YpIMiOAncwZiU38P1zsneL6J87dplI27uT95Jus3oVxNQk3Zi
         lCckFUPnPLMSLHVlbkkZCbL+u9F93/egkDaguqLIv1PltUgoB+p0yTOtc28J3YEAYdGK
         R7eGMTLvK6A5Qj+o107rCIq+UTqzIIgLz3X63JeA0toT4OEIBC7gS+fx60CRYXIJIhWT
         4kcUDFC/ltlTWK/tr2Beo6lQ41Ly1Z42tNGRW4/9t6qfNUfvr+gMgU1LyGEF+vvTdx5l
         GceQ==
X-Gm-Message-State: AOAM530ppFH2p+oPI/A+oIzLy6mOsQsp9k3RRZzMv7Mnqmdn5D8WSj3d
        /k2oBy2ASWL1e++lxQ7ORyk=
X-Google-Smtp-Source: ABdhPJyIGWVS5XKazs59dA4aMS5QBtCzzLSBxra+PUS1eSiqdBV0XhMoIZ1+l0h5nCx22E79UN1smg==
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr11886847oiw.43.1635962614309;
        Wed, 03 Nov 2021 11:03:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm707365otc.79.2021.11.03.11.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 11:03:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20211102142518.3723655-1-linux@roeck-us.net>
 <202111031011.D0F16D78@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RESEND PATCH v2] string: uninline memcpy_and_pad
Message-ID: <bc18aef2-17ee-dcbc-916c-952794adc658@roeck-us.net>
Date:   Wed, 3 Nov 2021 11:03:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202111031011.D0F16D78@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 10:37 AM, Kees Cook wrote:
> On Tue, Nov 02, 2021 at 07:25:18AM -0700, Guenter Roeck wrote:
>> When building m68k:allmodconfig, recent versions of gcc generate the
>> following error if the length of UTS_RELEASE is less than 8 bytes.
>>
>> In function 'memcpy_and_pad',
>>      inlined from 'nvmet_execute_disc_identify' at
>>      	drivers/nvme/target/discovery.c:268:2:
>> arch/m68k/include/asm/string.h:72:25: error:
>> 	'__builtin_memcpy' reading 8 bytes from a region of size 7
> 
> What things are size 8 and 7? "5.15.0\0" is 7 bytes -- is strlen()
> returning _8_?? It should return 6 here.
> 
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
> 
> Ew, no, this doesn't solve the problem -- it just makes the buffer sizes
> invisible to the compiler. This will hide legitimate problems. Please
> leave this inlined.
> 
> struct nvme_id_ctrl {
> 	...
>          char                    fr[8];
> ...
> 
>          memcpy_and_pad(id->fr, sizeof(id->fr),
>                         UTS_RELEASE, strlen(UTS_RELEASE), ' ');
> 
> 	memcpy_and_pad(id->fr, 8, UTS_RELEASE, 6, ' ')
> 
> 
> static inline void memcpy_and_pad(void *dest, size_t dest_len,
> 				  const void *src, size_t count, int pad)
> 	if (dest_len > count) {
> 		memcpy(dest, src, count);
> 		memset(dest + count, pad,  dest_len - count);
> 	} else {
> 		memcpy(dest, src, dest_len);
> 	}
> 
> ->
> 
> 	if (8 > 6) {
> 		memcpy(id->fr, UTS_RELEASE, 6);
> 		memset(fd->fr + 6, ' ', 2);
> 	}
> 
> Ah, I've found the earlier thread now:
> https://lore.kernel.org/all/CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com/
> 
> This looks like a compiler bug in that it isn't collapsing the strlen()
> into a compile-time constant. "sizeof(UTS_RELEASE) - 1" seems a
> reasonable work-around?
> 
> I'd suggest reporting this to GCC. I see two bugs:
> 
> - strlen() not getting replace with a constant expression

I do not think this can be classified as compiler bug. The compiler
does not know the result of strlen() because the version from
lib/string.c is used. It does know the length of UTS_RELEASE,
and it does know the length of fd->fr. Since it doesn't know
the return value of strlen(), it concludes that the else path
in memcpy_and_pad() may be taken, and comes to the wrong conclusion.

> - warning being generated across a runtime check
> 
I am not sure about that one either. gcc knows the size of dest,
the value of dest_len, and the size of src. I don't know what kind
of conclusions a compiler may make based on that information.

The problem I see is that if any kind of flow ahead of memcpy()
with compile-time constant parameters invalidates checks the compiler
can make based on those parameters, a lot of similar checks which
_are_ possible today may be disabled. Declaring this a compiler bug
and getting it "fixed" may have the undesirable side effect of
disabling a lot of useful checks. Maybe that is not a concern, but
I think it is something to be aware of.

> it seems like GCC *thinks* it knows strlen will be a CE, but then
> instead it keeps both branches anyway, triggering a warning.
> 

I don't think it believes that strlen is a CE.

Either case, I'll wait for advice from Linus on how to proceed.

Thanks,
Guenter

> -Kees
> 
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Moved to lib/string_helpers.c
>>      Balanced { } in if/else statement to make checkpatch happy
>>      Added Reviewed-by: /Acked-by: tags
>>
>>   include/linux/string.h | 19 ++-----------------
>>   lib/string_helpers.c   | 20 ++++++++++++++++++++
>>   2 files changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 5a36608144a9..b6572aeca2f5 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -253,23 +253,8 @@ static inline const char *kbasename(const char *path)
>>   #include <linux/fortify-string.h>
>>   #endif
>>   
>> -/**
>> - * memcpy_and_pad - Copy one buffer to another with padding
>> - * @dest: Where to copy to
>> - * @dest_len: The destination buffer size
>> - * @src: Where to copy from
>> - * @count: The number of bytes to copy
>> - * @pad: Character to use for padding if space is left in destination.
>> - */
>> -static inline void memcpy_and_pad(void *dest, size_t dest_len,
>> -				  const void *src, size_t count, int pad)
>> -{
>> -	if (dest_len > count) {
>> -		memcpy(dest, src, count);
>> -		memset(dest + count, pad,  dest_len - count);
>> -	} else
>> -		memcpy(dest, src, dest_len);
>> -}
>> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>> +		    int pad);
>>   
>>   /**
>>    * memset_after - Set a value after a struct member to the end of a struct
>> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
>> index faa9d8e4e2c5..d5d008f5b1d9 100644
>> --- a/lib/string_helpers.c
>> +++ b/lib/string_helpers.c
>> @@ -883,6 +883,26 @@ char *strreplace(char *s, char old, char new)
>>   }
>>   EXPORT_SYMBOL(strreplace);
>>   
>> +/**
>> + * memcpy_and_pad - Copy one buffer to another with padding
>> + * @dest: Where to copy to
>> + * @dest_len: The destination buffer size
>> + * @src: Where to copy from
>> + * @count: The number of bytes to copy
>> + * @pad: Character to use for padding if space is left in destination.
>> + */
>> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>> +		    int pad)
>> +{
>> +	if (dest_len > count) {
>> +		memcpy(dest, src, count);
>> +		memset(dest + count, pad,  dest_len - count);
>> +	} else {
>> +		memcpy(dest, src, dest_len);
>> +	}
>> +}
>> +EXPORT_SYMBOL(memcpy_and_pad);
>> +
>>   #ifdef CONFIG_FORTIFY_SOURCE
>>   void fortify_panic(const char *name)
>>   {
>> -- 
>> 2.33.0
>>
> 

