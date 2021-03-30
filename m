Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E307234E82B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhC3M74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhC3M7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:59:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:59:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617109171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrXdbF6JNK22B0Ib1PTXUdIbtdImM9W8KLqmLh/KayI=;
        b=zV4nV4hO76pdNDueYD4snO031cpFzHJ5/u0r02BRlnzHGSwSRahjByKm7TdR6FZYpt1YmM
        TsY4zVZJkBZgSyuCxnZsdXesJUMZfV4KhMYSY1nnf3nNI18uC3nfupT2zZmWvYEEuH1OKK
        +Zw1s6GFGnnyyaEr2YUqNLpi7VmMLZCidFdV+Dze2F8USX0cpwl6NAXlM1j+ukOy9LSiTP
        Jhw0j3jDrNS3rP6Vum3TlsfDk8cnjAi9VqmHctcJWjojs9VFmdtGi/sODeVRdt+qfgT8Vb
        o//0MJL0J+UDSHcko2sJJlsNdyfKKpsiHwHwiduJ6si9v3UCo3rYVLXer2kfsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617109171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrXdbF6JNK22B0Ib1PTXUdIbtdImM9W8KLqmLh/KayI=;
        b=SXSnjYvACbPdtKsPQI3W3i/brG/6DCOIryj7c3AiL7iFI9qSz5LVBeWivFXozcUTZVUfoj
        YVp4w/1M2jNQdzAg==
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: rename vprintk_func to vprintk
In-Reply-To: <YGMad9xq1avluv5T@alley>
References: <20210323144201.486050-1-linux@rasmusvillemoes.dk> <YGMad9xq1avluv5T@alley>
Date:   Tue, 30 Mar 2021 14:59:31 +0200
Message-ID: <87k0po4x1o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-30, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2021-03-23 15:42:01, Rasmus Villemoes wrote:
>> The printk code is already hard enough to understand. Remove an
>> unnecessary indirection by renaming vprintk_func to vprintk (adding
>> the asmlinkage annotation), and removing the vprintk definition from
>> printk.c. That way, printk is implemented in terms of vprintk as one
>> would expect, and there's no "vprintk_func, what's that? Some function
>> pointer that gets set where?"
>> 
>> The declaration of vprintk in linux/printk.h already has the
>> __printf(1,0) attribute, there's no point repeating that with the
>> definition - it's for diagnostics in callers.
>> 
>> linux/printk.h already contains a static inline {return 0;} definition
>> of vprintk when !CONFIG_PRINTK.
>> 
>> Since the corresponding stub definition of vprintk_func was not marked
>> "static inline", any translation unit including internal.h would get a
>> definition of vprintk_func - it just so happens that for
>> !CONFIG_PRINTK, there is precisely one such TU, namely printk.c. Had
>> there been more, it would be a link error; now it's just a silly waste
>> of a few bytes of .text, which one must assume are rather precious to
>> anyone disabling PRINTK.
>> 
>> $ objdump -dr kernel/printk/printk.o
>> 00000330 <vprintk_func>:
>>  330:   31 c0                   xor    %eax,%eax
>>  332:   c3                      ret
>>  333:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>>  33a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
>> 
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> Nice clean up!
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> John,
>
> it conflicts with the patchset removing printk safe buffers[1].
> Would you prefer to queue this into the patchset?
> Or should I push it into printk/linux.git, printk-rework and you would
> base v2 on top of it?

Please push it to printk-rework. I will base my v2 on top of it.

Thanks.

John
