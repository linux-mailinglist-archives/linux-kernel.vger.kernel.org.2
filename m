Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512933127F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCHPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:46:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCHPqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:46:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2480ADDB;
        Mon,  8 Mar 2021 15:46:09 +0000 (UTC)
Date:   Mon, 8 Mar 2021 16:46:07 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
Message-ID: <20210308154603.GA23272@linux>
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-4-osalvador@suse.de>
 <b139d4fe-fdef-b5d9-4fdf-2f79cb00a24a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b139d4fe-fdef-b5d9-4fdf-2f79cb00a24a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:35:08PM +0100, David Hildenbrand wrote:
> On 04.03.21 11:00, Oscar Salvador wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 04545725f187..e626dab39c60 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2794,6 +2794,20 @@
> >   			seconds.  Use this parameter to check at some
> >   			other rate.  0 disables periodic checking.
> > +	memory_hotplug.memmap_on_memory
> > +			[KNL,X86,ARM] Boolean flag to enable this feature.
> 
> Right now it can be set on any arch with memory hotplug, right? It's simply
> not effective.

Right.

> > +			Format: {on | off (default)}
> > +			When enabled, memory to build the pages tables for the
> > +			memmap array describing the hot-added range will be taken
> > +			from the range itself, so the memmap page tables will be
> > +			self-hosted.
> > +			Since only single memory device ranges are supported at
> > +			the moment, this option is disabled by default because
> > +			it might have an impact on workloads that needs large
> > +			contiguous memory chunks.
> > +			The state of the flag can be read in
> > +			/sys/module/memory_hotplug/parameters/memmap_on_memory.
> 
> Maybe want to add that even if enabled, there are cases where it is not
> effective?

Sure, I already added a hint.

> > +static bool memmap_on_memory __ro_after_init;
> > +module_param(memmap_on_memory, bool, 0444);
> > +MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> 
> Wondering if this makes sense getting wrapped in
> 
> #ifdef CONFIG MHP_MEMMAP_ON_MEMORY
> 
> just a thought.

Definitely, will wrapp it with MHP_MEMMAP_ON_MEMORY.

> 
> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


-- 
Oscar Salvador
SUSE L3
