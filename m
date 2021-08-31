Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24F3FC0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhHaC4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHaC4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:56:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:55:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so1339899pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 19:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AvjxB8xiv6vhyzTLX37XxNMhEu4AOfVYHWUw1RynGTs=;
        b=LcDbfg8h77pj9HiMCk164bJNj2c128WiFloKTzvlCsfV9j35JoVoN6K4+MJMAuj6ep
         L7VXntyWCg5GreKw4W71GiQyJXs6pMl4sKgtcnm+iUKE2LyqBn637UCJ9Tpq+vBH5dH0
         LDSvFiSgUA9AjbGMP83g5dzf2ai2Owxsw5uGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvjxB8xiv6vhyzTLX37XxNMhEu4AOfVYHWUw1RynGTs=;
        b=dQvXi3xlqPXJX280ZUNrWFHMvyzYwVKzurmWNfOOsdGIZ8Jn3AEDQYak/LSGsxxOAr
         An2kCXNuHkoWeVb2/ORC692flEtZD+uc029U3dt10ErUq1tt4/rHfYLnaMk1XV1ktvvl
         fXe+NrXshlhHIKHp7HERA+QWI4kDRVDcf2xQrjL2VLaHxk8bXsQXrUFv+VWY8qeZRxgE
         Sxat/f0Ik4Bm/JZNCj3flIVbsgtZKh4iDqKBA4IXa0IJgcpNFBaEvxw9x0VyxUlftfgO
         muNzz87SKRRin6kXfE9DHv5ZM26x3IvrxPQdgeeSivnWNZuGtxJEDdZwQxN/mWrZoQhU
         OKKg==
X-Gm-Message-State: AOAM530TfbUSoyc6zFAo7r70cBvpnxnOkf4HynUC4xEY1ZcCo/e6PZlD
        PLeSqv7Qz0KbAostrUmJJ7m+6w==
X-Google-Smtp-Source: ABdhPJw03Yb7FbPHCPVYncNmoWmE8n3JwHQ1UVAhawvsdVLIsqjK4EzbJrHspDGBLYYGA65M1S6+ig==
X-Received: by 2002:a17:902:a406:b029:12b:c50a:4289 with SMTP id p6-20020a170902a406b029012bc50a4289mr2499299plq.56.1630378508430;
        Mon, 30 Aug 2021 19:55:08 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id j9sm18869509pgl.1.2021.08.30.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:55:08 -0700 (PDT)
Date:   Tue, 31 Aug 2021 11:55:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH printk v1 07/10] console: add write_atomic interface
Message-ID: <YS2aBeymxuiW3CIw@google.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803131301.5588-8-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 15:18), John Ogness wrote:
[..]
> @@ -1993,6 +1993,16 @@ static int console_trylock_spinning(void)
>  	bool spin = false;
>  	unsigned long flags;
>  
> +#ifdef CONFIG_SMP
> +	/*
> +	 * CPUs holding the printk cpulock must not spin on any lock. Even
> +	 * console_trylock() must not be called because its implementation
> +	 * uses spinlocks.
> +	 */
> +	if (atomic_read(&printk_cpulock_owner) == smp_processor_id())
> +		return 0;
> +#endif
> +
>  	if (console_trylock())
>  		return 1;
>  
> @@ -2719,7 +2729,17 @@ static int have_callable_console(void)
>   */
>  static inline int can_use_console(void)
>  {
> -	return cpu_online(raw_smp_processor_id()) || have_callable_console();
> +	int cpu = raw_smp_processor_id();
> +#ifdef CONFIG_SMP
> +	/*
> +	 * CPUs holding the printk cpulock must not spin on any lock.
> +	 * Allowing console usage could call into the spinlocks of the
> +	 * various console drivers.
> +	 */
> +	if (atomic_read(&printk_cpulock_owner) == cpu)
> +		return 0;

I guess the only reason this is done in can_use_console() is
console_flush_on_panic()?

Because otherwise, I think, we can move this check to vprintk_emit().

can_use_console() can be called from preemptible() context. But
if it's called from preemptible() then we know that this is not
printk()/NMI path (but console_device() and friends instead) and
that this CPU is definitely not holding printk CPU lock.

console_trylock_spinning() and console_unlock()->can_use_console()
follow each other

	if (console_trylock_spinning())
		console_unlock();

so a single `atomic_read(&printk_cpulock_owner) == cpu` can suffice.

Now we get to the console_flush_on_panic(), which still calls console_unlock(),
iterates over messages, but when called by the CPU that owns printk_lock,
just skips all the messages. But there is no point in calling console_unlock()
in such a case, we can check if we're printk_cpulock_owner and bail out if so.

Or am I missing something?
