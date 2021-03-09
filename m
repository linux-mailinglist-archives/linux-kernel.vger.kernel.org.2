Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3B33207C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCIIZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:47258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhCIIZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:25:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57CD8AB8C;
        Tue,  9 Mar 2021 08:25:38 +0000 (UTC)
Date:   Tue, 9 Mar 2021 09:25:35 +0100
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
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <YEcw/wXCQPHnUdOS@localhost.localdomain>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
 <b1aff368-8321-0fa7-05ab-3d6c856c00f8@intel.com>
 <20210308184330.GB25767@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308184330.GB25767@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:43:30PM +0100, Oscar Salvador wrote:
> On Thu, Mar 04, 2021 at 09:02:36AM -0800, Dave Hansen wrote:
> > Also, logically, it would make a lot of sense if you can move the actual
> > PMD freeing logic in here.  That way, the caller is just saying, "unuse
> > this PMD region", and then this takes care of the rest.  As it stands,
> > it's a bit weird that the caller takes care of the freeing.
> 
> You mean to move the 
> 
>  free_hugepage_table(pmd_page(*pmd), altmap);
>  spin_lock(&init_mm.page_table_lock);
>  pmd_clear(pmd);
>  spin_unlock(&init_mm.page_table_lock);
> 
> block in there?
> 
> Well, from where I see it, it is more like:
> 
>  if (is_the_range_unused())
>   : if so, free everything
> 
> But I agree with you what it might make some sense to move it there.
> Since I do not feel strong about this, I will move it.

hi Dave,

So, after splitting this patch and re-shape it to address all the
feedback, I am still not sure about this one.
Honestly, I think the freeing logic would be better off kept in
remove_pmd_table.

The reason for me is that vmemmap_unuse_sub_pmd only 1) marks the range
to be removed as unused and 2) checks whether after that, the whole
PMD range is unused.

I think the confusion comes from the name.
"vmemmap_pmd_is_unused" might be a better fit?

What do you think? Do you feel strong about moving the log in there
regardless of the name?


-- 
Oscar Salvador
SUSE L3
