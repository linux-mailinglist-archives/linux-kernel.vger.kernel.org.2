Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC23AC248
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFRE2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhFRE2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2485611AC;
        Fri, 18 Jun 2021 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623990398;
        bh=wYoOekgC5HAp8GHJ2tzfqIuNSZQbt3gAoqHcI8FFIJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CtQQyxxjry1uSLf/ZF+vTyVW4bKn3MvFqYdgenZ1K5ICu3aOPeHSrKGaNCAHcHkJL
         DOlTPfzzuCn+d7RQUCaBDNBa6ZntbfU8+ILU8gEp/GnFfWwmP6jQ9rJxi6as2ifEKf
         zBpoxQB/PrdFLczgwJHgS4zrUhZ3CPHGjyiK/VcFt0J0/rWOavHjLAi8a6iROS8ZZx
         TnJvGborXSWm+lRZcfKoUy3PiAB67GZcPWBXDoH3rxaAxzdPHHrbxVJougo5GarW3i
         nzbmf0hAgiZ8Z7zOGHMbYJfW+W2nHh6TcQqHD8iip5BrkSzNSHDP7/orwAeKf68oo9
         x2o2cbbBcohfg==
Date:   Fri, 18 Jun 2021 13:26:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210618132636.ceef49ba0fd01bd26508f672@kernel.org>
In-Reply-To: <20210617130713.194a7152@gandalf.local.home>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
        <20210616112711.ce318fc66b389038203331d1@kernel.org>
        <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
        <1623946796.80yhllbpmp.naveen@linux.ibm.com>
        <20210617130713.194a7152@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 13:07:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 17 Jun 2021 22:04:34 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > > 2. Move the kretprobe instance pool from kretprobe to struct task.
> > >   This pool will allocates one page per task, and shared among all
> > >   kretprobes. This pool will be allocated when the 1st kretprobe
> > >   is registered. maxactive will be kept for someone who wants to
> > >   use per-instance data. But since dynamic event doesn't use it,
> > >   it will be removed from tracefs and perf.  
> > 
> > Won't this result in _more_ memory usage compared to what we have now?
> 
> Maybe or maybe not. At least with this approach (or the function graph
> one), you will allocate enough for the environment involved. If there's
> thousands of tasks, then yes, it will allocate more memory. But if you are
> running thousands of tasks, you should have a lot of memory in the machine.
> 
> If you are only running a few tasks, it will be less than the current
> approach.

Right, this depends on how many tasks you are running on your machine.
Anyway, since you may not sure how much maxactive is enough, you will
set maxactive high, then it can consume more than that. Of course you
can optimize by trial and error. But that does not guarantee all cases,
because the number of tasks can be increased while tracing. You might
need to re-configure it by checking the nmissed count again.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
