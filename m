Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC163484B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhCXWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhCXWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:36:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A657C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:36:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y6so280670eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrU0LEQQu62szOLJtECwzd0X8FkTv+FPbousgJV4Dpo=;
        b=R8y6i9CNrudieKcvjxBNrtnSuxS7RxwVCeP3FNC+TQrjrAc2dwq+8pr2w8NXzdDX2s
         6eyB4YOTtskT1rFXmdrhfH6DRYaKh7/PIJhE/xX6XUk52fQXCG6wITUDn/Z+ZUSSBiq0
         iZli6dy6oWmu8IBMakexH01HK+MDJ0Wt7wYEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrU0LEQQu62szOLJtECwzd0X8FkTv+FPbousgJV4Dpo=;
        b=UFc8ZC5q+uYdtP72L+Gx/OEM3Z8sk9k9n46cshbbonTXTiOhuKdHr/Dek3ia1bVAL8
         DlFss+HI1A0niH8QincGP7Goxu/oumtUn+MUXZfkSwkPyJBh+rsjvCUePEmVb5PkbZcw
         FkggQlq/SxOrVz6ok/7mqjXpNvAGwX2lZWz8aFGQImaN5ht/+v6o9Kj9KPolnTDdD6h9
         TADUPrw8zPKcFNm3VyXGoJTDYjtpiH3cbVbOSvjO5WrJf7oW6cxCpH4asfVSZeDCJEGP
         cbu4FErbgUSowAhBkOziqnvMOGQhxiLZR/DM42Zw3wiHxnnxPo2O5vXYXMDIdX4XGiSU
         jkAA==
X-Gm-Message-State: AOAM532/HT/32wNUvrc08l51mfpbffdqvC731tz0U+Sm1IAKYXLZH59f
        f5u610+q12XcKU8EQ91PJ04JmgAF634CpGKb
X-Google-Smtp-Source: ABdhPJxp4UjT41TpIcZFj1aJO9MCbPQ7EFBmwG5r4Pmv849nGe8leHxDikCxa6r9PdvKB1Z0UxXp6A==
X-Received: by 2002:aa7:d3ca:: with SMTP id o10mr5873130edr.374.1616625386815;
        Wed, 24 Mar 2021 15:36:26 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id cy5sm1787343edb.46.2021.03.24.15.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:36:26 -0700 (PDT)
Subject: Re: [RFC patch] vsprintf: Allow %pe to print non PTR_ERR %pe uses as
 decimal
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210324121832.3714570-1-arnd@kernel.org>
 <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
 <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
 <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
 <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
 <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
 <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
 <3d66137e-7842-2764-456f-7cc9e54a6d2e@rasmusvillemoes.dk>
 <9d320cd403921f4b36b726b71a51572463599cf5.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <aa3b389e-d433-0243-41c7-9d0b6da24ed7@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 23:36:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9d320cd403921f4b36b726b71a51572463599cf5.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 23.18, Joe Perches wrote:
> On Wed, 2021-03-24 at 22:27 +0100, Rasmus Villemoes wrote:
>> On 24/03/2021 20.24, Joe Perches wrote:
>>> On Wed, 2021-03-24 at 18:33 +0100, Rasmus Villemoes wrote:
>>>> On 24/03/2021 18.20, Joe Perches wrote:
>>>>
>>>>>
>>>>> Maybe it's better to output non PTR_ERR %pe uses as decimal so this
>>>>> sort of code would work.
>>>>
>>>> No, because that would leak the pointer value when somebody has
>>>> accidentally passed a real kernel pointer to %pe.
>>>
>>> I think it's not really an issue.
>>>
>>> _All_ code that uses %p<foo> extensions need inspection anyway.
>>
>> There are now a bunch of sanity checks in place that catch e.g. an
>> ERR_PTR passed to an extension that would derefence the pointer;
>> enforcing that only ERR_PTRs are passed to %pe (or falling back to %p)
>> is another of those safeguards.
>>
>>> It's already possible to intentionally 'leak' the ptr value
>>> by using %pe, -ptr so I think that's not really an issue.
>>>
>>
>> Huh, what? I assume -ptr is shorthand for (void*)-(unsigned long)ptr.
>> How would that leak the value if ptr is an ordinary kernel pointer?
>> That's not an ERR_PTR unless (unsigned long)ptr is < 4095 or so.
> 
> You are confusing ERR_PTR with IS_ERR

No I'm not, I'm just being slightly sloppy - obviously when I say "not
an ERR_PTR" I mean "not the result of ERR_PTR applied to a negative
errno value", or "not the result of a valid invocation of ERR_PTR". But
yes, feel free to read "not an ERR_PTR" as "something for which IS_ERR
is false".

Can you expand on why you think %pe, -ptr  would leak the value of ptr?

>> If you want to print the pointer value just do %px. No need for silly
>> games.
> 
> There's no silly game here.  %pe would either print a string or a value.

A hashed value, that is, never the raw value.

> It already does that in 2 cases.

Yes, if you pass it ERR_PTR(-1234) (where no E symbol exists) or
ERR_PTR(-EINVAL) but CONFIG_SYMBOLIC_ERRNAME=n, it prints the value in
decimal, because people will probably recognize "-22" and values in that
range don't reveal anything about the kernel image. Anything outside
[-4095,0] or so is hashed.

Rasmus
