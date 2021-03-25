Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5E348EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCYLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:23:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCYLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:23:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73BA3AC16;
        Thu, 25 Mar 2021 11:23:13 +0000 (UTC)
Date:   Thu, 25 Mar 2021 12:23:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFxyntJb2yRUfU7b@localhost.localdomain>
References: <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
 <YFtPxH0CT5QZsnR1@dhcp22.suse.cz>
 <3bc4168c-fd31-0c9a-44ac-88e25d524eef@redhat.com>
 <YFtjCMwYjx1BwEg0@dhcp22.suse.cz>
 <9591a0b8-c000-2f61-67a6-4402678fe50b@redhat.com>
 <YFxEp0cfcJmcz5bP@localhost.localdomain>
 <YFxVLWcQcKaMycEY@dhcp22.suse.cz>
 <YFxsBRORtgqUF/FZ@localhost.localdomain>
 <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0c9218-bdc3-9cc6-42da-ec36786b7b60@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:08:43PM +0100, David Hildenbrand wrote:
> As I said, having soemthing like
> memory_block_online()/memory_block_offline() could be one way to tackle it.
> We only support onlining/offlining of memory blocks and I ripped out all
> code that was abusing online_pages/offline_pages ...
> 
> So have memory_block_online() call online_pages() and do the accounting of
> the vmemmap, with a big fat comment that sections are actually set
> online/offline in online_pages/offline_pages(). Could be a simple cleanup on
> top of this series ...

I overlooked this in your previous reply.
Yes, this looks like a middle-ground compromise and something I would
definitely pick over the other options.

If there is a consensus that that is the most straightforward way to go, I
could try to code that up to see how it looks so we all have an idea.

Thanks!

-- 
Oscar Salvador
SUSE L3
