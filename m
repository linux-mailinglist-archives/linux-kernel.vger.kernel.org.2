Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAF359EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhDIMnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:43:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIMnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:43:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617972178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiL8GIn+kNksZGX+sHZ8dtDnwl03BF0KcDznW8aXSqA=;
        b=UfUcXlLJ8zbFuZ+4eapJA8Cvjn/dHDzZs21SonEP/japaikGIw41zEGfTlkPMNA18t7Rpk
        S1ofdPXsp7dzaIZgCh1dtjD4bUettRcKarIIuy7BS3r1/pa9fu2qPqPkkuD8X3mndq9OlJ
        7HxjCjK09MIBf1l2Qklpp6ucGdUaSaE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C172AF4C;
        Fri,  9 Apr 2021 12:42:58 +0000 (UTC)
Date:   Fri, 9 Apr 2021 14:42:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/memory_hotplug: Make unpopulated zones PCP structures
 unreachable during hot remove
Message-ID: <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
References: <20210409120957.GM3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409120957.GM3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-04-21 13:09:57, Mel Gorman wrote:
> zone_pcp_reset allegedly protects against a race with drain_pages
> using local_irq_save but this is bogus. local_irq_save only operates
> on the local CPU. If memory hotplug is running on CPU A and drain_pages
> is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> offers no protection.

Yes, the synchronization aspect is bogus indeed.

> This patch reorders memory hotremove such that the PCP structures
> relevant to the zone are no longer reachable by the time the structures
> are freed.  With this reordering, no protection is required to prevent
> a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
> renamed to zone_pcp_destroy to make it clear that the per-cpu structures
> are deleted when the function returns.

Wouldn't it be much easier to simply not destroy/reset pcp of an empty
zone at all? The whole point of this exercise seems to be described in
340175b7d14d5. setup_zone_pageset can check for an already allocated pcp
and simply reinitialize it. 
-- 
Michal Hocko
SUSE Labs
