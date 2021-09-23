Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1526415C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbhIWKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbhIWKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:38:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:36:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6800cf632848c722fe0b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:cf63:2848:c722:fe0b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E510D1EC0372;
        Thu, 23 Sep 2021 12:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632393406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lQM5wB25lDMMDo0IZxemDXSvYL4h52fkdvk6t5RH75w=;
        b=e2sgha3Wc+2qSpZAVRtT40mlaJ3mCb7MzYYwrKZLrxWOtXgSXY15w7R0xCZIbHSwX3/OUe
        leAcorKJguAVi1nzCohYZdW+HuEhtuPCDf1znxtj4nkz3k4e24lXfLt/c5GDLoFWjO93W6
        9xQ3drrDLvvw2XXCqT2wxpLv1IL1fMk=
Date:   Thu, 23 Sep 2021 12:36:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/12] x86/tdx: Add TDX guest support to
 intel_cc_platform_has()
Message-ID: <YUxYuDyKBjvnfn7T@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916183550.15349-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:43AM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index 253f3ea66cd8..e38430e6e396 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -61,6 +61,15 @@ enum cc_attr {
>  	 * Examples include SEV-ES.
>  	 */
>  	CC_ATTR_GUEST_STATE_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
> +	 *
> +	 * The platform/OS is running as a TDX guest/virtual machine.
> +	 *
> +	 * Examples include SEV-ES.
			    ^^^^^^^

Copy/paste huh? :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
