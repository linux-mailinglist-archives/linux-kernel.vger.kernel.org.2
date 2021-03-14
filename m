Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4333A371
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 08:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhCNHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 03:45:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:45:23 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z13so30224169iox.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c2Df9KqMXmJAPX/BGJjQIjMHZK30Fyv7x3AyjGi8hZg=;
        b=mX5bmAeZvHLcUaOx8cqeBs2Jfh2QMjAnwdBhGoR82xhGZqp+5ORQGPJpkrk6e6LyMi
         NdJmkpQ4SAnriWfG69eGwkd0CP9u9c9WAEJCdOU/oXuirVtdqc44SEGsJkED+AOdQ/j6
         axFqnDaOHIxBepJ5qp+iM3QPrFeKLxtNv0nM9fyIlXQMqb5iUcS1opNBRuQXTBEuvGc1
         7/vUz5XzT27O9fAd3n9cSDtenBH5UOsFau2X5bt9yuQelyd0L6NbN8MYyPm+wRS6nqz1
         MCEBLCaq7YIuE1Xcy2eCtGVyrMmVzj0R6H+ogVzDwpy3XmArkrYqm6wWUrUasl6LqB7o
         rnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c2Df9KqMXmJAPX/BGJjQIjMHZK30Fyv7x3AyjGi8hZg=;
        b=P1uVHVyPqCfiDFnfP7fTC3LleVKRQtukj7bwkpE3Gvt+jkY3cJYhHjPdCzQvrvTbyE
         3diahOKdvDvy5fRbyV2tstvhyLdmFhGz6soJ3wlhRaiHvNeYKREx3gQk4/uHmv2mRDu/
         t35lxQbvC8zTsemGNpYPN5OSZ4PeR4xiO8rsyttX+WI/5kJVZ/lBVY0woqv947v4pc2T
         JfleTfRKWguwdX2UxR2Ky6U1/BueTI5JnyUUHqJypinCRC+YgCT0gkzhRtEkTkOxhB4Q
         7B0in9vqg3rtRYfb3tzwFVl7VCzdraWVMYykxfwRvgDeLyt8YOfdRFAwKXd9Qfb6T9nT
         heEw==
X-Gm-Message-State: AOAM531u9fEo6DR1UVa6qPSLrqNfLbRIxYSB1NNvTvE5zPtftCUUYVuS
        OJjHunxaJ07qRpDtXHoy3UrmIA==
X-Google-Smtp-Source: ABdhPJx0oUMZWVtlgj9lUn+RJPTG45aJ+hibkbpMvu4YotZivIMW/JM9715OgSgjMDC0h9JJxVMJvQ==
X-Received: by 2002:a5d:9659:: with SMTP id d25mr792249ios.146.1615707922334;
        Sat, 13 Mar 2021 23:45:22 -0800 (PST)
Received: from google.com ([2620:15c:183:200:fd93:7779:42e7:2899])
        by smtp.gmail.com with ESMTPSA id a12sm4193650ilt.53.2021.03.13.23.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 23:45:21 -0800 (PST)
Date:   Sun, 14 Mar 2021 00:45:16 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 01/14] include/linux/memcontrol.h: do not warn in
 page_memcg_rcu() if !CONFIG_MEMCG
Message-ID: <YE2/DFSXvnoluncA@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-2-yuzhao@google.com>
 <20210313150918.GH2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313150918.GH2577561@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 03:09:18PM +0000, Matthew Wilcox wrote:
> On Sat, Mar 13, 2021 at 12:57:34AM -0700, Yu Zhao wrote:
> > We want to make sure the rcu lock is held while using
> > page_memcg_rcu(). But having a WARN_ON_ONCE() in page_memcg_rcu() when
> > !CONFIG_MEMCG is superfluous because of the following legit use case:
> > 
> >   memcg = lock_page_memcg(page1)
> >     (rcu_read_lock() if CONFIG_MEMCG=y)
> > 
> >   do something to page1
> > 
> >   if (page_memcg_rcu(page2) == memcg)
> >     do something to page2 too as it cannot be migrated away from the
> >     memcg either.
> > 
> >   unlock_page_memcg(page1)
> >     (rcu_read_unlock() if CONFIG_MEMCG=y)
> > 
> > This patch removes the WARN_ON_ONCE() from page_memcg_rcu() for the
> > !CONFIG_MEMCG case.
> 
> I think this is wrong.  Usually we try to have the same locking
> environment no matter what the CONFIG options are, like with
> kmap_atomic().  I think lock_page_memcg() should disable RCU even if
> CONFIG_MEMCG=n.

I agree in principle. On this topic I often debate myself where to
draw the line between being rigorous and paranoid. But in this
particular case, I thought it's no brainer because, imo, most of the
systems that don't use memcgs are small and preemptable, e.g.,
openwrt. They wouldn't appreciate a larger code size or rcu stalls due
to preemptions of functions that take rcu locks just to be rigorous.

This shouldn't be a problem if we only do so when CONFIG_DEBUG_VM=y,
but then its test coverage is another question. I'd be happy to work
out something in this direction, hopefully worth the trouble, if you
think this compromise is acceptable.
