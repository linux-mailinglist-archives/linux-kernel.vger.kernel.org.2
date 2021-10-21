Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8084357D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJUAiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUAiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:38:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 411616112D;
        Thu, 21 Oct 2021 00:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634776595;
        bh=xeXadm3agqzQ6VGRMKNr2Gx2mtZ4jBL+v1U1Z361QAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DsXg3f2/fAx+yB3iYvW5sINsPes2kuTGIYekbIoFcHhbcMHwaFAf2kvBL3qqis6fl
         APPMcxBOs9j5FMj7WfWSRtefRwGUdRCN/C9okPkPT7zL+/jue5qvf8rLGrjP/YTRrT
         BIoxZCxrLWs+pvXPJIeXdKT10wafeo4KPzCh9gTkMo+lhU7RaTuilQWjqXHzYyzXb5
         nVl7djXY4cHnWE15iueXbD5lECHsr9ZeOxhzVAs430nfeFVGyf5LrJNOm/x91VVmcQ
         M2xvPt6FUu8APTs6yickS/De+P8JXrGTT8/0H568V8q9IrNSLhYzHAMwDPkLgx7m7Y
         7AdpaeEJgUZBA==
Date:   Thu, 21 Oct 2021 09:36:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Huan Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Add trace any kernel object
Message-Id: <20211021093632.a197670625a6595d7082c9f8@kernel.org>
In-Reply-To: <CAEr6+EDf1hcm2SawO07+69KnBrODmiM05AqeeBwN+4wuyME=6w@mail.gmail.com>
References: <20211014014445.5734-1-xiehuan09@gmail.com>
        <20211013222056.312bec0c@oasis.local.home>
        <20211015220832.f9a13bd4ebbc4881b1e68163@kernel.org>
        <CAEr6+EDf1hcm2SawO07+69KnBrODmiM05AqeeBwN+4wuyME=6w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 00:04:40 +0800
Huan Xie <xiehuan09@gmail.com> wrote:

> > > > For example:
> > > >
> > > > For the function bio_add_page, we can trace the first argument:
> > > >
> > > > int bio_add_page(struct bio *bio, struct page *page,
> > > >                             unsigned int len, unsigned int offset)
> > > >
> > > >     #cd /sys/kernel/debug/tracing
> > > >     #echo 1 > ./trace_object
> >
> > Hmm, so what happen if there are several events in parallel?
> >
> > > >     #echo 'p bio_add_page arg1=$arg1' > kprobe_events
> > > >     #echo 1 > ./events/kprobes/p_bio_add_page_0/enable
> >
> > what about adding a "objfilter" trigger action to update the object
> > list? e.g.
> >
> > echo objfilter:add:arg1:1 if comm == "sync" >> ./events/kprobes/p_bio_add_page_0/trigger
> >
> > This will "add the value of 'arg1' to objfilter 1 time if the process
> > name is sync".
> 
> Thanks. The trigger seems to work in combination with kprobe/uprobe/eprobe.
> 
> I have been trying to implement this feature in recent days, But my
> code does not look very elegant at the moment :-)

No problem! I can help you to brush up the coding :)

> It seems the result of 'cat  trace' should also need to be filtered,
> Because it will output the functions we don’t want to care about.

It actually depends on what object user wants to trace. e.g. network
packet trace will not be affected by 'cat trace'.
Anyway, we have "options/pause-on-trace" to stop tracing while
reading trace file. So user can choose it stop it or not. :)

> 
> I didn't expect this idea to be a relatively large project. :-)
> 

Because you have an exciting idea :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
