Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2713C319521
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBKV0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:26:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBKV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:26:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22D3FAD3E;
        Thu, 11 Feb 2021 21:25:20 +0000 (UTC)
Date:   Thu, 11 Feb 2021 22:25:17 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/vmemmap: Drop handling of 4K unaligned
 vmemmap range
Message-ID: <20210211212517.GA2872@localhost.localdomain>
References: <20210203104750.23405-1-osalvador@suse.de>
 <20210203104750.23405-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203104750.23405-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:47:48AM +0100, Oscar Salvador wrote:
> remove_pte_table() is prepared to handle the case where either the
> start or the end of the range is not PAGE aligned.
> This cannot actually happen:
> 
> __populate_section_memmap enforces the range to be PMD aligned,
> so as long as the size of the struct page remains multiple of 8,
> the vmemmap range will be aligned to PAGE_SIZE.
> 
> Drop the dead code and place a VM_BUG_ON in vmemmap_{populate,free}
> to catch nasty cases.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>

Hi Andrew, 

the cover letter got lost somehow, but is this patchset, [1] and [2]
on your radar?

[1] https://lore.kernel.org/linux-mm/20210204134325.7237-3-osalvador@suse.de/
[2] https://lore.kernel.org/linux-mm/20210204134325.7237-4-osalvador@suse.de/

thanks


-- 
Oscar Salvador
SUSE L3
