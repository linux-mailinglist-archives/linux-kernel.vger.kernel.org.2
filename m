Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19F541E947
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352432AbhJAI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:59:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhJAI7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:59:47 -0400
Received: from zn.tnic (p200300ec2f0e8e00572b4e04e961fee2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:572b:4e04:e961:fee2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FF1A1EC04F3;
        Fri,  1 Oct 2021 10:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633078682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cCn6ZMYQ9cKRpFK4Mmh1ozo2bAFBofEhqz4IBQINPzg=;
        b=UOGtEWcY/i9uWsfbMmPUZsyrRZtr/1l4pllMa1qYXYROUsjkq3q4JqC2py9gaSq0Ynl9aM
        s+8GmKhIoMqHE1nwcIOKoKQZlN8q3anZ5EeDI8MQq23/ZpSlyzEP213VgdNS95ZVDntEYf
        pDbmo5EraFy9xSylY62J2Aw39lJfvHs=
Date:   Fri, 1 Oct 2021 10:57:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVbNlXwiASQEsG+x@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:40:50PM -0500, Tom Lendacky wrote:
> The size of the exception stacks was recently increased, resulting in
> stack sizes greater than a page in size. The #VC exception handling was
> only mapping the first (bottom) page, resulting in an SEV-ES guest failing
> to boot.
> 
> Update setup_vc_stacks() to map all the pages of both the IST stack area
> and the fallback stack area.
> 
> Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/sev.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a6895e440bc3..33e4704164cc 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -99,25 +99,33 @@ DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
>  /* Needed in vc_early_forward_exception */
>  void do_early_exception(struct pt_regs *regs, int trapnr);
>  
> +static void __init map_vc_stack(unsigned long bot, unsigned long top,
> +				phys_addr_t pa)
> +{
> +	while (bot < top) {
> +		cea_set_pte((void *)bot, pa, PAGE_KERNEL);
> +		bot += PAGE_SIZE;
> +		pa += PAGE_SIZE;
> +	}
> +}
> +
>  static void __init setup_vc_stacks(int cpu)
>  {
>  	struct sev_es_runtime_data *data;
>  	struct cpu_entry_area *cea;
> -	unsigned long vaddr;
> -	phys_addr_t pa;
>  
>  	data = per_cpu(runtime_data, cpu);
>  	cea  = get_cpu_entry_area(cpu);
>  
>  	/* Map #VC IST stack */
> -	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
> -	pa    = __pa(data->ist_stack);
> -	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
> +	map_vc_stack(CEA_ESTACK_BOT(&cea->estacks, VC),
> +		     CEA_ESTACK_TOP(&cea->estacks, VC),
> +		     __pa(data->ist_stack));

So this would not have broken if it would've used EXCEPTION_STKSZ or
EXCEPTION_STACK_ORDER rather since we're mapping pages.

Please use those defines so that this keeps working when someone mad
decides to increase those exception stack sizes again because everything
*and* the kitchen sink wants to instrument the damn kernel. Nothing to
see here people...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
