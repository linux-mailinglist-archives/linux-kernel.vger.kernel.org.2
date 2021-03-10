Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A53344CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhCJRHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhCJRGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:06:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3281C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:06:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7834297pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TfEm/y7pEQMr6MXjjU5bRH5tGGOCo24jcAcUw3mQM4s=;
        b=J8abThtMfxLAw9eH0YlC39eu8FGF7dH6sZt718K5+YhCCZy93/gSBWX7M+fIM7DWLa
         GWQwxTOkLGTL8cd958P0pBPh6vXMmO9AnVKXyF8EH/OCdPNJyWyZocVk+PmoRpGror5r
         DFzs8s7ZyXS42Ng/2yRaDkbLOrONFs9Xc2kjq0Nfof0LW+xC7Bj88jP1EH4N7IFUgtwq
         cAskTeWfYexhsik70qKo19NxwDLWLudHXXHNnvsEn8vTRKMCu2vEj55Ijw2jHPR6ZoMq
         GI8oruf7g41Wx0c6VBcfGcVxhXVsfBXkWifpJksav3KLiCjGVMGm49ANYJRkpHKZb0gm
         QCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TfEm/y7pEQMr6MXjjU5bRH5tGGOCo24jcAcUw3mQM4s=;
        b=MeZ0F6yXCfIEKgyO/3oNaQ9nMM/rVl+x5eaAbIxVFOHFZW3glaxa3005G99lr0MbRt
         ePCwG0pGzVmOyU0pzz9EuAufAqZo3ZFDnws36mQO3Bcsl5suwT9P4U2+vlkXUS6neHyt
         CdCdqhWgZZ4k0yI5T9z7g3NgmBUDWqXOIyZv4sQBMFVeuxLBfUD4p7I3kBg1eymLcpeR
         77TSp/znZUF0jgXbVkXE6jUGxlOSmhMLOVVs/BZJ9ZD+2BBqOCUfFyG2BEgm+xNj57OL
         YVQiwv4TBtCsC+uNiUPis4fI8LQQzflNPXRf0mP4nxVGygXRma5ISyMnDxWlQcuB+ZVd
         yrYA==
X-Gm-Message-State: AOAM5333NhUDuGm+IGHY1ZZ8yaLx/CicLiKC0Mv4eBIzJKsEQ4mfi+4f
        7MIvUE9MwJFQWrtbtTAQ4tI=
X-Google-Smtp-Source: ABdhPJwCWRueY/ClQ9By+RMJ0jAAvHVZvk6Jo9yiDh5JYuCFUDKZftr/Fb0E8TWYxiq/4YZfFygOmg==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr4529677pjb.74.1615396011239;
        Wed, 10 Mar 2021 09:06:51 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id d8sm113990pfq.27.2021.03.10.09.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:06:50 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 09:06:48 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEj8qACYFmbckWk7@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
 <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
 <YEjuUHBDKu2uX4EO@google.com>
 <YEj4AGuBn/Q4CIuY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEj4AGuBn/Q4CIuY@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:46:56PM +0100, Michal Hocko wrote:
> On Wed 10-03-21 08:05:36, Minchan Kim wrote:
> > On Wed, Mar 10, 2021 at 02:07:05PM +0100, Michal Hocko wrote:
> [...]
> > > The is a lot of churn indeed. Have you considered adding $FOO_lglvl
> > > variants for those so that you can use them for your particular case
> > > without affecting most of existing users? Something similar we have
> > > discussed in other email thread regarding lru_add_drain_all?
> > 
> > I thought that way but didn't try since it couldn't make them
> > atomic(For example, other printk place in other context will
> > affect by the $FOO_lglvl).
> 
> I do not follow. I meant something like the following (likely incomplete
> but you should get an idea).

Oh, I thought you wanted to override loglevel temporally.

old_lvl = save_printk_lvl(new level);
dump_page();
restore_printk_lvl(old_lvl);

> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 3468794f83d2..71b402eb8f78 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
>  extern void __split_page_owner(struct page *page, unsigned int nr);
>  extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
>  extern void __set_page_owner_migrate_reason(struct page *page, int reason);
> -extern void __dump_page_owner(struct page *page);
> +extern void __dump_page_owner(struct page *page, const char *loglvl);
>  extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  					pg_data_t *pgdat, struct zone *zone);
>  
> @@ -46,10 +46,10 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
>  	if (static_branch_unlikely(&page_owner_inited))
>  		__set_page_owner_migrate_reason(page, reason);
>  }
> -static inline void dump_page_owner(struct page *page)
> +static inline void dump_page_owner(struct page *page, const char *loglvl)
>  {
>  	if (static_branch_unlikely(&page_owner_inited))
> -		__dump_page_owner(page);
> +		__dump_page_owner(page, loglvl);
>  }
>  #else
>  static inline void reset_page_owner(struct page *page, unsigned int order)
> @@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
>  static inline void set_page_owner_migrate_reason(struct page *page, int reason)
>  {
>  }
> -static inline void dump_page_owner(struct page *page)
> +static inline void dump_page_owner(struct page *page, const char *loglvl)
>  {
>  }
>  #endif /* CONFIG_PAGE_OWNER */
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9f8117c7cfdd..1b13135d9916 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -14,6 +14,18 @@
>  #include <linux/kallsyms.h>
>  #include <linux/stacktrace.h>
>  
> +void __stack_trace_print(const unsigned long *entries, unsigned int nr_entries,
> +		       int spacesconst, char *loglvl)
> +{
> +	unsigned int i;
> +
> +	if (WARN_ON(!entries))
> +		return;
> +
> +	for (i = 0; i < nr_entries; i++)
> +		printk("%s%*c%pS\n", loglvl, 1 + spaces, ' ', (void *)entries[i]);
> +}

That's exactly I did with introducing pr_loglevel. I wanted to address
*all places* to use dump_page and stack_trace_print since some folks
might ask me to fix all the broken place all at once. I'm getting tired
with such hassle.

void dump_page(const char *log_lvl, struct page *page, const char *reason)
{
        __dump_page(log_lvl, page, reason);
        dump_page_owner(log_lvl, page);
}
EXPORT_SYMBOL(dump_page);

/**
 * pr_loglevel - Print an loglevel message
 * @level: loglevel
 * @fmt: format string
 * @...: arguments for the format string
 *
 * This macro expands to a printk with @loglevel. It uses pr_fmt() to
 * generate the format string.
 */
#define pr_loglevel(level, fmt, ...) \
        printk("%s" pr_fmt(fmt), level, ##__VA_ARGS__)

void __dump_page(const char *log_lvl, struct page *page, const char *reason)
{
..
..
        if (page_poisoned) {
                pr_loglevel(log_lvl, "page:%px is uninitialized and poisoned", page);
                goto hex_only;
        }
..
}

static inline void dump_page_owner(const char *log_lvl, struct page *page)
{
        if (static_branch_unlikely(&page_owner_inited))
                __dump_page_owner(log_lvl, page);
}

void stack_trace_print(const char *log_lvl, const unsigned long *entries,
                unsigned int nr_entries, int spaces)
{
        unsigned int i;

        if (WARN_ON(!entries))
                return;

        for (i = 0; i < nr_entries; i++)
                pr_loglevel(log_lvl, "%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
}
EXPORT_SYMBOL_GPL(stack_trace_print);


