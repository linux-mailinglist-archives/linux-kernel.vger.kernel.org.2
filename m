Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F030E36E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBCTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhBCTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:40:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01206C06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:39:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84001e2b7e52dd5f0f2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:1e2b:7e52:dd5f:f2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88B1A1EC0258;
        Wed,  3 Feb 2021 20:39:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612381193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qv5Dh7DuwVDnvyl4tcF6oCRho3YBLCJ94rnb64aZIHA=;
        b=OriZ6AgK1L7KbbFlaUxioWxqJNO7TTETXQ8GxUwRWHvLOQviyWBb+pTNkAVoJ3CODOKFdU
        co+Qg7q9q4wRKPMb+sNGsv7cu0fLQTIDD91CmXFp+xNHaoFNKdLTUFMSCeFZq/7tM884Ac
        M5VCx6cp0J6j6dgiRLeke8BoRWK1S2I=
Date:   Wed, 3 Feb 2021 20:39:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to
 kernelmode_fixup_or_oops()
Message-ID: <20210203193949.GI13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:40AM -0800, Andy Lutomirski wrote:
> The name no_context() has never been very clear.  It's only called for
> faults from kernel mode, so rename it and change the no-longer-useful
> user_mode(regs) check to a WARN_ON_ONCE.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 177b612c7f33..04cc98ec2423 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -693,17 +693,10 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  }
>  
>  static noinline void
> -no_context(struct pt_regs *regs, unsigned long error_code,
> -	   unsigned long address, int signal, int si_code)
> +kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
> +			 unsigned long address, int signal, int si_code)

Ew, I don't like functions with "or" in the name - they're probably not
doing one thing only as they should.

Why not simply "handle_kernel_fault" ?

Also, all the callsites now do:

	if (!user_mode(regs)) {
		kernelmode_fixup_or_oops
		...

I guess you can push the "user_mode" check inside that function for less
hairy code at the callsites.

>  {
> -	if (user_mode(regs)) {
> -		/*
> -		 * This is an implicit supervisor-mode access from user
> -		 * mode.  Bypass all the kernel-mode recovery code and just
> -		 * OOPS.
> -		 */
> -		goto oops;
> -	}
> +	WARN_ON_ONCE(user_mode(regs));

I guess...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
