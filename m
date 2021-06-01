Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92724396E09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhFAHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:43:20 -0400
Received: from server.lespinasse.org ([63.205.204.226]:48667 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:43:18 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-18-ed;
 t=1622533297; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=Pr1dogb2hhjVOwbkgIiWfu0YAuMoqxLdY7YfUv+oFLw=;
 b=Ov3ls7rVLNHWPnI1vs/cZijyudcYLW0N+4ltvG5YBaGdhCM9M3p7XtxrRxZb6QaWfxsC0
 HGqydB92/Ha5RSjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-18-rsa; t=1622533297; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=Pr1dogb2hhjVOwbkgIiWfu0YAuMoqxLdY7YfUv+oFLw=;
 b=rsaGoHtWqZD2TnXEGwqSRp5R8uNAVwpF58WMJCLETn0ZemeSG5xX1NuZ7wYvS9vRX/5qW
 gEguumXaUPolKBs0sKgHOZWgRdCxbZgZr6QaSTnYIN3L7kX+fa5y2HWHSlGRh3/RitOJ6d0
 E3b7NY6IvAi/es7MNsV4TTsnVrdnyZef6mr4xMdn9LKprb+mZnEPUlu8JEsOJE3B2z2GRTR
 wTIFXB4akEyGNwtUE0FtEJQsLiMgJUF6HzXloxbt1TI/aSHxO+TAWl8M9UNBhcQXcbn7weH
 xY106YkOKHIZihXqg67s16al+Bk27i8lxFkjmBlVe362L+Zr+IkESAM7gG9A==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id A48C8160564; Tue,  1 Jun 2021 00:41:37 -0700 (PDT)
Date:   Tue, 1 Jun 2021 00:41:37 -0700
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
Message-ID: <20210601074137.GC13530@lespinasse.org>
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

Thanks for looking into this.

I have to say, C's handling of header files is one of my least
favourite features, it tends to be very unmaintainable when there are
multiple configs involved :/

I haven't spent any time trying to reproduce the issue yet.
Paul, could you send your .config file to give me a starting point ?
Or maybe Suren already figured out what combination of config options
triggers the issue ?

Thanks,

--
Michel "walken" Lespinasse
