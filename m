Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC5337FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCKVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:48:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:36688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhCKVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:48:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4FE1AC54;
        Thu, 11 Mar 2021 21:48:37 +0000 (UTC)
Date:   Thu, 11 Mar 2021 22:48:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <YEqQMm6+oQiQmwB0@localhost.localdomain>
References: <20210309214050.4674-1-osalvador@suse.de>
 <20210309214050.4674-4-osalvador@suse.de>
 <0c4132aa-5d59-c0ba-5cfc-4ac401feba04@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c4132aa-5d59-c0ba-5cfc-4ac401feba04@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:29:39PM -0800, Dave Hansen wrote:
> On 3/9/21 1:40 PM, Oscar Salvador wrote:
> > +static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
> > +{
> > +	/*
> > +	 * Could be our memmap page is filled with PAGE_UNUSED already from a
> > +	 * previous remove. Make sure to reset it.
> > +	 */
> > +	vmemmap_use_sub_pmd(start);
> > +
> > +	/*
> > +	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
> > +	 */
> > +	if (!IS_ALIGNED(start, PMD_SIZE))
> > +		memset((void *)start, PAGE_UNUSED,
> > +		        start - ALIGN_DOWN(start, PMD_SIZE));
> > +	if (!IS_ALIGNED(end, PMD_SIZE))
> > +		memset((void *)end, PAGE_UNUSED,
> > +		        ALIGN(end, PMD_SIZE) - end);
> > +}
> > +#endif
> 
> This is apparently under both CONFIG_SPARSEMEM_VMEMMAP and
> CONFIG_MEMORY_HOTPLUG #ifdefs.  It errors out at compile-time with this
> config: https://sr71.net/~dave/intel/config-mmotm-20210311

It seems that mmotm still has v5.
v6 (this one) fixed that up. I basically moved the code out of
MEMORY_HOTPLUG #ifdefs.

I could not reproduce your error on v6.


-- 
Oscar Salvador
SUSE L3
