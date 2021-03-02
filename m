Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3365A32A7D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839771AbhCBQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:38:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448239AbhCBOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:18:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614694692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NXstPqNoq+Ya4HcHuK4GWUWbaHsx2F+nXYeiGSCA9I=;
        b=iz5rVafIREnC9DjOE5vl8y74cVzi1D/xpcxpyGohVuZv/HAJQnsdi3jKFmCL6GpaGpq6Bz
        H+XXAkgw0N+nbC3c4Mmp5mp7dm1mhrVAD/fGYiXYkq5S6R0BkzsOgWZ8o6l1ZxVI/wXMUy
        EOqje7nvyfU08aYMVgANl8YAG7LA0Jw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D981BAFF7;
        Tue,  2 Mar 2021 14:18:11 +0000 (UTC)
Date:   Tue, 2 Mar 2021 15:18:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD5JInqVjBvJbZ2X@dhcp22.suse.cz>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <CALvZod6Aqq_yCjfdbgKb1=Ocd04O=X_tNJ81kzyX77wHzBKBwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Aqq_yCjfdbgKb1=Ocd04O=X_tNJ81kzyX77wHzBKBwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-03-21 06:02:14, Shakeel Butt wrote:
> On Mon, Mar 1, 2021 at 11:52 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > __GFP_THISNODE to __vmalloc_node_range().
> 
> Instead of __GFP_THISNODE, mention that the kernel_clone() passes
> NUMA_NO_NODE which is being used for __vmalloc_node_range().

If we really want to do this then I would recommend reasoning in the
following line:

"
For simplification 991e7673859e ("mm: memcontrol: account kernel stack
per node") has changed the per zone vmalloc backed stack pages accounting
to per node. By doing that we have lost a certain precision because
those pages might live in different NUMA nodes. In the end
NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
some nodes while underestimated on others.

	< some examples would go here ideally >

This doesn't impose any real problem to correctnes of the kernel
behavior as the counter is not used for any internal processing but it
can cause some confusion to the userspace.

Address the problem by accounting each vmalloc backing page to its own
node.
"

-- 
Michal Hocko
SUSE Labs
