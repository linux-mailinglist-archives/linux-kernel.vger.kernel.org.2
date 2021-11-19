Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBC45736D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhKSQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhKSQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:52:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C77C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:49:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so7992406wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U2fKxyw43ArWsj2V69AQcBSyKarJUhYsmOMbJ7muvRE=;
        b=NXt02Tpj2XlTZTSJirdA/WVYb9IKHFa0i7W7PNhLsRdPriyzo2HCgQ1Vqwbbfg1GVu
         2TpwxtP2oQfVUmJZZH6XT5RbaMnSQWZdpzDwneA52CpegKvM8MfIKtqyU27cmiqUrDEN
         k4PFO/SrFyJlzN5N5uxzXjkMHCp/4BaIDFoZMYnQiT9VTYn4yLOMVLfzxaXWhNtxq4op
         0XtjHQy49alkqKTKyhzVb7Uz+TscKRQxqCtZHuhAHukZlIoMN/ZUTfUoQD+mQAkOjJf7
         vLhJZE9XPJ4/eOGT5B2MR9/+HJt5IRTe3Qokph/1Xtl8MznQOGdopgfyzl/Td0LlJrsI
         0lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U2fKxyw43ArWsj2V69AQcBSyKarJUhYsmOMbJ7muvRE=;
        b=mFb9su3sxDJGS3QHZ1cvtAcHR4TXnTBfMIEYgo0ssirXV7AKl18m4WBaQzOm91nJCk
         QA/eneis/xOPvorjNkoC5oW19v9XqsPTImAnb7+P8xAuzQwQnBDLLj+A3J4Jjgziy7kJ
         OsUU0OGWnnwPYLo7suL9tw9iwY7hZOLilVZcByccB/wsq0jiFT4pgH7r1uw2AcNjGUXA
         Z3Y5QcawcltsmhS0hCrHIdW+SgzCkWl23/nk3KkVy/kIYltu/hSAdqP5utD29mk+u28M
         BKWZ8h3MznZzRJeqNc0ydU9TrBBVfwr/CHbQWHZuagz6WXHfku+uWvUm4Itxn2UrHhDc
         SSWg==
X-Gm-Message-State: AOAM5333T8Mn+HW3qEmYS/I94seBPpJnceGNW8fsf2dPOBsKXrjFmMxI
        IpTbVQLbqH8/shzzH4RcW/k=
X-Google-Smtp-Source: ABdhPJxfaldckGH7iuC2yRY5PfOcTjit+wv+XaMx7DFOQIEn5LRocTnLZYCKWAUlmBliTVmtmQG7Sg==
X-Received: by 2002:a05:600c:3505:: with SMTP id h5mr1319862wmq.22.1637340593141;
        Fri, 19 Nov 2021 08:49:53 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a141sm12056450wme.37.2021.11.19.08.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:49:52 -0800 (PST)
Message-ID: <6909f9ed-609c-b179-6c34-2f9d8b1cb5a8@gmail.com>
Date:   Fri, 19 Nov 2021 17:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <CAK8P3a2yVXw9gf8-BNvX_rzectNoiy0MqGKvBcXydiUSrc_fCA@mail.gmail.com>
 <f751fb48-d19c-88af-452e-680994a586b4@gmail.com>
 <YZfS4lCt8rMZ7UlS@smile.fi.intel.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YZfS4lCt8rMZ7UlS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/21 17:37, Andy Shevchenko wrote:
> On Fri, Nov 19, 2021 at 05:12:19PM +0100, Alejandro Colomar (man-pages) wrote:
>> On 11/19/21 16:57, Arnd Bergmann wrote:
> 
> ...
> 
>>> On the plus side, I did see something on the order of a 30%
>>> compile speed improvement with clang, which is insane
>>> given that this only removed dead definitions.
>>
>> Huh!
>>
>> I'd like to see the kernel some day
>> not having _any_ hidden dependencies.
> 
> It's neither feasible nor practical. If we know the hard dependencies between
> headers, why should we not use implicit inclusion?
> 
> We all know that bitmap.h includes bitops.h and this is good and a must, why
> to avoid this?
> 

Well, none at all may be too much.
But being close to it would simplify much changing and especially
understanding the code.

At least avoiding 10 levels of indirection of includes
would be a good start :)

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
