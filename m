Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7B36656A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhDUG2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbhDUG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:28:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCADC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:27:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r20so12042348ejo.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubbveyGFGB9lGxZ2PsZnYO9Uh9BiFCaQmbz5AkePdx0=;
        b=0pOaCnRqDIIyyObKB+tQkHS6fLbcV4AILR/VdvFgpScvYjYEeh5bvwD62LwHKuRpbI
         MGYLRzMdQQMu+SFjyp1BhhXZTOm98ezI745/Za/FD8BnX6pKHmocYt5CjJyqRPe77IRH
         oERK4OZmBAOknovn8ndhPfwQXWdJdhJZcR2eZBVZ3QWlEhlt4Oy1+ucvnCnfqzGFNIdJ
         9FJp2UEaMKb5lE3yruWA7I9iTwIyNuMUmXhDFqUcJ2F2vYQnFylFeiRkYsr33TkzfXqB
         reYVuxtge1OCrihEboyaFD3JNhu84sb/lP74yKy4wCZPrMDrHADD1sEr+8AhyfyQPMit
         Km1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubbveyGFGB9lGxZ2PsZnYO9Uh9BiFCaQmbz5AkePdx0=;
        b=lGi+cQmfIWuxcL/9Kq0yIdOFNJ5K0ZdCBVGkUtRmlehSPQA2yUNp6D3K1JFRweA3fQ
         gWNnDZKEwUg6WSArNQWwoxDVmtbyQIr+fTf/1ePawoNxDW2dMu4jj6jy+TIme+8tVwE9
         uGfW2iMP4zc4aqEoqfH6TP75IgHGdNzZ1bcqaXpkIw/bqqAE3YhF+irDS8lvYWLHjz9Y
         IWW+OXw+O8y2DwKvz6UAbHKq24t8NvVhb0UzE0t1DOAZ31fPD6Wstr8bQSc0n0vwVU5K
         tsiN3fRHvViA0cEycDDuSqc4tcBSAOoN76Wjyctge1HvQVa0E5iY1zkJrYjh1uKWOJoM
         5oKQ==
X-Gm-Message-State: AOAM530OkP7d4E+6q5ZMc12lFjBZrNEVNthwErPkaAkRbNZsoPct2R8I
        owfxU0cFqXJwFfmJZNAS4V2s7XkKgHBYG7e7rf5JAg==
X-Google-Smtp-Source: ABdhPJwjK38YokcWOj87eRYHESjhBVScHpMQSqg8IL5vTvDH0sI422rrgmIsqrzKWo6B/OSqWobRNEJa7xW8XcK+7o0=
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr4871361ejj.523.1618986446803;
 Tue, 20 Apr 2021 23:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
 <877hc64klm.fsf@rustcorp.com.au> <20130813111442.632f3421@gandalf.local.home>
 <87siybk8yl.fsf@rustcorp.com.au> <20130814233228.778f25d0@gandalf.local.home>
 <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
 <20210419181111.5eb582e8@gandalf.local.home> <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
 <20210420085532.4062b15e@gandalf.local.home> <CAPcyv4gHHPdCYPzLeNzX0KMoNrOf8H0N5PBiWam0wF+WhV-Jpg@mail.gmail.com>
 <20210420163243.45293c9a@gandalf.local.home>
