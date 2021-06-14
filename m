Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40F83A6FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhFNUNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhFNUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:13:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844BC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:11:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09b9000c5f6a5325ce378c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:c5f:6a53:25ce:378c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91EE11EC04DB;
        Mon, 14 Jun 2021 22:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623701481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YLEhCAu033Ko8s2B8FzpAXaxJKlECW6GNIUYVXNIkQE=;
        b=ilceE67y8YnWP+BUuC6TjumeZ636ybrSUu7mJdcsizepjehdRIdcqHmMxehsNTPjOR+FhE
        Ge21GlebDKXLSMToJp3f/hWBf+ieBkyMCwZuo8+mJ9udZN8Sz/Bg00B94Z6DnvU2syKWzs
        z++mawFYn6Syxf5HZbnQ4MIRiA/iKiw=
Date:   Mon, 14 Jun 2021 22:11:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YMe34ptb8CCV7Vg9@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMcXvzD2o7rWsl0W@zn.tnic>
 <b0dff409-d084-bfc1-c260-e1732b5e8ee5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0dff409-d084-bfc1-c260-e1732b5e8ee5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:45:45PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> May be I should define a macro for it and use Mov to keep it uniform
> with other register updates.

Macro?

There's the, well, *MOV* instruction, if you insist on keeping it
uniform. But this is not about keeping it uniform - it is about having
the code as clear as understandable as possible:


	/* Set RAX to TDCALL leaf function 0 */
	xor %eax, %eax

Plain and simple and clear why the XORing is done.

> But, I am fine with passing it via stack, if this is recommended.
> 
> Please let me know.

Yes, please do.

> With the trace support, they should be able to see the flow before making
> the tdx_*_call(). That should be enough clue for debug right?

Are you expecting all those cloud users to trace their guests just to
figure that out? I'm sceptical they will...

Rather, I'd try to allocate a special error value that
do_tdx_hypercall() returns in %eax and then have the wrapper which will
puts %r10 on the stack, check that error value and panic with a nice
error message.

> Ok. I will follow your recommendation. I have done it this way to fix
> checkpatch reports.

Yeah but you should not take checkpatch reports to the letter and use
common sense instead.

> If we need helper functions for other output registers in future, we might
> have to add the suffix.

Btw, where is that function used? Gurgling, it shows it in some MMIO
patch, I'm guessing that's still coming.

As to how to do it properly, you pass in

	struct tdx_hypercall_output *out

as a function parameter and caller can pick out whatever it wants from
that struct.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
