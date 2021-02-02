Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693AB30C088
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhBBOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhBBNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:53:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04A6EAC45;
        Tue,  2 Feb 2021 13:52:56 +0000 (UTC)
Date:   Tue, 2 Feb 2021 14:52:53 +0100
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
Subject: Re: [PATCH 2/2] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210202135248.GA14438@linux>
References: <20210202112450.11932-1-osalvador@suse.de>
 <20210202112450.11932-3-osalvador@suse.de>
 <f1990f9d-305c-f5f9-e77d-5c5d71143672@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1990f9d-305c-f5f9-e77d-5c5d71143672@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:29:11PM +0100, David Hildenbrand wrote:
> > @@ -1088,10 +1150,10 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
> >   				pages++;
> >   			} else {
> >   				/* If here, we are freeing vmemmap pages. */
> > -				memset((void *)addr, PAGE_INUSE, next - addr);
> > +				memset((void *)addr, PAGE_UNUSED, next - addr);
> >   				page_addr = page_address(pud_page(*pud));
> > -				if (!memchr_inv(page_addr, PAGE_INUSE,
> > +				if (!memchr_inv(page_addr, PAGE_UNUSED,
> >   						PUD_SIZE)) {
> >   					free_pagetable(pud_page(*pud),
> >   						       get_order(PUD_SIZE));
> 
> I'm sorry to bother you again, but isn't that dead code as well?

Heh, I spotted that earlier, but I did not think much of it honestly.

All this was introduced by:

 commit ae9aae9eda2db71bf4b592f15618b0160eb07731
 Author: Wen Congyang <wency@cn.fujitsu.com>
 Date:   Fri Feb 22 16:33:04 2013 -0800

     memory-hotplug: common APIs to support page tables hot-remove


> How do we ever end up using 1GB pages for the vmemmap? At least not via
> vmemmap_populate() - so I guess never? There are not many occurrences of
> "PUD_SIZE" in the file after all ...

AFAICT, we don't. The largest we populate for vmemmap is 2MB.
I see init_memory_mapping can use 1G, but that should not affect us.

I guess that the vmemmap handling for 1GB can go as well.
I will update the patchset.

-- 
Oscar Salvador
SUSE L3
