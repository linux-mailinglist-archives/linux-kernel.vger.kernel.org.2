Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9741C323
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbhI2LF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244363AbhI2LFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:05:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3BF0613CE;
        Wed, 29 Sep 2021 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632913424;
        bh=XKEIYo+ZewR2Nn7R/NL3hozd8BvZN53o0z9on1e1NrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGcadR35ExfRhxZWQxX6/CNzbtNrPLnhvwUUpQJutBpAINi3cOtBW6U5I+zVPPD28
         MK8n/paiq4Mk16D1zosa/JzieW4SXYixQtnTBqUTAANPhBOeOTLalLmqLoJslA1sP3
         fsSZK+uuS8ZtpwUIcI6sHc/OiPeEqUbZvsNJ7rLHFhTBvLOYQ+XjOB9SSLYD8+kXZo
         nm5h6W1M2jHgFzVlMKVk+a5awfZZXEtD7C4XPRGy182X5kH+nRkrXhC5JL8a9wqYTz
         KY62+v0xingEOuZwgLze72IZynhJ4oj51P16OWVnPF8rZAIsH99oN3x93iBS9o0uBx
         U05dgfN+FdQ2w==
Date:   Wed, 29 Sep 2021 12:03:39 +0100
From:   Will Deacon <will@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <20210929110339.GA21510@willie-the-truck>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <20210929101028.GB21057@willie-the-truck>
 <13f56b37-afc7-bf6f-d544-8d6433588bf9@redhat.com>
 <20210929104241.GA21395@willie-the-truck>
 <b0717829-c8dd-c7c0-47bb-5392ed22f700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0717829-c8dd-c7c0-47bb-5392ed22f700@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:49:58PM +0200, David Hildenbrand wrote:
> On 29.09.21 12:42, Will Deacon wrote:
> > On Wed, Sep 29, 2021 at 12:29:32PM +0200, David Hildenbrand wrote:
> > > On 29.09.21 12:10, Will Deacon wrote:
> > > > On Thu, Sep 23, 2021 at 03:54:48PM -0700, Chris Goldsworthy wrote:
> > > > > From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > > > 
> > > > > After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> > > > > needs updating to reflect on new PFNs being hot added to system.
> > > > > 
> > > > > Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > > > Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> > > > > ---
> > > > >    arch/arm64/mm/mmu.c | 5 +++++
> > > > >    1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > > index cfd9deb..fd85b51 100644
> > > > > --- a/arch/arm64/mm/mmu.c
> > > > > +++ b/arch/arm64/mm/mmu.c
> > > > > @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
> > > > >    	if (ret)
> > > > >    		__remove_pgd_mapping(swapper_pg_dir,
> > > > >    				     __phys_to_virt(start), size);
> > > > > +	else {
> > > > > +		max_pfn = PFN_UP(start + size);
> > > > > +		max_low_pfn = max_pfn;
> > > > > +	}
> > > > 
> > > > We use 'max_pfn' as part of the argument to set_max_mapnr(). Does that need
> > > > updating as well?
> > > > 
> > > > Do we have sufficient locking to ensure nobody is looking at max_pfn or
> > > > max_low_pfn while we update them?
> > > 
> > > Only the write side is protected by memory hotplug locking. The read side is
> > > lockless -- just like all of the other pfn_to_online_page() machinery.
> > 
> > Hmm. So the readers can see one of the variables updated but the other one
> > stale?
> 
> Yes, just like it has been on x86-64 for a long time:
> 
> arch/x86/mm/init_64.c:update_end_of_memory_vars()
> 
> Not sure if anyone really cares about slightly delayed updates while memory
> is getting hotplugged. The users that I am aware of don't care.

Thanks, I'd missed that x86 also updates max_low_pfn. So at least we're not
worse off in that respect.

Looking at set_max_mapnr(), I'm wondering why we need to call that at all
on arm64 as 'max_mapnr' only seems to be used for nommu.

Will
