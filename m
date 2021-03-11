Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D01336EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCKJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhCKJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:33:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 071E164F4D;
        Thu, 11 Mar 2021 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615455187;
        bh=dh01iKnMh12GRgQjnoaGZLEPlCzGpVYYPsx3ni+tdT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D96/AvS+OpjlahZ4Rje/9KkDOawCIc0aRIuvfE2mBz8unqx2BWZao4vYZdnCKR3cC
         Mqds9QGdhCfbaVkOtbk1ObIxlHAXBFvNTeWBMuiYsOpexnpb3CO4fKMdNYCqYPzc+m
         GbwuMx/9zeMNzyxyON8bcyAKno/+Xv4x7VYpLZ6qaWduG+AC3fSZoyJeB/gFhbRwuh
         72Ibx0EOUjzvcy4EMYuOdrUhpmx+dZcF6wFzOROxE41Ot8Gc+43RgcVTCLHi01BFKc
         d0Q3SDeNFb9OF6aSAqf+5dXFZsL8RtqzPuHhZrdNwQDAoopzP40vTgiJzNHrnD8HRG
         +LTOkUx0g35Rw==
Date:   Thu, 11 Mar 2021 09:33:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <20210311093302.GA30603@willie-the-truck>
References: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
 <YEXme5SI+GxsYli8@kernel.org>
 <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:22:53PM +0530, Anshuman Khandual wrote:
> On 3/8/21 2:25 PM, Mike Rapoport wrote:
> > On Mon, Mar 08, 2021 at 08:57:53AM +0530, Anshuman Khandual wrote:
> >> Platforms like arm and arm64 have redefined pfn_valid() because their early
> >> memory sections might have contained memmap holes caused by memblock areas
> >> tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
> >> for struct page backing. This scenario could be captured with a new option
> >> CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
> >> improved to accommodate such platforms. This reduces overall code footprint
> >> and also improves maintainability.
> > 
> > I wonder whether arm64 would still need to free parts of its memmap after
> 
> free_unused_memmap() is applicable when CONFIG_SPARSEMEM_VMEMMAP is not enabled.
> I am not sure whether there still might be some platforms or boards which would
> benefit from this. Hence lets just keep this unchanged for now.

In my opinion, unless there's a compelling reason for us to offer all of
these different implementations of the memmap on arm64 then we shouldn't
bother -- it's not like it's fun to maintain! Just use sparsemem vmemmap
and be done with it. Is there some reason we can't do that?

Will
