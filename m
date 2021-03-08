Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118D63315C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCHSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhCHSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:20:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8700BAB8C;
        Mon,  8 Mar 2021 18:20:43 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:20:40 +0100
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
Subject: Re: [PATCH v4 1/3] x86/vmemmap: Drop handling of 4K unaligned
 vmemmap range
Message-ID: <20210308182031.GA25767@linux>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-2-osalvador@suse.de>
 <d2558ae7-475a-ae2c-77dc-6f8ad9b27a16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2558ae7-475a-ae2c-77dc-6f8ad9b27a16@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:50:10AM -0800, Dave Hansen wrote:
> On 3/1/21 12:32 AM, Oscar Salvador wrote:
> > remove_pte_table() is prepared to handle the case where either the
> > start or the end of the range is not PAGE aligned.
> > This cannot actually happen:
> > 
> > __populate_section_memmap enforces the range to be PMD aligned,
> > so as long as the size of the struct page remains multiple of 8,
> > the vmemmap range will be aligned to PAGE_SIZE.
> > 
> > Drop the dead code and place a VM_BUG_ON in vmemmap_{populate,free}
> > to catch nasty cases.
> 
> I was wondering why the VM_BUG_ON()s went in vmemmap_free() instead of
> closer to the code that you modified in remove_pte_table().  I assume
> this was because vmemmap_free() is the only (indirect) caller of
> remove_pte_table().

Yes, that was pretty much the reason.
It seemed reasonable to me to fence it off at the "gate", and not further
deep.

Does it make sense to you? May I keep your Ack?

Thanks Dave!

> 
> Otherwise, this looks fine to me:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

-- 
Oscar Salvador
SUSE L3
