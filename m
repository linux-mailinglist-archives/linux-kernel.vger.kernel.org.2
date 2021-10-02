Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1647541FB2D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhJBLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:43:26 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45894 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhJBLnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:43:25 -0400
Received: by mail-ed1-f46.google.com with SMTP id r18so44363770edv.12;
        Sat, 02 Oct 2021 04:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9tDiOVgsOJM22Fe9m6y3O2Yzwc8y2p0M/sgl00e/dH4=;
        b=QYz6aUt9kyrNtreu2+4dXVd4VxZfo0adaTR9T+3eomGjmIH+1ljKMCKSP1/dJ2T2JA
         jPBdZI+ICE1HGkO+ccvoWf975Q3tnR5P0KTyJtIS9uAlWtKzIoCPvA9/SeIQmI5sDO90
         eXmImYirHKZ+EZQTM8xdbfM58iQp1YI/tv7TxvXV/xPadq23wzKq/igTYz17RBDsC+je
         Ud1IQa04+VzUhdadKC11IGoHkfW6RuTmlPVpv0q73twGK828fYcSV7HLyj0QpI2IQ07k
         PCnat8gQfInRHacDzOYZjSlbfzQaZyPeinV3jhh4gGrLBleSXluxQpYzB2CouX4ZnAo2
         eNWQ==
X-Gm-Message-State: AOAM532rCcAHRMjFaVFuAXMR2cjv46TYEcgH3JEuhNzx731XbHOCcGvT
        U6IPmRKR3keaQDxYNJh3XG8=
X-Google-Smtp-Source: ABdhPJxJ7mL8CuDeamuLJyE93IBziQGzJIvvcMtkhnIEfPrNJtB4lpsvJK/qZiDiTKzyLd8ktoP4LA==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr3627978ejj.441.1633174898735;
        Sat, 02 Oct 2021 04:41:38 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id r26sm4091367ejd.85.2021.10.02.04.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 04:41:38 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        notify@kernel.org
References: <20210929185823.499268-1-alex.popov@linux.com>
 <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1> <YVWAPXSzFNbHz6+U@alley>
 <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <ba67ead7-f075-e7ad-3274-d9b2bc4c1f44@linux.com>
Date:   Sat, 2 Oct 2021 14:41:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2021 22:59, Linus Torvalds wrote:
> On Thu, Sep 30, 2021 at 2:15 AM Petr Mladek <pmladek@suse.com> wrote:
>>
>> Honestly, I am not sure if panic_on_warn() or the new pkill_on_warn()
>> work as expected. I wonder who uses it in practice and what is
>> the experience.
> 
> Afaik, there are only two valid uses for panic-on-warn:
> 
>  (a) test boxes (particularly VM's) that are literally running things
> like syzbot and want to report any kernel warnings
> 
>  (b) the "interchangeable production machinery" fail-fast kind of situation
> 
> So in that (a) case, it's literally that you consider a warning to be
> a failure case, and just want to stop. Very useful as a way to get
> notified by syzbot that "oh, that assert can actually trigger".
> 
> And the (b) case is more of a "we have 150 million machines, we expect
> about a thousand of them to fail for any random reason any day
> _anyway_ - perhaps simply due to hardware failure, and we'd rather
> take a machine down quickly and then perhaps look at why only much
> later when we have some pattern to the failures".
> 
> You shouldn't expect panic-on-warn to ever be the case for any actual
> production machine that _matters_. If it is, that production
> maintainer only has themselves to blame if they set that flag.
> 
> But yes, the expectation is that warnings are for "this can't happen,
> but if it does, it's not necessarily fatal, I want to know about it so
> that I can think about it".
> 
> So it might be a case that you don't handle, but that isn't
> necessarily _wrong_ to not handle. You are ok returning an error like
> -ENOSYS for that case, for example, but at the same time you are "If
> somebody uses this, we should perhaps react to it".
> 
> In many cases, a "pr_warn()" is much better. But if you are unsure
> just _how_ the situation can happen, and want a call trace and
> information about what process did it, and it really is a "this
> shouldn't ever happen" situation, a WARN_ON() or a WARN_ON_ONCE() is
> certainly not wrong.
> 
> So think of WARN_ON() as basically an assert, but an assert with the
> intention to be able to continue so that the assert can actually be
> reported. BUG_ON() and friends easily result in a machine that is
> dead. That's unacceptable.
> 
> And think of "panic-on-warn" as people who can deal with their own
> problems. It's fundamentally not your issue.  They took that choice,
> it's their problem, and the security arguments are pure BS - because
> WARN_ON() just shouldn't be something you can trigger anyway.

Thanks, Linus.
And what do you think about the proposed pkill_on_warn?

Let me quote the rationale behind it.

Currently, the Linux kernel provides two types of reaction to kernel warnings:
 1. Do nothing (by default),
 2. Call panic() if panic_on_warn is set. That's a very strong reaction,
    so panic_on_warn is usually disabled on production systems.

From a safety point of view, the Linux kernel misses a middle way of handling
kernel warnings:
 - The kernel should stop the activity that provokes a warning,
 - But the kernel should avoid complete denial of service.

From a security point of view, kernel warning messages provide a lot of useful
information for attackers. Many GNU/Linux distributions allow unprivileged users
to read the kernel log (for various reasons), so attackers use kernel warning
infoleak in vulnerability exploits. See the examples:
https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html
https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
https://googleprojectzero.blogspot.com/2018/09/a-cache-invalidation-bug-in-linux.html

Let's introduce the pkill_on_warn parameter.
If this parameter is set, the kernel kills all threads in a process that
provoked a kernel warning. This behavior is reasonable from a safety point of
view described above. It is also useful for kernel security hardening because
the system kills an exploit process that hits a kernel warning.

Linus, how do you see the proper way of handling WARN_ON() in kthreads if
pkill_on_warn is enabled?

Thanks!

Best regards,
Alexander
