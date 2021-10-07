Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B791E42598F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbhJGRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbhJGRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:34:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82268C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:32:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1265004099ae2673030416.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:6500:4099:ae26:7303:416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 086A01EC04B9;
        Thu,  7 Oct 2021 19:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633627963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YGcYP1zfWhrMRhm5NbdQtlJR8s9PibrnwvK1f5I30BQ=;
        b=nnnET05zB562mv1HWdbRoxV56lvPyBNXpZ6WCmZhXY5bgZw357a2040goJuGQgk4l5TE6H
        PSZgrUcU4sHJiKzT3yX8YugFht+U9eK3cdEGpobqZn6Ix02TQsaL7Ge8fVeXMIURnbs2xw
        d0N4W6fI5f+4w+wSTr46I8CpJyLdl6o=
Date:   Thu, 7 Oct 2021 19:32:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Message-ID: <YV8vN3SniVshnaHu@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YV8pE+QYcS/fUe98@zn.tnic>
 <9693938e-4171-90ec-1bbe-ee88e6452bd0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9693938e-4171-90ec-1bbe-ee88e6452bd0@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 10:22:16AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Now checking again, I think we don't to initialize the @out pointer. I will
> fix this in call cases.
> 
> But for tdx_get_ve_info() case, we are updating the @ve pointer without
> checking the tdcall return value and __tdx_module_call() will update the
> @out only if tdcall is successful. Currently due to @out=0 initialization,
> this logic does not cause any issue. But to properly fix it, I need to
> check for tdcall return value before updating the @ve value.

Yes, that looked weird too but I assumed since you enforce @out to be
non-NULL, you know that you'll get ve-> populated.

However, yes, you need to check the retval for that other case:

        /* Check for TDCALL success: 0 - Successful, otherwise failed */
        test %rax, %rax
        jnz 1f


> Current use case of tdx_get_ve_info() can never be NULL. But if you
> want to add this check for possible future issues, I can do it.
> 
> arch/x86/kernel/traps.c:1205:	ret = tdx_get_ve_info(&ve);
> arch/x86/kernel/tdx.c:945:	if (tdx_get_ve_info(&ve))

Yes, you want to fail gracefully in the case where someone forgets to
pass in a proper pointer to tdx_get_ve_info() in the future. As it is
now, the guest would simply explode and that is not nice.

Also, that function doesn't need to return an unsigned long if all it
wants to return is a bool, from looking at its call sites.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
