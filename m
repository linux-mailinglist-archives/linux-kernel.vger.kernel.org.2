Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9135ABA3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhDJH0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:26:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhDJH0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618039596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yjZzbPPWgXhfJIj4h7rGByFGwcymMj9q3Ge4BPGca+k=;
        b=fCSiSkzjE3C7mHOKwprZ06zOxaiXH5i4AebWdZtgLiv0uPW/lAcrcJEj1BIs/nlOoZ74eG
        f3dq9ng3FJLr294v+ORxAdreMahYyju1zN36zEWvWsgbfzSJmB0Sx4CdXU7Jy+gqgK2OGi
        qhdKuha/26jglfRF+kl/KTArr7VTPEo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBA12AFDF;
        Sat, 10 Apr 2021 07:26:36 +0000 (UTC)
Date:   Sat, 10 Apr 2021 09:25:52 +0200
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
Message-ID: <YHFS5OXrbyN68KSO@dhcp22.suse.cz>
References: <20210409120957.GM3697@techsingularity.net>
 <YHBL0e8s+EesIyDl@dhcp22.suse.cz>
 <YHBNDEAw1OqIWwb5@dhcp22.suse.cz>
 <20210409134221.GO3697@techsingularity.net>
 <YHBmxwH41WEHuVJj@dhcp22.suse.cz>
 <20210409151259.GP3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409151259.GP3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-04-21 16:12:59, Mel Gorman wrote:
[...]
> If anything, the minimal "fix" is to simply delete IRQ disable/enable on
> the grounds that IRQs protect nothing and assume the existing hotplug
> paths guarantees the PCP cannot be used after zone_pcp_enable(). That
> should be the case already because all the pages have been freed and
> there is nothing to even put into the PCPs but I worried that the PCP
> structure itself might still be reachable even if it's useless which is
> why I freed the structure once they could not be reached via zonelists.

OK. Let's do that for now and I will put a follow up on my todo list.

Thanks!
-- 
Michal Hocko
SUSE Labs
