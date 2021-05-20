Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5638BA03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhETXJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhETXJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0B6E6135B;
        Thu, 20 May 2021 23:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621552094;
        bh=uLz83HVMPoowinqW6vDUYL3pAH/trQxHeIbSlfBCwP4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DcZirm2IfgKDlXaXbw2UNcmPudyQwek09S0HonO/9IfmHX6tS6zJkdNCiQHYBD5Zw
         5Y27MNoEzcLLUSiDDrZe2bheoSgQDatxgw4pYz8I9KCGrkfi61gLxg+UPYGHF6bssH
         Ccb2nvCQq4qA8g2pN+Rj5rt78tH+CQ6CwnfeGh6ocXlHQ1UleVQ3b/8WyTChPeI/2t
         jFxLs31h1csRpE4AhNbLXtly/e2pX5KdltwqyNdMZfcmESllPayCxW7E/mq9sal/Es
         2P6e6BR/yDd7uYW3IMnoLXlKIRBUV5YqKpuwH1jtLA6WpHEECXtO8Laiohxb2EUJg8
         3GKljCKGe0yoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1A605C023D; Thu, 20 May 2021 16:08:14 -0700 (PDT)
Date:   Thu, 20 May 2021 16:08:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <20210520230814.GQ4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210430195232.30491-1-michel@lespinasse.org>
 <20210430224649.GA29203@lespinasse.org>
 <20210503181118.GA21048@lespinasse.org>
 <20210517175750.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <CAJuCfpHD=GN2UMhbAhpp+UfvF0doBWcZDNx+u4RzcDezUW2+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHD=GN2UMhbAhpp+UfvF0doBWcZDNx+u4RzcDezUW2+0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:10:24PM -0700, Suren Baghdasaryan wrote:
