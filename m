Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1B3332C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCJB3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCJB3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:29:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F18C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:29:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c16so7670250ply.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=mqm5GjReFw8SY6mddPr+SiVrrIzZTFQq/5dTlBRN2X8=;
        b=DhGbBceWgzp+vxj5K79waSiCvD8OZbI7JIq1uuWos/OxyLdE7wp1zLMX+uzVVqlV6A
         +0tBDqCZxaOaHrGTJU+zkfaEF+BotALT4/gIFd6kqHJF6Yt2QAMj1Ew4/XBrx5NXxk36
         8NynUE1jmV9AyIdNfJ4cY4VXX6opVSG7iWlj0QGnqYj6UHhX5K6TlcLhArnd0nwU4dY+
         cH8lcvA272qtrtfwLaKE+Hzfi/4U7CT4D4nQJ0G68HkNUkhhmforg1R70VmcMwJpX18t
         yNKKNo1sn5f2KJAy/eAwCGHTWIaE4X5LVbuq1waCqIW8GdxFjcpYW5D2klYgO85OR9Tr
         ORXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=mqm5GjReFw8SY6mddPr+SiVrrIzZTFQq/5dTlBRN2X8=;
        b=D0N2KRbcOlnAyygEinzHkI5EwfbTmv2zMFC+ftfn4g8TmigAjtT7oRfLWfCUCWcvcz
         QCUNMqAzLz40udlY1nK8s+KOxR0zuw2mLJGqcxSzoCfx58FdWbEVNnHHqj05HKDod0Bp
         Tc+NraYbpkjSFFOmGmJC2FmfeaUYf6+9PY/Pi2dHVS5wWJtK0UKHQQT375jL+Lj6dHhV
         MAEfj8JYqDvfr3ZQ718gP9Wx6AZWr8Onl1ElSu0xm7GPah4czzFW7pfit2XOFV5wtb4B
         S5lPpAAHMCobDItmk54aCCiD8it4IbVgdKK0dFWFDcMxN16SB2JMhTyjnvJgPvXzQa6h
         q26A==
X-Gm-Message-State: AOAM532qzQLfn9BTGHEqmnezrfJjnzAaCQjbXWJIVEQysoepCVX+daSa
        rd80LJWZeI3ZyXNb2PNGNH8=
X-Google-Smtp-Source: ABdhPJyqd5/1VOgBtk/ONDQ7gbtd2txT6fiYwn7VFXcj6nI+l/riLFDNeo3AobEPmMWAdK7jL9BSqg==
X-Received: by 2002:a17:90b:809:: with SMTP id bk9mr781935pjb.83.1615339756109;
        Tue, 09 Mar 2021 17:29:16 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s15sm14282344pfe.108.2021.03.09.17.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 17:29:15 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:29:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 28/43] powerpc/64e: Call bad_page_fault() from
 do_page_fault()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
        <b2878184d4c21faa8af55b60e52c83f391272112.1615291473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b2878184d4c21faa8af55b60e52c83f391272112.1615291473.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615339667.i88ve15v8a.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
> book3e/64 is the last one calling __bad_page_fault()
> from assembly.
>=20
> Save non volatile registers before calling do_page_fault()
> and modify do_page_fault() to call __bad_page_fault()
> for all platforms.
>=20
> Then it can be refactored by the call of bad_page_fault()
> which avoids the duplication of the exception table search.

This can go in with the 64e change after your series. I think it should
be ready for the next merge window as well.

Thanks,
Nick

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |  8 +-------
>  arch/powerpc/mm/fault.c              | 17 ++++-------------
>  2 files changed, 5 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/e=
xceptions-64e.S
> index e8eb9992a270..b60f89078a3f 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -1010,15 +1010,9 @@ storage_fault_common:
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	ld	r14,PACA_EXGEN+EX_R14(r13)
>  	ld	r15,PACA_EXGEN+EX_R15(r13)
> +	bl	save_nvgprs
>  	bl	do_page_fault
> -	cmpdi	r3,0
> -	bne-	1f
>  	b	ret_from_except_lite
> -1:	bl	save_nvgprs
> -	mr	r4,r3
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	__bad_page_fault
> -	b	ret_from_except
> =20
>  /*
>   * Alignment exception doesn't fit entirely in the 0x100 bytes so it
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 2e54bac99a22..7bcff3fca110 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -541,24 +541,15 @@ NOKPROBE_SYMBOL(___do_page_fault);
> =20
>  static long __do_page_fault(struct pt_regs *regs)
>  {
> -	const struct exception_table_entry *entry;
>  	long err;
> =20
>  	err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
>  	if (likely(!err))
> -		return err;
> -
> -	entry =3D search_exception_tables(regs->nip);
> -	if (likely(entry)) {
> -		instruction_pointer_set(regs, extable_fixup(entry));
>  		return 0;
> -	} else if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64)) {
> -		__bad_page_fault(regs, err);
> -		return 0;
> -	} else {
> -		/* 32 and 64e handle the bad page fault in asm */
> -		return err;
> -	}
> +
> +	bad_page_fault(regs, err);
> +
> +	return 0;
>  }
>  NOKPROBE_SYMBOL(__do_page_fault);
> =20
> --=20
> 2.25.0
>=20
>=20
