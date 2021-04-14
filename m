Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8BB35EE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhDNHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:18:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhDNHS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:18:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E650AC87;
        Wed, 14 Apr 2021 07:18:04 +0000 (UTC)
Date:   Wed, 14 Apr 2021 09:18:02 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
Message-ID: <20210414071756.GA20401@linux>
References: <20210412120842.GY3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412120842.GY3697@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:08:42PM +0100, Mel Gorman wrote:
> zone_pcp_reset allegedly protects against a race with drain_pages
> using local_irq_save but this is bogus. local_irq_save only operates
> on the local CPU. If memory hotplug is running on CPU A and drain_pages
> is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
> offers no protection.
> 
> This patch deletes IRQ disable/enable on the grounds that IRQs protect
> nothing and assumes the existing hotplug paths guarantees the PCP cannot be
> used after zone_pcp_enable(). That should be the case already because all
> the pages have been freed and there is no page to put on the PCP lists.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
