Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A1334644
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhCJSH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:07:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:07:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 18so12621055pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zxiip2c1Jbn1bNQkx0KWERIv1qGU2NgyRSD/41MH1PQ=;
        b=sWH/DMKMNLZLpIijHk76vZJm0wBKHgHee05dHNVrYaqg4afe2O0sENf3b8h5k8dqqQ
         eUl6jzWb6id/wwcENgDwVwHFYfIWA9OkVSC4U4u36/BGy4FGRUvgQUyBJgV1rL1tegYl
         nFdFyHmALWSITuq3H+4HVxRclEmxvABye5qWOzsom1EtvAuN0KjqhjRJz5alwHJIzkEm
         RXupMVoHoiK5AQZZHj/XiCwhxH4/HFFP4MDsK0f77yKZD6DJaTFl7ecpOxesBHl+0vYR
         0tlA5jmXQRSBIhTkdkHjV1c8pfezT8ih2YCASBj+mism15sQxcsAPszgPTyTbz1cylMQ
         OF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zxiip2c1Jbn1bNQkx0KWERIv1qGU2NgyRSD/41MH1PQ=;
        b=BK42g+/eAYWt8iAldeKAI4uGB18yxrHvfMbM5w0aCrzMSu8maLYrFfaegn9eTSMs0T
         bBaOSsIPFHQg8ECUlY+NhHrbl0bbv/IqfohJ2Zk82ot85AKZOjVWaK7CwPrRcYIkZSyY
         XeyNklI0P9nnw12fOWqLAX+iIg0/V6OdI397cWJZDJPTcBIi46uUTrXggr+fsLVXdHKF
         VxJbx2ri09ZqGx2tEWtRb7wH7kfEsZgvCYfJ6FOAOBchUD15v6RgNLqNF29LCBy7HErd
         o+1KILwQ0ET88HZiZuOrnn6fwiW67/gL2jpp3PQVcc33eI65rExCoQGpjw06Kl7GOShk
         593Q==
X-Gm-Message-State: AOAM530v7pET/MdfhgaJ837h7IRJ9IIyA044I9OdRqpZF9QpjNgUf0PK
        XrpEkRQBRAGc5yj26vl7PASAy1Tphd8=
X-Google-Smtp-Source: ABdhPJyhnhncF9bbuxh/qByGIrJSZdLQDYG8wDeZD8q3uMLGvjC1p8zeIuLoR7GeDQr6G3CLDJfkRg==
X-Received: by 2002:a63:505d:: with SMTP id q29mr3731904pgl.218.1615399648986;
        Wed, 10 Mar 2021 10:07:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id d19sm67477pjs.55.2021.03.10.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:07:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 10:07:25 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEkK3SktwS46Fp9o@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
 <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
 <YEjuUHBDKu2uX4EO@google.com>
 <YEj4AGuBn/Q4CIuY@dhcp22.suse.cz>
 <YEj8qACYFmbckWk7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEj8qACYFmbckWk7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 09:06:48AM -0800, Minchan Kim wrote:
> On Wed, Mar 10, 2021 at 05:46:56PM +0100, Michal Hocko wrote:
> > On Wed 10-03-21 08:05:36, Minchan Kim wrote:
> > > On Wed, Mar 10, 2021 at 02:07:05PM +0100, Michal Hocko wrote:
> > [...]
> > > > The is a lot of churn indeed. Have you considered adding $FOO_lglvl
> > > > variants for those so that you can use them for your particular case
> > > > without affecting most of existing users? Something similar we have
> > > > discussed in other email thread regarding lru_add_drain_all?
> > > 
> > > I thought that way but didn't try since it couldn't make them
> > > atomic(For example, other printk place in other context will
> > > affect by the $FOO_lglvl).
> > 
> > I do not follow. I meant something like the following (likely incomplete
> > but you should get an idea).
> 
> Oh, I thought you wanted to override loglevel temporally.
> 
> old_lvl = save_printk_lvl(new level);
> dump_page();
> restore_printk_lvl(old_lvl);
> 
> > 
> > diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> > index 3468794f83d2..71b402eb8f78 100644
> > --- a/include/linux/page_owner.h
> > +++ b/include/linux/page_owner.h
> > @@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
> >  extern void __split_page_owner(struct page *page, unsigned int nr);
> >  extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
> >  extern void __set_page_owner_migrate_reason(struct page *page, int reason);
> > -extern void __dump_page_owner(struct page *page);
> > +extern void __dump_page_owner(struct page *page, const char *loglvl);
> >  extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> >  					pg_data_t *pgdat, struct zone *zone);
> >  
> > @@ -46,10 +46,10 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
> >  	if (static_branch_unlikely(&page_owner_inited))
> >  		__set_page_owner_migrate_reason(page, reason);
> >  }
> > -static inline void dump_page_owner(struct page *page)
> > +static inline void dump_page_owner(struct page *page, const char *loglvl)
> >  {
> >  	if (static_branch_unlikely(&page_owner_inited))
> > -		__dump_page_owner(page);
> > +		__dump_page_owner(page, loglvl);
> >  }
> >  #else
> >  static inline void reset_page_owner(struct page *page, unsigned int order)
> > @@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
> >  static inline void set_page_owner_migrate_reason(struct page *page, int reason)
> >  {
> >  }
> > -static inline void dump_page_owner(struct page *page)
> > +static inline void dump_page_owner(struct page *page, const char *loglvl)
> >  {
> >  }
> >  #endif /* CONFIG_PAGE_OWNER */
> > diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> > index 9f8117c7cfdd..1b13135d9916 100644
> > --- a/kernel/stacktrace.c
> > +++ b/kernel/stacktrace.c
> > @@ -14,6 +14,18 @@
> >  #include <linux/kallsyms.h>
> >  #include <linux/stacktrace.h>
> >  
> > +void __stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
> > +		       int spacesconst, char *loglvl)
> > +{
> > +	unsigned int i;
> > +
> > +	if (WARN_ON(!entries))
> > +		return;
> > +
> > +	for (i = 0; i < nr_entries; i++)
> > +		printk("%s%*c%pS\n", loglvl, 1 + spaces, ' ', (void *)entries[i]);
> > +}
> 
> That's exactly I did with introducing pr_loglevel. I wanted to address
> *all places* to use dump_page and stack_trace_print since some folks
> might ask me to fix all the broken place all at once. I'm getting tired
> with such hassle.
> 
> void dump_page(const char *log_lvl, struct page *page, const char *reason)
> {
>         __dump_page(log_lvl, page, reason);
>         dump_page_owner(log_lvl, page);
> }
> EXPORT_SYMBOL(dump_page);

Since it's good to have regardless of the patch, I posted next revision
with removeing ratelimit and put something more in description to
proceed the work.

Posted v3 - https://lore.kernel.org/linux-mm/20210310180104.517886-1-minchan@kernel.org/

