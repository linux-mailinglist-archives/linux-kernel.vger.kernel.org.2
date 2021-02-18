Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1831E935
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBRLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:38:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:46500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbhBRKOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:14:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613642350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcmiomALekGfsrusGGhOOJorZlipuQKMkoJ+P8fS1ik=;
        b=T9gqctFyBxkPMosq2T8xMBAvn2jf/q1reaBR8KUjF8ffkRTknFpVRtAr25RegiaeZU43UL
        TwZt5fEVxGpGWM/n0OlwBITIgbZ+UrhV7DriQP+ewRx5LshSGYHi3l2zDxD5MdFObvfQKC
        wAutDrHNoyKQM1OkJTlSpMAKfPpmk4E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FC47ACE5;
        Thu, 18 Feb 2021 09:59:10 +0000 (UTC)
Date:   Thu, 18 Feb 2021 10:59:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC46bAJZNQXCglvJ@dhcp22.suse.cz>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-02-21 10:43:21, David Hildenbrand wrote:
> On 18.02.21 10:35, Michal Hocko wrote:
> > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > It's critical if the page migration fails on those areas so
> > > > > dump more debugging message like memory_hotplug unless user
> > > > > specifiy __GFP_NOWARN.
> > > > 
> > > > I agree with David that this has a potential to generate a lot of output
> > > > and it is not really clear whether it is worth it. Page isolation code
> > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > ("mm: only report isolation failures when offlining memory").
> > > > 
> > > > Maybe migration failures are less likely to fail but still.
> > > 
> > > Side note: I really dislike that uncontrolled error reporting on memory
> > > offlining path we have enabled as default. Yeah, it might be useful for
> > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > 
> > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > 
> > Anyway we can discuss this in a separate thread but I think this is not
> > a representative workload.
> 
> Sure, but the essence is "this is noise", and we'll have more noise on
> alloc_contig_range() as we see these calls more frequently. There should be
> an explicit way to enable such *debug* messages.

There is a dynamic debugging framework available. I do not have much of
an exprience there but maybe that is the way to go.
-- 
Michal Hocko
SUSE Labs
