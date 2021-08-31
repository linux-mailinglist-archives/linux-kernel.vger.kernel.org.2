Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41393FC840
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhHaNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhHaNcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 438C560249;
        Tue, 31 Aug 2021 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630416682;
        bh=yfQIQYdgnIv9MEe5gtI21/szPMXdVIsmtImv9y6mkGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izxX5uSZclyn0YetApctJ3htw30uSf7HiMuFzRZmej6Macq5nNuXXLnMCNI63G8q2
         mom12LvjWriKAQxzzotSfG5vu58R40KT7iNDO2vOEeE8rA16oCqNSpMzWAvWDpnPwL
         qFBb1GLl0JoMPZ8ccfe0ZK+vtbcyg/zWLqfKlcdSHKeJ1vrm0N8Asc3Z52AFA1LdxO
         GJaMTIzXsOTzcILA1nIQlWja9wDf6tD7gPmlNX0r1vTRQ+3Feue4AVEG9c44UmjgDC
         o9zTE733D8FkDZDHegehbEIQQzeaSpCjqoRsHAbfX96t50xbJ+XOTSaTYHWfhyn2tW
         KHUPy/FFM549A==
Date:   Tue, 31 Aug 2021 14:31:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        david@redhat.com
Subject: Re: [GIT PULL] arm64 fix for 5.14
Message-ID: <20210831133117.GD31712@willie-the-truck>
References: <20210826131747.GE26318@willie-the-truck>
 <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
 <20210827074041.GA24309@lst.de>
 <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
 <20210827171041.GA28149@lst.de>
 <CAHk-=wg=+P1+HQXhrszxN_BgWtLc-=dWiT61KzogcJU3hnLrtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=+P1+HQXhrszxN_BgWtLc-=dWiT61KzogcJU3hnLrtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+David]

On Fri, Aug 27, 2021 at 10:16:27AM -0700, Linus Torvalds wrote:
> On Fri, Aug 27, 2021 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > They CCed me on their earlier discussion, but I did not catch up on it
> > until you responded to the pull request  If I understood it correct it
> > was about a platform device mapping a MMIO region (like a PCI bar),
> > but something about section alignment cause pfn_valid to mistrigger.
> 
> Yeah, so I can easily see the maxpfn numbers can easily end up being
> rounded up to a whole memory section etc.
> 
> I think my suggested solution should JustWork(tm) - exactly because if
> the area is then in that "this pfn is valid" area, it will
> double-check the actual underlying page.

I think the pitfall there is that the 'struct page' might well exist,
but isn't necessarily initialised with anything meaningful. I remember
seeing something like that in the past (I think for "no-map" memory) and
David's reply here:

https://lore.kernel.org/r/aff3942e-b9ce-5bae-8214-0e5d89cd071c@redhat.com

hints that there are still gotchas with looking at the page flags for
pages if the memory is offline or ZONE_DEVICE.

Don't get me wrong, I'd really like to use the generic code here as I
think it would help to set expectations around what pfn_valid() actually
means, I'm just less keen on the try-it-and-see-what-breaks approach
given how sensitive it is to the layout of the physical memory map.

> That said, I think x86 avoids the problem another way - by just making
> sure max_pfn is exact. That works too, as long as there are no holes
> in the RAM map that might be used for PCI BAR's.
> 
> So I think arm could fix it that way too, depending on their memory layout.

The physical memory map is the wild west, unfortunately. It's one of the
things where everybody does something different and it's very common to see
disjoint banks of memory placed seemingly randomly around.

Will
