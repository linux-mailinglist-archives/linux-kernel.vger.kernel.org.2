Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0230BA58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhBBIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:52:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhBBIvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:51:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85868AEB3;
        Tue,  2 Feb 2021 08:51:11 +0000 (UTC)
Date:   Tue, 2 Feb 2021 09:51:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210202085100.GA8263@linux>
References: <20210129064045.18471-1-osalvador@suse.de>
 <b9a2f80e-a90f-62bf-4197-66cdb315cb84@redhat.com>
 <20210202075243.GA7037@linux>
 <dd9dfa98-21df-70c8-d43d-e9a83889464c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9dfa98-21df-70c8-d43d-e9a83889464c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:35:09AM +0100, David Hildenbrand wrote:
> Yeah, last time I raised it was in
> 
> https://lkml.kernel.org/r/20200703013435.GA11340@L-31X9LVDL-1304.local
> 
> but I never got to clean it up myself.

I see.

> > So, IIRC we have two cases during hotplug:
> >   1) the ones that want memory blocks
> >   2) the ones that do not want them (pmem stuff)
> > 
> > For #1, we always enforce section alignment in add_memory_resource, and for
> > #2 we always make sure the range is at least sub-section aligned.
> > 
> > And the important stuff is that boot memory is no longer to be hot-removed
> > (boot memory had some strange layout sometimes).
> 
> The vmemmap of boot mem sections is always fully populated, even with
> strange memory layouts (e.g., see comment in pfn_valid()). In addition, we
> can only offline+remove whole sections, so that should be fine.

You are right.

> 
> > 
> > So, given the above, I think it should be safe to drop that check in
> > remote_pte_table.
> > But do we really need to force page alignment in vmemmap_populate/vmemmap_free?
> > vmemmap_populate should already receive a page-aligned chunk because
> >   __populate_section_memmap made sure of that, and vmemmap_free() should be ok
> > as we already filtered out at hot-adding stage.
> > 
> > Of course, this will hold as long as struct page size of multiple of 8.
> > Should that change we might get trouble, but I do not think that can ever
> > happened (tm).
> > 
> > But anyway, I am fine with placing a couple of checks in vmemmap_{populate,free}
> > just to double check.
> > 
> > What do you think?
> 
> I'd just throw in 1 or 2 VM_BUG_ON() to self-document what we expect and
> that we thought about these conditions. It's then easy to identify the
> relevant commit where we explain the rationale.

Fine by me, also on a second thought it is good to have some sort of clue
when looking at the code.
I will add that cleanup before the actual "fix" of the sub-pmd stuff.

thanks!

-- 
Oscar Salvador
SUSE L3
