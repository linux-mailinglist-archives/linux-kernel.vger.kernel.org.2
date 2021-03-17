Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A628733EDED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCQKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCQKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:03:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:03:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mj10so1598961ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hAN+93EEWsC9k6+TFEu7LJglcAH+scOasCZK2sD+0JM=;
        b=Fr+3zcw7bmFzO/fNASA8aGBB5z67Py8dSxwufcOi0OW6tlv5w5Ul0mVkF/P8q4uwcf
         +Ak1rgowqB79ugAK2s8VoVDLZwX1Vw4bKGppKnk9jdqsql6I/KXh7EPFsE6AEM52E4eP
         ZyilDbnGqCTen9un74H5dDhctp4fXk6KE53B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAN+93EEWsC9k6+TFEu7LJglcAH+scOasCZK2sD+0JM=;
        b=g9VEwyPhvA976L4b8ExyjX7EzFZRI7e1sLUtB9ThdTsJ8GmA8l+lHQmjJ1cW4LOK5c
         kMVCFPoNck1+PcNb0mu7udMwkyI9ZSRYeiNhrPM2I8/E0DtxVJTn80MgZkb7KoK4FeY7
         eocm9yvgVpScUdHsPHcEwfsKpr9x4CbkUGSLoQDDbcdHsBA3PcaMNJmCQMZkozs65rFP
         OgyS67+i32OhWIKyKwNAsJiuWLWh3GLEskCv/nA+EKgN2UZ/l0PaxtOiQrXFtt2zDP7G
         86oYDW40bNCRoI2pLXJsZFn4n6q31l3pWoFXv/iRR2WjcqYXMxTJKuDxNBgXUjTzeWEg
         gxaA==
X-Gm-Message-State: AOAM530D25lnK+l7H73Yx5ezCC1xF8+noxKw5yEj45QwjqcVEC65yDgZ
        wZXciTgll0sFFAXELrs4fnYZ9RXiTQtweg==
X-Google-Smtp-Source: ABdhPJzauUmdx+PyML19JGr7m7iyK3Ntcn+wlHSryr1B2a6LbCh2Ufv+RTR4sWZOpHCUgW196dVkwg==
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr34702559ejb.244.1615975401608;
        Wed, 17 Mar 2021 03:03:21 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id bm10sm12120427edb.2.2021.03.17.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 03:03:21 -0700 (PDT)
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
To:     Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
Date:   Wed, 17 Mar 2021 11:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFHAdUB4lu4mJ9Ar@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2021 09.40, Petr Mladek wrote:
> On Tue 2021-03-16 14:28:12, Chris Down wrote:
>> Rasmus Villemoes writes:
>>> I think it's pointless renaming the symbol to _printk, with all the
>>> churn and reduced readability that involves (especially when reading
>>> assembly "why are we calling _printk and not printk here?"). There's
>>> nothing wrong with providing a macro wrapper by the same name
>>>
>>> #define printk(bla bla) ({ do_stuff; printk(bla bla); })
>>>
>>> Only two places would need to be updated to surround the word printk in
>>> parentheses to suppress macro expansion: The declaration and the
>>> definition of printk. I.e.
>>>
>>> int (printk)(const char *s, ...)

[Of course, one could avoid that on the declaration by making sure the
macro wrapper is defined below.]

>> Hmm, I'm indifferent to either. Personally I don't like the ambiguity of
>> having both a macro and function share the same name and having to think
>> "what's the preprocessor context here?".
> 
> I would prefer to keep _printk. I agree that it creates some churn but
> it is easier to see what is going on.

It is? Nobody except the few who happen to remember about the
printk_index thing are going to understand why, when looking at
disassembly, there's now calls of a _printk function. "Huh, my code just
does pr_err(), I'm not calling some internal printk function". But it's
not up to me, so I'll stop there.

Anyway, on to the other thing I mentioned on dev_err and friends: I
think it would improve readability and make it a lot easier to (probably
in a later patch) add support for all those dev_* and net_* and whatever
other subsystems have their own wrappers if one created a new header,
linux/printk-index.h, doing something like

#ifdef CONFIG_PRINTK_INDEX
#define __printk_index_emit(fmt) do {the appropriate magic} while (0)
#else
#define __printk_index_emit(fmt) do {} while (0)
#endif

#define printk_index_wrap(fmt, real_func, ...) ({ \
  __printk_index_emit(fmt); \
  real_func(__VA_ARGS__); \
})

and then it's a matter of doing

#define printk(fmt, ...) printk_index_wrap(fmt, _printk, fmt, ##__VA_ARGS__)

or

#define _dev_err(dev, fmt, ...) printk_index_wrap(fmt, __dev_err, dev,
fmt, ##__VA_ARGS__)

(yeah, _dev_err is the real function, dev_err is already a macro, so
doing it for dev_* would involve renaming _dev_err to __dev_err. Or one
could fold the printk_index logic into the existing dev_err macro).

That is, avoid defining two different versions of each and every
required wrapper macro depending on CONFIG_PRINTK_INDEX.

One could also record the function a format is being used with - without
that, the display probably can't show a reasonable <level> for those
dev_* function.

Rasmus
