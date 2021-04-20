Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AC364FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhDTB0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhDTB0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:26:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32595C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:26:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r20so6017447ejo.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v433RIgrg2kQQRI72xpOryqD9ZucPbQbhmAZVvLs6dA=;
        b=Wu2EEDpZHaYgPXWGrauzCxSPMzPN23CWLddOUY108yebHLnFrDOxqE7t7t0cL8laUX
         0tGj7IHn9qeu43zTeKT+gMCCPLHGnMg30f0SiCu7Rch5ZPybGTfW3jdfAsqjhBqYKrZ+
         nVFnJh3h8+4Cm1tRefpfDNf5HeyfSUBc5QVSiLIEaPunUFxZ2FumMcLtd/rfESQKZkqN
         5TF/ek+vUYlspsTjkyj556afYFqvWE3RKkQp5UdslpMkdzD5JE6xhfFJySMs1+G9pjhb
         OAgjpiPAQw2DJq9D5VYjz4sGnOZO3TQ56P9elo1jQ3X53cAyz0oacKR6cKj3/5l6yyEW
         otEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v433RIgrg2kQQRI72xpOryqD9ZucPbQbhmAZVvLs6dA=;
        b=IoYi48I6FymbDwKk9V1jaL3N4wzV6vCV2ZmxPbqrCmsqa8Qgl6XGfCJ+xOHpoELDYC
         7msBhC5V9kD726G3+st47eQPPWxohLrWNJDR22qRyX0sYnkLLDK+3it2qFWC77WQguWe
         DA3GVxR+wg86ojK7BC2vUx0IklSei/Tafk2qnK9VPgMVceo8BB/4/9/TxoYwcHNa/4kr
         MAw0OEeMsILcuFv4eMUudbwWK7uLnT5qvdRsIr//StRPx0t/3HBBakaizVVMxS7foft/
         o2aozaZkNsOT4G2YcP8fEWJ8NFB9sidvlPfDMHfw3aVZnYflpw477oRdnQTV2EoQmuLx
         gbHg==
X-Gm-Message-State: AOAM530W+158THBlSgRzw4v5w52AJ8sCsZIYljuFVFr07gHnhXSb06Ce
        V6ozD8F1YqKF5pMUOCSbMOQv814GZ1jCZ4Rbbc9EmA==
X-Google-Smtp-Source: ABdhPJw8HBXsl1Qu6bw+vp+DAGkKJWebB2F1KgoLCfeEY2M4sQaZur4YAK1zONi3wxVtB7k/vk6sa9BkdOcDizESSWg=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr8408011ejf.341.1618881963818;
 Mon, 19 Apr 2021 18:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
 <877hc64klm.fsf@rustcorp.com.au> <20130813111442.632f3421@gandalf.local.home>
 <87siybk8yl.fsf@rustcorp.com.au> <20130814233228.778f25d0@gandalf.local.home>
 <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com> <20210419181111.5eb582e8@gandalf.local.home>
In-Reply-To: <20210419181111.5eb582e8@gandalf.local.home>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Apr 2021 18:25:54 -0700
Message-ID: <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
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

On Mon, Apr 19, 2021 at 3:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 19 Apr 2021 21:54:13 +0000
> "Williams, Dan J" <dan.j.williams@intel.com> wrote:
>
> > [ drop Rusty, add Jessica and Emmanuel ]
>
> Probably could have kept Jessica on as she's the module maintainer.

Oh, you misread, I swapped out Rusty for Jessica on the Cc.

>
> >
> > On Wed, 2013-08-14 at 23:32 -0400, Steven Rostedt wrote:
> > > On Thu, 15 Aug 2013 11:32:10 +0930
>
> Wow, this is coming back from the dead! No thread rests in peace!

No one can escape the all seeing eye of lore, and it makes it so easy
to reply to ancient stuff. I thought it useful to kick the zombie
because this thread is the first thing that comes up in the Google
search of:

"enable tracepoint at module load"

