Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD913B5895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhF1FYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhF1FYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:24:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9128C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:22:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bu12so27840275ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3YaiTLHXg99rHH74lVW6PhlvAYWm3lWi5mDqyJqNpo=;
        b=azmCUVrIdS3Cmx6fNdO2Jyvbkk/AFshB1SEX7WpI/Kez6uOjQqu0RTNKnwqqtReZI0
         HH3PMTPuRQ3cqaSAmfnILttPufm8GnnJJcw9wQpL2F2YIXhotQK5AD2gkWqY7NVZOKjQ
         +9pmCHOUO95yvVUZae9ZLDX7HHicoDHPXyWuMsFEzFGMOzXw52YGzElZ6m0ykAsl/Fwx
         A8vMzeA0mr02qgigkVbHdXX1k4Cn0NKkL5bDCjoZAZZhz4lASU5ks9I2VNzT4yTxOrqO
         kwQl1ZOhQDjwrlKMa85PrMKsipqP/EqcqRAVBj7nk5UVWy7qzAlI9y9NljWS7Alf839m
         Pztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P3YaiTLHXg99rHH74lVW6PhlvAYWm3lWi5mDqyJqNpo=;
        b=KprHL/GYBeYujpNP95FJoEXVUA2mCxr3+70bNwmI9AAUM/sB3bLvmTCZrNPEXCW7fZ
         ppWhAx2bBiQIsSuqOy2OYEtnlHwD/VIMvaSw1GeCFsttJdEfIVeKkj6x2CNUhCigjhvi
         cwF+eIPynq9AQ+q61Wbntvg8BrMAJRxR8N5pOtE2uRxf4GcYGse2yFdSrBA0UxU9aPS3
         Jn/2RuBDLM8RznakMEiqQCUwu8aDmTHNwNaz5uG5g/+fec66Kpv40zrn8dtwMAkdUHWa
         Nrbo/kB+zNvuK/I/Jpbmtd4Kk/qKqkV5Gm6/1klBfRrOvJmcNcnVm5zdjIoB2sL+vxDa
         hMMQ==
X-Gm-Message-State: AOAM531McCrLyAiR7MDK2Ghbj4oOfGiUSVadHkJrniehHVTSmhgCXXSK
        d4/kusVonScRsLIAu5dKJ6Joc/jlwJo=
X-Google-Smtp-Source: ABdhPJz9hJ911FtYIFzJIfuONUWjPndUr3r5f0Q4r7ag0JlFNTdTX+NH1abzelNVR/FDn3JWSmW8qw==
X-Received: by 2002:a17:906:5d11:: with SMTP id g17mr21876575ejt.537.1624857732522;
        Sun, 27 Jun 2021 22:22:12 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id d2sm6270266ejo.13.2021.06.27.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:22:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:22:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sigqueue cache fix
Message-ID: <YNlcgryyawTxPz//@gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com>
 <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
 <YNlapAKObfeVPoQO@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlapAKObfeVPoQO@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

>  - Producer <-> consumer: this is the most interesting race, and I think 
>    it's unsafe in theory, because the producer doesn't make sure that any 
>    previous writes to the actual queue entry (struct sigqueue *q) have 
>    reached storage before the new 'free' entry is advertised to consumers.
> 
>    So in principle CPU#0 could see a new sigqueue entry and use it, before 
>    it's fully freed.
> 
>    In *practice* it's probably safe by accident (or by undocumented 
>    intent), because there's an atomic op we have shortly before putting the 
>    queue entry into the sigqueue_cache, in __sigqueue_free():
> 
>          if (atomic_dec_and_test(&q->user->sigpending))
>                 free_uid(q->user);
> 
>    And atomic_dec_and_test() implies a full barrier - although I haven't 
>    found the place where we document it and 
>    Documentation/memory-ordering.txt is silent on it. We should probably 
>    fix that too.
> 
> At minimum the patch adding the ->sigqueue_cache should include a 
> well-documented race analysis firmly documenting the implicit barrier after 
> the atomic_dec_and_test().

I just realized that even with that implicit full barrier it's not safe: 
the producer uses q->user after the atomic_dec_and_test(). That access is 
not serialized with the later write to ->sigqueue_cache - and another CPU 
might see that entry and use the ->sigqueue_cache and corrupt q->user ...

So I think this code might have a real race on LL/SC platforms and we'll 
need an smp_mb() in sigqueue_cache_or_free()?

Thanks,

	Ingo
