Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC303214E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhBVLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:15:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhBVLPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:15:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35868ACCF;
        Mon, 22 Feb 2021 11:15:13 +0000 (UTC)
Date:   Mon, 22 Feb 2021 12:15:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 0/7] Allocate memmap from hotadded memory (per device)
Message-ID: <20210222111506.GA23651@linux>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210217101851.GA28996@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217101851.GA28996@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:18:59AM +0100, Oscar Salvador wrote:
> On Tue, Feb 09, 2021 at 02:38:47PM +0100, Oscar Salvador wrote:
> > Hi,
> > 
> > here is v2.
> > 
> > Changes from v1 -> v2
> >  - Addressed feedback from David
> >  - Fence off the feature in case struct page size is not
> >    multiple of PMD size or pageblock alignment cannot be guaranted
> >  - Tested on x86_64 small and large memory_blocks
> >  - Tested on arm64 4KB and 64KB page sizes (for some reason I cannot boot
> >    my VM with 16KB page size).
> > 
> >  Arm64 with 4KB page size behaves like x86_64 after [1], which made section
> >  size smaller.
> >  With 64KB, the feature gets fenced off due to pageblock alignment.
> > 
> > Changes from RFCv3 -> v1:
> >  - Addressed feedback from David
> >  - Re-order patches
> > 
> > Changes from v2 -> v3 (RFC):
> >  - Re-order patches (Michal)
> >  - Fold "mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY" in patch#1
> >  - Add kernel boot option to enable this feature (Michal)
> > 
> > Changes from v1 -> v2 (RFC):
> >  - Addressed feedback provided by David
> >  - Add a arch_support_memmap_on_memory to be called
> >    from mhp_supports_memmap_on_memory, as atm,
> >    only ARM, powerpc and x86_64 have altmat support.
> > 
> > [1] https://lore.kernel.org/lkml/cover.1611206601.git.sudaraja@codeaurora.org/
> 
> Let me refloat this one :-)

Kindly ping :-)

 

-- 
Oscar Salvador
SUSE L3
