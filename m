Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9A343F66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhCVLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCVLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:13:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E42C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:13:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v186so8391537pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mbopn8hzCJgUALAOGDhuLMSj1tx4x0j6ipILFpuFSzQ=;
        b=f68vkjYTiuGcTqFEoHapQbG5ylfOWafOjzmqlNZdljtrxiNmv5VK+S7Su7x6A+JXFa
         SnRUYIxf03iuND+4bvswWYhnDHHI5WoTsMcKa5OUHg1ziboSxGEs7YOJfssyhrsk7led
         F6aLDttYUWU7JN3NNlByOVnrgd+7vqjZFKn08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mbopn8hzCJgUALAOGDhuLMSj1tx4x0j6ipILFpuFSzQ=;
        b=L0EXQL53E8/XhSTZbovCdiDQUfV4brUY4Ejl9MuISbeNL9xD5fqTf97DyDubhjU15Q
         jDJz/f4RXPJoPEEdjIXcbK9EUdGhVDJoHpa4zUzZVZHvqilckNO0W3ZS9B/82CsbnGVJ
         xFfKaJ7b7kOMaTX4elbsBXDEP97XWGtYDgphs5uP8cNCf3oIfbWn42LC0ugkXJ+bm7X4
         OHO0nlBMJILzCyZfwLmDPjuCGUVGNY9y/7F52SjqTa6F4prcPntLLnIixe4aIyfAHg94
         4mv2Vs2z2TQLm8SGxjjRQfgu5b86m2/RO3C24Sl0+sjFMe2Q5V+9m9C4Z8U3wiDyXV1+
         mZFg==
X-Gm-Message-State: AOAM533qvwog8UkPVwIunuEknJzxKq88oQJ93L/JnMrg5AkUugvCdO0a
        0GM39XmdIWug/euT6bXWbfnxYw==
X-Google-Smtp-Source: ABdhPJw0QI1cJEhLFlzExbGqhMW+fHkQw3w/CI8P9NRyr88PBFWKS/Clhvv+CGHGR3katJPaXCL2rQ==
X-Received: by 2002:a65:5585:: with SMTP id j5mr2986904pgs.316.1616411637538;
        Mon, 22 Mar 2021 04:13:57 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1b5:270:5df6:6d6e])
        by smtp.gmail.com with ESMTPSA id 193sm3822466pfa.148.2021.03.22.04.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:13:57 -0700 (PDT)
Date:   Mon, 22 Mar 2021 20:13:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
Message-ID: <YFh770T97jwQLRKu@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-2-john.ogness@linutronix.de>
 <YFba1Fje6+TeIiGW@google.com>
 <87mtuvmpcl.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtuvmpcl.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/22 11:53), John Ogness wrote:
> On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >> @@ -2055,6 +2122,9 @@ int vprintk_store(int facility, int level,
> >>  	 */
> >>  	ts_nsec = local_clock();
> >>  
> >> +	if (!printk_enter_irqsave(&irqflags))
> >> +		return 0;
> >
> > I guess it can be interesting to somehow signal us that we had
> > printk() recursion overflow, and how many messages we lost.
> 
> Honestly, if we hit 3 levels of recursion, we are probably dealing with
> an infinite recursion issue.

I tend to agree.

> I do not see the value of counting the overflows in that case. The
> logged messages at that recursion level would ben enough to point
> us to the problem.
>
> > 3 levels of recursion seem like reasonable limit, but I maybe wouldn't
> > mind one extra level.
>
> With 3 levels, we will see all the messages of:
>
>     printk -> WARN_ON -> WARN_ON -> WARN_ON

Well, not necessarily this simple.

printk
 vsprintf
  handle_foo_specifier
   printk
    call_console_drivers
     timekeeping
      printk
       vsprintf

We saw in the past that enabling CONFIG_DEBUG_OBJECTS (if I'm not
mistaken) can add quite a bit of extra printk recursion paths.

We also have other CONFIG_DEBUG_* config options that can pop up as
recursive printk-s here and there. For instance, from vsprintf::foo_specifier()
where we escape from printk() to various kernel subsystems: net, block,
etc.

Maybe sometimes on level 3+ we'll see something interesting,
but I've no strong opinion on this.

> Keep in mind that each additional level causes the reading of the logs
> to be significantly more complex. Each level increases the output
> exponentially:

Yes, I realize that. That's why I suggested that maybe recursive
printk-s can have some special extra prefix. Recursive printk-s
will interleave with whatever is being printed on this_cpu, so
prefix might be helpful.

	-ss
