Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88815343037
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTW47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTW4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:56:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC1C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:56:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso6609843pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTLPIzB8jbdebmCT/5vZ8cExdlJigjVKujeq2vKwp60=;
        b=Wp7XFPP6v2MTyMVpWEL+YPWIVSssOnTEsZRjwlLJnw7TQU4mIGsXjJ/BnRLkyZTnxx
         CZr8gJ4HeyOOgQxGygupwxmRlmiTXrYext7ic1Giy7iAR+6Jl02iizr67LMmhAHT2qsb
         dRTrjTMzTsYSBf4ut1O/AY62dvDyR+ITjSART637tEFTmIctonvmRhlH/aZvQDJ70cIU
         O0Z49niVMursoOhV4m+l3SAjFJuG1dpesmDtxr9RO634WDtvfewKsHtC8LnGBQALKqqQ
         MACqcuVcHalbsV9oNcgGr8UaJczsgQSkHGxWxMTjkrb6G/EE4cS+x47CjszpJo6IcSpM
         qesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTLPIzB8jbdebmCT/5vZ8cExdlJigjVKujeq2vKwp60=;
        b=k8YsnJw9QfvL8Vb0YmgMKBPYY68PeaRDabfM6DPXqugkG9TNjo4X+mfb6Fc7MLMsm9
         TIVW/WQ7Q3dhz8GCPQ3nRFjzjHNMQDoOXGVNwy3OpPazDemzaYoCDq4X5X2buKEBaOB2
         04A/WN4hshHArhOkR9wgJwj73xyqa+gPphntZq6aXjYshGuuheKhubNxqA89/o9m5GFx
         Ns+MaICEjBuVfdS1KlMrRSeu3IvVOP8QliBr52+FDNf85evxTiRIJlNjbMa9gEPzH2i5
         xgk81YRBy1cQHVv6z3LOILGNEz8jwWqZjWWZmBdb3a2YsR5NdR9ITZjz4BgGAcNUs5ES
         iXwQ==
X-Gm-Message-State: AOAM533ahGUYm1PdxomconRlM5yA5FA/1BjnJ0FM+/SaxhrVabR4wqnF
        Cyj7l5r1HRGvxoBvSPYomSYSZbssLE+9Ug==
X-Google-Smtp-Source: ABdhPJxdYXttB3z+iyVEGg8FUmLeQYpb8yFnB8ErsbNCNAekMlLJ8rWWot2S6Y7/cqXSG9Np2o0P9g==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr5421995pjr.66.1616280999567;
        Sat, 20 Mar 2021 15:56:39 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o1sm9401696pjp.4.2021.03.20.15.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 15:56:39 -0700 (PDT)
Subject: Re: [PATCHSET 0/2] PF_IO_WORKER signal tweaks
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20210320153832.1033687-1-axboe@kernel.dk>
 <m14kh5aj0n.fsf@fess.ebiederm.org>
 <CAHk-=whyL6prwWR0GdgxLZm_w-QWwo7jPw_DkEGYFbMeCdo8YQ@mail.gmail.com>
 <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a58f115e-2e42-8189-ca79-622db8289c3b@kernel.dk>
Date:   Sat, 20 Mar 2021 16:56:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/21 1:18 PM, Linus Torvalds wrote:
> On Sat, Mar 20, 2021 at 10:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Alternatively, make it not use
>> CLONE_SIGHAND|CLONE_THREAD at all, but that would make it
>> unnecessarily allocate its own signal state, so that's "cleaner" but
>> not great either.
> 
> Thinking some more about that, it would be problematic for things like
> the resource counters too. They'd be much better shared.
> 
> Not adding it to the thread list etc might be clever, but feels a bit too scary.

That would be my immediate concern - it might very well be the right long
term solution, but I'd be wary of doing it upfront and having weird fallout
due to it.

> So on the whole I think Jens' minor patches to just not have IO helper
> threads accept signals are probably the right thing to do.

I do think we should just go with those two - they are simple and
straight forward. I'm also totally fine replacing 2/2 with Eric's
variant if he prefers that, I've confirmed that it works fine for me as
well.

-- 
Jens Axboe

