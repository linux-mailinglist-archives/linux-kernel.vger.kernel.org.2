Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8D36BB04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhDZVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhDZVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:10:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA99C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cVSlfk0k5VlI2MdLvWwLCeH5UlzIu3c0n1nTtuqu/9c=; b=czs8OfUPLa0Ojk5hq7aw5m5MVF
        A9rkz7yPQgqikqkdWrD0W/9r/SdmVZxEjKEFCYPtjCzbUc0SfPDzGFK8v11cQU4xOVMOa6h3+cD6y
        TX1cg9bjOFrUAg/vpSVzwTc6K7A2SFzBr2itHoVpQYRs/Yci5veI+RyZGFTg4AGRx+6iJVhh5vL4v
        OfdkcqMUlULwh5rlH15ONTfmYCYpDWcmrQlf3e9eHi2GQzodEjK99d9qPj88KItQKYP0D0n6UANlT
        1lFB+Bb3aPZFd2Jlxyn+tUveh+v36dYDQAov8R5XyIj1s6ceQIhjH29/2vZ5z4kCSDUkyr7z1yAlP
        fy5D0fbQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb8U1-0066GT-C8; Mon, 26 Apr 2021 21:09:35 +0000
Subject: Re: [RFC v2 02/32] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <32870c547c6e143a8f42667c6087ee61dc07e90b.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a4faf7f0-27ab-9d39-a183-a9a696aae061@infradead.org>
Date:   Mon, 26 Apr 2021 14:09:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <32870c547c6e143a8f42667c6087ee61dc07e90b.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> Add INTEL_TDX_GUEST config option to selectively compile
> TDX guest support.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6b4b682af468..932e6d759ba7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -875,6 +875,21 @@ config ACRN_GUEST
>  	  IOT with small footprint and real-time features. More details can be
>  	  found in https://projectacrn.org/.
>  
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain eXtensions Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> +	depends on SECURITY
> +	select PARAVIRT_XL
> +	select X86_X2APIC
> +	select SECURITY_LOCKDOWN_LSM
> +	help
> +	  Provide support for running in a trusted domain on Intel processors
> +	  equipped with Trusted Domain eXtenstions. TDX is an new Intel

	                                                   a new Intel

> +	  technology that extends VMX and Memory Encryption with a new kind of
> +	  virtual machine guest called Trust Domain (TD). A TD is designed to
> +	  run in a CPU mode that protects the confidentiality of TD memory
> +	  contents and the TD’s CPU state from other software, including VMM.
> +
>  endif #HYPERVISOR_GUEST
>  
>  source "arch/x86/Kconfig.cpu"
> 


-- 
~Randy

