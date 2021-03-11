Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39E33686D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCKAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhCKAK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:10:27 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:10:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n9so11540656pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gs41KVLIDl1YqXYIyETYUWvJz/PpUVjtIQMneXFaB9M=;
        b=UrTecr91dq1tZRo04CLfTlKv8Cdj+YnBGVCz+zLUQU7mXZbJZugkWG6473cCQqzoLS
         b0miKagKU0NJTTRaqlqjeFbW65qv2T8X+Xq2sR4OhpZrZ0np69R3CQIjJehp8uuYdfvP
         EIol/EhR8extiFh3q9JfpdkBE3gyRhYrhVXeafWtE0qUFj8mKDrppuVt8uEYN7bsB8eN
         796Iqd8MFXuAKEQiKflaOQZoZiSINzWQmmU8a5CErD5+UB5bceuyP3YjV1KM/hEOCJ42
         iex4sOi1ioH1gBdtTGB/4E8rRNtcgVxVKQWru4jXCK7xNhGn4unJRydwBbQdN2ccpQbD
         ve8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Gs41KVLIDl1YqXYIyETYUWvJz/PpUVjtIQMneXFaB9M=;
        b=phDi1ps/XU0l483I4vnxCjoqvus+5e6npBBwyUGOxGfu6jJLwW9uJePaE2nx5VOjR+
         L02P1HZD3rQsk8z8VkHxPF87BCE22pnvG6/uHZrmF0pzWVPZnWBdjg2eyk7lrvmYmAx+
         lR9RocmUFeRlIcPWyZXMp8BzQHw3QdbD+0jj/aPNTsdFKHyhJteuFTdkSUXC8RDfZeAc
         0pmXGA8aEJQsSlvmjhreJuB+N+RjPiR5hpsT/7JRKjWBHavDUcGj5LKbycGty51Q6gjH
         +53ArUGCtk7zVCXx+zdcFF5iMJ5iKAn5CVuKWU8D/KEJqE7OaPplDOqhgvo9CmyjHzBN
         g96g==
X-Gm-Message-State: AOAM5311IN/x/hkOQF1QLcQ7P8BwV5yYDbnZfHhRXtJErUGHWxPXIxGD
        zDFN45RPhFm8ZCmQAAArxMs=
X-Google-Smtp-Source: ABdhPJxLtAAyRO3SrW+shtmaGb28nNyjaulRo690zfdpMLqhohdB8fazhtO9iJVGPOYHTJKG2I5l7A==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr5142164pfd.43.1615421427214;
        Wed, 10 Mar 2021 16:10:27 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id q15sm464043pje.28.2021.03.10.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:10:26 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 16:10:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v3] mm: page_alloc: dump migrate-failed pages
Message-ID: <YElf8BI0Ld54sd4V@google.com>
References: <20210310180104.517886-1-minchan@kernel.org>
 <20210310125609.359888dc65562fbed4b1f088@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310125609.359888dc65562fbed4b1f088@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 12:56:09PM -0800, Andrew Morton wrote:
> On Wed, 10 Mar 2021 10:01:04 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
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
> 
> I think the changelog is out of sync.  Did you mean
> "alloc_contig_dump_pages" here?

Oops. Now fixed.

> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8453,6 +8453,27 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
> >  				pageblock_nr_pages));
> >  }
> 
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
> > +		list_for_each_entry(page, page_list, lru)
> > +			dump_page(page, "migration failure");
> > +	}
> > +}
> 
> I doubt if everyone is familiar with dynamic debug.  It might be kind
> to add a little comment over this, telling people how to turn it on and
> off.

Something like this?

#if defined(CONFIG_DYNAMIC_DEBUG) || \
        (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
/*
 *      dyndbg_dir="/sys/kernel/debug/dynamic_debug"
 * To enable:
 *      echo "func dump_migrate_failure_pages +p" > $dyndbg_dir/control
 * To disable:
 *      echo "func dump_migrate_failure_pages =_" > $dyndbg_dir/control
 */
