Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4089C368028
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhDVMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235232AbhDVMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:20:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A09E861458;
        Thu, 22 Apr 2021 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094000;
        bh=Wr0OhYhDfMPeG2IHpq9JA+nWcwCtRYKEEDdMNXqNT9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlaLFhYwpL5KwHSeR+kWjYsDL/tsJ53z++3kDhDn76NrrSsP7VizhfXGQyIbXDoqb
         LJZ8mRtqqeFGV1Q8FDHsud8Q17LECv/AEoLpPNly3nyWYZtcAhFZdQm75qDzi5K+CU
         0FqxfTjCfYUtjkBT56BenF/rsDnUW62chd9fKHL8CYa3tPqiehAIWZaa30RoU9mGl6
         V59vWyrsISfh6puiMCNpZBbUjywKOXpSeNu+H0oCQEB5l5hNk6uAJFu7ybD+AkaS2C
         RRBa4F2UAmwnAb9qcAuFRpEbVSRLTjZYn3bSC9Tuad642ys+HkqBTTOCK45NDMDPIS
         dw8AordqXki3g==
Date:   Thu, 22 Apr 2021 15:19:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, david@redhat.com, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <YIFp6W/wgcZSxe1k@kernel.org>
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
 <YIEzaQF8fVtNgU0E@kernel.org>
 <6096b004-aaeb-d814-87e4-92ec1b180f1d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6096b004-aaeb-d814-87e4-92ec1b180f1d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:53:36PM +0530, Anshuman Khandual wrote:
> On 4/22/21 1:57 PM, Mike Rapoport wrote:

...

> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 3abf2c3fea7f..93f8a9c8428d 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -1740,6 +1740,7 @@ bool __init_memblock memblock_is_memory(phys_addr_t addr)
> >>  {
> >>  	return memblock_search(&memblock.memory, addr) != -1;
> >>  }
> >> +EXPORT_SYMBOL(memblock_is_memory);
> > 
> > Please make it inside #ifdef CONFIG_ARCH_MEMBLOCK
> CONFIG_ARCH_KEEP_MEMBLOCK ?

Yeah, _KEEP went away somehow :)

> Wrap it around the EXPORT_SYMBOL() or the entire function
> memblock_is_memory().

EXPORT_SYMBOL(). Otherwise we'll have exported __init function.
 
-- 
Sincerely yours,
Mike.
