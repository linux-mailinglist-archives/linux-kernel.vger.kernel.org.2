Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC34313305
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBHNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhBHNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:13:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E13C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:12:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id m2so3448872pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJa5SbqbKF4xNTjiToRrNry3Ju0mxfhiOycu/BLXH0Q=;
        b=kctx+M+k1WbpBrNhU6vf4QZhwk9ZBDi6hiiQu8DgnV6b0yd7Keqb7bZNazsyfmQUnC
         x6losCcBMvfQ4zBimPI8RvQKezELY7/0S+pcJq/2vdiiVJMwt/3Yr/jXaK1hfaNwOqcI
         hbBwjMrkA+5Wnsvzvn9jAeVY6/J7bTwIHefPu2s/B5nHHVEvjPb2JdydLedtgLHU4ASq
         q7pChf0SBqU+tfWOoKl10hXwsFf5JpKwUkCqArymxSRdTCIrQ6cvb4IYirtDU+ZOzkOX
         UsYOJfRazwtyph4G0DvOOS1W1OyQygM/DyRoXt7U60WvsbYzqtmBlln15nuYjhP6uODS
         Ts/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJa5SbqbKF4xNTjiToRrNry3Ju0mxfhiOycu/BLXH0Q=;
        b=XWo41ri5UI45mKZXkaAn43wCrrq0XveF/AwqZGvmdf94O9diku2mDhv32MctuuclXx
         QzFR3A3nyjf+LeAXxSwvUuuu5H98TRXDWgSxWPvs+IYWt5nyJFicxjVX6jBiIeLGotdT
         YUtDtkAHdgTzhHef37FqE1qLCczinlSftHulq3SxFihDBIcXFMyg/k7kogIkL5qR8JpX
         EelEeN9rbiBeyoNb0HLnQEv2Nl+vCh/g+fHsrk3f6fzJDgFX9uzvuvaQlGYx/rCW1GCn
         HTCDkvC4bJx6f+V76Om4ZHKTxIlPD3OTS/r5pv9IdKQC8nY6J5K7xDx27zikPjRNR69D
         AHdQ==
X-Gm-Message-State: AOAM531Yi8uo4NaT8EuQoBg4ALB2nA/5EdGObrMJtMawGnTAolb2JEBc
        E3ud2uAEa8gqjYr3v1CpFH8=
X-Google-Smtp-Source: ABdhPJzlavVKhX5a3nfmDpxircgydwSVYxVd2NJVqRwYwfJh67/jWjxMWAjd5uUM46aQFxXS3oo8Wg==
X-Received: by 2002:a63:ec4d:: with SMTP id r13mr16799513pgj.53.1612789942354;
        Mon, 08 Feb 2021 05:12:22 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id b17sm18232965pfo.151.2021.02.08.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:12:21 -0800 (PST)
Date:   Mon, 8 Feb 2021 22:12:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCE4tIrz/u/RkDc/@jagdpanzerIV.localdomain>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
 <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
 <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/08 16:49), Muchun Song wrote:
> On Mon, Feb 8, 2021 at 2:38 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > On (21/02/06 13:41), Muchun Song wrote:
> > > We found a deadlock bug on our server when the kernel panic. It can be
> > > described in the following diagram.
> > >
> > > CPU0:                                         CPU1:
> > > panic                                         rcu_dump_cpu_stacks
> > >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> > >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> > >                                                     __printk_safe_flush
> > >                                                       raw_spin_lock_irqsave(&read_lock)
> > >     // send NMI to other processors
> > >     apic_send_IPI_allbutself(NMI_VECTOR)
> > >                                                         // NMI interrupt, dead loop
> > >                                                         crash_nmi_callback
> >
> > At what point does this decrement num_online_cpus()? Any chance that
> > panic CPU can apic_send_IPI_allbutself() and printk_safe_flush_on_panic()
> > before num_online_cpus() becomes 1?
>
> I took a closer look at the code. IIUC, It seems that there is no point
> which decreases num_online_cpus.

So then this never re-inits the safe_read_lock?

               if (num_online_cpus() > 1)
                       return;

               debug_locks_off();
               raw_spin_lock_init(&safe_read_lock);

	-ss
