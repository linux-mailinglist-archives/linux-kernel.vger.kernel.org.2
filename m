Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1733126C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCHPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:43:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:39306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhCHPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:42:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615218165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PSwAr01wd8o8Gcv7XoZ8VHOldRlri/BnhPEeNOyHtBc=;
        b=kOCeT9ZjJ57p59c0D18mLh85tj1k/zY1lAzk/tqohe4PTVOW9pCHNrOAzxSZ66Fx+c1rbU
        9n12STBBoSSmTvK7t7UK7pN7SsPXjPeX+eiF9R36bUFqIlacqTkxBp9nrAR3+G39hXaf5M
        Y4UkVEToPD7Vn2xo+NU1rOrYKrLzmUM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A20A8AE05;
        Mon,  8 Mar 2021 15:42:45 +0000 (UTC)
Date:   Mon, 8 Mar 2021 16:42:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
References: <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
 <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 15:13:35, David Hildenbrand wrote:
> On 08.03.21 15:11, Michal Hocko wrote:
> > On Mon 08-03-21 14:22:12, David Hildenbrand wrote:
> > > On 08.03.21 13:49, Michal Hocko wrote:
> > [...]
> > > > Earlier in the discussion I have suggested dynamic debugging facility.
> > > > Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
> > > > look into that direction?
> > > 
> > > Did you see the previous mail this is based on:
> > > 
> > > https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com
> > > 
> > > I agree that "nofail" is misleading. Rather something like
> > > "dump_on_failure", just a better name :)
> > 
> > Yeah, I have read through the email thread. I just do not get why we
> > cannot make it pr_debug() and add -DDYNAMIC_DEBUG_MODULE for
> > page_alloc.c (I haven't checked whether that is possible for built in
> > compile units, maybe it is not but from a quick seems it should).
> > 
> > I really do not like this to be a part of the API. alloc_contig_range is
> 
> Which API?

Any level of the alloc_contig_range api because I strongly suspect that
once there is something on the lower levels there will be a push to have
it in the directly consumed api as well. Besides that I think this is
just a wrong way to approach the problem.

> It does not affect alloc_contig_range() itself, it's used
> internally only. Sure, we could simply pr_debug() for each and every
> migration failure. As long as it's default-disabled, sure.
> 
> I do agree that we should look into properly including this into the dynamic
> debugging ifrastructure.

Yeah, unless we learn this is not feasible for some reason, which I do
not see right now, then let's just make it pr_debug with the runtime
control.
-- 
Michal Hocko
SUSE Labs
