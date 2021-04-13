Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1B35DC54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhDMKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhDMKQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:16:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618308991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etAr+vdy6QGHF0HOCTnJnOC8u4Cj4xKN+06/PtCWHn4=;
        b=OXv/r8nGtM3qBcGiQ8t/oCUHzaV3plqzqFmvzaLQva0Uiu1izcvZC9ipH3VpyIOFxep5TC
        uqU+eZXHQyV7r9YUVeQUQwB9+PMwXLfcP746/g0wQVz89PRnvenS5SHv60eKhJl4w+MBE1
        phYm2DhX6q/C2jj0zZtyMRfUxoICvog=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0933DAF80;
        Tue, 13 Apr 2021 10:16:31 +0000 (UTC)
Date:   Tue, 13 Apr 2021 12:16:30 +0200
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
Message-ID: <YHVvfv8PtRcRgOcl@dhcp22.suse.cz>
References: <20210412120842.GY3697@techsingularity.net>
 <d4e4c3e4-7d47-d634-4374-4cf1e55c7895@suse.cz>
 <20210412140852.GZ3697@techsingularity.net>
 <b1243b7b-fa4c-496f-5bfc-c83c7cee81cf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1243b7b-fa4c-496f-5bfc-c83c7cee81cf@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 11:36:08, Vlastimil Babka wrote:
[...]
> AFAIK even Oscar's work on using the node to self-contain its own structures is
> only applicable to struct pages, not percpu allocations?

Correct. Teaching pcp storage on movable zone sounds like a large
undertaking to me. Not sure this is worth it TBH. Even an idea of any
pcp access synchronization with memory hotplug makes for a decent headache.

-- 
Michal Hocko
SUSE Labs
