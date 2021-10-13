Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC042BA10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhJMIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhJMIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:20:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE324C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 01:18:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce200e42a3e901495df36.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e200:e42a:3e90:1495:df36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 311391EC0295;
        Wed, 13 Oct 2021 10:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634113099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MaxWKFgeGl9ViNtma+2LibnXupM6dcTqky8zQxSSmI0=;
        b=btNVSxnqrsp5FlBYJIRjdSvrFUitheODBtuCN/GMK2cRxkL9uwOW7Brs1rAtoFjT8EDeiA
        XapajUmwoCtaNKpF/qlu9I77fPy7fQlSzccdGvxQcBrVoUDp1QFosKNF4cppZYntC20d9Z
        /YIIqpT7RvfmWfc+hhVZMiLzmTPhtC4=
Date:   Wed, 13 Oct 2021 10:18:18 +0200
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YWaWSmWn6AZ6OLx+@zn.tnic>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:37:39PM -0700, Kuppuswamy Sathyanarayanan wrote:
> @@ -500,6 +501,14 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  
>  	copy_bootdata(__va(real_mode_data));
>  
> +	/*
> +	 * A future dependency on cmdline parameters is expected (for
> +	 * adding debug options). So the order of calling it should be
> +	 * after copy_bootdata() (in which command line parameter is
> +	 * initialized).
> +	 */

Plain and simple:

        /*
         * Keep this after copy_bootdata() so that TDX cmdline options can take
         * effect.
         */


> +	tdx_early_init();
> +
>  	/*
>  	 * Load microcode early on BSP.
>  	 */
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> new file mode 100644
> index 000000000000..88bf12788684
> --- /dev/null
> +++ b/arch/x86/kernel/tdx.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020 Intel Corporation */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)     "tdx: " fmt
> +
> +#include <asm/tdx.h>
> +
> +bool is_tdx_guest(void)
> +{
> +	static int tdx_guest = -1;

Put that one at the top of the file because such static variables do not
belong among the automatic function vars.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