>
> > > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >
> > > > Steven Rostedt <rostedt@goodmis.org> writes:
> > > > > But the thing about this that bothers me is that there's no way
> > > > > to say,
> > > > > "Enable all tracepoints in this module on load". I would like a
> > > > > way to
> > > > > do that, but I don't know of a way to do that without modifying
> > > > > the
> > > > > module code. Have any ideas? Basically, I would love to have:
> > > > >
> > > > > insmod foo tracepoints=all
> > > > >
> > > > > or something and have all tracepoints enabled.
> > > >
> > > > "without modifying the module code"?  Why?  The code isn't that
> > > > scary,
> > > > and this seems useful.
> > >
> > > I'm not afraid of the code, I'm afraid of you ;-) I hear you have
> > > killer puppies.
> > >
> > >
> > > OK, then when I get some time, I may cook something up.
>
>
> "when I get some time" HAHAHAHAHAHAH!!!!  That was what? 8 years ago!

free time coming up... any day now.

>
> > >
> > > Thanks,
> > >
> > > -- Steve
> >
> > Revive an old thread...
>
> I'll say!
>
> >
> > Steven, did you ever end up with a solution to the "enable tracing at
> > module load" problem?
>
> For tracepoints, no. For function tracing, yes!
>
> >
> > I see some people getting admonished to use ftrace over dev_dbg() [1],
> > but one of the features that keeps dev_dbg() proliferating is its
> > generic "$mod_name.dyndbg=" module parameter support for selective
> > debug enabling at boot / module-load.
> >
> > It would be useful to be able to do
> > /sys/kernel/debug/dynamic_debug/control enabling for tracepoints, but
> > also module::function_name patterns for "got here" style debugging. I'd
> > be happy to help with this, but wanted to understand where you left
> > things.
> >
> > [1]: https://lore.kernel.org/linux-wireless/YHRFy3aq%2FgB7Vde6@kroah.com/
>
> I don't think I did anything with trace events, I'll have to dig deeper.
> But today you have this:
>
>  # cd /sys/kernel/tracing
>
>  # rmmod bridge
>
>  # echo ':mod:bridge' > set_ftrace_filter
>
>  # cat set_ftrace_filter
> :mod:bridge
>
>  # echo function > current_tracer
>
>  # cat trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 0/0   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>
>  # modprobe bridge
>
>  # cat set_ftrace_filter
> br_switchdev_event [bridge]
> br_device_event [bridge]
> br_net_exit [bridge]
> br_boolopt_get [bridge]
> br_boolopt_multi_get [bridge]
> br_opt_toggle [bridge]
> br_boolopt_toggle [bridge]
> br_boolopt_multi_toggle [bridge]
> br_dev_set_multicast_list [bridge]
> br_get_link_ksettings [bridge]
> [..]
>
>  # cat trace
> # tracer: function
> #
> # entries-in-buffer/entries-written: 10/10   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>         modprobe-2364    [006] .... 12929.869510: br_init <-do_one_initcall
>         modprobe-2364    [006] .... 12929.869513: br_fdb_init <-br_init
>         modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869523: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869523: br_device_event <-call_netdevice_register_net_notifiers
>         modprobe-2364    [006] .... 12929.869524: br_netlink_init <-br_init
>         modprobe-2364    [006] .... 12929.869524: br_mdb_init <-br_netlink_init
>
>
> So yes, function tracing now allows setting a filter to trace only the
> functions for a given module, and if that module is not yet loaded, it
> stores the filter until it is.

Ah, thanks for the pointer. So if I wanted to convert a kernel command like:

libnvdimm.dyndbg

...it would be something like:

ftrace=function ftrace_filter=:mod:libnvdimm

...and then "cat /sys/kernel/tracing/trace" instead of "dmesg" to
retrieve... assuming only "got here" style debug was being attempted.

> To do something similar for tracepoints, I think we still need to add it as
> a module parameter.

The dev_dbg() filter language is attractive, it's too bad
trace_printk() has such a high runtime cost as combining dynamic-debug
and tracing would seem to be a panacea.
