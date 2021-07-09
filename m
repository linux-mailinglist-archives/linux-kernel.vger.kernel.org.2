Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367143C28DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGISMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGISMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04C32613E4;
        Fri,  9 Jul 2021 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625854186;
        bh=TqENfX4/Y4XS+LJ0cQtmdQhv2V3wRC2My1Cs65yxTXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQKk/IaskGDyw63vltCrWcYXDZZPObVaR6R250fxYTSwNiAeIlqhOQT07AoaBWBXP
         oJbkY2/oJw6a1DqMOvFhq17faJxKlUZkzGEOzPbb1LIWvJyJzpsJ3QwetvghNZypz8
         GZytA1b/1aYY9Ye5Yny3sGHb0ilszW2JKy0Dp6E15hkrLw6cICAgbu9VQDwRnXYLgy
         1GEbmTu80EcKqXvtU4Pk0yzRSHYuWdE4COv20OgSGR7cgPs7CSrEwgNYmhBS3OO348
         UDUzyBldLZTiqIcsizpX4fLfAOk//ZKWyVWBrVS/Al5D+GSf9mdpAwDbmFkjNerm5K
         m+Ke3SvCj3hmg==
Date:   Fri, 9 Jul 2021 21:09:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Message-ID: <20210709180944.46fr74atwkghmw7a@kernel.org>
References: <20210708181423.1312359-1-tony.luck@intel.com>
 <20210708181423.1312359-2-tony.luck@intel.com>
 <20210709180800.kpjlrvbljaknuncq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709180800.kpjlrvbljaknuncq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 09:08:03PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 08, 2021 at 11:14:20AM -0700, Tony Luck wrote:
> > Memory errors can be reported either synchronously as memory is accessed,
> > or asynchronously by speculative access or by a memory controller page
> > scrubber.  The life cycle of an EPC page takes it through:
> > 	dirty -> free -> in-use -> free.
> > 
> > Memory errors are reported using physical addresses. It is a simple
> > matter to find which sgx_epc_page structure maps a given address.
> > But then recovery code needs to be able to determine the current use of
> > the page to take the appropriate recovery action. Within the "in-use"
> > phase different actions are needed based on how the page is used in
> > the enclave.
> > 
> > Add new flags bits to describe the phase (with an extra bit for the new
> > phase of "poisoned"). Drop pages marked as poisoned instead of adding
> > them to a free list to make sure they are not re-used.
> > 
> > Add a type field to struct epc_page for how an in-use page has been
> > allocated. Re-use "enum sgx_page_type" for this type, with a couple
> > of additions for s/w types.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/sgx.h      |  6 ++++++
> >  arch/x86/kernel/cpu/sgx/encl.c  |  4 ++--
> >  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
> >  arch/x86/kernel/cpu/sgx/main.c  | 21 +++++++++++++++++++--
> >  arch/x86/kernel/cpu/sgx/sgx.h   | 14 ++++++++++++--
> >  arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
> >  6 files changed, 42 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> > index 9c31e0ebc55b..9619a6d77a83 100644
> > --- a/arch/x86/include/asm/sgx.h
> > +++ b/arch/x86/include/asm/sgx.h
> > @@ -216,6 +216,8 @@ struct sgx_pageinfo {
> >   * %SGX_PAGE_TYPE_REG:	a regular page
> >   * %SGX_PAGE_TYPE_VA:	a VA page
> >   * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
> > + *
> > + * Also used to track current use of &struct sgx_epc_page
> >   */
> >  enum sgx_page_type {
> >  	SGX_PAGE_TYPE_SECS,
> > @@ -223,6 +225,10 @@ enum sgx_page_type {
> >  	SGX_PAGE_TYPE_REG,
> >  	SGX_PAGE_TYPE_VA,
> >  	SGX_PAGE_TYPE_TRIM,
> > +
> > +	/* sgx_epc_page.type */
> > +	SGX_PAGE_TYPE_FREE = 100,
> > +	SGX_PAGE_TYPE_KVM = 101,
> >  };
> >  
> >  #define SGX_NR_PAGE_TYPES	5
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 3be203297988..abf6e1a704c0 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -72,7 +72,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
> >  	struct sgx_epc_page *epc_page;
> >  	int ret;
> >  
> > -	epc_page = sgx_alloc_epc_page(encl_page, false);
> > +	epc_page = sgx_alloc_epc_page(encl_page, SGX_PAGE_TYPE_REG, false);
> >  	if (IS_ERR(epc_page))
> >  		return epc_page;
> >  
> > @@ -679,7 +679,7 @@ struct sgx_epc_page *sgx_alloc_va_page(void)
> >  	struct sgx_epc_page *epc_page;
> >  	int ret;
> >  
> > -	epc_page = sgx_alloc_epc_page(NULL, true);
> > +	epc_page = sgx_alloc_epc_page(NULL,  SGX_PAGE_TYPE_VA, true);
> >  	if (IS_ERR(epc_page))
> >  		return ERR_CAST(epc_page);
> >  
> > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> > index 83df20e3e633..a74ae00194cc 100644
> > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > @@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
> >  
> >  	encl->backing = backing;
> >  
> > -	secs_epc = sgx_alloc_epc_page(&encl->secs, true);
> > +	secs_epc = sgx_alloc_epc_page(&encl->secs, SGX_PAGE_TYPE_SECS, true);
> >  	if (IS_ERR(secs_epc)) {
> >  		ret = PTR_ERR(secs_epc);
> >  		goto err_out_backing;
> > @@ -300,7 +300,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
> >  	if (IS_ERR(encl_page))
> >  		return PTR_ERR(encl_page);
> >  
> > -	epc_page = sgx_alloc_epc_page(encl_page, true);
> > +	epc_page = sgx_alloc_epc_page(encl_page, SGX_PAGE_TYPE_REG, true);
> >  	if (IS_ERR(epc_page)) {
> >  		kfree(encl_page);
> >  		return PTR_ERR(epc_page);
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > index 63d3de02bbcc..643df87b3e01 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -401,7 +401,12 @@ static void sgx_reclaim_pages(void)
> >  		section = &sgx_epc_sections[epc_page->section];
> >  		node = section->node;
> >  
> > +		/* drop poison pages instead of adding to free list */
> > +		if (epc_page->flags & SGX_EPC_PAGE_POISON)
> > +			continue;
> > +
> >  		spin_lock(&node->lock);
> > +		epc_page->flags = SGX_EPC_PAGE_FREE;
> >  		list_add_tail(&epc_page->list, &node->free_page_list);
> >  		sgx_nr_free_pages++;
> >  		spin_unlock(&node->lock);
> > @@ -560,6 +565,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
> >  /**
> >   * sgx_alloc_epc_page() - Allocate an EPC page
> >   * @owner:	the owner of the EPC page
> > + * @type:	type of page being allocated
> >   * @reclaim:	reclaim pages if necessary
> >   *
> >   * Iterate through EPC sections and borrow a free EPC page to the caller. When a
> > @@ -574,7 +580,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
> >   *   an EPC page,
> >   *   -errno on error
> >   */
> > -struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
> > +struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_page_type type, bool reclaim)
> >  {
> >  	struct sgx_epc_page *page;
> >  
> > @@ -582,6 +588,8 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
> >  		page = __sgx_alloc_epc_page();
> >  		if (!IS_ERR(page)) {
> >  			page->owner = owner;
> > +			page->type = type;
> > +			page->flags = 0;
> >  			break;
> >  		}
> >  
> > @@ -616,14 +624,22 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
> >   * responsibility to make sure that the page is in uninitialized state. In other
> >   * words, do EREMOVE, EWB or whatever operation is necessary before calling
> >   * this function.
> > + *
> > + * Note that if the page has been tagged as poisoned, it is simply
> > + * dropped on the floor instead of added to the free list to make
> > + * sure we do not re-use it.
> >   */
> >  void sgx_free_epc_page(struct sgx_epc_page *page)
> >  {
> >  	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
> >  	struct sgx_numa_node *node = section->node;
> >  
> > +	if (page->flags & SGX_EPC_PAGE_POISON)
> > +		return;
> 
> I tend to think that it would be nice to collect them somewhere instead
> purposely leaking. E.g. this gives possibility to examine list with
> debugging tools.

I'm not also sure why free and dirty pages need to be tagged. Why a
poison flag is enough? This could be better explained in the commit
message.

