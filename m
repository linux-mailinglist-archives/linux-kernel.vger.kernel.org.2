Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D25331622
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhCHSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:31:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:31:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f05ab0000cbc018bb7305ab.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:ab00:cb:c018:bb73:5ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 402F51EC0473;
        Mon,  8 Mar 2021 19:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615228264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R6Ru9203fpURvzmZRq8yn1riFpTQt60U5lcjEmeWKn0=;
        b=qIptAghnedJcDlkx/F8uwNChFfQEKy4KKBB+5XrfeEuhThKI8g22F1BamxZ83fyPHVx7BX
        oJvtgVXiR88qxGa+hs5ED0PQMY20AkAWQFP4qF9KJN9vVmYqQYRxNHt7L4UqA57BK0gDxx
        1JhtQ+BoV1uLOBTASs1EwTFbeIdf+KM=
Date:   Mon, 8 Mar 2021 19:30:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH v5 11/12] x86/paravirt: switch functions with custom code
 to ALTERNATIVE
Message-ID: <20210308183058.GC12548@zn.tnic>
References: <20210308122844.30488-1-jgross@suse.com>
 <20210308122844.30488-12-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308122844.30488-12-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 01:28:43PM +0100, Juergen Gross wrote:
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 36cd71fa097f..04b3067f31b5 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -137,7 +137,8 @@ static inline void write_cr0(unsigned long x)
>  
>  static inline unsigned long read_cr2(void)
>  {
> -	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
> +	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
> +				"mov %%cr2, %%rax;", ~X86_FEATURE_XENPV);

Just some cursory poking first - indepth review later.

Do I see this correctly that the negated feature can be expressed with, to use
this example here:

	ALTERNATIVE_TERNARY(mmu.read_cr2, X86_FEATURE_XENPV, "", "mov %%cr2, %%rax;");

?

And then you don't need to touch the patching code for ~feature handling
and the flags byte.

If you want it syntactically sugared, you can define a separate
ALTERNATIVE_NOT macro using ALTERNATIVE_TERNARY...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
