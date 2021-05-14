Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6383807D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhENLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhENLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 682706143D;
        Fri, 14 May 2021 10:59:04 +0000 (UTC)
Date:   Fri, 14 May 2021 11:59:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
Message-ID: <20210514105901.GC855@arm.com>
References: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
 <20210510144337.GA92897@C02TD0UTHF1T.local>
 <4a36d7b7-6b27-31cc-d701-ebe3c6e4946e@arm.com>
 <20210511140708.GC8933@C02TD0UTHF1T.local>
 <8023de56-e6d5-8df0-9920-35fe7dbde640@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8023de56-e6d5-8df0-9920-35fe7dbde640@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:44:04AM +0530, Anshuman Khandual wrote:
> On 5/11/21 7:37 PM, Mark Rutland wrote:
> > On Tue, May 11, 2021 at 09:21:46AM +0530, Anshuman Khandual wrote:
> >> On 5/10/21 8:13 PM, Mark Rutland wrote:
> >>> On Mon, May 10, 2021 at 04:37:51PM +0530, Anshuman Khandual wrote:
> >>>> Semantics wise, [pud|pmd]_bad() have always implied that a given [PUD|PMD]
> >>>> entry does not have a pointer to the next level page table. This had been
> >>>> made clear in the commit a1c76574f345 ("arm64: mm: use *_sect to check for
> >>>> section maps"). Hence explicitly check for a table entry rather than just
> >>>> testing a single bit. This basically redefines [pud|pmd]_bad() in terms of
> >>>> [pud|pmd]_table() making the semantics clear.
> >>>>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will@kernel.org>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>
> >>> I have no strong feelings either way, so: 
> >>>
> >>> Acked-by: Mark Rutland <mark.rutland@arm.com>
> >>>
> >>> ... that said, I think that the "bad" naming is unclear and misleading,
> >>> and it'd be really nice if we could clean that up treewide with
> >>> something clearer than "bad".
> >>
> >> Agreed, the name is misleading.
> >>
> >>> It does seem that would roughly fit p??_leaf() if we had
> >>
> >> But what if the platform does not support huge page aka leaf mapping
> >> at the given level ? Also a non table i.e bad entry might not always
> >> mean a leaf/section/huge page mapping, it could simply imply that the
> >> entry is not just pointing to next level and might be just in an bad
> >> intermediate or invalid state.
> > 
> > Ah, so that's also covering swap entries, too? It's not entirely clear
> > to me what "bad intermediate or invalid state" means, because I assume
> > it's not arbitrary junk or this wouldn't be sound genrally.
> 
> Intermediate states like swap, migration or probably even splitting THP.
> Though I am not really sure whether pxx_bad() only gets used for valid
> table or leaf entries i.e things which are mapped. Hence checking just
> for non table entry is better and even safer, than looking out for what
> other states the entry could be in.

I had a quick look through some of the uses and it seems the expectation
is that after a !pmd_bad(), the pmd is a table. The checks for
migration, huge page etc. are prior to the pmd_bad() check.

For this patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
