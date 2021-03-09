Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABB332C25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCIQca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:32:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231700AbhCIQcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:32:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615307529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xcv+tTfctmNOcwxK3BnqfaoqCTlTPEg0tYmqXjRtkqc=;
        b=JD1vnHhwYyCf1KuBUErPu7BJVgBYoNZkqQBFd+v0oVdMHUUPz+FyGqfYXjY7W89+jF0/As
        ahXVuTf4p/GfYllcMoS3jHmjNFOI/2eBBkBj2zR5k577e9mCUuzWXkEpFFAQ3v8YbY0PAa
        6ZZk/x5aRl5h2vLyRXOHaaZLgVsmOQA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5604BAEBD;
        Tue,  9 Mar 2021 16:32:09 +0000 (UTC)
Date:   Tue, 9 Mar 2021 17:32:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEejCP5tzUtrAjcw@dhcp22.suse.cz>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEefLYiX6rF3Uk4E@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-03-21 08:15:41, Minchan Kim wrote:
> On Tue, Mar 09, 2021 at 10:32:51AM +0100, Michal Hocko wrote:
> > On Mon 08-03-21 12:20:47, Minchan Kim wrote:
> > > alloc_contig_range is usually used on cma area or movable zone.
> > > It's critical if the page migration fails on those areas so
> > > dump more debugging message.
> > 
> > I disagree with this statement. alloc_contig_range is not a reliable
> > allocator. Any user, be it CMA or direct users of alloc_contig_range
> > have to deal with allocation failures. Debugging information can be
> > still useful but considering migration failures critical is
> > overstatement to say the least.
> 
> Fair enough. Let's change it.
> 
> "Currently, debugging CMA allocation failure is too hard
> due to lacking of page information. alloc_contig_range is
> proper place to dump them since it has migrate-failed page
> list."

"Currently, debugging CMA allocation failures is quite limited. The most
commong source of these failures seems to be page migration which
doesn't provide any useful information on the reason of the failure by
itself. alloc_contig_range can report those failures as it holds a list
of migrate-failed pages."
 
> > > page refcount, mapcount with page flags on dump_page are
> > > helpful information to deduce the culprit. Furthermore,
> > > dump_page_owner was super helpful to find long term pinner
> > > who initiated the page allocation.
> > > 
> > > Admin could enable the dump like this(by default, disabled)
> > > 
> > > 	echo "func dump_migrate_failure_pages +p" > control
> > > 
> > > Admin could disable it.
> > > 
> > > 	echo "func dump_migrate_failure_pages =_" > control
> > 
> > My original idea was to add few pr_debug and -DDYNAMIC_DEBUG_MODULE for
> > page_alloc.c. It makes sense to enable a whole bunch at once though.
> > The naming should better reflect this is alloc_contig_rage related
> > because the above sounds like a generic migration failure thing.
> 
> alloc_contig_dump_pages?

Yes this is more clear.

> > Somebody more familiar with the dynamic debugging infrastructure needs
> > to have a look but from from a quick look it seems ok.
> > 
> > Do we really need all the ugly ifdefery, though? Don't we want to have
> > this compiled in all the time and just rely on the static branch managed
> > by the dynamic debugging framework?
> 
> I have no further idea to make it simple while we keep the flexibility
> for arguments and print format.
> 
> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>         (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> static void alloc_contig_dump_pages(struct list_head *page_list)
> {
>         static DEFINE_RATELIMIT_STATE(_rs,
>                                         DEFAULT_RATELIMIT_INTERVAL,
>                                         DEFAULT_RATELIMIT_BURST);
> 
>         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
>                         "migrate failure");
>         if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs)) {
>                 struct page *page;
> 
>                 WARN(1, "failed callstack");
>                 list_for_each_entry(page, page_list, lru)
>                         dump_page(page, "migration failure");
>         }
> }
> #else
> static inline void alloc_contig_dump_pages(struct list_head *page_list)
> {
> }
> #endif

First, you would be much better off by droping the rate limitting. I am
nt really convinced this is really necessary as this is a debugging aid
enabled on request. A single list can be large enough to swamp logs so
why bother?

Also are all those CONFIG_DYNAMIC_DEBUG* ifdefs necessary?  Can we
simply enable DYNAMIC_DEBUG for page_alloc as I've suggested above?
-- 
Michal Hocko
SUSE Labs
