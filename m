Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFB3DE7AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhHCH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234344AbhHCH66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE40360F01;
        Tue,  3 Aug 2021 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627977527;
        bh=xrL0L5sjmEbvAkIaM5DGTisQzBhF+YdUH3ou+1qqyG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRBVCHEHNAVwAvlSuUBEhFfD7chxFF0uhc/a362qNsf4FIq3FHkg6HTjznR5/prww
         l5Cg2J4mtQRpp43pjt0z7A9cOibVYYUJBbNRbtKEGa4APmlJRa9F6VIFuKQsV9nrwZ
         DlwsCsWmBI6nLgSSMxWaiOj9mPwVdCCj9fKlavEn4FbMvVXIqUxtGrqmBGZC2KpZU5
         F9r/V6mgrvxF4sUMCpPZzOv+NmFOUsiNLSoHS5bAO5Vf9FKFK7tsoWnBhpdmgicQUG
         uWCwgU4ZgGTItiWhvVGDjB3+cCUrtzRmuRHAPLJdh3/Pti7VMRm3JLHyvOqI/dFQ8O
         eLN3UYYYUGM3A==
Date:   Tue, 3 Aug 2021 10:58:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] memblock: stop poisoning raw allocations
Message-ID: <YQj3MqOON6qySFFa@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-5-rppt@kernel.org>
 <72be13936ca341897d2fd7c65fb4345a8467c571.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72be13936ca341897d2fd7c65fb4345a8467c571.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 10:13:04AM -0700, Joe Perches wrote:
> On Wed, 2021-07-14 at 15:37 +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Functions memblock_alloc_exact_nid_raw() and memblock_alloc_try_nid_raw()
> > are intended for early memory allocation without overhead of zeroing the
> > allocated memory. Since these functions were used to allocate the memory
> > map, they have ended up with addition of a call to page_init_poison() that
> > poisoned the allocated memory when CONFIG_PAGE_POISON was set.
> > 
> > Since the memory map is allocated using a dedicated memmep_alloc() function
> > that takes care of the poisoning, remove page poisoning from the
> > memblock_alloc_*_raw() functions.
> []
> > diff --git a/mm/memblock.c b/mm/memblock.c
> []
> > @@ -1490,18 +1490,12 @@ void * __init memblock_alloc_exact_nid_raw(
> >  			phys_addr_t min_addr, phys_addr_t max_addr,
> >  			int nid)
> >  {
> > -	void *ptr;
> > -
> >  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> >  		     __func__, (u64)size, (u64)align, nid, &min_addr,
> >  		     &max_addr, (void *)_RET_IP_);
> 
> unassociated trivia:
> 
> casting _RET_IP_ back to void * seems odd as the define is
> include/linux/kernel.h:#define _RET_IP_         (unsigned long)__builtin_return_address(0)
> 
> It's probably easier to understand as just __builtin_return_address(0)

Maybe, but I'm not sure it's worth the churn.
 
> > @@ -1528,18 +1522,12 @@ void * __init memblock_alloc_try_nid_raw(
> >  			phys_addr_t min_addr, phys_addr_t max_addr,
> >  			int nid)
> >  {
> > -	void *ptr;
> > -
> >  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> >  		     __func__, (u64)size, (u64)align, nid, &min_addr,
> >  		     &max_addr, (void *)_RET_IP_);
> 
> here too
> 

-- 
Sincerely yours,
Mike.
