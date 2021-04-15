Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625813602F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDOHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhDOHI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:08:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618470513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nOLV/Oy9dMUzuTuhuv9iYZGKpUTv1tQoggqmfp9NMG0=;
        b=XHGBcj3hBO+MfNOihzVvmuEuljVs10StZmWDsrrX0tWmfIs9xfhJt/xRK5LXm8UDnMdMfj
        Gw43B1ylwVv3quvDI3TC+YcYcGGXGlVVPRoKKp69lMnpLSBRxg3u1HfjUD1K3GJVkDcQwD
        s88Q+PYfS6rt8uzZm4YIIvmYuRNIdeY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51A6CB035;
        Thu, 15 Apr 2021 07:08:33 +0000 (UTC)
Date:   Thu, 15 Apr 2021 09:08:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, guro@fb.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com
Subject: Re: [External] Re: [PATCH 4/7] mm: memcontrol: simplify
 lruvec_holds_page_lru_lock
Message-ID: <YHfmcLLbW6MMbcPG@dhcp22.suse.cz>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com>
 <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
 <CAMZfGtXBqxxgNaB5dcNGvtoH7Gn-1+Ara1YOGS-OahNXaExhsQ@mail.gmail.com>
 <YHcrRMsmrXd5n3oQ@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcrRMsmrXd5n3oQ@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-04-21 13:49:56, Johannes Weiner wrote:
> On Wed, Apr 14, 2021 at 06:00:42PM +0800, Muchun Song wrote:
> > On Wed, Apr 14, 2021 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 13-04-21 14:51:50, Muchun Song wrote:
> > > > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > > > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > > > lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> > > > page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> > > > of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> > > > to simplify the code. We can have a single definition for this function
> > > > that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> > > > CONFIG_MEMCG.
> > >
> > > Neat. While you are at it wouldn't it make sesne to rename the function
> > > as well. I do not want to bikeshed but this is really a misnomer. it
> > > doesn't check anything about locking. page_belongs_lruvec?
> > 
> > Right. lruvec_holds_page_lru_lock is used to check whether
> > the page belongs to the lruvec. page_belongs_lruvec
> > obviously more clearer. I can rename it to
> > page_belongs_lruvec the next version.
> 
> This sounds strange to me, I think 'belongs' needs a 'to' to be
> correct, so page_belongs_to_lruvec(). Still kind of a mouthful.
> 
> page_matches_lruvec()?
> 
> page_from_lruvec()?

Any of those is much better than what we have here.

-- 
Michal Hocko
SUSE Labs