> On Mon, May 17, 2021 at 10:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, May 03, 2021 at 11:11:18AM -0700, Michel Lespinasse wrote:
> > > On Fri, Apr 30, 2021 at 03:46:49PM -0700, Michel Lespinasse wrote:
> > > > I- Maple tree
> > > >
> > > > I do not think there is any fundamental conflict between the maple
> > > > tree patches currently being considered, and this patchset.
> > > > I actually have a (very lightly tested) tree merging the two together,
> > > > which was a fairly easy merge. For those interested, I made this
> > > > available at my github, as the v5.12-maple-spf branch.
> > >
> > > People were still confused about it, so the instructions to fetch this are:
> > > git fetch https://github.com/lespinasse/linux.git v5.12-maple-spf
> >
> > Finally getting around to actually testing this, apologies for the
> > delay!
> >
> > Just checking to see if I am in the right place.  The warning below is
> > easily fixed, but I figured that I should check.
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> >   CC      arch/x86/kernel/asm-offsets.s
> > In file included from ./include/linux/mmap_lock.h:10,
> >                  from ./include/linux/mm.h:18,
> >                  from ./include/linux/kallsyms.h:12,
> >                  from ./include/linux/bpf.h:20,
> >                  from ./include/linux/bpf-cgroup.h:5,
> >                  from ./include/linux/cgroup-defs.h:22,
> >                  from ./include/linux/cgroup.h:28,
> >                  from ./include/linux/memcontrol.h:13,
> >                  from ./include/linux/swap.h:9,
> >                  from ./include/linux/suspend.h:5,
> >                  from arch/x86/kernel/asm-offsets.c:13:
> > ./include/linux/vmstat.h: In function ‘__mod_lruvec_page_state’:
> > ./include/linux/vmstat.h:504:24: error: implicit declaration of function ‘page_pgdat’; did you mean ‘page_private’? [-Werror=implicit-function-declaration]
> >   __mod_node_page_state(page_pgdat(page), idx, val);
> >                         ^~~~~~~~~~
> >                         page_private
> > ./include/linux/vmstat.h:504:24: warning: passing argument 1 of ‘__mod_node_page_state’ makes pointer from integer without a cast [-Wint-conversion]
> >   __mod_node_page_state(page_pgdat(page), idx, val);
> >                         ^~~~~~~~~~~~~~~~
> > ./include/linux/vmstat.h:267:28: note: expected ‘struct pglist_data *’ but argument is of type ‘int’
> >  void __mod_node_page_state(struct pglist_data *, enum node_stat_item item, long);
> >                             ^~~~~~~~~~~~~~~~~~~~
> > ./include/linux/vmstat.h: In function ‘mod_lruvec_page_state’:
> > ./include/linux/vmstat.h:510:22: warning: passing argument 1 of ‘mod_node_page_state’ makes pointer from integer without a cast [-Wint-conversion]
> >   mod_node_page_state(page_pgdat(page), idx, val);
> >                       ^~~~~~~~~~~~~~~~
> > ./include/linux/vmstat.h:275:26: note: expected ‘struct pglist_data *’ but argument is of type ‘int’
> >  void mod_node_page_state(struct pglist_data *, enum node_stat_item, long);
> >                           ^~~~~~~~~~~~~~~~~~~~
> > In file included from ./include/linux/kallsyms.h:12,
> >                  from ./include/linux/bpf.h:20,
> >                  from ./include/linux/bpf-cgroup.h:5,
> >                  from ./include/linux/cgroup-defs.h:22,
> >                  from ./include/linux/cgroup.h:28,
> >                  from ./include/linux/memcontrol.h:13,
> >                  from ./include/linux/swap.h:9,
> >                  from ./include/linux/suspend.h:5,
> >                  from arch/x86/kernel/asm-offsets.c:13:
> > ./include/linux/mm.h: At top level:
> > ./include/linux/mm.h:1568:26: error: conflicting types for ‘page_pgdat’
> >  static inline pg_data_t *page_pgdat(const struct page *page)
> >                           ^~~~~~~~~~
> > In file included from ./include/linux/mmap_lock.h:10,
> >                  from ./include/linux/mm.h:18,
> >                  from ./include/linux/kallsyms.h:12,
> >                  from ./include/linux/bpf.h:20,
> >                  from ./include/linux/bpf-cgroup.h:5,
> >                  from ./include/linux/cgroup-defs.h:22,
> >                  from ./include/linux/cgroup.h:28,
> >                  from ./include/linux/memcontrol.h:13,
> >                  from ./include/linux/swap.h:9,
> >                  from ./include/linux/suspend.h:5,
> >                  from arch/x86/kernel/asm-offsets.c:13:
> > ./include/linux/vmstat.h:504:24: note: previous implicit declaration of ‘page_pgdat’ was here
> >   __mod_node_page_state(page_pgdat(page), idx, val);
> >                         ^~~~~~~~~~
> > cc1: some warnings being treated as errors
> 
> Hi Paul,
> I promised you to look into this but somehow forgot to reply, sorry
> about that. The issue is the new "#include <linux/mm_types.h>" in mm.h
> which causes page_pgdat() usage before it is defined:
> 
> mm.h includes mm_types.h
> mm_types.h includes vmstat.h
> vmstat.h uses page_pgdat()
> mm.h defines page_pgdat()
> 
> Not sure if this is the best way to fix it but this worked fine for me:

OK, so I really am using the right tree, then.  I will try with your
patch below, thank you!

							Thanx, Paul

> ---
>  include/linux/mmap_lock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 98f24a9910a9..13d4a706c0eb 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -7,7 +7,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/types.h>
> -#include <linux/vmstat.h>
> +#include <linux/vm_event_item.h>
> 
>  #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>  #define MMAP_LOCK_SEQ_INITIALIZER(name) \
> @@ -113,6 +113,8 @@ static inline bool __mmap_seq_read_check(struct
> mm_struct *mm,
>  }
> 
>  #ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
> +static inline void count_vm_event(enum vm_event_item item);
> +
>  static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq,
>          enum vm_event_item fail_event)
>  {
> --
> 
> Thanks,
> Suren.
