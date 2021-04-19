Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFECC364D83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhDSWLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSWLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:11:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9526127C;
        Mon, 19 Apr 2021 22:11:13 +0000 (UTC)
Date:   Mon, 19 Apr 2021 18:11:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Message-ID: <20210419181111.5eb582e8@gandalf.local.home>
In-Reply-To: <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
        <877hc64klm.fsf@rustcorp.com.au>
        <20130813111442.632f3421@gandalf.local.home>
        <87siybk8yl.fsf@rustcorp.com.au>
        <20130814233228.778f25d0@gandalf.local.home>
        <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 21:54:13 +0000
"Williams, Dan J" <dan.j.williams@intel.com> wrote:

> [ drop Rusty, add Jessica and Emmanuel ]

Probably could have kept Jessica on as she's the module maintainer.

> 
> On Wed, 2013-08-14 at 23:32 -0400, Steven Rostedt wrote:
> > On Thu, 15 Aug 2013 11:32:10 +0930

Wow, this is coming back from the dead! No thread rests in peace!

> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> >   
> > > Steven Rostedt <rostedt@goodmis.org> writes:  
> > > > But the thing about this that bothers me is that there's no way
> > > > to say,
> > > > "Enable all tracepoints in this module on load". I would like a
> > > > way to
> > > > do that, but I don't know of a way to do that without modifying
> > > > the
> > > > module code. Have any ideas? Basically, I would love to have:
> > > > 
> > > > insmod foo tracepoints=all
> > > > 
> > > > or something and have all tracepoints enabled.  
> > > 
> > > "without modifying the module code"?  Why?  The code isn't that
> > > scary,
> > > and this seems useful.  
> > 
> > I'm not afraid of the code, I'm afraid of you ;-) I hear you have
> > killer puppies.
> > 
> > 
> > OK, then when I get some time, I may cook something up.


"when I get some time" HAHAHAHAHAHAH!!!!  That was what? 8 years ago!

> > 
> > Thanks,
> > 
> > -- Steve  
> 
> Revive an old thread...

I'll say!

> 
> Steven, did you ever end up with a solution to the "enable tracing at
> module load" problem?

For tracepoints, no. For function tracing, yes!

> 
> I see some people getting admonished to use ftrace over dev_dbg() [1],
> but one of the features that keeps dev_dbg() proliferating is its
> generic "$mod_name.dyndbg=" module parameter support for selective
> debug enabling at boot / module-load.
> 
> It would be useful to be able to do
> /sys/kernel/debug/dynamic_debug/control enabling for tracepoints, but
> also module::function_name patterns for "got here" style debugging. I'd
> be happy to help with this, but wanted to understand where you left
> things.
> 
> [1]: https://lore.kernel.org/linux-wireless/YHRFy3aq%2FgB7Vde6@kroah.com/

I don't think I did anything with trace events, I'll have to dig deeper.
But today you have this:

 # cd /sys/kernel/tracing

 # rmmod bridge

 # echo ':mod:bridge' > set_ftrace_filter 

 # cat set_ftrace_filter
:mod:bridge

 # echo function > current_tracer

 # cat trace
# tracer: function
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |

 # modprobe bridge

 # cat set_ftrace_filter
br_switchdev_event [bridge]
br_device_event [bridge]
br_net_exit [bridge]
br_boolopt_get [bridge]
br_boolopt_multi_get [bridge]
br_opt_toggle [bridge]
br_boolopt_toggle [bridge]
br_boolopt_multi_toggle [bridge]
br_dev_set_multicast_list [bridge]
br_get_link_ksettings [bridge]
[..]

 # cat trace
# tracer: function
#
# entries-in-buffer/entries-written: 10/10   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
        modprobe-2364    [006] .... 12929.869510: br_init <-do_one_initcall
        modprobe-2364    [006] .... 12929.869513: br_fdb_init <-br_init
        modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869522: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869523: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869523: br_device_event <-call_netdevice_register_net_notifiers
        modprobe-2364    [006] .... 12929.869524: br_netlink_init <-br_init
        modprobe-2364    [006] .... 12929.869524: br_mdb_init <-br_netlink_init


So yes, function tracing now allows setting a filter to trace only the
functions for a given module, and if that module is not yet loaded, it
stores the filter until it is.

To do something similar for tracepoints, I think we still need to add it as
a module parameter.

-- Steve
