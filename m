Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6730E395
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhBCTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhBCTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:51:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:50:24 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84001e2b7e52dd5f0f2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:1e2b:7e52:dd5f:f2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9599A1EC0257;
        Wed,  3 Feb 2021 20:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612381822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N8guk8HFEpl0w+erO6vrJ6FO0v8tWc63A8/S5JJBFRQ=;
        b=B23t0B4fqLjLTHmEI/t3gQerOfhB5fyrHEyy+UCbaTrZZ+PHbqlHzwJ4VzI2uuyaS4Z3fU
        mMkP+35nrlEejNFdFRkKOaa9DALiIAP7ilKEm5FYM384WkdYHdah1bV6ghKnmMfYuZ7ZGo
        lqJjlg73M5j8/RNdkRKb2qtqZyIquvI=
Date:   Wed, 3 Feb 2021 20:50:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/11] x86/fault: Don't run fixups for SMAP violations
Message-ID: <20210203195024.GK13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <416aa53570523f2659edf9e39d553160cb253c5f.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <416aa53570523f2659edf9e39d553160cb253c5f.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:41AM -0800, Andy Lutomirski wrote:
> A SMAP-violating kernel access is not a recoverable condition.  Imagine
> kernel code that, outside of a uaccess region, dereferences a pointer to
> the user range by accident.  If SMAP is on, this will reliably generate
> as an intentional user access.  This makes it easy for bugs to be
> overlooked if code is inadequately tested both with and without SMAP.
> 
> We discovered this because BPF can generate invalid accesses to user
> memory, but those warnings only got printed if SMAP was off.  With this
> patch, this type of error will be discovered with SMAP on as well.
> 
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 04cc98ec2423..d39946ad8a91 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1242,7 +1242,11 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		     !(error_code & X86_PF_USER) &&
>  		     !(regs->flags & X86_EFLAGS_AC)))
>  	{
	^

Might wanna fix that opening brace too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
