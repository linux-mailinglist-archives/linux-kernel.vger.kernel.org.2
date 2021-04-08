Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8C35805D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhDHKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:13:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhDHKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617876800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yvidRElOU50/DcX6YopVHSEwI5Pj7b3vwtdUcMsLgWQ=;
        b=lxB/nureVcPpVOz5bhdGBk5/E//r9Dqz/kkto4qDnHLS4yUoIVgy3kq99/9ii2G9LDFNVc
        ruxT/RYaP93RQdW3cbrKgTSu0Mjz9WFagTgUaYkrvTi0Mxbg16Eu2R8+I3i5Kw74lXyKJB
        kSBfjog2+rNBK5MQeGuCkK2zWgycXXc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5704AFF7;
        Thu,  8 Apr 2021 10:13:20 +0000 (UTC)
Date:   Thu, 8 Apr 2021 12:13:20 +0200
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
Message-ID: <YG7XQK1FCofMZsqM@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-4-swboyd@chromium.org>
 <YG27p1AhiOKJOm+y@alley>
 <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-04-07 23:20:32, Stephen Boyd wrote:
> Quoting Petr Mladek (2021-04-07 07:03:19)
> > # readelf -Wn vmlinux-5.12.0-rc6-default+ 
> > 
> > Displaying notes found in: .notes
> >   Owner                 Data size       Description
> >   Xen                  0x00000006       Unknown note type: (0x00000006)    description data: 6c 69 6e 75 78 00 
> >   Xen                  0x00000004       Unknown note type: (0x00000007)    description data: 32 2e 36 00 
> >   Xen                  0x00000008       Unknown note type: (0x00000005)    description data: 78 65 6e 2d 33 2e 30 00 
> >   Xen                  0x00000008       Unknown note type: (0x00000003)    description data: 00 00 00 ffffff80 ffffffff ffffffff ffffffff ffffffff 
> > 
> 
> Thanks for the readelf output. That was most helpful to see what's going
> on. The buildid code isn't prepared for this it seems. We'll need to
> check the note data to see if it starts with "GNU\0" and if it does then
> we use it as the buildid. I'm not sure what this Xen note is that has a
> type of 3 but I think that's OK, it won't have "GNU" in there so we
> should ignore it. Does this patch work?
> 
> ----8<----
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 483abf71eeec..f281dbe6fb83 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -25,6 +25,7 @@ static int parse_build_id_buf(unsigned char *build_id,
>  
>  		if (nhdr->n_type == BUILD_ID &&
>  		    nhdr->n_namesz == sizeof("GNU") &&
> +		    !strcmp((char *)(nhdr + 1), "GNU") &&
>  		    nhdr->n_descsz > 0 &&
>  		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
>  			memcpy(build_id,

It helped with the vmlinux buildid. I see the following:

[  551.435942][ T1803] test_printf: loaded.
[  551.436667][ T1803] ------------[ cut here ]------------
[  551.437561][ T1803] kernel BUG at lib/test_printf.c:689!
[  551.438352][ T1803] invalid opcode: 0000 [#1] SMP NOPTI
[  551.438359][ T1803] CPU: 3 PID: 1803 Comm: modprobe Kdump: loaded Tainted: G            E     5.12.0-rc6-default+ #176 e51781e52aaf4d6dfea7a18574c104c8bfd7c37f
[  551.438363][ T1803] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  551.438365][ T1803] RIP: 0010:test_printf_init+0x561/0xc99 [test_printf c2388ff0552611501b4d2ad58d8e5ca441d9a350]
[  551.443090][ T1803] Code: 00 48 c7 c7 b8 36 1b c0 e8 19 f9 ff ff b9 ab 00 00 00 48 c7 c2 93 36 1b c0 be 08 00 00 00 48 c7 c7 af 36 1b c0 e8 fc f8 ff ff <0f> 0b 8b 05 44 07 00 00 8b 35 3a 07 00 00 8b 1d 3c 07 00 00 85 c0
[  551.443094][ T1803] RSP: 0018:ffffb62c0039bc78 EFLAGS: 00010282
[  551.443096][ T1803] RAX: 0000000000000000 RBX: ffffb62c0039bc80 RCX: ffffd62bffc00b70
[  551.443098][ T1803] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0352fd5
[  551.443099][ T1803] RBP: ffffffffc01b7367 R08: 0000000000000001 R09: 0000000000000001
[  551.443100][ T1803] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9bc08c87c820
[  551.443101][ T1803] R13: 0000000000000001 R14: ffff9bc0d2798480 R15: ffffb62c0039be90
[  551.443102][ T1803] FS:  00007f5767485b80(0000) GS:ffff9bc0ffc00000(0000) knlGS:0000000000000000
[  551.443103][ T1803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  551.443105][ T1803] CR2: 00007f5766b36ef0 CR3: 0000000100368004 CR4: 0000000000370ee0
[  551.443108][ T1803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  551.443108][ T1803] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  551.443109][ T1803] Call Trace:
[  551.443113][ T1803]  ? __test+0x13c/0x149 [test_printf]
[  551.443116][ T1803]  ? rcu_read_lock_sched_held+0x52/0x80
[  551.443120][ T1803]  do_one_initcall+0x5b/0x2d0
[  551.443125][ T1803]  do_init_module+0x5b/0x21c
[  551.443127][ T1803]  load_module+0x1eaa/0x23c0
[  551.443130][ T1803]  ? show_modinfo_version+0x30/0x30
[  551.443134][ T1803]  ? __do_sys_finit_module+0xad/0x110
[  551.443135][ T1803]  __do_sys_finit_module+0xad/0x110
[  551.443138][ T1803]  do_syscall_64+0x33/0x40
[  551.443139][ T1803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  551.443143][ T1803] RIP: 0033:0x7f5766b5b2a9
[

Note that it still does not show the build id for the module. It fails
in the module init call and the build id should be already initialized
at this stage.

One more thing. I am not familiar with the elf-related code.
Is it safe to access (nhdr + 1)? Do we need a check that
it is still withing the given section?

Best Regards,
Petr
