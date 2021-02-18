Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175CD31E8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBRKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:49:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:47104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhBRJgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:36:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613640929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOTaO1omfPlkRnn1YUpa+vtFf0rS0L1QNZvI+45woCc=;
        b=HIcMHhdtvXFMw+pM36OAmXseZ8sHd0dr5U1/g2L7/DfZCLYBV2fKm6FBqY+B3C7OyTBr4b
        JK1fxUh1wClPo3hyzoD16YOjj3NE+IzkczYh/KuICS1j5MvlxstZsNtVSOVR3L3maGK+tM
        a8MeMgYo2lpSw84OSmqvcIsLTvdX9XA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80283ACD9;
        Thu, 18 Feb 2021 09:35:29 +0000 (UTC)
Date:   Thu, 18 Feb 2021 10:35:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC402s1vqvC4q041@dhcp22.suse.cz>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> On 18.02.21 09:56, Michal Hocko wrote:
> > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > alloc_contig_range is usually used on cma area or movable zone.
> > > It's critical if the page migration fails on those areas so
> > > dump more debugging message like memory_hotplug unless user
> > > specifiy __GFP_NOWARN.
> > 
> > I agree with David that this has a potential to generate a lot of output
> > and it is not really clear whether it is worth it. Page isolation code
> > already has REPORT_FAILURE mode which currently used only for the memory
> > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > ("mm: only report isolation failures when offlining memory").
> > 
> > Maybe migration failures are less likely to fail but still.
> 
> Side note: I really dislike that uncontrolled error reporting on memory
> offlining path we have enabled as default. Yeah, it might be useful for
> ZONE_MOVABLE in some cases, but otherwise it's just noise.
> 
> Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded

Anyway we can discuss this in a separate thread but I think this is not
a representative workload.
-- 
Michal Hocko
SUSE Labs