In-Reply-To: <20210420163243.45293c9a@gandalf.local.home>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Apr 2021 23:27:19 -0700
Message-ID: <CAPcyv4gS7iDrahX9i0PGMhR4k14XVkrCyGk3ZX8JEtO9RAQDhw@mail.gmail.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 1:33 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 20 Apr 2021 12:54:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Apr 20, 2021 at 5:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > The dev_dbg() filter language is attractive, it's too bad
> > >
> > > Not sure what you mean by that. What filter language. Tracepoints do have a
> > > pretty good filtering too.
> >
> > I'm trying to replicate dev_dbg() usability with tracing. So, when
> > people say "don't use dev_dbg() for that" that tracing can reliably
> > replace everything that dev_dbg() was offering. What I think that
> > looks like is the ability to turn on function tracing by a function
> > name glob in addition to any tracepoints in those same functions all
> > from the kernel boot command line, or a module parameter.
>
> You can enable functions on the kernel command line in globs (and trace
> events as well). And if the kernel command line doesn't work properly (it's
> not as tested as the run time side is), it should be trivial to fix it.
>
>
> >
> > > > trace_printk() has such a high runtime cost as combining dynamic-debug
> > > > and tracing would seem to be a panacea.
> > >
> > > trace_printk() has a high runtime cost? Besides that it's not allowed on
> > > production code (see nasty banner), it is made to be extremely fast.
> > > Although, it does do sprintf() work.
> >
> > I was referring to the banner. dev_dbg() does not have that production
> > code restriction.
>
> You can have a tracepoint like trace_printk that doesn't give a banner.
> Basically, the reason trace_printk() has that restriction is because you
> can't filter it like you can trace events. It's similar to a printk(). If I
> had allowed trace_printk() in the kernel, it would be all over the place,
> and it would just add a bunch of noise to the trace output, because its
> either on or off. And if you have trace_printk() and so would all other
> systems, and then you would deal with trace_printk()s from everyone which
> could drown out the ones you want. Hence, I added that banner to keep that
> from happening. trace_printk() will even drown out events. (I hate it when
> I leave one in my debug kernel, and it adds a bunch of noise against what
> I'm trying to debug with events!).
>
> But you can add your own trace point, and even make it generic. That's what
> bpf did for their bpf_trace_printk. You could convert dev_dbg() into a
> tracepoint!
>
>
> static __printf(2, 3) int __dev_dbg(const struct device *dev, char *fmt, ...)
> {
>         static char buf[DEV_DEBUG_PRINTK_SIZE];
>         unsigned long flags;
>         va_list ap;
>         int ret;
>
>         raw_spin_lock_irqsave(&dev_dbg_printk_lock, flags);
>         va_start(ap, fmt);
>         ret = vsnprintf(buf, sizeof(buf), fmt, ap);
>         va_end(ap);
>         /* vsnprintf() will not append null for zero-length strings */
>         if (ret == 0)
>                 buf[0] = '\0';
>         trace_dev_dbg_printk(dev, buf);
>         raw_spin_unlock_irqrestore(&dev_dbg_printk_lock, flags);
>
>         return ret;
> }
>
> #define dev_dbg(dev, fmt, ...)                                  \
>         do {                                                    \
>                 if (trace_dev_dbg_printk_enabled())             \
>                         __dev_dbg(dev, fmt, ##__VA_ARGS__);     \
>         } while (0)
>
> Note, the "trace_dev_dbg_printk_enabled()" is a static branch, which means
> it is a nop when the dev_dbg_printk tracepoint is not enabled, and is a jmp
> to the __dev_dbg() logic when it is enabled. It's not a conditional branch.
>
> And have:
>
> TRACE_EVENT(dev_dbg_printk,
>
>         TP_PROTO(const struct device *dev, const char *dbg_str),
>
>         TP_ARGS(dev, dbg_str),
>
>         TP_STRUCT__entry(
>                 __field(const struct device *dev)
>                 __string(dev_name, dev_name(dev))
>                 __string(dbg_str, dbg_str)
>         ),
>
>         TP_fast_assign(
>                 __entry->dev = dev;
>                 __assign_str(dev_name, dev_name(dev))
>                 __assign_str(dbg_str, dbg_str);
>         ),
>
>         TP_printk("%p dev=%s %s", __entry->dev, __get_string(dev_name), __get_str(dbg_str))
> );
>
> And then you could even filter on the device name, or even parts of the
> string, as you can filter events, and even have them have glob matches.

Oooh, I might run with this, it's been on my backlog to go investigate
and you just threw out a solution. Imagine being able to to specify
't' instead of 'p' for a given debug print so that dev_dbg() users can
move from console to trace buffer, but also tracing users have access
to more tracepoints that happen to appear at useful dev_dbg()
locations.

Thanks, Steven!
