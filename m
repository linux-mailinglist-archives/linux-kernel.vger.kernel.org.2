Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D72337E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCKT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:27:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C04C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:27:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so9855074pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=di7TxN9U126MSsXtqlFQMHE0KdPDQyfURh79C8JPP0U=;
        b=TVRq0bZ2FraysW+EuxxHMyYW2TT1gIy6UzaA7mf8P9r6gheonkItJbRnC+mzH4DVh4
         BrCjw+aURdQiNTr+sFBxWZu6oMNl5Twn2dfHo9oB6yeueNk2ZFl1CKZDBFPrsjfJG5lb
         owdY409itZQWQd3iGWHk3+VDPgTZX4I3VPu9TFqCf7tnTsmtq2/JiWKll2+Xhu8kQGAU
         ZZBmykwbelU54pjljgevY6MSeOpiur863A12VyyeqNbds6WXXf2NJaGFSRHhHjlGW5BN
         6SfdUaGOR0yD9RLQE+ojIQVKGgpcbh2CwkVBmAnebNwayWxv3LSfu6a0p/LlnPiMefl3
         b/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=di7TxN9U126MSsXtqlFQMHE0KdPDQyfURh79C8JPP0U=;
        b=kVyYpUxAQId7gT91B8tyJBYpOlLhfG0NN5J9iVYlFhKTfI8okqtmFsMEQV27ORdOql
         tk+9p9J4nMAosMccvCllMSOKTiZJdDxcRptHCUjuES6k4IDyAnG2ZZlPMNrCMfx5/V/m
         XqkmkuEu7+MLmUZaeEyE1M+rwHWQV8e3DwAM3uLTSvvoAiLwFDc1o8V4LWtfI6oXEodN
         BWFkqqWIFascKWqyQ3q85GN/vFPOU3kT0hPGUg19Okuv9ivCQexjEsLQZkic7B9KEGRX
         92cM902+EZ62/5xYzAoj0/4J/46KUOAsEMNdRJTbpVF/ehxzSY4H3Q20k3KRz5LV9/L3
         /dNw==
X-Gm-Message-State: AOAM533ANhlGbGLQ7nYrbXZkZRAcvydy+D+ystXWzSmYdAh8pM+oLn2o
        g5QCq4WJS3yW87qQWeiuwJU=
X-Google-Smtp-Source: ABdhPJxTCSt6l5a1HplytmRfVdIODJI7BtuMtW4z7hsoBorfmlcBoPYhRytrHlcIa2XqjPO0Jd2urg==
X-Received: by 2002:a17:903:1242:b029:e0:3263:1693 with SMTP id u2-20020a1709031242b02900e032631693mr9871609plh.33.1615490868099;
        Thu, 11 Mar 2021 11:27:48 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id y68sm3498281pgy.5.2021.03.11.11.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:27:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Mar 2021 11:27:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>, Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v4] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEpvMSUbSIw6UQRn@google.com>
References: <20210311183047.805891-1-minchan@kernel.org>
 <c2bdb4c2-e025-53b2-5c96-6fe413eb242f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bdb4c2-e025-53b2-5c96-6fe413eb242f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 07:53:01PM +0100, David Hildenbrand wrote:
> On 11.03.21 19:30, Minchan Kim wrote:
> > Currently, debugging CMA allocation failures is quite limited.
> > The most commong source of these failures seems to be page
> 
> s/commong/common/

Oops.

> 
> > migration which doesn't provide any useful information on the
> > reason of the failure by itself. alloc_contig_range can report
> > those failures as it holds a list of migrate-failed pages.
> > 
> > page refcount, mapcount with page flags on dump_page are
> > helpful information to deduce the culprit. Furthermore,
> > dump_page_owner was super helpful to find long term pinner
> > who initiated the page allocation.
> 
> Maybe simply "The information logged by dump_page() has already proven
> helpful for debugging allocation issues, like identifying long-term pinnings
> on ZONE_MOVABLE or MIGRATE_CMA."

