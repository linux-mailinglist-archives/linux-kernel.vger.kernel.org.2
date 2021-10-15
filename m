Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC442E6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhJOCm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJOCmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:42:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF92BC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:40:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so6193102pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=1z9J+dqYZ0Lm4fpS0d38asO4WoVCpgoJ+AZGclBygSw=;
        b=EvQpgtaABkTrtIlpw7t8qz1LOZyc0vQx+fTsu0AP1QNQHIOL6/eV3sr2y7xoI2EhUq
         /9UWjv2HwYYK7VPNe3Soj+xsI68YX6XRdiL/a+7zfFDD4vZqZInCVfqRLakBCcZWND5V
         dWMwvjyial6T3MGV8Dsis664VHgktnoPRinko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=1z9J+dqYZ0Lm4fpS0d38asO4WoVCpgoJ+AZGclBygSw=;
        b=decZ7oaUtlqPsTB1ETdv/++IKFY/tggclH2t4Jmnotps/hO+XzkcUL/owfwtxk1uN2
         PMWkzlMSwaL+qOCkTwyujEyCXrcggsbVXJ8DS5QwxOVDqej+Bflo/6jaDIHSLwz0IXwB
         b6noipRi6/WLBn0MxPyBCxUI7AURE1h1xPfE98mMSBYXNYSA5IiTGpHIPOX3g/vrzuW4
         roLt0TJC1626Nyh6pWPtFivluKxgGW46C/QNIRnZVNxAdIjhdOh80ITYcIc3uuYvG/1N
         1Ge5BWqG9nWj8m7V4DN1U6dAVYRMEgSjVA7ALjOarS0RxSsbOVt2zcdPL/ndhe3bQHkF
         AFTg==
X-Gm-Message-State: AOAM5305DNjmV6pjstV6dHSOTs78T4puWcNLUuw6pO4emfepRAIP0XVO
        2mO2fqX4WvRRGylEvMUOaLBZQ2eaKvFadw==
X-Google-Smtp-Source: ABdhPJzdZdrnP5J2QzmpwXWEsAdMq2pO8zfrgLGyrHCqu2jeLIzYwDQL2JYb8mlr+aGCxCl3MHn0yQ==
X-Received: by 2002:a17:90a:4801:: with SMTP id a1mr24227600pjh.156.1634265648055;
        Thu, 14 Oct 2021 19:40:48 -0700 (PDT)
Received: from [127.0.0.1] (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kb15sm4048938pjb.43.2021.10.14.19.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 19:40:47 -0700 (PDT)
Date:   Thu, 14 Oct 2021 19:40:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
User-Agent: K-9 Mail for Android
In-Reply-To: <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
References: <20211013150025.2875883-1-arnd@kernel.org> <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
Message-ID: <721BDA47-9998-4F0B-80B4-F4E4765E4885@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 14, 2021 1:12:54 AM PDT, Vincenzo Frascino <vincenzo=2Efrascino=
@arm=2Ecom> wrote:
>
>
>On 10/13/21 5:00 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb=2Ede>
>>=20
>> Calling memcmp() and memchr() with an intentional buffer overflow
>> is now caught at compile time:
>>=20
>> In function 'memcmp',
>>     inlined from 'kasan_memcmp' at lib/test_kasan=2Ec:897:2:
>> include/linux/fortify-string=2Eh:263:25: error: call to '__read_overflo=
w' declared with attribute error: detected read beyond size of object (1st =
parameter)
>>   263 |                         __read_overflow();
>>       |                         ^~~~~~~~~~~~~~~~~
>> In function 'memchr',
>>     inlined from 'kasan_memchr' at lib/test_kasan=2Ec:872:2:
>> include/linux/fortify-string=2Eh:277:17: error: call to '__read_overflo=
w' declared with attribute error: detected read beyond size of object (1st =
parameter)
>>   277 |                 __read_overflow();
>>       |                 ^~~~~~~~~~~~~~~~~
>>=20
>> Change the kasan tests to wrap those inside of a noinline function
>> to prevent the compiler from noticing the bug and let kasan find
>> it at runtime=2E
>>=20
>> Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>
>Reviewed-by: Vincenzo Frascino <vincenzo=2Efrascino@arm=2Ecom>

How about just explicitly making the size invisible to the compiler?

I did this for similar issues in the same source:

https://lore=2Ekernel=2Eorg/linux-hardening/20211006181544=2E1670992-1-kee=
scook@chromium=2Eorg/T/#u


-Kees

>
>> ---
>>  lib/test_kasan=2Ec | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/lib/test_kasan=2Ec b/lib/test_kasan=2Ec
>> index 67ed689a0b1b=2E=2E903215e944f1 100644
>> --- a/lib/test_kasan=2Ec
>> +++ b/lib/test_kasan=2Ec
>> @@ -852,6 +852,21 @@ static void kmem_cache_invalid_free(struct kunit *=
test)
>>  	kmem_cache_destroy(cache);
>>  }
>> =20
>> +/*
>> + * noinline wrappers to prevent the compiler from noticing the overflo=
w
>> + * at compile time rather than having kasan catch it=2E
>> + * */
>> +static noinline void *__kasan_memchr(const void *s, int c, size_t n)
>> +{
>> +	return memchr(s, c, n);
>> +}
>> +
>> +static noinline int __kasan_memcmp(const void *s1, const void *s2, siz=
e_t n)
>> +{
>> +	return memcmp(s1, s2, n);
>> +}
>> +
>> +
>>  static void kasan_memchr(struct kunit *test)
>>  {
>>  	char *ptr;
>> @@ -870,7 +885,7 @@ static void kasan_memchr(struct kunit *test)
>>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>> =20
>>  	KUNIT_EXPECT_KASAN_FAIL(test,
>> -		kasan_ptr_result =3D memchr(ptr, '1', size + 1));
>> +		kasan_ptr_result =3D __kasan_memchr(ptr, '1', size + 1));
>> =20
>>  	kfree(ptr);
>>  }
>> @@ -895,7 +910,7 @@ static void kasan_memcmp(struct kunit *test)
>>  	memset(arr, 0, sizeof(arr));
>> =20
>>  	KUNIT_EXPECT_KASAN_FAIL(test,
>> -		kasan_int_result =3D memcmp(ptr, arr, size+1));
>> +		kasan_int_result =3D __kasan_memcmp(ptr, arr, size+1));
>>  	kfree(ptr);
>>  }
>> =20
>>=20
>

--=20
Kees Cook
