Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04676340107
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCRI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhCRI1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:27:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D170AC1E;
        Thu, 18 Mar 2021 08:27:51 +0000 (UTC)
Date:   Thu, 18 Mar 2021 09:27:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YFMPBFSJPq2VEOk9@localhost.localdomain>
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
 <20210317140847.GA20407@linux>
 <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 03:35:41PM +0100, David Hildenbrand wrote:
> Just assume you have two ranges
> 
> [ ZONE_DEVICE 0 ][ ZONE_DEVICE 1]
> 
> If the vmemmap of ZONE_DEVICE 1 could be taken from the altmap of
> ZONE_DEVICE 0, we could be in trouble, as both parts can be
> removed/repurposed independently ...

I have to say my knowledge about ZONE_DEVICE and its intrinsencs tend to
0, that is why I thought it might not matter, but I agree that this is
only asking for trouble.

> If we check for
> 
> IS_ALIGNED(nr_vmemmap_pages, PMD_SIZE), please add a proper TODO comment
> that this is most probably the wrong place to take care of this.

Sure, I will stuff the check in there and place a big TODO comment so we
do not forget about addressing this issue the right way.

I will prepare a v5 (hopefully the last one) and do some more testing
before sending it out.

Thanks David!

-- 
Oscar Salvador
SUSE L3
