Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE03A5D61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFNHGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:06:45 -0400
Received: from server.lespinasse.org ([63.205.204.226]:34919 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhFNHGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:06:44 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-20-ed;
 t=1623654281; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=3AVCNhIvo4M95EhB7FF7RNyXT3JEJVpODvygh/r6OPk=;
 b=PXivVQW6eWktfGyI+mumqLmTQvM4bULsbFVL4aNk922OK+Xt32PFAy6wj6Kxlmgjs6Lk2
 JpAlgpU80zOjWhlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-20-rsa; t=1623654281; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=3AVCNhIvo4M95EhB7FF7RNyXT3JEJVpODvygh/r6OPk=;
 b=j4iXVr63U9HucLWMaX9nnYgHq2M/Pa09hNOMAA3OQFPon1KUED0sfM5uXtUcVStdUkXCT
 hGtL/lY1ZbnObVuLGtzYBc/VihWO9ua7B/9Lvh8Qt1QkeIrV2qHm1AnAdRu7+mi4/caLQcp
 DJpxEAEIMu2PyuEelywNZU7+gzLCxG+m/trleT//8+86CG8L52GAZdJ9uNiic8pkcFWsLEY
 nB7v8N1lI8riKetb2FzCw1PzfWnxIuiW++eKiI6iUrRguUsFpbiDOt/DnWoj1B5KgGYLNTQ
 wiJl5AjGe5sX+sozTDChtIJ55lP4OtEtihGjNqdXK2nAJ6Axgx0Ch1YvBExg==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 126EF160897; Mon, 14 Jun 2021 00:04:41 -0700 (PDT)
Date:   Mon, 14 Jun 2021 00:04:41 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
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
Message-ID: <20210614070441.GA3801@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
 <20210430224649.GA29203@lespinasse.org>
 <20210503181118.GA21048@lespinasse.org>
 <20210517175750.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <CAJuCfpHD=GN2UMhbAhpp+UfvF0doBWcZDNx+u4RzcDezUW2+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHD=GN2UMhbAhpp+UfvF0doBWcZDNx+u4RzcDezUW2+0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:10:24PM -0700, Suren Baghdasaryan wrote:
> Hi Paul,
> I promised you to look into this but somehow forgot to reply, sorry
> about that. The issue is the new "#include <linux/mm_types.h>" in mm.h
> which causes page_pgdat() usage before it is defined:

Yes. This only happens in non-memcg configs, which is why I hadn't
found it in testing.

> 
> mm.h includes mm_types.h
> mm_types.h includes vmstat.h
> vmstat.h uses page_pgdat()
> mm.h defines page_pgdat()
> 
> Not sure if this is the best way to fix it but this worked fine for me:
> 
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

I think having only the count_vm_event() prototype may cause it to not
actually get inlined when we want it ?

I think it would be ideal to have a separate linux/vm_event.h header,
with just the definitions that are currently in linux/vmstat.h
between "#ifdef CONFIG_VM_EVENT_COUNTERS" and up to (and including)
the __count_vm_events() definition (i.e., functions that just increment
the percpu event counters). Then mmap_lock.h could use that instead of
the full vmstat.h.

--
Michel "walken" Lespinasse
