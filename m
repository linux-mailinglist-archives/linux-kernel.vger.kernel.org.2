Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0748342D34F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhJNHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478EFC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:12:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634195577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8/ZKL3qCkam3RdoGxPa61NCBe3o5Hu4qxhl481QQ/M=;
        b=ipF4o0uExc9Rqq+SE/vKFPwl1naCTqnp+HGU0FRWVKaRVYh/WXJPslyRQLYwCo7JLuLg0v
        hR70l+nYTZ4XyzLUeYDYo8odxDf54oqfY37BI4v7CSXV2Ufcdd9qGm1bNUdRM7Vzo/pl5X
        zt8oQO86C5lKw+54itj+gdbBTM5ce3QL4v9syAsapKqBGxtHVoz0ysrgx+EfVVR8useIDm
        UyLhz6sXsnLM6tIXD3dDVuWXrlO35GHdHCp08KD+GFriu1g9LW+BLMvabFY2wGuU5s4XHE
        wJuLpDDXKXrO+4eNog/7REQko3wvACqEW8mVv8CFtdYKPveSwbPkvrZTcTtp3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634195577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8/ZKL3qCkam3RdoGxPa61NCBe3o5Hu4qxhl481QQ/M=;
        b=xJGPePf+dseKSZ1keePo7cT9sautatbPqJyNPmvNykHPQ+2EJ8a9HX0yRFtNgGeoMVdHzL
        5tPhtgiXPufJhuCA==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Subject: Re: [PATCH v10 04/11] x86/tdx: Add TDX support to
 intel_cc_platform_has()
In-Reply-To: <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 09:12:56 +0200
Message-ID: <87tuhk6pvr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>  
> -static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
> +static bool intel_cc_platform_has(enum cc_attr attr)
>  {
>  #ifdef CONFIG_INTEL_TDX_GUEST
> -	return false;
> +	switch (attr) {
> +	case CC_ATTR_GUEST_TDX:
> +		return is_tdx_guest();

This function is only called when is_tdx_guest() is true. So
is_tdx_guest() has to be called again to make sure?

Also the ifdeffery can just go away simply because the compiler will
discard this function when CONFIG_INTEL_TDX_GUEST=n due to:

> +#ifdef CONFIG_INTEL_TDX_GUEST
> +
> +bool is_tdx_guest(void);
> +void __init tdx_early_init(void);
> +
> +#else
> +
> +static inline bool is_tdx_guest(void) { return false; }
> +static inline void tdx_early_init(void) { };
> +
> +#endif /* CONFIG_INTEL_TDX_GUEST */

Thanks,

        tglx
