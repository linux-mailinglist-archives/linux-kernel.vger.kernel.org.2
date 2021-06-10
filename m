Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5003A2CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFJN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFJN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:28:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 06:26:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623331576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG6fzWWIt6qWZK3IBMGs/xYJLoLBG31sTm79ZD9P7YY=;
        b=k4SQeB1X5HBaHDvB7DhC7HL0Y5KOiUtZm6Ul81+JJ1o4AVH6PVUVUkQEhNUcSFwKrL02ft
        RUkL1XvW44I2L1Y/mim/x7Qe0uiSy04p9vGV31W0aN0NUsBKraodwcXg4fljQOu8jpz7b9
        zDp5RglFp/CFkp9C7kUQF6NnQ2zk62T51WTGyFZDhhL6pNb/upA7X8eTIp/7qIkSMdcJ5t
        NSj5/02QLGSIGIqmawtUekBzn07DbkaOvN1j4HbpEvZKF7YpIRSiNWiNSyNDrSxpqc9bw/
        JmAObtNSpSmVNIZmCeYS0IWdkA4UONMmJFlTD+acORvSy/k6IkR9MrJWY2RWEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623331576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG6fzWWIt6qWZK3IBMGs/xYJLoLBG31sTm79ZD9P7YY=;
        b=AozmGgxT0vXnF1xVNnOTPOz4PZMajcAgl1LMBdSLjxVJ1mEBJjnKK7k+ZIH4XUtglTHra7
        81QjBefDF5XG8vAA==
To:     Petr Mladek <pmladek@suse.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
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
In-Reply-To: <YL91JlCUiD6C05Q2@alley>
References: <20210607200232.22211-2-john.ogness@linutronix.de> <202106081055.UgUlUS1Z-lkp@intel.com> <YL91JlCUiD6C05Q2@alley>
Date:   Thu, 10 Jun 2021 15:26:15 +0200
Message-ID: <877dj1u9zc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
>>    lib/dump_stack.c: In function 'dump_stack_lvl':
>> >> lib/dump_stack.c:107:2: warning: 'lock_flag' is used uninitialized in this function [-Wuninitialized]
>>      107 |  printk_cpu_unlock_irqrestore(lock_flag, irq_flags);
>>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Interesting. I am curious that it does not complain also about
> irq_flags. But it is possible the it reports only the first problem.

Strangely enough, if I set a value for @lock_flag, it is happy and does
not complain about @irq_flags. Probably a compiler oversight.

> Anyway, we will likely need to do some trickery via #define to tell
> the compiler that the value is set.

This is on ARCH=mips and !CONFIG_SMP. So the value is _not_ getting
set. (The static inline function does nothing.)

By changing printk_cpu_unlock_irqrestore() to use pointers:

    static inline void printk_cpu_unlock_irqrestore(bool *lock_flag, unsigned long *irq_flags)

then the warning disappears. Indeed, by not using pointers on unlock,
technically data is copied that was never initialized. I thought maybe
the compiler would optimize all that out, but it seems that it does not.

I have no problems using pointers for unlock(). It was strange using
pointers for lock(), but not for unlock() anyway.

Or would you prefer something else?

John Ogness
