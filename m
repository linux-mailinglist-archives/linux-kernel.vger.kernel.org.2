Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA438198E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhEOPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhEOPax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD4B3613CD;
        Sat, 15 May 2021 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621092579;
        bh=BcG8mCe9C/Ts+MPHGTEIAQ8DSW/EoqxmARLmaOLsK5Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FtfrvzJuPJiQjaidajh1nzrxEQaELUYoCvIZchLuBnLjpxNYBs++9hhrEpg9w7Zbz
         Uqvkcmh6MtcrWMKlQUC3DxWdwvjmz2YtFe5RAiv6JAZvg9LUYPb9D6XbjFcir00Akg
         UJW/J10lEFE350NSOZkuh38BVT8byEmZ4nBaYovp6H59RTq9JQSIb922yK4FEpuUiy
         c1Pf+bXkQH/y/h8UXBkauOqT8Qm3I25vu+5Gf+fWGAoYJ6nxenw5ZiK6YQ5QAUB38D
         AOUcEa9o/GJd+sTavlxDxNLh2rkrNfV0djxoZW7BjbRBc+e/c1ey461VkDQ0X0uJzJ
         5u74Y1ZCRBbsQ==
Subject: Re: [PATCH v2 5/9] x86/desc: add native_[ig]dt_invalidate() to
 <asm/desc.h>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210515014400.2999028-1-hpa@zytor.com>
 <20210515014400.2999028-6-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b844acb0-bfe6-0987-5a24-a7800b70d5ed@kernel.org>
Date:   Sat, 15 May 2021 08:29:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515014400.2999028-6-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 6:43 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> In some places, we want the native forms of descriptor table
> invalidation. Rather than open-coding them, add explicitly native
> functions to invalidate the GDT and IDT.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/include/asm/desc.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index b8429ae50b71..aa366b2bbc41 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -224,6 +224,21 @@ static inline void store_idt(struct desc_ptr *dtr)
>  	asm volatile("sidt %0":"=m" (*dtr));
>  }
>  
> +static const struct desc_ptr __invalid_gdt_idt_ptr __maybe_unused = {
> +	.address = 0,
> +	.size = 0
> +};

I'm not convinced that putting this in a header is really a great idea.
How about:

> +
> +static inline void native_gdt_invalidate(void)
> +{
        const struct desc_ptr ... = ...;

> +	native_load_gdt(&__invalid_gdt_idt_ptr);
> +}

That should generate two PUSH instructions and may well result in a
smaller binary :)

--Andy
