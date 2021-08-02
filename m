Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA83DD23F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhHBIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhHBIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:48:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0987B60F36;
        Mon,  2 Aug 2021 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627894128;
        bh=miF6hfM5bVUHxLAXxnn63b7rbFA0D5M3oOqpci7guOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPBLtTquIbg2IVD/nWH8y18L+Okc0lcqkO+t0Epj6qydQgLi2PMqPUQomGCE7EskT
         fDoxWdwb/m60TWQBT0FL+Fkolaz4YwsqtjZSWZxZT7Nj+0CMqs5U1t0cwuLWCJb2f6
         H9GsmrVT6woiCZgG3GVlosKqqjoATaZdOBRzKOAm9WwJV478F7zhmBN0zU+EHCEez6
         YpbTNcoGl8X7b0kBHA1JdeGiBr/Uc24lcG8yK24RRaIrLpgBcgYmauN8Pz9xrdJMgC
         /hS84X0dbfDkrWDPn4mjvobUnUfs9hCLUqxX/DVy5EL0Xt+RwZeVTye4ufOzp2P8i4
         dNjxLd0YN7khA==
Date:   Mon, 2 Aug 2021 11:48:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <20210802084844.piewpbpzbktgbyfo@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
 <YQQsz/tvrQpqAbpX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQQsz/tvrQpqAbpX@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:46:07PM +0000, Sean Christopherson wrote:
> On Fri, Jul 30, 2021, Jarkko Sakkinen wrote:
> > On Wed, Jul 28, 2021 at 03:19:46PM -0700, Dave Hansen wrote:
> > > On 7/28/21 1:46 PM, Tony Luck wrote:
> > > > Export a function sgx_is_epc_page() that simply reports whether an
> > > > address is an EPC page for use elsewhere in the kernel.
> > > 
> > > It would be really nice to mention why this needs to be exported to
> > > modules.  I assume it's the error injection driver or something that can
> > > be built as a module, but this export was a surprise when I saw it.
> > > 
> > > It's probably also worth noting that this is a sloooooooow
> > > implementation compared to the core VM code that does something
> > > analogous: pfn_to_page().  It's fine for error handling, but we should
> > > probably have a comment to this effect so that more liberal use doesn't
> > > creep in anywhere.
> > 
> > You could also create an xarray to track physical EPC address ranges,
> > and make the query fast.
> 
> Eh, it's not _that_ slow due to the constraints on the number of EPC sections.
> The hard limit is currently '8', and practically speaking there will be one
> section per socket.  Turning a linear search into a binary search in this case
> isn't going to buy much.

Also, consumes more memory.

Just pointing out that it is possible to improve without much fuzz, if ever
required, for instance by using DEFINE_XARRAY() to be define file-scope
xarray.

> Out of curiosity, on multi-socket systems, are EPC sections clustered in a single
> address range, or are they interleaved with regular RAM?  If they're clustered,
> you could track the min/max across all sections to optimize the common case that
> an address isn't in any EPC section.

Given that physical address ranges of different NUMA nodes are disjoint,
and each has EPC section is reserved from one such section, I would presume
that they are interleaved.

> static struct sgx_epc_page *sgx_paddr_to_page(u64 paddr)
> {
> 	struct sgx_epc_section *section;
> 	int i;
> 
>         if (paddr < min_epc_pa || paddr > max_epc_pa)
>                 return NULL;
> 
> 	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
> 		section = &sgx_epc_sections[i];
> 
> 		if (paddr < section->phys_addr || paddr > section->end_phys_addr)
> 			continue;
> 
> 		return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
> 	}
> 
> 	return NULL;
> }

/Jarkko
