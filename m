Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9616457EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 16:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhKTPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 10:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhKTPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 10:25:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 07:22:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso9398201wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9h+PyJVI+J/jk7CrfScjFwP4ghuFS8I41cpzNkNVExo=;
        b=Cq8FDxnYcS05vCM3l13gztARsKs7aMg/b1mLOZFttmI8NmRM1pXVL6My7zn/EnMpQ8
         wc74HALnkKl1Rhfq5QdpQCziUJI4FJrHJuL7nPZBH19AVAADNZG12mrSledEkZSRPcae
         IaUDavJcn3bu0sPulhQUn1YBXi8xqsfPcoOHOr0Hr58ZCPJ2qH4c08z6m8ldhYSYxXLs
         sweFRIDk0ePuKHWfOqozPdCgLr8dap4wlvG+iDyfqJGTQdhwPwGyV/txnN/TlQ6u9873
         unPxGmeZt3AP8VNkZ1WpbO+NR4NhjhFkU8JzwFuulaSnBPvRv6wIrg2bIqhlYBWbUoqi
         lGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9h+PyJVI+J/jk7CrfScjFwP4ghuFS8I41cpzNkNVExo=;
        b=2zjQjCF7e9p+iBw/k6DNmEeK2mE4NCU1TGfpe/GueqgptU/1xoYSkZlntK6rBun4OQ
         a9ytv4aWGvxJLpuquRwiWWtIQYRR8WCzXHoTLoNzaDrCrE/HDfBPDNF4r7JEjGRT/Geq
         XpErFoatmbKSxXUs9TC3OyvL3eyjVZDdEyt3nqQ077wlf8/eUzQb5d+W7ix2IbelPXCV
         Fb6Cq/u3/pEPejtde71P6amIoxarRz2dYCyCT2INPxCV3vKnUk7KWU/qECrW2Si9dPF0
         4vwTWtPqRawOV4rHJGe6+lfFcJqW1m7psV1QcpzAueIO/CTzZ4UvNjp7lItaa6kGKb3R
         te/A==
X-Gm-Message-State: AOAM530O4Cdse4kQTRBWA8hG8W+ZMAOd46DOu5foDVrpzWJ20SizC7Ta
        Sg7mHuhlDiS7QiuwpvaGOgZRAFffOzp+sg==
X-Google-Smtp-Source: ABdhPJx3h0kft0+qGWkzsSDM50AiSPsmATzRdJB+5KoqHJAPLmHGCItofRzH1QfDCLUgyvOOQS98Ng==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr10878629wma.69.1637421761321;
        Sat, 20 Nov 2021 07:22:41 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id c4sm3069597wrr.37.2021.11.20.07.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 07:22:41 -0800 (PST)
Message-ID: <43a9a694-c58d-e4e1-04e4-585ad9a8fc97@gmail.com>
Date:   Sat, 20 Nov 2021 16:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 12/20] linux/must_be.h: Add must_be() to improve
 readability of BUILD_BUG_ON_ZERO()
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-13-alx.manpages@gmail.com>
 <YZkOolX1SBsqXAsP@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YZkOolX1SBsqXAsP@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 11/20/21 16:05, Alexey Dobriyan wrote:
> On Sat, Nov 20, 2021 at 02:00:55PM +0100, Alejandro Colomar wrote:
>> Historically, BUILD_BUG_ON_ZERO() has been hard to read.
>> __must_be_array() is based on BUILD_BUG_ON_ZERO(),
>> and unlike BUILD_BUG_ON_*(),
>> it has a pretty readable name.
> 
> The best name is assert() which userspace uses and is standartised.

Yes, assert() is almost the same thing.
In this case, it would be better named static_assert(),
since it's a compile-time assert().

However,
there's still one slight difference
between static_assert() and must_be():

static_assert() is limited;
it cannot be used in some places,
such as in the implementation of ARRAY_SIZE().
The following doesn't compile:

 #define __arraycount(a)  (sizeof((arr)) / sizeof((arr)[0])
 #define ARRAY_SIZE(a)    (__arraycount(a) + static_assert(is_array(a)))

And if you change it to be:

 #define ARRAY_SIZE(a)    (		\
 {					\
	static_assert(is_array(a));	\
	__arraycount(a);		\
 }					\
 )

then the macro can't be used at file scope
(since ({}) can't be used at file scope).

The good thing about __must_be() is that it evaluates to 0,
which allows you to use it
everywhere a 0 can be used.

My own implementation of __must_be() is
more standards compliant,
and is:

#define must_be(e)  (                      \
        0 * (int)sizeof(                   \
                struct {                   \
                        static_assert(e);  \
                        char ISO_C_forbids_a_struct_with_no_members__; \
                }                          \
        )                                  \
)

I would like this to superseed
the kernel's BUILD_BUG_ON_ZERO(),
but it makes use of C2X static_assert().
I don't know how much that can be a problem.

But please consider this proposal.

Thanks,
Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
