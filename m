Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0E367E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhDVKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhDVKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0402F613F2;
        Thu, 22 Apr 2021 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619085845;
        bh=IRoMB5T0HjVZPko4a93wd1DTQr7V5iRUr5V9MLSeMXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdCbNPMG1OgSoEWz6JHR1/0oq7859Zo3OIjVU2zV0vPRzzKqgm1AdP8rSrMgw6YUZ
         4CPkIJYkxFEiNcbEMjDAcnr97CA3rd4Mnt3gQfjLivjGvZPBxTc+Lepc6dzrAFRkMg
         QxzkqLudSYG2QDwV7osarzrtL1K9uAGirns7s7K+/1x0wkIDBfNRlDuWFagvNt4hpH
         fjG9tt7XyyZzeCUFoM8FeSg6Sg7Q0hyTh8rYicCRE8jungk5SUzDgr+ZdbVrmhjklY
         Ypz765TFR6gciYE2viQShYYRcKoTyDX8EwgjvY94jnyCLuYdjiaxHevjipkbffIXI/
         qGjSdVztO0Fpw==
Date:   Thu, 22 Apr 2021 13:03:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
Message-ID: <YIFKDm0FMARKvP9B@kernel.org>
References: <20210422061902.21614-1-rppt@kernel.org>
 <1619077823-3819-1-git-send-email-anshuman.khandual@arm.com>
 <ce4f8045-2481-103f-f418-28cb43c7c7ff@redhat.com>
 <YIFFIiuy+z3WLHDi@kernel.org>
 <61523566-f302-1051-9565-b1e129c6cac0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61523566-f302-1051-9565-b1e129c6cac0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:48:58AM +0200, David Hildenbrand wrote:
> > 
> > > IOW, avoiding having to adjust generic pfn_valid()/pfn_to_online_page() at
> > > all. Am i missing something or should that be possible?
> > 
> > We are back again to the question "should arm64 free its memmap".
> > If the answer is no, we don't need arm64::pfn_valid() for SPARSEMEM at all.
> > If the answer is yes, Anshuman's patch is way better than a custom
> > pfn_valid().
> 
> Well, I propose something in between: stop freeing with SPARSEMEM, continue
> freeing with FLATMEM.

I'm all for it.

-- 
Sincerely yours,
Mike.
