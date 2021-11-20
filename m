Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0EC457F95
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhKTQri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhKTQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:47:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25141C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:44:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so11285045wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jFMMgrcV8K1/gRJILpYzf+/E86LRUWQ+xm+F8PN1BzI=;
        b=BUNrGqDxas1CLevZq8BReaO9t+sjjS/r1MGcarLxFHU2jZ7ecWv6MIacF3PKjt5r4z
         FDIK2ujk3vt0YRTtrQiWjjFnXZw04ZZhhF8j2QsjOWg0W4ZQ392SfCMc3wEWUrS+91jH
         eabg2mY0/T2ZI5j6XSDu7/+ctrOxSgaN29SfspgVfjI+Y2HB4EMffwYSCKQMyjNp0tfI
         II1Vy0z6Tqgum/zcJ26e+QAWbpdtdxKgLoWcGubMeMtWvWMH7hb+wtxkZuy/5E0AoGwy
         xfdVL3X3W0X2Rif8Rn55SM+bTe/Vci+gEONaPerEAV2Puhbryt8Foo7aClYaxrOySPq1
         TJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jFMMgrcV8K1/gRJILpYzf+/E86LRUWQ+xm+F8PN1BzI=;
        b=NeK8oE6XNUhcUiyrZkVQgRPL6MEJQXFzCVh4dETCttn0dOlIoWO06FGboWQevtOzMz
         CQRFkeQWnfp0s9ihnhdRk+0bopw4UiSYWxRzDnEz+k0abHlpqisEtoErvy/P1VBzi6Jw
         SodZPitUQMCS19jhOwMelEvVguNP7O3g8feEuIcpxhVSqMmwBl0tCUas7XjPiU/h4JMr
         1Z9hgOPZzZ0hlHma2V/wPY6IkQNNr2Ho0so/G+XeS1Jv9gQ7HlrW/+TOO04A6D7GCIkK
         o1t7NQGWDGYu0PiLMF4lJ7X0rPkBKEysXoHsmLh6wgumVH6gdq8Pkz26dM2ylpEAb3BW
         KmtQ==
X-Gm-Message-State: AOAM533XG4BAazBSNfH8PppbasaVw6HoWIGeFnwQVeDwJFnitgoE/z5x
        5r/920Qv49TFl7Iq++Sitgs=
X-Google-Smtp-Source: ABdhPJy2MjN/MfLSmmxYlRPF0hXFMNGM6sg73H2w+AwB014XpIev4ylVLrjOV+YEhlZO8WapzIh9zg==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr11622349wmi.151.1637426672802;
        Sat, 20 Nov 2021 08:44:32 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id l18sm3306176wrt.81.2021.11.20.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 08:44:32 -0800 (PST)
Message-ID: <ffc69671-43c8-7b29-5947-2d7837ccc7cd@gmail.com>
Date:   Sat, 20 Nov 2021 17:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 11/20] linux/container_of.h: Cosmetic
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-12-alx.manpages@gmail.com>
 <CAHp75VfYvO2pHTtExLpcY1AmiGAEvvdf_Q_46ZhxR6JD68MNow@mail.gmail.com>
 <8d99e5cc64db64b6262b74aa7a9e04a642a7629f.camel@perches.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <8d99e5cc64db64b6262b74aa7a9e04a642a7629f.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe and Andy,

On 11/20/21 17:33, Joe Perches wrote:
> On Sat, 2021-11-20 at 18:12 +0200, Andy Shevchenko wrote:
>> On Sat, Nov 20, 2021 at 3:03 PM Alejandro Colomar
>> <alx.manpages@gmail.com> wrote:
>>>
>>> Place braces in a ({}) expression
>>> similarly to how a function would have them.
>>
>> I don't think we need this change. ({ on one line is pretty much
>> idiomatic for macros.
> 
> true
> 
> $ grep-2.5.4 -rP --include=*.[ch] -oh '\(\s*\\?\s*\{' * | \
>    sort | uniq -c | sort -rn
>     2756 ({
>       13 {
>       13 ( {
>        4 (			\
>        2 ( \
>        2 (                                \
>        2 (		\
>        1 (	\
>        1 (				\
>        1 (					\
>        1 (									\
>        1 		{
> 
> 

Thanks,
I'll drop that one.

Cheers,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
