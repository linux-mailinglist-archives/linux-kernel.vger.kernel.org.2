Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36317347469
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhCXJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhCXJU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616577628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gLziUiladtyJd3p/ln2FmDe2g6zHX+KsW0OGVFj21E=;
        b=VbHnPFE42SYJRuEFkhkWAHr4t4p5qxQJFsfZtY++E0e10Oi90jUMuP+zzxNFPz8a9B4/r5
        03tb8a/woot6C3mA/isgfeHqnxPl2AYvprLiKqyKLbsAKxnFJUkqMiVlLv0bKVDUtwVFUC
        UGcnOeyxadhb/QMMNWjhwTBfwijht1Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1E0EAC16;
        Wed, 24 Mar 2021 09:20:27 +0000 (UTC)
Date:   Wed, 24 Mar 2021 10:20:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix memsw uncharge for
 root_mem_cgroup
Message-ID: <YFsEWfzxB3iPc66Y@dhcp22.suse.cz>
References: <20210323145653.25684-1-songmuchun@bytedance.com>
 <CAMZfGtWT8XXDtg0Jcv=1qJpdLD6foJWE=kB_i1ZyHjvrku=vrw@mail.gmail.com>
 <YFr5SrJ2iNGYwVNA@dhcp22.suse.cz>
 <CAMZfGtVe6seRLA7Wo4TST0ApkaHdkDmv6sL5GZytK_4hvMbkXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVe6seRLA7Wo4TST0ApkaHdkDmv6sL5GZytK_4hvMbkXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 16:50:41, Muchun Song wrote:
> On Wed, Mar 24, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-03-21 12:11:35, Muchun Song wrote:
> > > On Tue, Mar 23, 2021 at 11:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > The pages aren't accounted at the root level, so we cannot uncharge the
> > > > page to the memsw counter for the root memcg. Fix this.
> > > >
> > > > Fixes: 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >
> > > I am very sorry. I should repent. I suddenly realise the fix is totally
> > > wrong. Because the @memcg cannot be root memcg when
> > > @memcg != @swap_memcg.
> >
> > I am probably blind but I do not see why this would be the case.
> > We have memcg != swap_memcg in this branch but we do not know the
> > neither of the two is root_mem_cgroup, no? If we did knot that we
> > wouldn't have to check for swap_memcg != root_mem_cgroup. Or do I miss
> > something?
> 
> I look at the mem_cgroup_id_get_online() closely. If memcg is root, this
> function always returns root memcg. So memcg will equal swap_memcg.

Ahh, I can see it now. I have completely missed that the swap_memcg is
a parent of an offline memcg. I should have looked more closely.
-- 
Michal Hocko
SUSE Labs
