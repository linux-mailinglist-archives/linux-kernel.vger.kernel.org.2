Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD338C738
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhEUM5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEUM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:56:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:55:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f12so23829873ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RG+qj7BiHESr7b9/kpky5P+DagmlXXZqdyvMo23Vqwk=;
        b=FaHzqMzjtIl+aTlXwc3sixqf6LBB3UGl3YkBUO8afOdqTNLV/3oPD0fMFKRrv3ZK4u
         fAOYhSHQfTYABJFI+X9Fok6Kz+PJApjQ6YBtRItIimFa4lGK8skHlWFVEC71xZ7KpG8L
         D+ul5GAqy2uABC3q1ONGWtEuFSsD3fr5rTj+IKpd6e/69dJbghVBNFYAl6vGQlaUbwEZ
         /uGmN8Y5y/mz0Qi3jmyk4SQlwpYDE59frGd5g+VLjPpc4iQ6cn14TpmvZw19nlNzL197
         vt89Axjy6ejyjAMaKYNHEWvrVVDEXpBzBcpnEzR3d6h7gShr7fZheAPuvIJiEZtlP4oQ
         A99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RG+qj7BiHESr7b9/kpky5P+DagmlXXZqdyvMo23Vqwk=;
        b=OM+sEeTMK6H+QXm2vLw3NsToBqS3uY16kk8BmZSG0WzY790jSL7ucHAzD4oD3BBRJv
         /T3IR8lSkUibdwIu5CXmAGOuldToMhyjKLMxM7XboUuIdehQrxhXIjL/HqzuPxrWrV86
         UwMtlxAVekQyvgYSxshp58Q7isUt70iP7ngti2qRTPGW9oCR4qE6lIv8IXqcAGlhk18a
         ubUyRRVsPlTK65ByMbuuPluC/igHAYWUAB1r8YRIpCE2FIJmh4TPw70zyMxEgIj4p7ht
         MFDkjH8b52AwlRUIJco2KI6k9AzfNIjs9lh7FJX/jG90JRrkdgmCxPxPs2APmWBAoYqr
         ARNw==
X-Gm-Message-State: AOAM53295B7JVfViYZ9MI2ab9Xniam7c8vUgLpewplofohPkkkWz8+5n
        y4yy595fczSeAhaY62bLpSk=
X-Google-Smtp-Source: ABdhPJy74Snm1N/MyJlMd0ksGioW6dOm79VU8ZxYAdzQ8eaBLwMvirD+o2auuaRC/VyTT2YaokUIOg==
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr663521ljk.301.1621601712150;
        Fri, 21 May 2021 05:55:12 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d28sm638048ljo.136.2021.05.21.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:55:11 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 21 May 2021 14:55:09 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm/vmalloc: Fallback to a single page allocator
Message-ID: <20210521125509.GA2442@pc638.lan>
References: <20210521111033.2243-1-urezki@gmail.com>
 <YKecydxDtWLTDuKg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKecydxDtWLTDuKg@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 21, 2021 at 01:10:33PM +0200, Uladzislau Rezki (Sony) wrote:
> > +static inline unsigned int
> > +vm_area_alloc_pages(gfp_t gfp, int nid, unsigned int page_order,
> > +	unsigned long nr_small_pages, struct page **pages)
> 
> (at least) two tabs here, please, otherwise the argument list is at
> the same indentation as the code which trips up my parser.  some people
> like to match the opening bracket, but that always feels like more work
> than it's worth.  fwiw, i'd format it like this:
> 
> static inline unsigned int vm_area_alloc_pages(gfp_t gfp, int nid,
> 		unsigned int order, unsigned long nr_pages, struct page **pages)
> {
> ...
>
No problem. Will fix it.

> 
> (yes, i renamed some of the variables there; overly long variable names
> are painful)
> 
> The rest of the patch looks good.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Thank you!

I will re-spin the patch and send a v2.

--
Vlad Rezki
