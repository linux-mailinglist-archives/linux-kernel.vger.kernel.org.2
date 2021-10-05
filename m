Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0283421DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 06:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhJEEtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 00:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEEtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:49:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CADC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=PhbjEGM2n1Fc82VkHwTU+uA5vUT19ZB/Op/qghm6Xsc=; b=I6itD9q01fvJJt6IfSbshaZPne
        fQ3dGyoUfKiawkdRty5NQMZgvqZ8ON3zaunInA/iMEVL5yxzCbszmvbOI0zwAmxVcIHk1nuNTukuP
        9HspbH9KCePEDSLfQdcHj499WgqoFuTegA44ueZF6yt8y5JlAnHcev+m+Gmno9EljFUwCrupLD1U/
        SntgDkIEHa0aPe+2aNKlCtb74/4iuDMbZJ7xVsjUB3h0qwzL/G8tynTosabc7eYFUEaswdCaXLmKc
        9xoCtCdfn+PeIx8qjBUEKZj1r6ZYBkJ/i7fO5hy0Gkz63jZRB2hDpNdHo9ynar5L9NIyfuWOdd8xX
        yVbnjf9g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXcMK-008udL-JI; Tue, 05 Oct 2021 04:47:20 +0000
Subject: Re: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50eaabfc-50b2-7617-ed9f-61f61b619cd8@infradead.org>
Date:   Mon, 4 Oct 2021 21:47:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 7:51 PM, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c42dd8a2d1f4..abb249dc829d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
>   	depends on SECURITY
>   	select X86_X2APIC
>   	select SECURITY_LOCKDOWN_LSM
> +	select ARCH_HAS_CC_PLATFORM

Where is ARCH_HAS_CC_PLATFORM defined, please?
I can't seem to find it.

>   	help
>   	  Provide support for running in a trusted domain on Intel processors
>   	  equipped with Trusted Domain eXtensions. TDX is a Intel technology


thanks.
-- 
~Randy
