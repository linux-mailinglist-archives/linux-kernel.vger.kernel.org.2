Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F603A3C80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFKHCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:02:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:02:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30D8621996;
        Fri, 11 Jun 2021 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623394835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ekzr2AU25bb7DB9fCYCk3o3bmvIjX/dZw8dEyQ+Vd4s=;
        b=P9hCFsWqufX8cHMi1igIvIi0VYocpYrjlZ74a1hUovDCMRlFDBOoQEU79M8u9X/hHR+49M
        UdL3a+XbldrCaJCQfC3dG0jOcCs/92bfXH/839WjjWYKGVxn2S7hzJ2e7SUqZIZ0zYJJKO
        5lvTfAPy9IuPktMuUn8N+qs9hM/uNJc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3CABA3B8A;
        Fri, 11 Jun 2021 07:00:34 +0000 (UTC)
Date:   Fri, 11 Jun 2021 09:00:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YMMKErwuH7ps8fNe@alley>
References: <20210607200232.22211-2-john.ogness@linutronix.de>
 <202106081055.UgUlUS1Z-lkp@intel.com>
 <YL91JlCUiD6C05Q2@alley>
 <877dj1u9zc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dj1u9zc.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-10 15:26:15, John Ogness wrote:
> On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
> >>    lib/dump_stack.c: In function 'dump_stack_lvl':
> >> >> lib/dump_stack.c:107:2: warning: 'lock_flag' is used uninitialized in this function [-Wuninitialized]
> >>      107 |  printk_cpu_unlock_irqrestore(lock_flag, irq_flags);
> >>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Interesting. I am curious that it does not complain also about
> > irq_flags. But it is possible the it reports only the first problem.
> 
> Strangely enough, if I set a value for @lock_flag, it is happy and does
> not complain about @irq_flags. Probably a compiler oversight.

Yeah, it is strange.

> > Anyway, we will likely need to do some trickery via #define to tell
> > the compiler that the value is set.
> 
> This is on ARCH=mips and !CONFIG_SMP. So the value is _not_ getting
> set. (The static inline function does nothing.)
> 
> By changing printk_cpu_unlock_irqrestore() to use pointers:
> 
>     static inline void printk_cpu_unlock_irqrestore(bool *lock_flag, unsigned long *irq_flags)
> 
> then the warning disappears. Indeed, by not using pointers on unlock,
> technically data is copied that was never initialized. I thought maybe
> the compiler would optimize all that out, but it seems that it does not.
> 
> I have no problems using pointers for unlock(). It was strange using
> pointers for lock(), but not for unlock() anyway.
> 
> Or would you prefer something else?

I would actually prefer to introduce the macros and pass the flags
without referencing.

I was about to write that I did not mind. But then it came to me that
it might be worth being compatible with the other
irqsafe()/irqrestore() APIs. It seems that people are pretty used
to pass flags directly:

$> git grep irqsave.*flags | wc -l
17084
$> git grep irqsave.*\&flags | wc -l
15

That said, I do not resist on it. It will not block the patchset
if you decided to used the pointers. The lock should not be used
widely...

Best Regards,
Petr
