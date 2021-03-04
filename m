Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C932CA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhCDBjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhCDBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:38:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9FC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 17:38:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q204so16617013pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 17:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RzlHn4xFRh1Zx79ORyn6MfrsS+lNJ1vPReW80eTB3E=;
        b=UzzJplrA+FoaUIs6vVFqHpyo+BUwyG1DYilJI6kodVPoMKbAuSZUkPY0cxTEppgWBN
         mzKtQZ3FsnmBKJU2uw+t50HaT27+0nkKaaNSAJ7sNDlt7IBDhsAJ34AAxvdV3khyD8DT
         pJWXqYN+MPQ1+8kFodjaSjg1ZRoGH4b4EWOxeDEFDBWKzRerXEM74HSznqJYv6exjd6Y
         POmfygtbtp5ULsCvaS9Ahawb4Qwm0MI2KOfos69+M1Xm0RDIKh2RxRPdiIgm1fYf5ykS
         IDpOHNWnFqbQd6uhA/wmsegEeLRYyIRyOTt7bj/A3twy4DDXI9SblgWtZFn+QUzL9KkC
         eObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5RzlHn4xFRh1Zx79ORyn6MfrsS+lNJ1vPReW80eTB3E=;
        b=Orhz7ieYpWzV7/1CtMyYXcE3NonTh/PsNnyQ/n/o/gyfLfGuGJxbUlGMcdXiaNrI7D
         Oj4imZ7/z1hXw8cz31FmI+UCqZs0XyZfAKGw6xwg9Lgu25U9uJ4aXQNcBA/aKGXlMJ/g
         kpWvK/etisKeb5mfMF+eVYCHiTKlBhQ5vuAP+9DIoHN980ASVQfENjoRptinfD9X4O6s
         F2R0t9U4tGn6e47LWzB3Ai29sIY2HM95ful6wndeDRX95wowfm+kn3LK5oPnmr+sZAZO
         u17jkOIcqstyuzPKEdpQ+EFM8YywgrUiTSuV4OhqWPbn2w5T5gGfo1wGE7laq0lcRuL6
         HzSw==
X-Gm-Message-State: AOAM531cWVKdSAx32jGqTgGrVoWxoKT2ycVBN9cGiVH0GFBx4EuQL+RS
        eZsjBBf75tO0T7t5TMNZCF9lFSotOrU=
X-Google-Smtp-Source: ABdhPJyR3HXwyIFHBX5fFAFE7aa3y92ete2pVPs9zFiKehki51VmjR9w7IYuXCTJ5sVabeX5vxqRbA==
X-Received: by 2002:aa7:8d92:0:b029:1ee:75d1:c87 with SMTP id i18-20020aa78d920000b02901ee75d10c87mr1547429pfr.9.1614821895386;
        Wed, 03 Mar 2021 17:38:15 -0800 (PST)
Received: from google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id m9sm7562093pjl.4.2021.03.03.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:38:14 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 3 Mar 2021 17:38:12 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, surenb@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-ID: <YEA6BGHO0I1hSjLq@google.com>
References: <20210303205053.2906924-1-minchan@kernel.org>
 <20210303144449.aa69518bfbaec9c71f799dc7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303144449.aa69518bfbaec9c71f799dc7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 02:44:49PM -0800, Andrew Morton wrote:
> On Wed,  3 Mar 2021 12:50:53 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Since CMA is getting used more widely, it's more important to
> > keep monitoring CMA statistics for system health since it's
> > directly related to user experience.
> > 
> > This patch introduces sysfs statistics for CMA, in order to provide
> > some basic monitoring of the CMA allocator.
> > 
> >  * the number of CMA page allocation attempts
> >  * the number of CMA page allocation failures
> > 
> > These two values allow the user to calcuate the allocation
> > failure rate for each CMA area.
> > 
> > e.g.)
> >   /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
> >   /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
> >   /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> > 
> > ...
> >
> > --- a/mm/cma.h
> > +++ b/mm/cma.h
> > @@ -3,6 +3,14 @@
> >  #define __MM_CMA_H__
> >  
> >  #include <linux/debugfs.h>
> > +#include <linux/kobject.h>
> > +
> > +struct cma_stat {
> > +	spinlock_t lock;
> > +	unsigned long pages_attempts;	/* the number of CMA page allocation attempts */
> > +	unsigned long pages_fails;	/* the number of CMA page allocation failures */
> > +	struct kobject kobj;
> > +};
> >  
> >  struct cma {
> >  	unsigned long   base_pfn;
> > @@ -16,6 +24,9 @@ struct cma {
> >  	struct debugfs_u32_array dfs_bitmap;
> >  #endif
> >  	char name[CMA_MAX_NAME];
> > +#ifdef CONFIG_CMA_SYSFS
> > +	struct cma_stat	*stat;
> > +#endif
> >  };
> 
> Why aren't the stat fields simply placed directly into struct cma_stat?

It have a related long discussion.
https://lore.kernel.org/linux-mm/YCIoHBGELFWAyfMi@kroah.com/
https://lore.kernel.org/linux-mm/YCLLKDEQ4NYqb5Y5@kroah.com/

TLDR - Greg really want to see kobject stuff working as dynamic
property.

> 
> > ...
> >
> > +static int __init cma_sysfs_init(void)
> > +{
> > +	int i = 0;
> > +	struct cma *cma;
> > +
> > +	cma_kobj = kobject_create_and_add("cma", mm_kobj);
> > +	if (!cma_kobj) {
> > +		pr_err("failed to create cma kobject\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cma_stats = kzalloc(array_size(sizeof(struct cma_stat),
> > +				cma_area_count), GFP_KERNEL);
> 
> kmalloc_array(..., GFP_KERNEL|__GFP_ZERO);

Yub.

> 
> ?
> 
> > +	if (!cma_stats) {
> > +		pr_err("failed to create cma_stats\n");
> 
> Probably unneeded - the ENOMEM stack backtrace will point straight here.

I failed to find the point you mentioned to print backtrace.
Where code do you mean to dump the backtrace?
