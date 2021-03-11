Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3996F337C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:17:12 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB77C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:17:11 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g4so14195594pgj.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xyO0tjr3czQHJ74CSGp1W7NkaFObkKH/BgzSQUWd/4c=;
        b=utUfhSKTSxUX+crWVXtGaBcG79X85FXBhVwJ5yuQdFJ5wCr7Lk6k37+c42JJiOnxL9
         t7AN8RNmlfngNlMidifSaDj/JI9nJKrVuNEHAaULd1oFfoxQLBmwZxP4iiaEla7MvWGA
         ZlmklBOUFRPyprWW1L5bzSgOw1j3HJmlRGqH92n4Zboy1+cNASHG1wH42RGimyBIj4z0
         vq2fFA7Wk9KMxdD6pcxIPsGGK1zJR28KSxwSBIkwvNIKQ96HhwtpLFoQcM9FGWSOIouf
         S7SW3ioP8ca1drCWtw+wwwvblUjMr1Et2LCGF+4NzolNcLuvJpWfCo4CPX27VtsB0s7B
         Nbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xyO0tjr3czQHJ74CSGp1W7NkaFObkKH/BgzSQUWd/4c=;
        b=E50fftWRG+xQglkiVuWdzdM5MPetLsdcHS+B4l4RtpfzCyT8k0pmW4vIuVK9hZnSOw
         2VfUBy232ESwmLpanpqxyYRqfv1mhwi8Csd9lXZGr45HHVPO18fR7kl/QdWyN7G1pWLf
         NrjwSaObs3PAagDCo2NYEbjWe3TT7TpkqHWwDQ18mYGnIWH4gydkGYw4wOzW8UzWmvLh
         YhxBlHpVzVUPMBHQ6fG6UCJGk1IqNgmZl/XOllppCDf30eq6sjZ1q9XrLMOl803kni60
         pgiJg2Ykp679z9ylS2a4gG+YnyB1+gW7PadfmiGCgrXdAvFJD6eap+brZSFtv5ffmKOd
         0Z9g==
X-Gm-Message-State: AOAM533l3nHwS8j8gsPzKNMtw7YMajKBHW8AC96C1BrpFsbOp57taBzz
        hZk5Ie7kMA7gPuARnyKYTBk=
X-Google-Smtp-Source: ABdhPJxg3tlHCUnP70z/OrKBd9ofGsVE7mOejG/hVLppuM8JS7gYdcCDtgRfasTcT7BIyApfqKuDDw==
X-Received: by 2002:a63:c90f:: with SMTP id o15mr4851390pgg.400.1615486630790;
        Thu, 11 Mar 2021 10:17:10 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id s26sm3063519pfd.5.2021.03.11.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:17:09 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Mar 2021 10:17:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>, Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v3] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEpeowE+NCc3dBhG@google.com>
References: <20210310180104.517886-1-minchan@kernel.org>
 <cdca0d9b-0c7e-bafc-6d86-bc75654b16ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdca0d9b-0c7e-bafc-6d86-bc75654b16ae@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 05:40:35PM +0100, David Hildenbrand wrote:
> On 10.03.21 19:01, Minchan Kim wrote:
> > Currently, debugging CMA allocation failures is quite limited.
> > The most commong source of these failures seems to be page
> > migration which doesn't provide any useful information on the
> > reason of the failure by itself. alloc_contig_range can report
> > those failures as it holds a list of migrate-failed pages.
> > 
> > page refcount, mapcount with page flags on dump_page are
> > helpful information to deduce the culprit. Furthermore,
> > dump_page_owner was super helpful to find long term pinner
> > who initiated the page allocation.
> > 
> > The reason it approach with dynamic debug is the debug message
> > could emit lots of noises as alloc_contig_range calls more
> > frequently since it's a best effort allocator.
> > 
> > There are two ifdefery conditions to support common dyndbg options:
> > 
> > - CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE
> > It aims for supporting the feature with only specific file
> > with adding ccflags.
> > 
> > - CONFIG_DYNAMIC_DEBUG
> > It aims for supporting the feature with system wide globally.
> > 
> > A simple example to enable the feature:
> > 
> > Admin could enable the dump like this(by default, disabled)
> > 
> > 	echo "func dump_migrate_failure_pages +p" > control
> > 
> > Admin could disable it.
> > 
> > 	echo "func dump_migrate_failure_pages =_" > control
> > 
> > Detail goes Documentation/admin-guide/dynamic-debug-howto.rst
> > 
> > A concern is utility functions in dump_page uses inconsistent
> > loglevels.
> > 
> > __dump_page: KERN_WARNING
> > __dump_page_owner: KERN_ALERT
> >          stack_trace_print: KERN_DEFAULT
> > 
> > There are bunch of places to use the inconsistent loglevel
> > utility functions(e.g., just grep dump_page/strace_trace_print).
> > It's unfortunate but here we are. It could be addressed
> > different patchset.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
> >    * remove ratelimit - mhocko
> > 
> > * from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
> >    * use dynamic debugging with system wide instead of per-call site - mhocko
> > 
> >   mm/page_alloc.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3e4b29ee2b1e..f42f3e208794 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
> >   				pageblock_nr_pages));
> >   }
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> > +static void alloc_contig_dump_pages(struct list_head *page_list)
> > +{
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > +			"migrate failure");
> > +
> > +	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
> > +		struct page *page;
> > +
> > +		WARN(1, "failed callstack");
> 
> Not sure if we want that here. You can deterministically crash a kernel with
> panic_on_warn set - which is what some distros already do.

Good point.

> 
> Some other way to dump the current call stack would be handy ...

Yub, let's go with dump_stack.

> 
> > +		list_for_each_entry(page, page_list, lru)
> > +			dump_page(page, "migration failure");
> > +	}
> > +}
> > +#else
> > +static inline void alloc_contig_dump_pages(struct list_head *page_list)
> > +{
> > +}
> > +#endif
> > +
> >   /* [start, end) must belong to a single zone. */
> >   static int __alloc_contig_migrate_range(struct compact_control *cc,
> >   					unsigned long start, unsigned long end)
> > @@ -8496,6 +8517,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> >   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> >   	}
> >   	if (ret < 0) {
> > +		alloc_contig_dump_pages(&cc->migratepages);
> >   		putback_movable_pages(&cc->migratepages);
> >   		return ret;
> >   	}
> > 
> 
> For me, this is good enough for now.

Thanks.
Let me send next revision with addressing your point and Andrew's one.
