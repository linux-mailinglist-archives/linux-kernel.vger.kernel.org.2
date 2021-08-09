Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804083E450B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhHILtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:49:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhHILtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:49:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EE3361FDCB;
        Mon,  9 Aug 2021 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628509759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTbs/oAWdsEgUa8fNGlTSzW9u7qIXvDedRy0yP7NhHs=;
        b=iKDi+/fu4Gd8GxCi3jrRjW3J0vrQwJwVllhFySyBgCyikeLsyuwZuzHer6hzEfVM3ERyRy
        h8GScA/lbnan9QBPXttTNxHehkaMYkYlE4QwL+LwebbBM33kTIHSZBBb6Gow8B6s0Hthsz
        8mgsqHHmk/q5Eg6ksB8Y+o9+5q4tXqo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEC5FA3B89;
        Mon,  9 Aug 2021 11:49:19 +0000 (UTC)
Date:   Mon, 9 Aug 2021 13:49:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Nico Pache <npache@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] vm_swappiness=0 should still try to avoid swapping anon
 memory
Message-ID: <YREWP2nw/QIDq8zO@dhcp22.suse.cz>
References: <20210806231701.106980-1-npache@redhat.com>
 <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
 <91605888-e343-2712-c097-bcade4cb389d@redhat.com>
 <CALvZod6Kv_eZcZeJOvypXe_XVzkvLDau7faiDQ2mrqV8kOqq3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Kv_eZcZeJOvypXe_XVzkvLDau7faiDQ2mrqV8kOqq3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-08-21 22:23:48, Shakeel Butt wrote:
> On Fri, Aug 6, 2021 at 6:37 PM Nico Pache <npache@redhat.com> wrote:
> >
> >
> > On 8/6/21 9:00 PM, Shakeel Butt wrote:
> [...]
> > > If you are really seeing the said behavior then why will this fix it.
> > > This is just about deactivating active anon LRU. I would rather look
> > > at get_scan_count() to check why swappiness = 0 is still letting the
> > > kernel to scan anon LRU. BTW in cgroup v1, the memcg can overwrite
> > > their swappiness which will be preferred over system vm_swappiness.
> > > Did you set system level swappiness or memcg one?
> >
> > This fixes the issue because shrink_list() uses the may_deactivate field
> > to determine if it should shrink the active list.
> 
> First, the shrink_list() will not be called for anon LRU if get_scan_count()
> has decided to not scan the anon LRU.
> 
> Second, I would like to get your attention to the following comment in
> get_scan_count():
> 
> "Global reclaim will swap to prevent OOM even with no swappiness"
> 
> It seems like the behavior you are seeing is actually working as intended.
> You may decide to change that behavior but you will need to motivate the
> change.

Yes this is true. Only the memcg has a strict no swapping behavior
historically. I do agree that the patch should go into much more details
about the existing problem though. In this context it would be really
good to explain why trashing over page cache is a better outcome than
swapping out some pages.

-- 
Michal Hocko
SUSE Labs
