Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073D2332D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhCIR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhCIR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:27:55 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52581C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:27:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w7so3446705pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RgCAC8soedBAR4QV6xrwRz7z96hXnQfIsjeHL6pqe5I=;
        b=neFB4ap49LsR/+Ea8ax5epXOkyWa4xXrzFKkoAMpt7upOSctyqk+0Znslr3U5Thf0G
         UkedV76CyXkyNkUD505gwubYQbvFedbL773bhgVpfauWpGD7Kr52RJeMQhzMzXRN0Or4
         HibQ5z3ETpIFtOF3yZUS94v1IVqNO2KGgXePMLGxr8wFNHjNH0pMePO40l5ebSwD5SFB
         x0KZY231Kqy7GfPBHRwugE1BXgQ8/C0S9GjzmVPDINz2tbsH0wzsQPtGqEfWDij0bTDT
         T2LLFeHo2v/0oC0NaLt+qlkqUPBQP294Wml1/VhONdDh3j/jGBcfJ+XFiipiX7zHivw7
         2zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RgCAC8soedBAR4QV6xrwRz7z96hXnQfIsjeHL6pqe5I=;
        b=TUWKPC2eyrxndbLkw+bYQyowEGP52FrwyyWHMR3RITN1ScRG7p37TkC5C6IiIo6g97
         o0DGwkQQSiWr2kMg4DOwj9TPHsNfdhLVkDTWK197OgYZK/TyXRpLhkbh/wOOHaEiZwmw
         2EH1X69iiIihXyY3CC/MN0B0FYCQddsTYrtQdl/brsiIIARdY13F4qwZAwlKYb6PB6B3
         YEBnfJXPkn3JKosYmF/IZpz/ne4UegU9n18XIkFk/do/jS37PYrlxn9USVsrlRBenogy
         LIIv152j6xklZ89zyLX3+5a5pIeHtcDczbVEIdbZu7CHDvF/l16ZzNULjsHq+Wb7ZKeF
         O9wQ==
X-Gm-Message-State: AOAM530oKU2MUKqpKCGiTCgbPTGhJgafYDYe+bITGCLQGQi+EzRQGLrq
        PfJgOTtH0S32n5rkZ8yppY3rGwKNs+Y=
X-Google-Smtp-Source: ABdhPJyD8Z2B4M1dFVTdJp5evU8UPdMy5k3IS9vQ4jFRKfoj4IZVuV0T3UZWyAZASZ7TZ8MPVIwIzw==
X-Received: by 2002:a17:90a:5587:: with SMTP id c7mr5549405pji.5.1615310874689;
        Tue, 09 Mar 2021 09:27:54 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id e83sm6038999pfh.80.2021.03.09.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:27:53 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 09:27:51 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEewF8c1ydu2pU0A@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEejCP5tzUtrAjcw@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEejCP5tzUtrAjcw@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:32:08PM +0100, Michal Hocko wrote:
> On Tue 09-03-21 08:15:41, Minchan Kim wrote:
> > On Tue, Mar 09, 2021 at 10:32:51AM +0100, Michal Hocko wrote:
> > > On Mon 08-03-21 12:20:47, Minchan Kim wrote:
> > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > It's critical if the page migration fails on those areas so
> > > > dump more debugging message.
> > > 
> > > I disagree with this statement. alloc_contig_range is not a reliable
> > > allocator. Any user, be it CMA or direct users of alloc_contig_range
> > > have to deal with allocation failures. Debugging information can be
> > > still useful but considering migration failures critical is
> > > overstatement to say the least.
> > 
> > Fair enough. Let's change it.
> > 
> > "Currently, debugging CMA allocation failure is too hard
> > due to lacking of page information. alloc_contig_range is
> > proper place to dump them since it has migrate-failed page
> > list."
> 
> "Currently, debugging CMA allocation failures is quite limited. The most
> commong source of these failures seems to be page migration which
> doesn't provide any useful information on the reason of the failure by
> itself. alloc_contig_range can report those failures as it holds a list
> of migrate-failed pages."

Will take it. Thanks.

< snip >

> > > Somebody more familiar with the dynamic debugging infrastructure needs
> > > to have a look but from from a quick look it seems ok.
> > > 
> > > Do we really need all the ugly ifdefery, though? Don't we want to have
> > > this compiled in all the time and just rely on the static branch managed
> > > by the dynamic debugging framework?
> > 
> > I have no further idea to make it simple while we keep the flexibility
> > for arguments and print format.
> > 
> > #if defined(CONFIG_DYNAMIC_DEBUG) || \
> >         (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> > static void alloc_contig_dump_pages(struct list_head *page_list)
> > {
> >         static DEFINE_RATELIMIT_STATE(_rs,
> >                                         DEFAULT_RATELIMIT_INTERVAL,
> >                                         DEFAULT_RATELIMIT_BURST);
> > 
> >         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> >                         "migrate failure");
> >         if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs)) {
> >                 struct page *page;
> > 
> >                 WARN(1, "failed callstack");
> >                 list_for_each_entry(page, page_list, lru)
> >                         dump_page(page, "migration failure");
> >         }
> > }
> > #else
> > static inline void alloc_contig_dump_pages(struct list_head *page_list)
> > {
> > }
> > #endif
> 
> First, you would be much better off by droping the rate limitting. I am
> nt really convinced this is really necessary as this is a debugging aid
> enabled on request. A single list can be large enough to swamp logs so
> why bother?

No problem. Just added since David mentioned hugetlb pages are easily
fail to mgirate at this moment.
Yes, We could add the ratelimit if we get complain.

> 
> Also are all those CONFIG_DYNAMIC_DEBUG* ifdefs necessary?  Can we
> simply enable DYNAMIC_DEBUG for page_alloc as I've suggested above?

They are different usecases.

With DYNAMIC_DEBUG_MODULE with CONFIG_DYNAMIC_DEBUG_CORE,
it works for only specific compile flags as you suggested.
(CONFIG_DYNAMIC_DEBUG_CORE is requirement to work DYNAMIC_DEBUG_MODULE.

With CONFIG_DYNAMIC_DEBUG, user could enable/disable every dynamic
debug places without needing DYNAMIC_DEBUG_MODULE flags for source
files.

Both usecase makes sense to me.
