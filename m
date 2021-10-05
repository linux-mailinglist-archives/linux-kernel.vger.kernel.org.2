Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4C421DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJEEzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 00:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhJEEzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:55:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8CAC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 21:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=mPGehtmO6oZa/oMqwX4rwVEex96j3B66VMFMwI+/DB4=; b=2Ma939YRgwDKlrrFK+2Wz9SZZh
        wBGSduWyUa+ars1iYiuPlL4KMdZO2lOxxPVpKzu6qrdOTlREugK7yebe0Vy5og2eidVLm5x5DMaDJ
        GAIQ2qw9bnTShkallz3Ef+VHKr6IM0cGBLrYYk3hExpewGAqcgIaRSnhYpApvgR1kHtMlVwmD809F
        jMur3zHu+RUBdc1hgySa5olFgYuNyF0L5rFQKN8UYZ9RosOI7bjpufWGEwEjWOfgbGJrvdwn9vq8b
        qPyY0Z9/rgvqBoa2G9oORRJlJly/x48pll7+zzr2tGiBvLK84xHntOX+kQoKJk1hPFr3R3G50bq6B
        1EV3YDZw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXcRr-008v4i-0D; Tue, 05 Oct 2021 04:53:03 +0000
Subject: Re: [PATCH v8 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
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
 <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf33750f-615a-1edd-0fee-28e720bb38ce@infradead.org>
Date:   Mon, 4 Oct 2021 21:53:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005025205.1784480-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 7:51 PM, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2b2a9639d8ae..c42dd8a2d1f4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -865,6 +865,20 @@ config ACRN_GUEST
>   	  IOT with small footprint and real-time features. More details can be
>   	  found inhttps://projectacrn.org/.
>   
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain eXtensions Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> +	depends on SECURITY
> +	select X86_X2APIC

Apparently some Intel CPUs don't have the x2apic feature, since the
Kconfig help text for X86_X2APIC says:

	  This enables x2apic support on CPUs that have this feature.

so how is it safe to set/enable/select that kconfig symbol?

Will the x2apic code just safely not work if the h/w feature is
missing?

> +	select SECURITY_LOCKDOWN_LSM
> +	help
> +	  Provide support for running in a trusted domain on Intel processors
> +	  equipped with Trusted Domain eXtensions. TDX is a Intel technology
> +	  that extends VMX and Memory Encryption with a new kind of virtual
> +	  machine guest called Trust Domain (TD). A TD is designed to run in
> +	  a CPU mode that protects the confidentiality of TD memory contents
> +	  and the TD’s CPU state from other software, including VMM.


thanks.
-- 
~Randy
