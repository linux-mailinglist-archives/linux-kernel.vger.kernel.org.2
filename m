Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39B44D9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhKKQAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhKKQAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:00:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB64D61247;
        Thu, 11 Nov 2021 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636646282;
        bh=e8dGzQJOCppdcf+R4KIjC0581S+PaGrbv4IH/XDMgZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfnVNHYyJsUDs8kfaqnYJC78XfdfwtIq47XsbFLTdy6QfQqYvSeyvtx3hXVzhKQOq
         6+rQCZDZ0uNDQWy1WFlOWOHO0BAiTSaDb6ZIwoDfyGIzeAJz2tJHKhkl0Q8AOfvcUw
         k7zZy6OpATq6ZwqCkmkyDu2I+i2ngdZ05A0skI2IQJmWjK80L08226FuIaa52CjYuC
         doNqpqf76SWKz9NaF8o7NFdNEtnCLzp/bqxFbZTWZPAEf08HOSgVk497XHQTYcAGTR
         Mwx93LS66lA7J/pasCrPoO2h6yS3Nr5fftt3Vel5yPG+JiVCkc3VhEJTfnEfz6qnVd
         4Z2QMxc51XxRg==
Date:   Thu, 11 Nov 2021 17:57:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/mm: replace GFP_ATOMIC with GFP_KERNEL for
 direct map allocations
Message-ID: <YY09g03W1o8OAuPJ@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
 <20211111110241.25968-5-rppt@kernel.org>
 <234cb35b-2092-22e1-8d44-4fad7a2e1877@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234cb35b-2092-22e1-8d44-4fad7a2e1877@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 07:19:40AM -0800, Dave Hansen wrote:
> On 11/11/21 3:02 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The allocations of the direct map pages are mostly happen very early during
> > the system boot and they use either the page table cache in brk area of bss
> > or memblock.
> > 
> > The few callers that effectively use page allocator for the direct map
> > updates are gart_iommu_init() and memory hotplug. Neither of them happen in
> > an atomic context so there is no reason to use GFP_ATOMIC for these
> > allocations.
> > 
> > Replace GFP_ATOMIC with GFP_KERNEL to avoid using atomic reserves for
> > allocations that do not require that.
> 
> I usually think of the biggest downside of GFP_ATOMIC as being that it
> fails more often.  But, since we tend not to be low on memory in early
> boot, GFP_ATOMIC and GFP_KERNEL end up being pretty close in actual
> behavior.
> 
> These allocations also get exposed via init_extra_mapping_*().  But,
> those are used via early_initcall()s where GFP_KERNEL is fine too.

Right, I forgot to mention them in the changelog...

> Those are a bit worrying because they're in somewhat nice code, like the
> Numascale APIC code.  I'm not sure how much use it sees these days.
>
> I guess if this goes wrong somehow, we'll get some nice splats to tell
> us what happened.
> 
> Was this motivated by anything in particular?  Or is it a pure cleanup?

The trigger was the discussion about PKS protection for the kernel page
tables, but for now I'd say it's pure cleanup.

-- 
Sincerely yours,
Mike.
