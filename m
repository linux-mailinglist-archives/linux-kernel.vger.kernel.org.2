Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99C36052A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhDOJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhDOJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:03:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:03:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so611629wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GIMWDCBKDJy1lIzhHaK60D03TcZX6qfBwBL0treeLOk=;
        b=AJonxEmC7A53Umcpeu0Abidf9Sb0L3BrC3aEKH5VMyiBH61FV4jGZMckoClDBGx79r
         ZU4CSt82sXpqH51xJjQbnJ4p7dUoD0K0Do8k/TeG/13mrpEdriCIC7Y6UVcu0vVoLyT5
         Xi/C8agJ2OKsx0IrhfZHv5xpur2jD2JMF0hN6FCiz84861pr/C1yCoeNabdy4ippgUqL
         W9DjL5mWCmlol6nsk+EKQAGpYOzTC8ag6iw8v4CBR48sr9jh92PgyHe7w2aTC/D3vvvP
         MGDM1Yh9+Wl+VS6Od+EM7uEahMidtO8Ust+u481T/qiHiVF0LGpAdd8yJugdJhAaq1ii
         5Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GIMWDCBKDJy1lIzhHaK60D03TcZX6qfBwBL0treeLOk=;
        b=EQ/Gztgh7OXnIj2cSI0AGBHrCSKzG8LJCv9pey33aBAvKxTh0xsJU0RsM2KHGUlAO+
         Gpl33Zf9j4+Ye9N5zZVpR9DdP+x+Qzt0lz6ijRGVa+wntCDbk5RyUmd0C9wkXtagLqEa
         IlO3Ych45iI84WLkcyoUUctA/KUYdMpn33c7VhapczWl5FWjN2DKAr5yWBwCv/QLVazO
         cS8ETO3ZUpd3dpRDD22egi/wKFsNrEIU5E6Fu8fDJsR8Yb8hyQIDlNQS8YInMOHQpMRw
         Qsy9aOFt8h6KNOHllXuMcAqXi1SHGYI17TWlYSoKwdVKHIf/CHWd7+bV0PY5pvQkN9Jy
         qaSw==
X-Gm-Message-State: AOAM531FyCOOwxp/XZ17v5LwpLI9gpXvqyILhWz0xVMA6ANgqh/cX4ST
        kGTEv2LGsRSdJP9v/J7wOw6hdA==
X-Google-Smtp-Source: ABdhPJzlFb3cRx4s3QOq/0VgwcQr4s4ln4YYAMHys7YvkG7xEBGyDWrKEotMOXDE84yD6100Y8VYTA==
X-Received: by 2002:a05:600c:4fcb:: with SMTP id o11mr2077482wmq.117.1618477395307;
        Thu, 15 Apr 2021 02:03:15 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
        by smtp.gmail.com with ESMTPSA id v189sm1962157wmg.9.2021.04.15.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:03:14 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:03:09 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/core 18/22] kernel/events/core.c:6418:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <YHgBTRciZNDUkfId@elver.google.com>
References: <202104142209.hLOfOONR-lkp@intel.com>
 <YHb9Mi1IwY5qtJxp@elver.google.com>
 <YHf92aCeN65rANQY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHf92aCeN65rANQY@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:48AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 04:33:22PM +0200, Marco Elver wrote:
> > On Wed, Apr 14, 2021 at 10:10PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > > head:   0da503cd07380952599b67ded6efe030d78ea42d
> > > commit: c7d4112e9f0e69edd649665836ce72008b95ab9f [18/22] perf: Add support for SIGTRAP on perf events
> > [...]
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > [...]
> > >   6416		info.si_errno = event->attr.type;
> > >   6417		info.si_perf = event->attr.sig_data;
> > > > 6418		info.si_addr = (void *)event->sig_addr;
> > >   6419		force_sig_info(&info);
> > 
> > I think it wants the below (feel free to squash into "perf: Add support
> > for SIGTRAP on perf events").
> > 
> > Thanks,
> > -- Marco
> > 
[...]
> 
> Now the silly robot complains about:
> 
> CC      kernel/events/core.o
> ../kernel/events/core.c: In function ‘perf_sigtrap’:
> ../kernel/events/core.c:6418:17: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 6418 |  info.si_addr = (void __user *)event->sig_addr;
> 
> for all 32bit builds (because sig_addr is u64 and the pointer cast
> truncates bits).
> 
> This had me look a little harder at sig_addr and I figured it should be
> next to the pending fields for cache locality.
> 
> I've ended up with the below delta, does that work for you?

Thanks, that works for me. Do note that I explicitly chose u64 for
sig_addr/pending_addr because data->addr is u64. There might be a new
warning about the u64 to unsigned long assignment on 32 bit arches.

Perhaps it needs something ugly like this:

	info.si_addr = (void __user *)(unsigned long)event->pending_addr;

if pending_addr wants to be u64. Or just

	event->pending_addr = (unsigned long)data->addr;

if data->addr being u64 on 32 bit arches is simply overkill.

Thanks,
-- Marco

> ---
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -735,6 +735,7 @@ struct perf_event {
>  	int				pending_wakeup;
>  	int				pending_kill;
>  	int				pending_disable;
> +	unsigned long			pending_addr;	/* SIGTRAP */
>  	struct irq_work			pending;
>  
>  	atomic_t			event_limit;
> @@ -778,9 +779,6 @@ struct perf_event {
>  	void *security;
>  #endif
>  	struct list_head		sb_list;
> -
> -	/* Address associated with event, which can be passed to siginfo_t. */
> -	u64				sig_addr;
>  #endif /* CONFIG_PERF_EVENTS */
>  };
>  
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6415,7 +6415,7 @@ static void perf_sigtrap(struct perf_eve
>  	info.si_code = TRAP_PERF;
>  	info.si_errno = event->attr.type;
>  	info.si_perf = event->attr.sig_data;
> -	info.si_addr = (void __user *)event->sig_addr;
> +	info.si_addr = (void __user *)event->pending_addr;
>  	force_sig_info(&info);
>  }
>  
> @@ -9137,7 +9137,7 @@ static int __perf_event_overflow(struct
>  	if (events && atomic_dec_and_test(&event->event_limit)) {
>  		ret = 1;
>  		event->pending_kill = POLL_HUP;
> -		event->sig_addr = data->addr;
> +		event->pending_addr = data->addr;
>  
>  		perf_event_disable_inatomic(event);
>  	}
