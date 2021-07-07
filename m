Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC70D3BE48C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGGIpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:45:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGIpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:45:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE2D122420;
        Wed,  7 Jul 2021 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625647350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkLCW4DkuZu2U5kb03XazVB0P803gy0MwtE2WyaRvuA=;
        b=PAhMNqpAZQQNQMWGXPV/K3pU6RBD5KeDo/1jcw0nshTSqU4W0C/5I8s0gVFUajxpDz1/x4
        +hv5JilYabTkBpN578LwDcInUwniKbGRDr7dVw1u89BZ+u7SshjhWJTJcG1DEXlgEon84q
        e+6ks4eLHzd7+YDg2QNZC2v18UAY+Qg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 111B5A3B8A;
        Wed,  7 Jul 2021 08:42:30 +0000 (UTC)
Date:   Wed, 7 Jul 2021 10:42:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in
 bulk-allocator
Message-ID: <YOVo9bBtncG3/uLi@dhcp22.suse.cz>
References: <20210705170537.43060-1-urezki@gmail.com>
 <20210706132653.8374852963b25989e360d599@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706132653.8374852963b25989e360d599@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-07-21 13:26:53, Andrew Morton wrote:
> On Mon,  5 Jul 2021 19:05:36 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > In case of simultaneous vmalloc allocations, for example it is 1GB and
> > 12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
> > kernel.
> > 
> > <snip>
> > ...
> >
> > are obtained, i.e. do batched page requests adding cond_resched() meanwhile
> > to reschedule. Batched value is hard-coded and is 100 pages per call.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Can we please have a Fixes: for this?

Is this a fix for any actual real life problem? I mean allocating 1GB of
vmalloc space back and forth sounds like a stretch to me.
 
> Is this fix important enough for 4.14-rcx?  I think so...

I do not think so. This is an improvement so that vmalloc behaves more
sanely for those abusers...
-- 
Michal Hocko
SUSE Labs
