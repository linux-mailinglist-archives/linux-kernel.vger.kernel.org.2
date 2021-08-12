Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A143C3E9E59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHLGTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhHLGTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:19:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7519560F57;
        Thu, 12 Aug 2021 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628749119;
        bh=SruAedw0pxejnRXjingrcJLTyjDFY9+CyOnUc7yNQmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFsIWVtNpplZxYYRWthnJL2sIAGAuI8SF/piyN76QRpS8JmdMB0WDhMZZjlzJopzZ
         Q9yjN04o9z4H7ZklEW5PlUTU9A79tm5HZ2lkk4IwkV6+KEonIxkSbThvjw7ZU4OHG/
         C7LlBN+BdaYBJ/uSr6XZFxx3EZb6If5gmsYmVON+GXK3PTqN8wmmgv1ilAtyaI/Ztq
         M7/MTS1P6X1/ftmcwmilgN8LWbawKEoNpKW2Jv2iv/nfA60xKaQj+RiQPQlgCIiCXv
         hEgwVW4rqQOmInP35LWKck+fYFkZ0vgg0BUYjG1DwI5jrBuFpkJmsKa7cniIRqXTMp
         X2e+2Pf60nzHw==
Date:   Thu, 12 Aug 2021 09:18:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 09/18] ARC: mm: non-functional code cleanup ahead of 3
 levels
Message-ID: <YRS9OvkgaQxOfkkg@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-10-vgupta@kernel.org>
 <YRPDL90Qr5RLDmnT@kernel.org>
 <7d022d55-c70b-b3ac-4f0b-1faa26c0d4bd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d022d55-c70b-b3ac-4f0b-1faa26c0d4bd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 06:37:19PM -0700, Vineet Gupta wrote:
> On 8/11/21 5:31 AM, Mike Rapoport wrote:
> > > +/*
> > > + * For ARC, pgtable_t is not struct page *, but pte_t * (to avoid
> > > + * extraneous page_address() calculations) hence can't use
> > > + * use asm-generic/pgalloc.h which assumes it being struct page *
> > > + */
> > Another reason to leave ARC without asm-generic/pgalloc.h was
> > __get_order_pte() that other arches don't have.
> > So this and pgtable_t aliased to pte_t * seemed to me too much to bother
> > then, but probably it's worth reconsidering with addition of 3rd and 4th
> > levels.
> 
> I agree that savings of not havign page_address() might not be huge. However
> asm-generic/pgalloc.h only has pte allocation routines and all other
> allocation levels come from arch file

asm-generic/pgalloc.h has allocation routines up to PUD.
There is also pgtable_pmd_page_ctor() and pgtable_pmd_page_dtor() called in
the generic versions of PMD allocation, it seems they are not called in ARC
implementation.

So using asm-generic/pgalloc.h would probably save you some THP debugging ;-)

We may even probably accommodate multi-page PTEs in asm-generic/pgalloc.h
with something like

#ifndef __HAVE_ARCH_PTE_GET_ORDER
static inline int __pte_get_order(void)
{
	return 0;
}
#endif

> Also for ARCv2, given the arbitrary address split and ensuing paging levels
> (as well as support for different page sizes) we will need to make sure that
> one page is enough to hold any level's paging using say BUILD_BUG_ON. In
> fact that should also be done for 3rd and 4th levels for sanity.

Right, these sanity checks would be useful, but they may live in one of .c
files in arch/arc/mm.
 
> -Vineet
> 
> 

-- 
Sincerely yours,
Mike.
