Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459F35D833
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbhDMGpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhDMGo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618296279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTHqN90N3wecRIGfpw8tHL3yzki9YdDloPKkWwSqmpw=;
        b=C8P7rHJSpRLR6l+VfIVmAeoOx+SL6fSN/9lUgTeiXlTU7REGML2CYXIZo8K1i2g/Bx422/
        5G5EiaxM5SAX+I0cIe/m4sUl17JXOrhdg7p6bpivFa8jbU7goJl9oYkGDaKfgH+zmlc2Nx
        7yeV21temq6KZTbItGhzH5MfsjvGuKQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 633B0AFF1;
        Tue, 13 Apr 2021 06:44:39 +0000 (UTC)
Date:   Tue, 13 Apr 2021 08:44:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <YHU90R07614YhcFM@dhcp22.suse.cz>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-04-21 14:40:18, Vlastimil Babka wrote:
> On 4/12/21 2:08 PM, Mel Gorman wrote:
> > zone_pcp_reset allegedly protects against a race with drain_pages
> > using local_irq_save but this is bogus. local_irq_save only operates
> > on the local CPU. If memory hotplug is running on CPU A and drain_pages
> > is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> > offers no protection.
> > 
> > This patch deletes IRQ disable/enable on the grounds that IRQs protect
> > nothing and assumes the existing hotplug paths guarantees the PCP cannot be
> > used after zone_pcp_enable(). That should be the case already because all
> > the pages have been freed and there is no page to put on the PCP lists.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Yeah the irq disabling here is clearly bogus, so:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But I think Michal has a point that we might best leave the pagesets around, by
> a future change. I'm have some doubts that even with your reordering of the
> reset/destroy after zonelist rebuild in v1 they cant't be reachable. We have no
> protection between zonelist rebuild and zonelist traversal, and that's why we
> just leave pgdats around.
> 
> So I can imagine a task racing with memory hotremove might see watermarks as ok
> in get_page_from_freelist() for the zone and proceeds to try_this_zone:, then
> gets stalled/scheduled out while hotremove rebuilds the zonelist and destroys
> the pcplists, then the first task is resumed and proceeds with rmqueue_pcplist().
> 
> So that's very rare thus not urgent, and this patch doesn't make it less rare so
> not a reason to block it.

Completely agreed here. Not an urgent thing to work on but something to
look into long term.

-- 
Michal Hocko
SUSE Labs
