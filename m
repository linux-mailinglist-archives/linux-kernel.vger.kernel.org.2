Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D03876F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348669AbhERKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhERKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 530AE61209;
        Tue, 18 May 2021 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621335233;
        bh=1albl1iFT7lO5QgNDVJ5jG4lfAFdGkvbnRzuLTqjPyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXYY4DqSW4QsbgaQL6QXi6ZdeHaDW0T9FE0beaOSIKCYCn9kq/YT0pBgfFKzJadpq
         mg5IKthMepa5IUsNYEkt7XZupKPjSMoT0FDUPkt/n06x5N3wRKbnBLI5QuiHOGA38I
         v1sopQyLLuJ1Jp+PeDm/2Aqv9H1VE4+nLlqnIzu3lZf0JKdAHh7vB87BSwcu0W2QF1
         Mm0tUX9k4jU+m5LuGtr3Zz+n2x7YGZwmWnytR53m/Pu+EUpYAZJs3J3k34MB3DHx9H
         UJBMJJgMhHbV2RIBzRl/BPZAL+O9wT3vpsNgHQDWU+EwzBjPXmV7Ije2PISjlP3VXM
         sSXb3k9WsydOg==
Date:   Tue, 18 May 2021 13:53:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
Message-ID: <YKOcunzormJuuuie@kernel.org>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
 <20210518094427.GR12395@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094427.GR12395@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:44:27AM +0100, Russell King (Oracle) wrote:
> On Tue, May 18, 2021 at 12:06:13PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When unused memory map is freed the preserved part of the memory map is
> > extended to match pageblock boundaries because lots of core mm
> > functionality relies on homogeneity of the memory map within pageblock
> > boundaries.
> > 
> > Since pfn_valid() is used to check whether there is a valid memory map
> > entry for a PFN, make it return true also for PFNs that have memory map
> > entries even if there is no actual memory populated there.
> 
> I thought pfn_valid() was a particularly hot path... do we really want
> to be doing multiple lookups here? Is there no better solution?

It is hot, but for more, hmm, straightforward memory layouts it'll take 

	if (memblock_is_map_memory(addr))
		return 1;

branch, I think.

Most of mm operations are on pages that are fed into buddy allocator, and
if there are no holes with weird alignment  pfn_valid() will return 1 right
away.

Now thinking about it, with the patch that marks NOMAP areas reserved in
the memory map [1], we could also use
	
	memblock_overlaps_region(&memblock.memory,
				 ALIGN_DOWN(addr, pageblock_size),
				 ALIGN(addr + 1, pageblock_size))
to have only one lookup.

Completely another approach would be to simply stop freeing memory map with
SPARSEMEM. For systems like the one Kefen is using, it would waste less
than 2M out of 1.5G.
It is worse of course for old systems with small memories. The worst case
being mach-ep93xx with sections size of 256M and I presume 16M per section
would be normal for such machines.

[1] https://lore.kernel.org/lkml/20210511100550.28178-3-rppt@kernel.org

-- 
Sincerely yours,
Mike.
