Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6330506F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhA0EJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236632AbhA0Din (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:38:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E792065D;
        Wed, 27 Jan 2021 02:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611713643;
        bh=pBjS8rajKCc4fs2v623TwRe6Bucank2I4/ZmVoafaQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CccKoyyVkrAYSqqEAQgo/nqYUOLf5MzbSBGuWIaX+WBeEJUh/VwSDS8NXO4BsCSxS
         UP3YLp83difx1edvKkDPv4VsuI6ryhYVs3jLo5ziYmjEO8b0aGegmiFzFKA5hwLYx9
         jg9zyxaFTMSo1y4gHnhy5YTrKgHfn8tPG4cVokSyyGlt0oVXeYO1MUomaVMKZnOFog
         RhzvtB3HwXEdNp5e2AL0t8kaU17HNw12Dv5Xh1VDzFD0MdoPEo9cGX7KQsXOHWnZNY
         Nsl72PfFm1HYYJkW9c2lj8mbfwbOe6d+hOxjIK4b1yGlJ6lR3vPf9DQonx1oaPSVYX
         YXuRp5WH7fE2w==
Date:   Wed, 27 Jan 2021 11:14:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-Id: <20210127111400.1b9accddc80bd2a2422b9d40@kernel.org>
In-Reply-To: <20210126164038.566ef8c2@gandalf.local.home>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
        <20210126154302.302a3bb0@gandalf.local.home>
        <20210126211722.GA23645@redhat.com>
        <20210126164038.566ef8c2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 16:40:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Jan 2021 22:17:23 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 01/26, Steven Rostedt wrote:
> > >
> > > On Tue, 26 Jan 2021 21:20:59 +0100
> > > Oleg Nesterov <oleg@redhat.com> wrote:
> > >  
> > > > > No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> > > > > kprobe_on_func_entry() will check it.  
> > > >
> > > > Yes, but unless I am totally confused... if kprobe_on_func_entry() returns false,
> > > > then trace_kprobe_create() should fail with BAD_RETPROBE even if offset == 0 ?  
> > >
> > > From what I understand. kprobe_on_func_entry() can return false if you pass
> > > in: "MOD:not_yet_loaded_module_func", but this is OK, because when the
> > > module is loaded, and the "not_yet_loaded_module_func" exists, the
> > > kretprobe will then be added.
> > >
> > > The strchr(symbol,":") check is to see if "MOD:" (or some other ":" command)
> > > is in the name, and we don't want it to fail if it is. Which is why we
> > > should have that commented.  
> > 
> > Agreed, this matches my understanding.
> > 
> > But just in case... not sure I read this code correctly, but I think that
> > module_kallsyms_lookup_name("not_yet_loaded_module_func") should work even
> > without the "MOD:" prefix.
> > 
> > IOW, kprobe_on_func_entry("not_yet_loaded_module_func") can fail, and then
> > later succeed if you load the module which provides this symbol.
> > 
> > But even if I am right, I agree with the strchr(symbol,":") check.
> 
> I see what you are saying. If "MOD" is not loaded yet, the
> kprobe_on_func_entry() should succeed.

No, that makes me more confused. kprobes_on_func_entry() returns true
only if it confirms the given address is on the function entry, because
it is used in the register_kretprobe() too.

OK, I will make a separate check which detects an error that the
module is loaded but the symbol does not exist.
(current code doesn't check the module is loaded or not)

That makes the code clearer.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
