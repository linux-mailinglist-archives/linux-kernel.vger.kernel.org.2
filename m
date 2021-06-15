Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DD3A72D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhFOAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhFOAQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CFB3611CE;
        Tue, 15 Jun 2021 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623716032;
        bh=se15b76/aO5F2KF29EEk9PwTwphIiHEyGbjleL82ixY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tmS0lMh/VywKn2t8cjW762qsXrHuoTR/DXI+eYIY2xEWlKn+4r8XTI1T7FfSNbq7b
         s20wu3oBOjhC5s/81saZyD8vF2BkQw1E/oEK7AtKSq9vpMRcUxmGpBA+GghcD3azo5
         TOiEqP0rjplZ3Q2VUu8UmANEdKmZsenGTnNnZQoE=
Date:   Mon, 14 Jun 2021 17:13:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-Id: <20210614171351.8c778c335896285020846666@linux-foundation.org>
In-Reply-To: <YMcSkvXrsDMPLicd@linux.ibm.com>
References: <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
        <YK6EXNZHY1xt7Kjs@linux.ibm.com>
        <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
        <YK9e0LgDOfCFo6TM@linux.ibm.com>
        <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
        <YK/HKMgajBCwpLt8@linux.ibm.com>
        <20210527175047.GK8661@arm.com>
        <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
        <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
        <daaf6faa-b5c1-b201-28c9-07f8e1fe4a82@arm.com>
        <YMcSkvXrsDMPLicd@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 11:25:54 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:

> On Tue, Jun 08, 2021 at 12:36:21PM +0530, Anshuman Khandual wrote:
> > 
> > 
> > On 5/28/21 10:43 AM, Mike Rapoport wrote:
> > > On Thu, May 27, 2021 at 03:56:44PM -0700, Andrew Morton wrote:
> > >> On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >>
> > >>>> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> > >>>>
> > >>>> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > >>>>
> > >>>> It seems to me that the check for memblock_is_memory() in
> > >>>> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> > >>>> section parts that are not actually populated and then we have
> > >>>> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> > >>>
> > >>> I acked Anshuman's patch, I think they all need to go in together.
> > >>
> > >> That's neat.   Specifically which patches are we referring to here?
> > > 
> > > arm64: drop pfn_valid_within() and simplify pfn_valid():
> > > https://lore.kernel.org/lkml/20210511100550.28178-5-rppt@kernel.org
> > > 
> > > arm64/mm: Drop HAVE_ARCH_PFN_VALID:
> > > https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > 
> > I dont see the above patch (which drops HAVE_ARCH_PFN_VALID on arm64) on linux-next
> > i.e. next-20210607. I might have missed some earlier context here but do not we want
> > to fallback on generic pfn_valid() after Mike's series ?
> 
> Andrew,
> 
> Can you please pick the two patches above?

I already had

include-linux-mmzoneh-add-documentation-for-pfn_valid.patch
memblock-update-initialization-of-reserved-pages.patch
arm64-decouple-check-whether-pfn-is-in-linear-map-from-pfn_valid.patch
arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch

and I just added

arm64-mm-drop-have_arch_pfn_valid.patch

so I think we're all good now?

and I don't think any of this is needed in 5.13 or -stable, correct?

I still have question marks over

https://lkml.kernel.org/r/YJ0Fhs5krPJ0FgiV@kernel.org and
https://lkml.kernel.org/r/d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com

Is this all OK now?
