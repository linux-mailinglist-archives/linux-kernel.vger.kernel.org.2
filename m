Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF794059DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhIIPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbhIIPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:01:10 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:00:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 6so2820910oiy.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cdZ5UReirNbJCz4qtRz9jPX8lIr89503B9bA6FIRuzQ=;
        b=jDgnkGSK/AzbQ/fvUe+F8Q6VZgBkRHWd4DcBMpA845U1VP2maB6KuDUGyL8c2z1MQ5
         UX6S2hMX3XaL+wIg8XPiRW3uTqvaEgPp8GwPJPJByHRkVu8WdVGBxNU7ND2J8PWd6MjQ
         1BL0tMyxa7ZdE0Z2Q+WzTnNgCJ+YMSVMHlQ3G1GlF5G2afc7lU4RB3k5FIovm8QarUG7
         RPmR6TFjaMcSuvD67sPx0N8yWJj2K9lVY4kxvs9O3saKM+uEhuFWmi956IZGiUFIdrmY
         hqz6C5u3zKx731XS7IajOTZL1HWrKGy6fsTJ74ufvBqwljrPlIixlbiTt+K2g3iOZX5u
         avbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdZ5UReirNbJCz4qtRz9jPX8lIr89503B9bA6FIRuzQ=;
        b=AaCqov0hhO/9VyFyEd/zvAcQBB5SZfMYe/p4ZwuIzOsuH/m91Uq/6E2OlDUhrdicwH
         7JVH7G5ZgR1omXf6dgn3ufiWCu8uEEkeo4SA+97VboR63KaaikX0C/ZkNebjYfKLZNi/
         I2tV3Fiba3yq3x2VLw+kl4Y4ULNmzkB2e1W0doND+RcVtYy8+7aSDKJFzJmLy+FpdO/q
         mdI1yYe7PSybNs2rcOGptV17/Yxguf/3UGn9eJTlqsbxGZnkKjANsSKDC5F3dOa0iWSl
         MJzVWw8iOczNUpKUe2qGG8jGL1S0LPxLGp3AuB2j9J2Y1M/opr7xrp9M8o8Gt/07g59b
         68XA==
X-Gm-Message-State: AOAM533Vrxak+H7jQ6bkqnSROWzgCQfzE0Fws2WcOHoxwlb5Hxk/jhX0
        foeHE0AACGzxt7EnDH6YWO4=
X-Google-Smtp-Source: ABdhPJy29+VUAR+47DHLnfifhIlBecXxb8pFnECJqaJhWQNcxsfS3c0Ish2MaEwbx71o2d1eL5rWmg==
X-Received: by 2002:aca:1709:: with SMTP id j9mr233084oii.120.1631199599971;
        Thu, 09 Sep 2021 07:59:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l44sm475368otv.81.2021.09.09.07.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 07:59:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <a04c4c37-7151-ef7e-09ce-a61ac7b12106@roeck-us.net>
 <78aeab09-de88-966f-9f03-a2d56a0a6064@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <80a56a5a-5351-1897-b87e-3c3cd84bb13c@roeck-us.net>
Date:   Thu, 9 Sep 2021 07:59:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <78aeab09-de88-966f-9f03-a2d56a0a6064@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 12:30 AM, Christian König wrote:
> Am 09.09.21 um 08:07 schrieb Guenter Roeck:
>> On 9/8/21 10:58 PM, Christoph Hellwig wrote:
>>> On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
>>>> It'd be good to avoid. It has helped uncover build issues with KASAN in
>>>> the past. Or at least make it dependent on the problematic architecture.
>>>> For example if arm is a problem, something like this:
>>>
>>> I'm also seeing quite a few stack size warnings with KASAN on x86_64
>>> without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
>>> few warnings without KASAN, but with KASAN there are a lot more.
>>> I'll try to find some time to dig into them.
>>>
>>> While we're at it, with -Werror something like this is really futile:
>>>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function ‘amdgpu_bo_support_uswc’:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
>>> Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Wcpp
>>>    493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
>>>        |  ^~~~~~~
> 
> Ah, yes good point!
> 
>>
>> I have been wondering if all those #warning "errors" should either
>> be removed or be replaced with "#pragma message".
> 
> Well we started to add those warnings because people compiled their kernel with CONFIG_MTRR and CONFIG_X86_PAT and was then wondering why the performance of the display driver was so crappy.
> 
> When those warning now generate an error which you have to disable explicitly then that might not be bad at all.
> 
> It at least points people to this setting and makes it really clear that they are doing something very unusual and need to keep in mind that it might not have the desired result.
> 

That specific warning is surrounded with "#ifndef CONFIG_COMPILE_TEST"
so it doesn't really matter because it doesn't cause test build failures.
Of course, we could do the same for any #warning which does now
cause a test build failure.

Guenter
