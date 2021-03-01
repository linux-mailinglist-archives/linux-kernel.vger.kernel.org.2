Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A37327E10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhCAMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:15:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232836AbhCAMPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:15:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614600903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsLZ5Y4Ek3DADqn5FApSaLdnl0AlNSLh5qu8paQS2MA=;
        b=h51r4GoWiVVRKIf3kAFyA2IuXEPrk/XF/HNpzik1F6Zr3+5QYBzL5XY5rKVapq8i4wk3eb
        A9sEJX6VS1HLEnqxhXYzDIWFgafBF170CMwAXOHUPITdULmCIw6QM8isThOY/K7qkqhR4h
        9XpzD5LMZMqJwGnvcnZhtusom/LyST8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FB38AC24;
        Mon,  1 Mar 2021 12:15:03 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:15:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
Message-ID: <YDzaxi91fTg1ww6H@dhcp22.suse.cz>
References: <20210226021254.3980-1-shy828301@gmail.com>
 <YDijjovHAer2tiL5@dhcp22.suse.cz>
 <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoLC-gGZA1GvDZjgTnVFzCTQnLMd4JWzZ6Ge_q63YhWKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 08:42:29, Yang Shi wrote:
> On Thu, Feb 25, 2021 at 11:30 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 25-02-21 18:12:54, Yang Shi wrote:
> > > When debugging an oom issue, I found the oom_kill counter of memcg is
> > > confusing.  At the first glance without checking document, I thought it
> > > just counts for memcg oom, but it turns out it counts both global and
> > > memcg oom.
> >
> > Yes, this is the case indeed. The point of the counter was to count oom
> > victims from the memcg rather than matching that to the source of the
> > oom. Rememeber that this could have been a memcg oom up in the
> > hierarchy as well. Counting victims on the oom origin could be equally
> 
> Yes, it is updated hierarchically on v2, but not on v1. I'm supposed
> this is because v1 may work in non-hierarchcal mode? If this is the
> only reason we may be able to remove this to get aligned with v2 since
> non-hierarchal mode is no longer supported.

I believe the reson is that v1 can have tasks in the intermediate
(non-leaf) memcgs. So you wouldn't have a way to tell whether the oom
kill has happened in such a memcg or somewhere down the hierarchy.
-- 
Michal Hocko
SUSE Labs
