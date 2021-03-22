Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F509343E79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCVKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:53:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCVKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:53:32 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616410411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp0gL2alME5v9/kBSavy8Q29B216Wshqc+j+rBkpYLg=;
        b=LbDKUc/4ms9UvTlydmD7l/u9oKFpVeqK8gVIQFUMwg0/Djg+qTLxNTUQHmM1T3b339CXCa
        acQYJ/0bpFpYjfN7tFk5JLSQD8LqD90BGdOMKTFLPRmhbgzZii/G8LVrSi1d4l9FoQQ4wT
        v1FyNjtZzkai99qmdWXgLy0LUs7dlklLDqJ5TZE/pMpdP1fa3j+ZtKZreYlcxIhfoz8Eyz
        qT2EfyqRwZTDNnOO8kFgnesJWqgNmZ3ihv9eIpXJ4f+EwoOks7aUeaRuhJKj7FdrDcFuqo
        E1GxzXe1wpS3EYsZQQIkRC/iJt9oDKJtrUCvdPPsuFb4VjO2wBw0PrEaSQeptg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616410411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yp0gL2alME5v9/kBSavy8Q29B216Wshqc+j+rBkpYLg=;
        b=nJgg5NA5QJIa7S1YfHg1f38PCKGCRA00aDzk9QTGgykY0l4TsG3D8qvax3HYs0xjMhfzrP
        V3cVZD18I1HWU9DA==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
In-Reply-To: <YFba1Fje6+TeIiGW@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-2-john.ogness@linutronix.de> <YFba1Fje6+TeIiGW@google.com>
Date:   Mon, 22 Mar 2021 11:53:30 +0100
Message-ID: <87mtuvmpcl.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> @@ -2055,6 +2122,9 @@ int vprintk_store(int facility, int level,
>>  	 */
>>  	ts_nsec = local_clock();
>>  
>> +	if (!printk_enter_irqsave(&irqflags))
>> +		return 0;
>
> I guess it can be interesting to somehow signal us that we had
> printk() recursion overflow, and how many messages we lost.

Honestly, if we hit 3 levels of recursion, we are probably dealing with
an infinite recursion issue. I do not see the value of counting the
overflows in that case. The logged messages at that recursion level
would ben enough to point us to the problem.

> 3 levels of recursion seem like reasonable limit, but I maybe wouldn't
> mind one extra level.

With 3 levels, we will see all the messages of:

    printk -> WARN_ON -> WARN_ON -> WARN_ON

Keep in mind that each additional level causes the reading of the logs
to be significantly more complex. Each level increases the output
exponentially:

   for every line1 in 1st_WARN_ON {
      for every line2 in 2nd_WARN_ON {
         for every line3 in 3rd_WARN_ON {
            print $line3
         }
         print $line2
      }
      print $line1
   }
   print $line0

IMHO 2 levels is enough because we should _never_ hit 2 levels of
recursion. If we do, the log output at that second level should be
enough to point to the bug. IMHO printing a third level just makes
things unnecessarily difficult to read. (My series uses 3 levels as a
compromise on my part. I would prefer reducing it to 2.)

> And maybe we could add some sort of message prefix for high levels of
> recursion nesting (levels 3+), so that things should not be normal
> will be on the radars and, possibly, will be reported.

I considered this, but am very hesitant to change the output
format. Also, the CUT_HERE usage (combined with PRINTK_CALLER) seem to
be enough.

John Ogness
