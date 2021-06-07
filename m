Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8680839D79A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:44:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38480 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:44:04 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2F6A61FDA5;
        Mon,  7 Jun 2021 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623055333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3F3FHeKDWylfF8W6AMh3TTuaGg9ATjr41pkU+HFOFE=;
        b=RIPGit61ezH96kAndMRXb4M5TOkS+gxNEvLG1rSI3+s3MLKdUHScGPSnXEYMwvP9Ks2lpq
        +6NSYxvxLgcS5HV6Uj+/Cp6cdf3lo8JtV9uZt9SpuJQWJOPwvllrgMImXmf9/hP1GVF946
        O7oqNiIOh7DC6WkxcDk009kn2rkW9bc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ED786A3B88;
        Mon,  7 Jun 2021 08:42:12 +0000 (UTC)
Date:   Mon, 7 Jun 2021 10:42:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <YL3b5HGqfIW23TJh@dhcp22.suse.cz>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain>
 <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604074140.GA25063@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-06-21 09:41:45, Oscar Salvador wrote:
> On Thu, Jun 03, 2021 at 02:45:13PM +0200, Michal Hocko wrote:
[...]
> > But the primary question is whether anybody actually cares about
> > potential races in the first place.
> 
> I have been checking move_freepages_block() and alloc_contig_pages(), which
> are two of the functions that call zone_spans_pfn().
> 
> move_freepages_block() uses it in a way to align the given pfn to pageblock
> top and bottom, and then check that aligned pfns are still within the same zone.
> From a memory-hotplug perspective that's ok as we know that we are offlining
> PAGES_PER_SECTION (which implies whole pageblocks).
> 
> alloc_contig_pages() (used by the hugetlb gigantic allocator) runs through a
> node's zonelist and checks whether zone->zone_start_pfn + nr_pages stays within
> the same zone.
> IMHO, the race with zone_spans_last_pfn() vs mem-hotplug would not be that bad,
> as it will be caught afters by e.g: __alloc_contig_pages when pages cannot be
> isolated because they are offline etc.
> 
> So, I would say we do not really need the lock, but I might be missing something.
> But if we chose to care about this, then the locking should be done right, not
> half-way as it is right now.

That is my understanding as well.
-- 
Michal Hocko
SUSE Labs
