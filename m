Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47B23E7BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbhHJPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:19:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:8045 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239937AbhHJPTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:19:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="300513128"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="300513128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 08:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="469054407"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2021 08:16:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 03C38142; Tue, 10 Aug 2021 18:15:48 +0300 (EEST)
Date:   Tue, 10 Aug 2021 18:15:48 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] x86: Impplement support for unaccepted memory
Message-ID: <20210810151548.4exag5uj73bummsr@black.fi.intel.com>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <4b80289a-07a4-bf92-9946-b0a8afb27326@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b80289a-07a4-bf92-9946-b0a8afb27326@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:08:58AM -0700, Dave Hansen wrote:
> On 8/9/21 11:26 PM, Kirill A. Shutemov wrote:
> > UEFI Specification version 2.9 introduces concept of memory acceptance:
> > Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> > requiring memory to be accepted before it can be used by the guest.
> > Accepting happens via a protocol specific for the Virtrual Machine
> > platform.
> > 
> > Accepting memory is costly and it makes VMM allocate memory for the
> > accepted guest physical address range. We don't want to accept all memory
> > upfront.
> 
> This could use a bit more explanation.  Any VM is likely to *eventually*
> touch all its memory, so it's not like a VMM has a long-term advantage
> by delaying this.
> 
> So, it must have to do with resource use at boot.  Is this to help boot
> times?

Yes, boot time is main motivation.

But I'm going also to look at long-term VM behaviour with the fixed memory
footprint. I think if a workload allocate/free memory within the same
amount we can keep memory beyond the size unaccepted. Few tweaks likely
will be required such as disabling page shuffling on free to keep
unaccepted memory at the tail of free list. More investigation needed.

> I had expected this series, but I also expected it to be connected to
> CONFIG_DEFERRED_STRUCT_PAGE_INIT somehow.  Could you explain a bit how
> this problem is different and demands a totally orthogonal solution?
>
> For instance, what prevents us from declaring: "Memory is accepted at
> the time that its 'struct page' is initialized" ?  Then, we use all the
> infrastructure we already have for DEFERRED_STRUCT_PAGE_INIT.

That was my first thought too and I tried it just to realize that it is
not what we want. If we would accept page on page struct init it means we
would make host allocate all memory assigned to the guest on boot even if
guest actually use small portion of it.

Also deferred page init only allows to scale memory accept across multiple
CPUs, but doesn't allow to get to userspace before we done with it. See
wait_for_completion(&pgdat_init_all_done_comp).

-- 
 Kirill A. Shutemov
