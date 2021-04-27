Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECE36BDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhD0Dhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhD0Dhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:37:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46779C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ANnb4BwdsJgmq/ngwPXPAcMleywCXQ3VIzlu/GWL+j8=; b=YbE8TFo8bThfJ9RPb+iSuOjGVQ
        ORpBqVTGkE+DtxIy43Gj78IGNx2o5/o2sVIV6/IP9LlNNsqnw34sirZi5JAgoQTC/yOe6DD/1wa4+
        emRFw+I8JUng9GOPCN8Vav00R0XuHrnNae/yqXWbPC5GHlfxVjYLW/F+/Pl5BPf+liqA0Rc45ieRK
        ikg4H1ETqI7k4uZpt6ik0X2YppSzkRpGzv9m+1DxIjDV4bi/4UwDzr8+LkfhspfGveOEQdKUTHZsq
        OtUTRyVr6JLdgVupdefQ9utV17Ribe8tBrpr+jxtCgkCDHM+cQAu/bLxtuzbv1+NwaCx0T73PSs51
        nN88gaYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbEWW-006QLu-T6; Tue, 27 Apr 2021 03:36:38 +0000
Date:   Tue, 27 Apr 2021 04:36:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
Message-ID: <20210427033632.GW235567@casper.infradead.org>
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org>
 <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:29:32AM +0800, Xiongwei Song wrote:
> On Tue, Apr 27, 2021 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> > > From: Xiongwei Song <sxwjean@gmail.com>
> > >
> > > When calling kmalloc_order, the flags should include __GFP_COMP here,
> > > so that trace_malloc can trace the precise flags.
> >
> > I suppose that depends on your point of view.
> Correct.
> 
> Should we report the
> > flags used by the caller, or the flags that we used to allocate memory?
> > And why does it matter?
> When I capture kmem:kmalloc events on my env with perf:
> (perf record -p my_pid -e kmem:kmalloc)
> I got the result below:
>      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000
> bytes_req=10176 bytes_alloc=16384
> gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC

Hmm ... if you have a lot of allocations about this size, that would
argue in favour of adding a kmem_cache of 10880 [*] bytes.  That way,
we'd get 3 allocations per 32kB instead of 2.

[*] 32768 / 3, rounded down to a 64 byte cacheline

But I don't understand why this confused you.  Your caller at
ffffffff851d0cb0 didn't specify __GFP_COMP.  I'd be more confused if
this did report __GFP_COMP.

