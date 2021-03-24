Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FC347417
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhCXJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234097AbhCXJDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:03:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616576580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q62GRUcYqwa0bhTYR+NsnkCuP71Dr4dG9ssvpOpUr8I=;
        b=IR0BUxQ99fN0sgC3473sFuhPsn3RspQGgea1Da1bJ8X0J4sUzZk2gmpybRuTVQK1uT/jh0
        DY66yqwonMySJggdXBoi9r6r/KOwtnUUZ01Nb9ooe55UCSKTaJpD56ROhlGCAjkodizLPN
        /04nnRXoA1XVD8YFRjMfw8cr965vrJo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1093AB9B;
        Wed, 24 Mar 2021 09:02:59 +0000 (UTC)
Date:   Wed, 24 Mar 2021 10:02:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
Message-ID: <YFsAQxZFCE0L3Sor@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-4-osalvador@suse.de>
 <YFnHWQ30O5efsdQ1@dhcp22.suse.cz>
 <20210324084457.GA16560@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324084457.GA16560@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 09:45:01, Oscar Salvador wrote:
> On Tue, Mar 23, 2021 at 11:47:53AM +0100, Michal Hocko wrote:
> > On Fri 19-03-21 10:26:33, Oscar Salvador wrote:
> > > Self stored memmap leads to a sparse memory situation which is unsuitable
> > > for workloads that requires large contiguous memory chunks, so make this
> > > an opt-in which needs to be explicitly enabled.
> > > 
> > > To control this, let memory_hotplug have its own memory space, as suggested
> > > by David, so we can add memory_hotplug.memmap_on_memory parameter.
> > > 
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > I would just rephrased the help text to be less low level
> ...
> > 			When enabled, runtime hotplugged memory will
> > 			allocate its internal metadata (struct pages)
> > 			from the hotadded memory which will allow to
> > 			hotadd a lot of memory without requiring
> > 			additional memory to do so.
> > 			This feature is disabled by default because it
> > 			has some implication on large (e.g. GB)
> > 			allocations in some configurations (e.g. small
> > 			memory blocks).
> 
> Ok, this sounds good as well, and I guess it might suit best for what admin-guide
> is about.
> 
> > The memmap_on_memory can be dropped from the 1st patch IIUC and only
> > introduce it now.
> 
> It could be done, and I __think__ in some previous persion it was that way, but
> I am leaning to not do it.
> In the 1st patch, memmap_on_memory is false by default, so I see it as a preparatory
> step for later (this patchset) till it might be enabled.
> 
> Moreover, the big comment from mhp_support_memmap_on_memory() should change to not
> mention it, and change here again to reflect it.
> 
> All in all, I think it can stay, but maybe place a comment in the 1st patch above
> the variable saying something like "This is a noop now, it will be enabled later on"

I will leave that up to you. This is likely not worth a larger
discussion but it seems quite pointless to add a variable which never
changes. The resulting code might look different than you expect because
compiler is allowed to simply drop the whole condition.
 
> > > +
> > > +/*
> > > + * memory_hotplug.memmap_on_memory parameter
> > > + */
> > > +static bool memmap_on_memory __ro_after_init;
> > > +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> > > +module_param(memmap_on_memory, bool, 0444);
> > > +MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> > > +#endif
> > 
> > I am not very much familiar with the machinery. Does this expose the
> > state to the userspace?
> 
> Kind of:
> 
> # ls /sys/module/memory_hotplug/parameters
> memmap_on_memory
> # cat /sys/module/memory_hotplug/parameters/memmap_on_memory 
> Y
> 
> But that is not really the state, but rather it shows whether the user
> opted-in the feature by passing "memory_hotplug.memmap_on_memory=yes".
> It might be that the user opted-in the feature, but it cannot be used at
> at runtime (e.g: mhp_support_memmap_on_memory() return false due to size !=
> memory_block_size())

Thanks for the clarification.
-- 
Michal Hocko
SUSE Labs
