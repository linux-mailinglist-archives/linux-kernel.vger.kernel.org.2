Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C1359901
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhDIJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:20:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhDIJUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:20:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617959995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOoTeMyHSOzXgjxuo5hUxXGZfriqBY1BcycCu9h2K9A=;
        b=bCSKUHaj7hFSmqTSnvx/LK5n4uVuKVwdbxHYo3Mm2wUnfwTPXckwo/v/J+7H9NNuuoQ+DS
        SSeQEISEBVcu7iaizxUy7eqq0o4R5ZPIqS37KPr0Ax4eVwC8B7lXl/x+gogX/PEdI6PwyF
        PK8kM9+p2q4jXebBJAxGvLlBMxsn4Dk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BC31AFC4;
        Fri,  9 Apr 2021 09:19:55 +0000 (UTC)
Date:   Fri, 9 Apr 2021 11:19:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YHAcOy6LdO4IAhyR@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-4-swboyd@chromium.org>
 <YG27p1AhiOKJOm+y@alley>
 <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com>
 <YG7XQK1FCofMZsqM@alley>
 <161791154751.3790633.14778133079958701015@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161791154751.3790633.14778133079958701015@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-04-08 12:52:27, Stephen Boyd wrote:
> Quoting Petr Mladek (2021-04-08 03:13:20)
> > It helped with the vmlinux buildid. I see the following:
> > 
> > [  551.435942][ T1803] test_printf: loaded.
> > [  551.436667][ T1803] ------------[ cut here ]------------
> > [  551.437561][ T1803] kernel BUG at lib/test_printf.c:689!
> > [  551.438352][ T1803] invalid opcode: 0000 [#1] SMP NOPTI
> > [  551.438359][ T1803] CPU: 3 PID: 1803 Comm: modprobe Kdump: loaded Tainted: G            E     5.12.0-rc6-default+ #176 e51781e52aaf4d6dfea7a18574c104c8bfd7c37f
> > [  551.438363][ T1803] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> > [  551.438365][ T1803] RIP: 0010:test_printf_init+0x561/0xc99 [test_printf c2388ff0552611501b4d2ad58d8e5ca441d9a350]
> 
> It shows it for the test module here.

I see.

> > [  551.443090][ T1803] Code: 00 48 c7 c7 b8 36 1b c0 e8 19 f9 ff ff b9 ab 00 00 00 48 c7 c2 93 36 1b c0 be 08 00 00 00 48 c7 c7 af 36 1b c0 e8 fc f8 ff ff <0f> 0b 8b 05 44 07 00 00 8b 35 3a 07 00 00 8b 1d 3c 07 00 00 85 c0
> > [  551.443094][ T1803] RSP: 0018:ffffb62c0039bc78 EFLAGS: 00010282
> > [  551.443096][ T1803] RAX: 0000000000000000 RBX: ffffb62c0039bc80 RCX: ffffd62bffc00b70
> > [  551.443098][ T1803] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0352fd5
> > [  551.443099][ T1803] RBP: ffffffffc01b7367 R08: 0000000000000001 R09: 0000000000000001
> > [  551.443100][ T1803] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9bc08c87c820
> > [  551.443101][ T1803] R13: 0000000000000001 R14: ffff9bc0d2798480 R15: ffffb62c0039be90
> > [  551.443102][ T1803] FS:  00007f5767485b80(0000) GS:ffff9bc0ffc00000(0000) knlGS:0000000000000000
> > [  551.443103][ T1803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  551.443105][ T1803] CR2: 00007f5766b36ef0 CR3: 0000000100368004 CR4: 0000000000370ee0
> > [  551.443108][ T1803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  551.443108][ T1803] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  551.443109][ T1803] Call Trace:
> > [  551.443113][ T1803]  ? __test+0x13c/0x149 [test_printf]
> 
> But not here. I missed a place in the x86 code, printk_stack_address()
> uses %pB, so I'll need to introduce %pBb to indicate that we're printing
> a backtrace with a build ID, oof!
> 
> Can you try this patch for x86? I'll dig up some hardware in the meantime.

The patch helped. Now, I see:

   55.324174][ T1843] test_printf: loaded.
[   55.326875][ T1843] ------------[ cut here ]------------
[   55.329644][ T1843] kernel BUG at lib/test_printf.c:689!
[   55.331642][ T1843] invalid opcode: 0000 [#1] SMP NOPTI
[   55.331651][ T1843] CPU: 3 PID: 1843 Comm: modprobe Kdump: loaded Tainted: G            E     5.12.0-rc6-default+ #177 4a028b3004ded4cbaa81d717e520bff895755225
[   55.331658][ T1843] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   55.331660][ T1843] RIP: 0010:test_printf_init+0x561/0xc99 [test_printf c2388ff0552611501b4d2ad58d8e5ca441d9a350]
[   55.331677][ T1843] Code: 00 48 c7 c7 b8 b6 42 c0 e8 19 f9 ff ff b9 ab 00 00 00 48 c7 c2 93 b6 42 c0 be 08 00 00 00 48 c7 c7 af b6 42 c0 e8 fc f8 ff ff <0f> 0b 8b 05 44 07 00 00 8b 35 3a 07 00 00 8b 1d 3c 07 00 00 85 c0
[   55.331680][ T1843] RSP: 0018:ffffa1d800c1fc78 EFLAGS: 00010282
[   55.331685][ T1843] RAX: 0000000000000000 RBX: ffffa1d800c1fc80 RCX: ffffc1d7ffc00b70
[   55.331688][ T1843] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa5352ff5
[   55.331690][ T1843] RBP: ffffffffc042f367 R08: 0000000000000001 R09: 0000000000000001
[   55.331693][ T1843] R10: 0000000000000000 R11: 0000000000000001 R12: ffff940290b29480
[   55.331695][ T1843] R13: 0000000000000001 R14: ffff940286a83f80 R15: ffffa1d800c1fe90
[   55.331697][ T1843] FS:  00007f870ba13b80(0000) GS:ffff9402ffc00000(0000) knlGS:0000000000000000
[   55.331701][ T1843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.331704][ T1843] CR2: 00007f870b0c4ef0 CR3: 000000010ac8a001 CR4: 0000000000370ee0
[   55.331712][ T1843] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.331715][ T1843] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.359095][ T1843] Call Trace:
[   55.359100][ T1843]  ? __test+0x13c/0x149 [test_printf c2388ff0552611501b4d2ad58d8e5ca441d9a350]
g[   55.359107][ T1843]  ? rcu_read_lock_sched_held+0x52/0x80
[   55.359112][ T1843]  do_one_initcall+0x5b/0x2d0

Best Regards,
Petr
