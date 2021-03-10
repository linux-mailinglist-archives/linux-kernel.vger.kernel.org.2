Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369EC3345A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhCJRuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:50:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232828AbhCJRuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:50:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40EBFAC54;
        Wed, 10 Mar 2021 17:50:00 +0000 (UTC)
Date:   Wed, 10 Mar 2021 18:49:57 +0100
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
Subject: Re: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210310174953.GA16289@linux>
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-4-osalvador@suse.de>
 <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:52:38PM +0100, David Hildenbrand wrote:
> > -#define PAGE_INUSE 0xFD
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +#define PAGE_UNUSED 0xFD
> > +
> > +/* Returns true if the PMD is completely unused and thus it can be freed */
> > +static bool __meminit vmemmap_pmd_is_unused(unsigned long addr, unsigned long end)
> > +{
> 
> I don't think the new name is any better. It implies that all it does is a
> check - yet it actually clears the given range. (I prefer the old name, but
> well, I came up with that, so what do I know :D )

Sorry, I did not mean to offend here.

Something like: vmemmap_is_pmd_unused_after_clearing_it would be a bit better
I guess.
Tbh, both this and previous one looked fine to me, but I understand where Dave
confusion was coming from, that is why I decided to rename it.

Maybe a middle-ground would have been to expand the comment above.

-- 
Oscar Salvador
SUSE L3
