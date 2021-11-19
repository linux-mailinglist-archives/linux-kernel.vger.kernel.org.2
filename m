Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF1457680
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhKSSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235193AbhKSSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637346952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgWP6xNa+jpQwS6DkS1zn+lf6uHsgWR6k/PugODvNqA=;
        b=SMlGiXE11U563c7ojzffa3cvwj2gm/+rpoWYqPp/fCAhMtRlDjpZ4jXqaW6WpyJ/N77l7H
        PGbNeFifYH89bu+qAD9sKfloPiCfSM+4e4MXuy2H3en22VvB1QvfhTV2RQhsHgGw/ytWSm
        Sy6cQF4QYnqrfLcxyA2zYI4+UUusFVA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-fi0mbDa1O0-koNpzt5tn_A-1; Fri, 19 Nov 2021 13:35:49 -0500
X-MC-Unique: fi0mbDa1O0-koNpzt5tn_A-1
Received: by mail-qk1-f198.google.com with SMTP id u8-20020a05620a454800b00468482aac5dso8536811qkp.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgWP6xNa+jpQwS6DkS1zn+lf6uHsgWR6k/PugODvNqA=;
        b=E5a/K3J+A11neJmwB1Yx/opPVnXL+et8/2xkRvZio5fBQtaZdxDkROFlfPqJhODW5D
         vKtKjc/O/kvbMwlFGmDFLdLqbVC2AVF5NBzWG4e+AFk5oLazRvVB3t5IUIjszNt9urIq
         yKiRkc5uOJjK9sibjjoO3odGd1VSyeCb6m8Wwgj/DKbDPsgBic2vcH69G8b9e6OO6p86
         lV4MVKkMmcPRdfGA4uq7bj4PVJdzDucPLiWxHBDPqHrrlxVI0CBKl3+D5JLUpUdLWKni
         IXfA5UbFP6vpCmg7cu8755REtNin6zkFnC20KJIk5cf33gtQowSLMC1yy6XqeJ2nwePj
         87SQ==
X-Gm-Message-State: AOAM5323+vqtHRN7nrkxBTo9eNq4AM/Ck29578EURQa86C/J5aUW8Bnz
        /y9z8Wazekn6gfsaQFgchT+NayTheOWsKadOW8b9t+l6tLlEGvf0G7yc1w1+H/Au5s1NdPhNNzV
        dgy/v0fi434eAr+L0abhJqJZz
X-Received: by 2002:a05:6214:2a8b:: with SMTP id jr11mr75820786qvb.19.1637346948941;
        Fri, 19 Nov 2021 10:35:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjEgRwHrPBoLnCBZW6+Lj1tMIFlecHbiuJPj8EtAzjeBf5w4PMRBUWYgLB68yXc97jPRjXTQ==
X-Received: by 2002:a05:6214:2a8b:: with SMTP id jr11mr75820748qvb.19.1637346948672;
        Fri, 19 Nov 2021 10:35:48 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id q20sm259237qkl.53.2021.11.19.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:35:48 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:35:44 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Holger Hoffst??tte <holger@applied-asynchrony.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] x86: Pin task-stack in __get_wchan()
Message-ID: <20211119183544.sragh42cn2liu3pw@treble>
References: <20211117101657.463560063@linuxfoundation.org>
 <YZV02RCRVHIa144u@fedora64.linuxtx.org>
 <55c7b316-e03d-9e91-d74c-fea63c469b3b@applied-asynchrony.com>
 <CAHk-=wjHbKfck1Ws4Y0pUZ7bxdjU9eh2WK0EFsv65utfeVkT9Q@mail.gmail.com>
 <20211118080627.GH174703@worktop.programming.kicks-ass.net>
 <20211118081852.GM174730@worktop.programming.kicks-ass.net>
 <YZYfYOcqNqOyZ8Yo@hirez.programming.kicks-ass.net>
 <YZZC3Shc0XA/gHK9@hirez.programming.kicks-ass.net>
 <20211119020427.2y5esq2czquwmvwc@treble>
 <YZduix64h64cDa7R@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZduix64h64cDa7R@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:29:47AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 18, 2021 at 06:04:27PM -0800, Josh Poimboeuf wrote:
> > On Thu, Nov 18, 2021 at 01:11:09PM +0100, Peter Zijlstra wrote:
> 
> > > I now have the below, the only thing missing is that there's a
> > > user_mode() call on a stack based regs. Now on x86_64 we can
> > > __get_kernel_nofault() regs->cs and call it a day, but on i386 we have
> > > to also fetch regs->flags.
> > > 
> > > Is this really the way to go?
> > 
> > Please no.  Can we just add a check in unwind_start() to ensure the
> > caller did try_get_task_stack()?
> 
> I tried; but at best it's fundamentally racy and in practise its worse
> because init_task doesn't seem to believe in refcounts and kthreads are
> odd for some raisin. Now those are fixable, but given the fundamental
> races, I don't see how it's ever going to be reliable.

I'm probably out of the loop here, but I wonder what races you're
referring to.

And I assume 'stack_refcount > 0' only needs to be asserted when
unwinding other tasks, not current.  So it shouldn't affect unwinds
during boot, or oopses.

Yes, the unwinder has to be rock solid, but if the caller can't even
ensure the given task's memory exists, it sounds like a bug in the
caller that needs a warning.

-- 
Josh

