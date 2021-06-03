Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1588539A94E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhFCRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhFCRiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:38:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75EE0613D2;
        Thu,  3 Jun 2021 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741779;
        bh=W5VtMzkbAGL0j41NfYq8Dg7iAXlEqGGO4NewsXtht7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iPK/T3Pqk6Ud3zOeZO2V2STEij5Kv6cHY+if/9zgdK3dgdjUz5k+1mThLfEKnYHRL
         0YtT8eTNjn4W17ccWTx8srm84lSjw1oek05zmlNRElWONGOWP3QjeVjNCtRvhJhhV9
         pDSKsClaTySFXXEhF+HxPPLIhuCnbLei0u4DbEkiP4kxhikqZvgY4jnnz9OV8Vz222
         jsndfVGGLW/94vNJ3fhNdabARCpdk3//IAYVdUvk4oIrDlDdMPnnF2qgQi3hScoews
         MRHm/voDR7uHmr1foFUl5MIBxNHA/NgoGDC6gZuZXzMaRoq7RdZEny0T7tCyHxuqI3
         Uma7nmFSkBnzg==
Subject: Re: [RFC PATCH 2/4] x86/entry/nmi: Use normal idtentry macro for NMI
 from userspace
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-3-jiangshanlai@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <9bc8ec45-c87f-ad38-a028-0df50a0c4516@kernel.org>
Date:   Thu, 3 Jun 2021 10:36:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601065217.23540-3-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 11:52 PM, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Before tglx made huge refactor on entry code, high level code is called
> from ASM code including idtentry exit path which might reopen IRQ,
> reschedule, do signal among other works and made normal entry path not
> suitable for userspace NMI entry.  So when the commit 9b6e6a8334d56
> ("x86/nmi/64: Switch stacks on userspace NMI entry") added special code
> for userspace NMI entry, it didn't use normal entry code.
> 
> After the said refactor on entry code, high level code was moved into
> C code, and the idtentry macros are really low level and fit for
> userspace NMI entry after it switches to entry stack, so this
> patch uses idtentry_body macro for NMI from userspace.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 42 ++++++---------------------------------
>  1 file changed, 6 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 4190e668f346..f54e06139d4b 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1113,11 +1113,7 @@ SYM_CODE_START(asm_exc_nmi)
>  	jz	.Lnmi_from_kernel
>  
>  	/*
> -	 * NMI from user mode.  We need to run on the thread stack, but we
> -	 * can't go through the normal entry paths: NMIs are masked, and
> -	 * we don't want to enable interrupts, because then we'll end
> -	 * up in an awkward situation in which IRQs are on but NMIs
> -	 * are off.
> +	 * NMI from user mode.  We need to run on the thread stack.

This comment is IMO still important, but I think you're right that it no
longer matters in the asm.  Could you relocate the comment to the
appropriate place in the C code so that a future cleanup doesn't mess up
the C path?

Thanks,
Andy
