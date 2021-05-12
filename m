Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB637EEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385842AbhELWKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389945AbhELVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:04:03 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2143C0611BA
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:55:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jm10so12818065qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mv09EXSN8YMgLNRJHYq6AfwdGG3FEKwFc2Di0Cry05Q=;
        b=leSeXQeHW5ZY4wdM4lD6mAJGIIVaOJvSk903NpWsPuieedUZVhYbK9uu8YHNBHTM/U
         kv4TbjioAYnTIVDviYbXczNiTzwIZc+EwgAY5DT0PkJnUGnahGDDWc2KTZ4lFjA7p0Ip
         fokkDzLZK+/ED+9Du5nzJmUd1i/2QJ3dKmlg3l25pML/xUmjF7mRoKy0im+1dAR4i0K+
         RqxJi9qKIBOGFTrZkbORJoHHl0RymVnk0yMzWYlkrniSodl2A1C7ZGZpHPql8TGF5mDA
         AYuff76dSJlLnWAOaeayXh/I1K/MfZjfG31C+fwv+EHX5SSSZcK/7dJvePb+aoa+8Q7y
         moAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mv09EXSN8YMgLNRJHYq6AfwdGG3FEKwFc2Di0Cry05Q=;
        b=eHP610HeWyhZ1+0HOejrPWQw3x8UeOOeHX6xMNyY5lBEQUvZ7cT3fdFLiKsNhebbn6
         hxwu1up9inPrAn9A46SEEDqNGJ4Bt3JbOImgzJfylhaMHOuVjj3T2aUFJrrufgipl1w7
         XtjXzt5wPDhRuq2cmGMsN4QBVI1u9+OMy67NGnD+jv7qnuCmy0zvch0e59IW7lbCm2yh
         4u7nbMpPWZaU3N2/0nD+NHuaY78vhrIm5NnaOn/zYVnHM3trg6Tyf4Yf46dIyKIk3cUw
         2g3V1ltygf5KAKKe5cOs7tr3kQ6xqsYI0om1BpBHONBJejkgBq2uSLB2SlbzVnUtbYkz
         k9og==
X-Gm-Message-State: AOAM533YG3LSaRIAEoghkdPW8+uPJiNYwRvIucvB9S+7q7nIi1nhBj0U
        2yw9vAUwAeZiQpI+I1inklww2Q==
X-Google-Smtp-Source: ABdhPJxy5Q2QantP/1nAIpA42y0zMuSNsfAG7ZAl/LlMVllxl4TSu4B8/lkq5CNkZEQ3M1wtD2C0HA==
X-Received: by 2002:ad4:4c49:: with SMTP id cs9mr37114961qvb.43.1620852914734;
        Wed, 12 May 2021 13:55:14 -0700 (PDT)
Received: from [172.19.131.127] ([8.46.72.121])
        by smtp.gmail.com with ESMTPSA id n17sm975665qke.14.2021.05.12.13.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:55:14 -0700 (PDT)
Subject: Re: [PATCH] io_thread/x86: don't reset 'cs', 'ss', 'ds' and 'es'
 registers for io_threads
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Olivier Langlois <olivier@trillion01.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <8735v3ex3h.ffs@nanos.tec.linutronix.de>
 <3C41339D-29A2-4AB1-958F-19DB0A92D8D7@amacapital.net>
 <CAHk-=wh0KoEZXPYMGkfkeVEerSCEF1AiCZSvz9TRrx=Kj74D+Q@mail.gmail.com>
 <CALCETrV9bCenqzzaW6Ra18tCvNP-my09decTjmLDVZZAQxR6VA@mail.gmail.com>
 <CAHk-=wgo6XEz3VQ9ntqzWLR3-hm1YXrXUz4_heDs4wcLe9NYvA@mail.gmail.com>
 <d26e3a82-8a2c-7354-d36b-cac945c208c7@kernel.dk>
 <CALCETrWmhquicE2C=G2Hmwfj4VNypXVxY-K3CWOkyMe9Edv88A@mail.gmail.com>
 <CAHk-=wgqK0qUskrzeWXmChErEm32UiOaUmynWdyrjAwNzkDKaw@mail.gmail.com>
 <8735v3jujv.ffs@nanos.tec.linutronix.de>
 <CAHk-=wi4Dyg_Z70J_hJbtFLPQDG+Zx3dP2jB5QrOdZC6W6j4Gw@mail.gmail.com>
 <12710fda-1732-ee55-9ac1-0df9882aa71b@samba.org>
 <CAHk-=wiR7c-UHh_3Rj-EU8=AbURKchnMFJWW7=5EH=qEUDT8wg@mail.gmail.com>
 <59ea3b5a-d7b3-b62e-cc83-1f32a83c4ac2@kernel.dk>
 <17471c9fec18765449ef3a5a4cddc23561b97f52.camel@trillion01.com>
 <CAHk-=whoJCocFsQ7+Sqq=dkuzHE+RXxvRdd4ZvyYqnsKBqsKAA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3df541c3-728c-c63d-eaeb-a4c382e01f0b@kernel.dk>
Date:   Wed, 12 May 2021 14:55:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whoJCocFsQ7+Sqq=dkuzHE+RXxvRdd4ZvyYqnsKBqsKAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 11:44 AM, Linus Torvalds wrote:
> On Tue, May 11, 2021 at 9:24 PM Olivier Langlois <olivier@trillion01.com> wrote:
>>
>> I have reported an issue that I have with a user process using io_uring
>> where when it core dumps, the dump fails to be generated.
>> https://github.com/axboe/liburing/issues/346
> 
> I suspect most kernel developers don't have github notifications
> enabled. I know I have them disabled because it would be *way* too
> noisy not to.
> 
> But maybe Jens does for that libiouring part.
> 
>> Pavel did comment to my report and he did point out this thread as
>> possibly a related issue.
> 
> I don't think this is related. The gdb confusion wouldn't affect core
> dump generation.
> 
> I don't see why a core-dump shouldn't work from an IO thread these
> days - the signal struct and synchronization should all be the same as
> for a regular user thread.
> 
> That said, I do wonder if we should avoid generating core dumps from
> the IO worker thread itself. The IO thread itself should never get a
> SIGSEGV/SIGBUS anyway, it should have been turned into -EFAULT.
> 
> So maybe the
> 
>                 if (current->flags & PF_IO_WORKER)
>                         goto out;
> 
> in kernel/signal.c should be moved up above the do_coredump() logic regardless.

I actually think that's how I originally had it, but Eric had some comment
on that and we moved it. IIRC. I'll dig out the conversation.

> Jens, have you played with core-dumping when there are active io_uring
> threads? There's a test-program in that github issue report..

Yes, I also did that again after the report, and did so again right now
just to verify. I'm not seeing any issues with coredumps being generated
if the app crashes, or if I send it SIGILL, for example... I also just
now tried Olivier's test case, and it seems to dump just fine for me.

I then tried backing out the patch from Stefan, and it works fine with
that reverted too. So a bit puzzled as to what is going on here...

Anyway, I'll check in on that github thread and see if we can narrow
this down.

-- 
Jens Axboe

