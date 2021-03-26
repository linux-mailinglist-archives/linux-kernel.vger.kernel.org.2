Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03034AF7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCZTqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCZTpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:45:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7C05619C7;
        Fri, 26 Mar 2021 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616787954;
        bh=ZTDhus6muL1m6rBYPHTfl1mHLrPDAxL3zd4m78f4VF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDKADaIVj6lm9xgwj12JdNAz7sXs8A6z6taZmu2Xqfqqn8shKYW/8CT2Qjskiehi6
         qYbFKtl86ZtxJk1/tvsWMnIU2e86EfqTdywutPq61w7QJ4tU8VoyH+eQp62Pz9RgT1
         OvxMNfXMf0xgdkLRbdcBYNBKiuEwrEGKQRp/1l9c4veZAJd75e33n7zu3lsmeO3cJ8
         FoMMme7VDYQn8gpROOl3YCHWDz55J0NqWuP+6AXJa/lVOS9PFbxmwqCnFYT+Fb8A57
         SUmMJPhLioZGkLCfulhYxhZBGGqVkLTambNDZBq/7IdPeY285nxZXYVP4FfwFkWNDt
         F2uOwAddfYBQQ==
Date:   Fri, 26 Mar 2021 21:45:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Sean Christopherson <seanjc@google.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <YF451PGNd8x/i56z@kernel.org>
References: <20210324182246.2484875-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324182246.2484875-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:22:46AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap is inefficient and is being replaced by kmap_local_page(), if
> possible.

Nit: just saying that something is inefficient is not enough. Always
should have something to back it up.

> That said, there is no readily apparent reason why initp_page needs to
> be allocated and kmap'ed() except that 'sigstruct' needs to be page
> aligned and 'token' 512 byte aligned.
> 
> Rather than change this kmap() to kmap_local_page() use kmalloc()
> instead because kmalloc() can gives this alignment when allocating
> PAGE_SIZE bytes.
> 
> Remove the alloc_page()/kmap() and replace with kmalloc(PAGE_SIZE, ...)
> to get a page aligned kernel address.
> 
> In addition add a comment to document the alignment requirements so that
> others don't attempt to 'fix' this again.

I'm a bit confused based on this commit message. Why is kmap_local_page()
better, and why kmalloc() is the ultimate choice of all three options?

> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Jethro Beekman <jethro@fortanix.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
 
/Jarkko
