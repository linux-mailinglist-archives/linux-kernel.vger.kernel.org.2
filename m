Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFD3DB04F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhG3AeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhG3AeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AD260F21;
        Fri, 30 Jul 2021 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627605238;
        bh=d9GQl5EJTvuOzzjdzsLOUFVFQ1w35Dm5T2hYbZADpB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZHP12hXIfTDhQb+DNrCpfqjU558IuAuyX6JapTF21RYrhHEpxCNnkinkT275hYlv
         BZpLy9/OUkT5vwaB5jvvXhxtk990WKj6ANNtDPaOeVtCqbDvmRLYpg1AmknMjcMsZV
         GfPzhvlyPfb0rrynPV5Z4MNDaEBtMlLT+AVPtf3r/CZgNtSXOZVNNCc8NuyJkZnkQ6
         b03LsyYPADtLbc4WDG9oyxsLpe3d6ZQ75As3NbiXR0NWjzuLtyW1B8UQs4Ol0H21gy
         MFFLutgqIiKmvCQ4cvJ9hde4B3+9ygfNahAG1WR47Ut1LTunDs2YmijbbWo9nsQkb1
         PeA4ClBUpHjvA==
Date:   Fri, 30 Jul 2021 03:33:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Message-ID: <20210730003354.xahfbqnjnkexvxh6@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:12:03PM -0700, Dave Hansen wrote:
> On 7/28/21 1:46 PM, Tony Luck wrote:
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -581,7 +581,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
> >  	for ( ; ; ) {
> >  		page = __sgx_alloc_epc_page();
> >  		if (!IS_ERR(page)) {
> > -			page->owner = owner;
> > +			page->owner = owner ? owner : page;
> >  			break;
> >  		}
> 
> I'm a little worried about this.
> 
> Let's say we get confused about the type of the page and dereference
> page->owner.  If it's NULL, we get a nice oops.  If it's a real, valid
> pointer, we get real valid memory back that we can scribble on.
> 
> Wouldn't it be safer to do something like:
> 
> 	page->owner = owner ? owner : (void *)-1;
> 
> -1 is non-NULL, but also invalid, which makes it harder for us to poke
> ourselves in the eye.

Works for me.

/Jarkko
