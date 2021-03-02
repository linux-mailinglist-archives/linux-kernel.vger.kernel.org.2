Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAF32A3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577763AbhCBJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238007AbhCBJgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:36:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614677650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSTLa9hZjScF2nB/fdohi0qlgKjoTXLy1AfmxxhJlBE=;
        b=Eh5uhBdOdjB3Tu9kATn08Pfe+yZ7BbNU6zC0pyU7JryhFYPGBCSuVjOp7QnEv7a/6Tv1mt
        /2ZKuLEZuGPgwKP/GwytapTUVpIjbVRvmtoEbGGTVM5d+Z1wXNL0AfENyFyNApIVZ5x0dJ
        Zp8SYDoZIpCuuehjzbODzi9pc7UXV7Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F880AAC5;
        Tue,  2 Mar 2021 09:34:10 +0000 (UTC)
Date:   Tue, 2 Mar 2021 10:34:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD4GkRnTN6RK5CyG@dhcp22.suse.cz>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <YD36+i1PZX/CH1jf@dhcp22.suse.cz>
 <CAMZfGtX=EmE8iOLfO3duCyMWOmu-OYra9Rk4mKsknds+5MueMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX=EmE8iOLfO3duCyMWOmu-OYra9Rk4mKsknds+5MueMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 17:23:42, Muchun Song wrote:
> On Tue, Mar 2, 2021 at 4:44 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 02-03-21 15:37:33, Muchun Song wrote:
> > > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > > __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> > > mod_lruvec_page_state() for each page one by one.
> >
> > What is the actual problem you are trying to address by this patch?
> > 991e7673859e has deliberately dropped the per page accounting. Can you
> > explain why that was incorrect? There surely is some imprecision
> > involved but does it matter and is it even observable?
> 
> When I read the code of account_kernel_stack(), I see a comment that
> says "All stack pages are in the same node". I am confused about this.
> IIUC, there is no guarantee about this. Right?

Yes there is no guarantee indeed. Please always make sure to describe
the underlying reasoning for the patch. Subject of this patch refers to
a fix without explaining the actual problem. If a change is motivated by
code reading then make it explicit. Also if you are refering to a
different commit by Fixes: tag then it would be really helpful to
explicitly mention why that commit is incorrect or cause a visible
problems.

> Yeah, imprecision may
> not be a problem. But if this is what we did deliberately, I think that
> it is better to add a comment there. Thanks.

Yes the comment is quite confusing. I suspect it meant to say
	/* All stack pages are accounted to the same node */

-- 
Michal Hocko
SUSE Labs
