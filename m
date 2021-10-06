Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75642427C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhJFQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhJFQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:22:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC30C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:20:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d3600bdb6aa8687ce684e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:bdb6:aa86:87ce:684e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AB881EC03FE;
        Wed,  6 Oct 2021 18:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633537246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1xddPaZ1UE7THsd1YqIakKfcdzE8fDpzy5AsfG2miN4=;
        b=QLWmuk0sdHDEvg0dsydydUF1AtPZ3u7XXbFpiRqFIAnspA+EdtJ5Ld/Bb2jN1MwG8rkBkD
        HhDaO3QAc6X/p4ioCRW98ueERjbzmZs8l+TVt0ijXuVj3a5cQ7yqEis3nbKxsXGSKQMXhW
        VEqxddiZc8nTYsEcVlwQIzcwLzzSqm0=
Date:   Wed, 6 Oct 2021 18:20:41 +0200
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
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YV3M2cqqMTkC/rUK@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YV3AKekdJU0vsbaN@zn.tnic>
 <328cc0e7-89e7-a1b2-f798-fe758c2c1f4e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <328cc0e7-89e7-a1b2-f798-fe758c2c1f4e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:43:48AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Yes. But, Joerg Roedel in his review recommended using variable
> similar to sme_me_mask to avoid function call in Intel platform in
> cc_platform_has().

That would normally make sense if this were a fast path. But I don't see
that being one. Besides, the subsequent runs will be the function call +
a couple of instructions:

# arch/x86/kernel/tdx.c:22: 	if (tdx_guest >= 0)
	movl	tdx_guest(%rip), %eax	# tdx_guest,
	testl	%eax, %eax	#
	jns	.L11	#,

...

.L11:
# arch/x86/kernel/tdx.c:23: 		return tdx_guest;
	setne	%al	#, <retval>
# arch/x86/kernel/tdx.c:35: }
	ret

which is not the end of the world.

And it if it is really used in a fast path, then we can do a static
branch etc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
