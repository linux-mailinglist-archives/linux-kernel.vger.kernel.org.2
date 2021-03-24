Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0F3477ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhCXMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:11:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232818AbhCXMKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:10:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616587847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96jnjjSpy2xKmrQMmEaN6LFhnUlQSEZSPONAt/EFWgw=;
        b=ns9q73a97BurP81xsKfxjdKABrCj8znlqRYT9wIZqjMLMG/DekrS27vAxHb349LImoer0o
        VgwEfzRDgn0FlrVBvZUTIVQ4TbHS+nWP2OD7MbvCkAPnfZLr2nha2aIgtpKEzVNFzie3Ps
        8jAenGL+5D5BBR9qW9Xjkadd35HCkIE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4DECEAD38;
        Wed, 24 Mar 2021 12:10:47 +0000 (UTC)
Date:   Wed, 24 Mar 2021 13:10:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFssRr7gZEPfHieA@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-2-osalvador@suse.de>
 <YFm+7ifpyzm6eNy8@dhcp22.suse.cz>
 <20210324101259.GB16560@linux>
 <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFsqkY2Pd+UZ7vzD@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 13:03:29, Michal Hocko wrote:
> On Wed 24-03-21 11:12:59, Oscar Salvador wrote:
[...]

an additional remark

> > - online_pages()->move_pfn_range_to_zone(): Accounts for node/zone's spanned pages
> > - online_pages()->zone->present_pages += nr_pages;

I am pretty sure you shouldn't account vmmemmap pages to the target zone
in some cases - e.g. vmemmap cannot be part of the movable zone, can it?
So this would be yet another special casing. This patch has got it wrong
unless I have missed some special casing.
-- 
Michal Hocko
SUSE Labs
