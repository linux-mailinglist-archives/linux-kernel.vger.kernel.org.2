Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7966C35DB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhDMJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDMJg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:36:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B1EEAF1B;
        Tue, 13 Apr 2021 09:36:09 +0000 (UTC)
Subject: Re: [PATCH v2 resend] mm/memory_hotplug: Make unpopulated zones PCP
 structures unreachable during hot remove
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b1243b7b-fa4c-496f-5bfc-c83c7cee81cf@suse.cz>
Date:   Tue, 13 Apr 2021 11:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412140852.GZ3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 4:08 PM, Mel Gorman wrote:
> On Mon, Apr 12, 2021 at 02:40:18PM +0200, Vlastimil Babka wrote:
>> On 4/12/21 2:08 PM, Mel Gorman wrote:
>
> the pageset structures in place would be much more straight-forward
> assuming the structures were not allocated in the zone that is being
> hot-removed.

I would expect this is not possible, at least for ZONE_MOVABLE, as the percpu
allocations should be GFP_KERNEL. And it's not realistic to expect offlining to
succeed at all without using ZONE_MOVABLE.

AFAIK even Oscar's work on using the node to self-contain its own structures is
only applicable to struct pages, not percpu allocations?
