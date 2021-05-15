Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F53381B02
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhEOUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:38:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37244 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233286AbhEOUiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:38:03 -0400
Received: from zn.tnic (p200300ec2f1e9400519c4c3da1ce0d62.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:9400:519c:4c3d:a1ce:d62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C665B1EC0409;
        Sat, 15 May 2021 22:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621111008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JcqP0OeNjgBhhon0AQdW6vw7fHTq3bBpv6lDo9wrXmQ=;
        b=Ye6npR94RCuW1sMBE4SLhIq0ESd6OlN6Yst2vn+X2zpMokVgwBCg7OS/LFJmJjZ0BIxQl6
        jm7mXCcY2FVrVSkGhpKrUC0WuZhffXivoIy+GUm2yWL9N55qaBFkFSe5VSQyDshfugPYcx
        qEJ5xETINNQvfx0LuqU3CERrTOdnzwU=
Date:   Sat, 15 May 2021 22:36:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     peterz@infradead.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] x86/kernel: Fix unchecked return value
Message-ID: <YKAw3Yl8c6nU1zng@zn.tnic>
References: <20210515202212.24836-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210515202212.24836-1-khaledromdhani216@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 09:22:12PM +0100, Khaled ROMDHANI wrote:
> From the coverity scan analysis, the return value from
> insn_decode_kernel is not checked. It is a macro constructed
> from the insn_decode function which may fail and return
> negative integer. Fix this by explicitly checking the
> return value.
> 
> Addresses-Coverity: ("Unchecked return value")
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---
>  arch/x86/kernel/jump_label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index a762dc1c615e..bf0ea003b6e7 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -23,7 +23,7 @@ int arch_jump_entry_size(struct jump_entry *entry)
>  {
>  	struct insn insn = {};
>  
> -	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
> +	WARN_ON(insn_decode_kernel(&insn, (void *)jump_entry_code(entry)));

I don't think coverity is smart enough to notice...

>  	BUG_ON(insn.length != 2 && insn.length != 5);
	^^^^^^^^^^^^^

... this line.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