Will take it.

> 
> > 
> > The reason it approach with dynamic debug is the debug message
> > could emit lots of noises as alloc_contig_range calls more
> > frequently since it's a best effort allocator.
> 
> "Let's use the dynamic debugging infrastructure, such that we avoid
> flooding the logs and creating a lot of noise on frequent
> alloc_contig_range() calls. This information is helpful for debugging only."

Sure.

> 
> >>>
> 
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
> > 	echo "func alloc_contig_dump_pages +p" > control
> > 
> > Admin could disable it.
> > 
> > 	echo "func alloc_contig_dump_pages =_" > control
> > 
> > Detail goes Documentation/admin-guide/dynamic-debug-howto.rst
> 
> <<< I'd drop that completely and only mention:
> 
> "For details on dynamic debugging, see
> Documentation/admin-guide/dynamic-debug-howto.rst."

I'd like to keep it since many developer are not familiar with
dynamic debug and the syntax was not straightforward to me
when I read the doc. I believe that's why Andrew asked me to
add simple comment on the comment. Including simple how to use
in the description makes reviewer more comfortable to start
the detail doc if they want to read and test.

> 
> As you have usage in the code itself, I think you don't have to be
> repetitive. The ifdeffery seems to be common (e.g.,
> include/linux/netdevice.) for dynamic debugging users, so I don't see the
> need to describe that in detail.
> 
> >>>
> 
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
> 
> <<< I'd drop that completely and mention
> 
> "In the future, we might want to make the loglevels used inside dump_page()
> consistent and eventually rework the way we log the information here. See
> [1]"
> 
> Where [1] is a link to the discussion.
> 
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from v3 - https://lore.kernel.org/linux-mm/20210310180104.517886-1-minchan@kernel.org
> >    * add dyndgb usage comment - akpm
> >    * use dumpstack instead of warn_on - david
> > 
> > * from v2 - https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/
> >    * remove ratelimit - mhocko
> > 
> > * from v1 - https://lore.kernel.org/linux-mm/20210217163603.429062-1-minchan@kernel.org/
> >    * use dynamic debugging with system wide instead of per-call site - mhocko
> > 
> >   mm/page_alloc.c | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> > 
> 
> Minor nits:
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3e4b29ee2b1e..76fc202cb105 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8453,6 +8453,36 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
> >   				pageblock_nr_pages));
> >   }
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> > +/*
> > + * usage)
> 
> "usage)" looks wrong here. Did you mean "Usage:"

Sure.

> 
> > + * 	dyndbg_dir="/sys/kernel/debug/dynamic_debug"
> > + * To enable:
> > + * 	echo "func alloc_contig_dump_pages +p" > $dyndbg_dir/control
> > + * To disable:
> > + * 	echo "func alloc_contig_dump_pages =_" > $dyndbg_dir/control
> > + * For detail, read dynamic-debug-howto.rst
> 
> Maybe simply
> 
> "See admin-guide/dynamic-debug-howto.rst"

Yes, for code comment, it would be enough to point out where the detail
is. 

> 
> > + */
> > +static void alloc_contig_dump_pages(struct list_head *page_list)
> > +{
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > +			"migrate failure");
> 
> You can fit that into a single line.

Sure.

> 
> > +
> > +	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {
> > +		struct page *page;
> > +
> > +		dump_stack();
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
> > @@ -8496,6 +8526,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> >   				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> >   	}
> >   	if (ret < 0) {
> > +		alloc_contig_dump_pages(&cc->migratepages);
> >   		putback_movable_pages(&cc->migratepages);
> >   		return ret;
> >   	}
> > 
> 
> As I said, for my taste good enough for now. I would certainly preferred
> what Michal suggested (e.g., doing it via debug loglevels), but this gets

Sure, that is definitely improvement. Someday, I will post the clean up.

> the job done and is not too ugly.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks.
