Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321C2327E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhCAMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:25:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:44356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233559AbhCAMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:25:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614601485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4e5MHeBWKUeRuWwrRN4F6v9QXnyfuUzg8gdWTjEdSqM=;
        b=Fv+Mhst1p1X2WCTKlqJ9E0maHOvbj9R5gK7b5JimaCIkQTFmdYibMYSzgt1pTbuU6xo65u
        LgdWWmvuZDMdP4UAU4UbjaWlfXNtFIeDklFRYjLOz7GZVsLWD74aI5ALutzCgF28FQxfMw
        0LdXP4KRPF9ogyGljs12sUzVbfqOCV4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23E67AE30;
        Mon,  1 Mar 2021 12:24:45 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:24:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
Message-ID: <YDzdB7RtLex+8VkA@dhcp22.suse.cz>
References: <20210226021254.3980-1-shy828301@gmail.com>
 <YDijjovHAer2tiL5@dhcp22.suse.cz>
 <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
 <CAHbLzkrgtbR1o3pTSh_hqPhrkugXBnB4uwdHh+uK6Ndp-u_fEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrgtbR1o3pTSh_hqPhrkugXBnB4uwdHh+uK6Ndp-u_fEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 11:19:51, Yang Shi wrote:
> On Fri, Feb 26, 2021 at 8:42 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > > > When debugging an oom issue, I found the oom_kill counter of memcg is
> > > > confusing.  At the first glance without checking document, I thought it
> > > > just counts for memcg oom, but it turns out it counts both global and
> > > > memcg oom.
> > >
> > > Yes, this is the case indeed. The point of the counter was to count oom
> > > victims from the memcg rather than matching that to the source of the
> > > oom. Rememeber that this could have been a memcg oom up in the
> > > hierarchy as well. Counting victims on the oom origin could be equally
> >
> > Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
> > this is because v1 may work in non-hierarchcal mode? If this is the
> > only reason we may be able to remove this to get aligned with v2 since
> > non-hierarchal mode is no longer supported.
> 
> BTW, having the counter recorded hierarchically may help out one of
> our usecases. We want to monitor the oom_kill for some services, but
> systemd would wipe out the cgroup if the service is oom killed then
> restart the service from scratch (it means create a brand new cgroup
> with the same name). So this systemd behavior makes the counter
> useless if it is not recorded hierarchically.

Just to make sure I understand correctly. You have a setup where memcg
for a service has a hard limit configured and it is destroyed when oom
happens inside that memcg. A new instance is created at the same place
of the hierarchy with a new memcg. Your problem is that the oom killed
memcg will not be recorded in its parent oom event and the information
will get lost with the torn down memcg. Correct?

If yes then how do you tell which of the child cgroup was killed from
the parent counter? Or is there only a single child?

Anyway, cgroup v2 will offer the hierarchical behavior. Do you have any
strong reasons that you cannot use v2?
-- 
Michal Hocko
SUSE Labs
