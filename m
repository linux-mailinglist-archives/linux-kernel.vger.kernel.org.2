Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D64332BB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhCIQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCIQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:15:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:15:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso3011152pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q8QcsiDggpb3mUao/vPMlCQf9DIzik0cDjIhhbkZ1xU=;
        b=kurzX2QEsZgWOk8Mh1sbjNngCHk6XBbPsZJWyXicZERzy0zHoyqVMbXT5GZgCRIJQr
         /fEApk1lteEzwU211kh81mfmqSuOWYzEm+8P8j0bhxfC/pzGpRKix6ZxO2P9KEY87caL
         EjrrT6qnehJsKEPq+27N+k5AAxHipLak2kP4H7ffzgtk8PzmIq98kdazRicmfsiiCz9a
         jlq0W5JykHT85+g0YlzzZ+Nu8lHjP9CcVyU0UDrMy+as8kLPefIZ4D784szO6IR7cwda
         FnIfZwPLKT6XmNWS4oWarsVl4PREzvmITjUqX8qk48isdxRyuMWUUNvMmiWlWvv612oC
         SECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q8QcsiDggpb3mUao/vPMlCQf9DIzik0cDjIhhbkZ1xU=;
        b=ZkLW5w0SNoifpLUUxYu61jeIe/++WhYAKBUQgd1+lYCv/ixqJS1IUt577Mw8eps+Gb
         Gjl3eesWJT/iPm5oWIIz9KX0o655eDWn21OnF/rutKCJn5U6D0LPw6hfE5U9svGIJjEN
         mzctz4XlW2rSuJ/tf6UU25J4bMmUU2xvhDe8RLpB+chG9It1ZyeG2psvPuN94innHnfw
         CPs0UrboLTPZn72mXxU2zdaYd6hrhOfLzg5DVKtOPF5CbvXfbVTmdVgm4mSNvOopG9BA
         eutV4xmbBTHop9/OXr/WXzSnlxcgzvrRqA5OXJ/xEZ5AbYoroLJABtKHRD4rusojRhVE
         jp8Q==
X-Gm-Message-State: AOAM531P+oPlB+Ii63BFfKiIWf+VidGlaZNAB0bguxteBdizzyIf6nQY
        js58ndOR+TX8AbCC2U+xiu4=
X-Google-Smtp-Source: ABdhPJwvXPilPXsLCeZvlYRu1vDeUu5wIgsqikU51/KQCQC6Hsol40QPCM9/bNVg2VMvX6OfnsvpSw==
X-Received: by 2002:a17:902:ab8f:b029:e5:c92e:2c5f with SMTP id f15-20020a170902ab8fb02900e5c92e2c5fmr4565623plr.75.1615306544357;
        Tue, 09 Mar 2021 08:15:44 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id i10sm15315250pgo.75.2021.03.09.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:15:43 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 08:15:41 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEefLYiX6rF3Uk4E@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:32:51AM +0100, Michal Hocko wrote:
> On Mon 08-03-21 12:20:47, Minchan Kim wrote:
> > alloc_contig_range is usually used on cma area or movable zone.
> > It's critical if the page migration fails on those areas so
> > dump more debugging message.
> 
> I disagree with this statement. alloc_contig_range is not a reliable
> allocator. Any user, be it CMA or direct users of alloc_contig_range
> have to deal with allocation failures. Debugging information can be
> still useful but considering migration failures critical is
> overstatement to say the least.

Fair enough. Let's change it.

"Currently, debugging CMA allocation failure is too hard
due to lacking of page information. alloc_contig_range is
proper place to dump them since it has migrate-failed page
list."


> 
> > page refcount, mapcount with page flags on dump_page are
> > helpful information to deduce the culprit. Furthermore,
> > dump_page_owner was super helpful to find long term pinner
> > who initiated the page allocation.
> > 
> > Admin could enable the dump like this(by default, disabled)
> > 
> > 	echo "func dump_migrate_failure_pages +p" > control
> > 
> > Admin could disable it.
> > 
> > 	echo "func dump_migrate_failure_pages =_" > control
> 
> My original idea was to add few pr_debug and -DDYNAMIC_DEBUG_MODULE for
> page_alloc.c. It makes sense to enable a whole bunch at once though.
> The naming should better reflect this is alloc_contig_rage related
> because the above sounds like a generic migration failure thing.

alloc_contig_dump_pages?

> 
> Somebody more familiar with the dynamic debugging infrastructure needs
> to have a look but from from a quick look it seems ok.
> 
> Do we really need all the ugly ifdefery, though? Don't we want to have
> this compiled in all the time and just rely on the static branch managed
> by the dynamic debugging framework?

I have no further idea to make it simple while we keep the flexibility
for arguments and print format.

#if defined(CONFIG_DYNAMIC_DEBUG) || \
        (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
static void alloc_contig_dump_pages(struct list_head *page_list)
{
        static DEFINE_RATELIMIT_STATE(_rs,
                                        DEFAULT_RATELIMIT_INTERVAL,
                                        DEFAULT_RATELIMIT_BURST);

        DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
                        "migrate failure");
        if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs)) {
                struct page *page;

                WARN(1, "failed callstack");
                list_for_each_entry(page, page_list, lru)
                        dump_page(page, "migration failure");
        }
}
#else
static inline void alloc_contig_dump_pages(struct list_head *page_list)
{
}
#endif

>  
> [...]
> > +void dump_migrate_failure_pages(struct list_head *page_list)
> > +{
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > +			"migrate failure");
> > +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > +			alloc_contig_ratelimit()) {
> > +		struct page *page;
> > +
> > +		WARN(1, "failed callstack");
> > +		list_for_each_entry(page, page_list, lru)
> > +			dump_page(page, "migration failure");
> > +	}
> 
> Apart from the above, do we have to warn for something that is a
> debugging aid? A similar concern wrt dump_page which uses pr_warn and

Make sense.

> page owner is using even pr_alert.
> Would it make sense to add a loglevel parameter both into __dump_page
> and dump_page_owner?

Let me try it.
