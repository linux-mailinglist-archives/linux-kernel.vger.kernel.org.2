Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7441ADF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhI1Liy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:38:54 -0400
Received: from 8bytes.org ([81.169.241.247]:39894 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240172AbhI1Lix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:38:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4D8C2208; Tue, 28 Sep 2021 13:37:12 +0200 (CEST)
Date:   Tue, 28 Sep 2021 13:37:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
Message-ID: <YVL+YSAZc6JOWTCH@8bytes.org>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903172812.1097643-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:28:03AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain eXtensions Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> +	depends on SECURITY
> +	select X86_X2APIC
> +	select SECURITY_LOCKDOWN_LSM
> +	help
> +	  Provide support for running in a trusted domain on Intel processors
> +	  equipped with Trusted Domain eXtensions. TDX is a new Intel

Nit: the word 'new' in this description will not age well, you should
consider removing it.

Regards,

	Joerg
