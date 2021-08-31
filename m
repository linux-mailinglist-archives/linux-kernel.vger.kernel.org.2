Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99193FCBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhHaQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238852AbhHaQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38B46103D;
        Tue, 31 Aug 2021 16:56:52 +0000 (UTC)
Date:   Tue, 31 Aug 2021 17:56:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
Message-ID: <YS5fUqQYWf0AKLgD@arm.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:16:27AM -0700, Linus Torvalds wrote:
> On Fri, Aug 27, 2021 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
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
> 
> That said, I think x86 avoids the problem another way - by just making
> sure max_pfn is exact. That works too, as long as there are no holes
> in the RAM map that might be used for PCI BAR's.
> 
> So I think arm could fix it that way too, depending on their memory layout.

The suggested solution in the original thread was to change the generic
DMA code to use memblock_is_memory() instead of pfn_valid():

https://lore.kernel.org/lkml/b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com/

Given how late we discovered this in the -rc cycle, the decision was to
revert the pfn_valid() patch. We'll re-instate it at some point but
someone needs to sanity check the other pfn_valid() call sites and the
expected semantics.

-- 
Catalin
