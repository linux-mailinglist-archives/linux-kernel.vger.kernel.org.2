Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0958C312784
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 22:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBGVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 16:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBGVR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 16:17:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E91A64E3F;
        Sun,  7 Feb 2021 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612732635;
        bh=5Xyqr8rs0eusH8iyrd6QXcXzQDQTUKI3rFAQ5S8uH5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qv3f2KipmsrnggEw3SsbdauRHtaGR3K71Hz7fTKymieZfqZ69C2uZsVhChO0WF3ZH
         CkuoG8q2BXNZdlvbNdOwFMYJ0/7yq5ftxM/SWKWvfpvph9k/XETWbjU9RRTGpRLScM
         uPRrUpZ5eP1lmd5qsWrQQstzvTAvR381LUHEOVlBqEOqpUnjQQH1V0HWm6DiGfxjS2
         dOzmwLbJyGuRbYFxsPpv0nOHPhnx4vWXhQIcK74ADp5JsHWbJgO6QkX9Opkpaf2PeB
         Z/6+DZV7HMrNQuy+pbI6HHWS1xLEmiXNcp3X57YGsuapFN+6EAOJnz4SjYOmUYCpqs
         n3DQ/tWcOtK5w==
Date:   Sun, 7 Feb 2021 23:17:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jethro Beekman <jethro@fortanix.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v4] x86: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <YCBY02iEKLVyj7Ix@kernel.org>
References: <20210205170030.856723-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205170030.856723-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 09:00:30AM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap is inefficient and we are trying to reduce the usage in the kernel.
> There is no readily apparent reason why initp_page needs to be allocated
> and kmap'ed() but sigstruct needs to be page aligned and token
> 512 byte aligned.
> 
> kmalloc() can give us this alignment but we need to allocate PAGE_SIZE
> bytes to do so.  Rather than change this kmap() to kmap_local_page() use
> kmalloc() instead.
> 
> Remove the alloc_page()/kmap() and replace with kmalloc(PAGE_SIZE, ...)
> to get a page aligned kernel address to use.
> 
> In addition add a comment to document the alignment requirements so that
> others like myself don't attempt to 'fix' this again.
> 
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Jethro Beekman <jethro@fortanix.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
