Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C32334BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCJWfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCJWfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:35:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6521864FC3;
        Wed, 10 Mar 2021 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615415740;
        bh=ZgnCH1hQWC6Z4R3JUtthPrDcwUI2uj8mw7mKd5ALw2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uq6JUK86B4S4OSxPsgbaFcpjkXW2py8Zbl+jiPXXv3wukWEV/FmtQUeHWWj/iztfE
         LB65fWlLD42ka4RHzrXEqszaQDliCsrw3WlFqA1uXX9LpNINbgTYErkzYBZrkNyNnf
         QKi7+9w0cY5wKcmpcwgsYipLzx7DSwwMhGKbOI0qOLVnIKCNfNxpBzCVZPHX+Cadu5
         7YX4Ht1bthQq651QcRMVXEFhiuuY4utA6DOENXrHbqn8jY/uQo+aAbHv972uzzdGeQ
         L9AR4spSJRJfcs8gPiWkVmFXxHHS/4U33Jh3fjpzPU7HCubYa+ok2E+YjmNYUXQfRg
         gnfRz/PsKDbpA==
Date:   Thu, 11 Mar 2021 00:35:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86/sgx: Use sgx_free_epc_page() in
 sgx_reclaim_pages()
Message-ID: <YElJpEQ8KLa/HlLD@kernel.org>
References: <20210303150323.433207-1-jarkko@kernel.org>
 <20210303150323.433207-3-jarkko@kernel.org>
 <b223ea92-8b20-def3-7bd0-2cc44474bd78@intel.com>
 <YEjhjhBpYJ6i6EFD@kernel.org>
 <d8e55c583c4d76f3c9e9722e73f35c0618e40623.camel@intel.com>
 <YElD7orORGElfMdZ@kernel.org>
 <YElEQXZlzdrElovv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YElEQXZlzdrElovv@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:12:17AM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 11, 2021 at 12:10:56AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 11, 2021 at 09:36:15AM +1300, Kai Huang wrote:
> > > On Wed, 2021-03-10 at 17:11 +0200, Jarkko Sakkinen wrote:
> > > > On Wed, Mar 03, 2021 at 08:59:17AM -0800, Dave Hansen wrote:
> > > > > On 3/3/21 7:03 AM, Jarkko Sakkinen wrote:
> > > > > > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > > > > > index 52d070fb4c9a..ed99c60024dc 100644
> > > > > > --- a/arch/x86/kernel/cpu/sgx/main.c
> > > > > > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > > > > > @@ -305,7 +305,6 @@ static void sgx_reclaim_pages(void)
> > > > > > �{
> > > > > > �	struct sgx_epc_page *chunk[SGX_NR_TO_SCAN];
> > > > > > �	struct sgx_backing backing[SGX_NR_TO_SCAN];
> > > > > > -	struct sgx_epc_section *section;
> > > > > > �	struct sgx_encl_page *encl_page;
> > > > > > �	struct sgx_epc_page *epc_page;
> > > > > > �	pgoff_t page_index;
> > > > > > @@ -378,11 +377,7 @@ static void sgx_reclaim_pages(void)
> > > > > > �		kref_put(&encl_page->encl->refcount, sgx_encl_release);
> > > > > > �		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> > > > > > �
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -		section = &sgx_epc_sections[epc_page->section];
> > > > > > -		spin_lock(&section->lock);
> > > > > > -		list_add_tail(&epc_page->list, &section->page_list);
> > > > > > -		section->free_cnt++;
> > > > > > -		spin_unlock(&section->lock);
> > > > > > +		sgx_free_epc_page(epc_page);
> > > > > > �	}
> > > > > > �}
> > > > > 
> > > > > In current upstream (3fb6d0e00e), sgx_free_epc_page() calls __eremove().
> > > > > �This code does not call __eremove().  That seems to be changing
> > > > > behavior where none was intended.
> > > > 
> > > > EREMOVE does not matter here, as it doesn't in almost all most of the sites
> > > > where sgx_free_epc_page() is used in the driver. It does nothing to an
> > > > uninitialized pages.
> > > 
> > > Right. EREMOVE on uninitialized pages does nothing, so a more reasonable way is to
> > > just NOT call EREMOVE (your original code), since it is absolutely unnecessary.
> > > 
> > > I don't see ANY reason we should call EREMOVE here. 
> > > 
> > > Actually w/o my patch to split EREMOVE out of sgx_free_epc_page(), it then makes
> > > perfect sense to have new sgx_free_epc_page() here.
> > > 
> > > > 
> > > > The two patches that I posted originally for Kai's series took EREMOVE out
> > > > of sgx_free_epc_page() and put an explicit EREMOVE where it is actually
> > > > needed, but for reasons unknown to me, that change is gone.
> > > > 
> > > 
> > > It's not gone. It goes into a new sgx_encl_free_epc_page(), which is exactly the same
> > > as current sgx_free_epc_page() which as EREMOVE, instead of putting EREMOVE into a
> > > dedicated sgx_reset_epc_page(), as you did in your series:
> > > 
> > > https://lore.kernel.org/linux-sgx/20210113233541.17669-1-jarkko@kernel.org/
> > > 
> > > However, your change has side effort: it always put page back into free pool, even
> > > EREMOVE fails. To make your change w/o having any functional change, it has to be:
> > > 
> > > 	if(!sgx_reset_epc_page())
> > > 		sgx_free_epc_page();
> > 
> > OK, great, your patch set uses the wrapper only in the necessary call
> > sites. Sorry, I overlooked this part.
> > 
> > Anyway, it knowingly does that. I considered either as equally harmful
> > side-ffects when I implemented. Either can only trigger, when there is a
> > bug in the kernel code.
> > 
> > It *could* do what that snippet suggest but it's like "out of the frying pan,
> > into the fire" kind of change.
> > 
> > Since NUMA patch set anyway requires to have a global dirty list, I think
> > the better way to deal with this, would be to declare a new global in the
> > patch under discussion:
> > 
> > static struct list_head sgx_dirty_list;
> 
> sgx_dirty_page_list

Actually, I think it is good as it is now. Please do nothing :-)

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I can continue from that and improve the fallback further. Not perfect, but
good enough.

/Jarkko
