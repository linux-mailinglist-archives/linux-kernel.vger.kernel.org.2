Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364CD42C564
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhJMP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:59:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E82C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:57:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f12080010afaa72f664282d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:10af:aa72:f664:282d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F27791EC0577;
        Wed, 13 Oct 2021 17:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634140642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=McFj9BmziWqrQ02/OktCTOH/0kcbVZHKlUFdk2XFnzk=;
        b=diObHOrBjnE17KoeOAQlfV1RJEeD5ttAz+9t8XahNjYcc0C0JnseuzCAwra5mhDccFhjZG
        DdjpEaC7dHYzdGLNz3N1SmQqLl5UACCjaK+ak6XIsN2oBGaBDbLjCOzUr/zNByhOWlAfO0
        uE8YeR8CeIP2LsaeYep0o8f57NoE3Rw=
Date:   Wed, 13 Oct 2021 17:57:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [PATCH v10 04/11] x86/tdx: Add TDX support to
 intel_cc_platform_has()
Message-ID: <YWcB4R3Nn82YYd4D@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:37:40PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index a075b70b9a70..6124527a0423 100644
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
> +	 * Examples include Intel TDX.

It already has "TDX" in the name - no need for "Examples ..."

> +	 */
> +	CC_ATTR_GUEST_TDX,

Yeah, we talked about putting those vendor-specific enums in a block so
that they're all consecutive, so please do

	CC_ATTR_GUEST_TDX	= 0x200

Brijesh already took the 0x100 range for SNP.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
