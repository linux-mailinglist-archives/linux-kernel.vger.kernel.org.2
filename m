Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE1340521
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCRMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:04:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhCRMEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:04:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA818AC75;
        Thu, 18 Mar 2021 12:04:01 +0000 (UTC)
Date:   Thu, 18 Mar 2021 13:03:59 +0100
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
Message-ID: <YFNBrzNFpyKLORfe@localhost.localdomain>
References: <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
 <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
 <20210317140847.GA20407@linux>
 <f996f570-eed9-509f-553c-280a62dc6d20@redhat.com>
 <YFMPBFSJPq2VEOk9@localhost.localdomain>
 <YFMtuKZ8Ho66D8hN@localhost.localdomain>
 <51c645b3-1220-80c4-e44c-4c0411222148@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c645b3-1220-80c4-e44c-4c0411222148@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:24:16PM +0100, David Hildenbrand wrote:
> I don't follow. 2MB == 2MB. And if there would be difference then we would
> be in the problem I brought up: vmemmap code allocating too much via the
> altmap, which can be very bad because might be populating more vmemmap than
> we actually need.

Yes, I meant to say nr_vmemmap_pages won't match, or IOW, won't have the
same meaning.
The end result is the same.

> vmemmap_size = 512 * 4KiB = 2 MiB.
> 
> That calculation wasn't very useful (/ PAGE_SIZE * PAGE_SIZE)?

Yeah, somewhat redundant.

> 
> >          unsigned long remaining_size = size - vmemmap_size;
> 
> And here we could get something like
> 
> remaining_size = 2 GiB - 2 MiB

Yes, vmemmap_size would need to scale with nr_sections to be relative to
size.

Just wanted to bring it up, because somene might wonder
"ok, why do we have altmap->nr_pfns = X, and here nr_vmemmap_pages
 is Y"

It was an effort to make it consistent, although I see it would bring
more confusion other than anything, so disregard.

-- 
Oscar Salvador
SUSE L3
