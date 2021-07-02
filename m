Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86303B9A82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhGBB1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhGBB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:27:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19091C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:25:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g24so5434820pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=j6iUe8HIceUkFWNmIAR8GP6qmF3Cqvbw/0ZMAoaDhVk=;
        b=BVJd8KA0TcF1xsUFLwjzboqq8/UqTibUuLCT6ADFWD8uaYRLpnFbPYwNQzB0JtU3fd
         c1selm/jyb47/Ovmnj+qS/V8cQGSQ9VKOGOBLZI9bdH8FY449Swd9w3Y7aMRE38BM6TS
         cKtBEeGMJBzr8naae1D62/WP76was1WgxdQj+qoutP0QaVVDGRkL4Z6/dtbn4uJlFtgZ
         25+oqKJYZlqKSZ++wz9ICI1K2qKYxqg0yrajgx/as4v1qLO1OmLoLs+4R/AWz0oVYwai
         fNQ3v0YJNSQ8dmhmPN7zmHKJqTS+79huaw8tZ9fEC3J6bcXFUr4gdEx6tvjtr2by9yGB
         E2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=j6iUe8HIceUkFWNmIAR8GP6qmF3Cqvbw/0ZMAoaDhVk=;
        b=heoMNRRlUiKEBjejewOorHZRn+zxl/RPvbhDtwp1jtjKLNU+oXWpkpiDbCPXsLl18Q
         V6OTcwWTq/2GRnJIYwGQeaeRG7Zw/DzS8sSiGUho5EHkGBoAhB4b0QWmSi8ek3V42uem
         9NbMZ2D14TfLH0pQfbKZiM97Gb6abaTW/DmkmWzJ40o5cxctvSppFKTkklIWX/xsurEG
         zAWS4TQ3I9eqjlC9HyjU9VjhozwXx3lpDJSbXema21H/YCb8ff7qAZcHijQeqOFI9MYH
         jpPOJ3ny58wICKry82DGxT1IrtimtgRbiK449esMFxdknsQ4JZPPXKmfGAyS1fFSguPJ
         vxPQ==
X-Gm-Message-State: AOAM533N8gloJmF6hKWyxYGrqCLMmutiLGq8YzSAynydNPtBPK8153FY
        kxCpfccOEaJubqpLM4+cEjM=
X-Google-Smtp-Source: ABdhPJz07vEU+x8XcahatpwhI+bYmWSvGSidNX2mrf79YEecOn/xmhTR08mLQr9mGsbQbAEDE2+xbQ==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr2353106pjb.16.1625189111444;
        Thu, 01 Jul 2021 18:25:11 -0700 (PDT)
Received: from localhost ([118.209.250.144])
        by smtp.gmail.com with ESMTPSA id p14sm1259110pgb.2.2021.07.01.18.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:25:11 -0700 (PDT)
Date:   Fri, 02 Jul 2021 11:25:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix lockup on kernel exec fault
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <024bb05105050f704743a0083fe3548702be5706.1625138205.git.christophe.leroy@csgroup.eu>
In-Reply-To: <024bb05105050f704743a0083fe3548702be5706.1625138205.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1625188324.lt6lsizhsx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of July 1, 2021 9:17 pm:
> The powerpc kernel is not prepared to handle exec faults from kernel.
> Especially, the function is_exec_fault() will return 'false' when an
> exec fault is taken by kernel, because the check is based on reading
> current->thread.regs->trap which contains the trap from user.
>=20
> For instance, when provoking a LKDTM EXEC_USERSPACE test,
> current->thread.regs->trap is set to SYSCALL trap (0xc00), and
> the fault taken by the kernel is not seen as an exec fault by
> set_access_flags_filter().
>=20
> Commit d7df2443cd5f ("powerpc/mm: Fix spurrious segfaults on radix
> with autonuma") made it clear and handled it properly. But later on
> commit d3ca587404b3 ("powerpc/mm: Fix reporting of kernel execute
> faults") removed that handling, introducing test based on error_code.
> And here is the problem, because on the 603 all upper bits of SRR1
> get cleared when the TLB instruction miss handler bails out to ISI.

So the problem is 603 doesn't see the DSISR_NOEXEC_OR_G bit?

I don't see the problem with this for 64s, I don't think anything sane
can be done for any 0x400 interrupt in the kernel so it's probably
good to catch all here just in case. For 64s,

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Why is 32s clearing those top bits? And it seems to be setting DSISR
that AFAIKS it does not use. Seems like it would be good to add a
NOEXEC_OR_G bit into SRR1.

Thanks,
Nick


> Until commit cbd7e6ca0210 ("powerpc/fault: Avoid heavy
> search_exception_tables() verification"), an exec fault from kernel
> at a userspace address was indirectly caught by the lack of entry for
> that address in the exception tables. But after that commit the
> kernel mainly rely on KUAP or on core mm handling to catch wrong
> user accesses. Here the access is not wrong, so mm handles it.
> It is a minor fault because PAGE_EXEC is not set,
> set_access_flags_filter() should set PAGE_EXEC and voila.
> But as is_exec_fault() returns false as explained in the begining,
> set_access_flags_filter() bails out without setting PAGE_EXEC flag,
> which leads to a forever minor exec fault.
>=20
> As the kernel is not prepared to handle such exec faults, the thing
> to do is to fire in bad_kernel_fault() for any exec fault taken by
> the kernel, as it was prior to commit d3ca587404b3.
>=20
> Fixes: d3ca587404b3 ("powerpc/mm: Fix reporting of kernel execute faults"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/fault.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 34f641d4a2fe..a8d0ce85d39a 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -199,9 +199,7 @@ static bool bad_kernel_fault(struct pt_regs *regs, un=
signed long error_code,
>  {
>  	int is_exec =3D TRAP(regs) =3D=3D INTERRUPT_INST_STORAGE;
> =20
> -	/* NX faults set DSISR_PROTFAULT on the 8xx, DSISR_NOEXEC_OR_G on other=
s */
> -	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
> -				      DSISR_PROTFAULT))) {
> +	if (is_exec) {
>  		pr_crit_ratelimited("kernel tried to execute %s page (%lx) - exploit a=
ttempt? (uid: %d)\n",
>  				    address >=3D TASK_SIZE ? "exec-protected" : "user",
>  				    address,
> --=20
> 2.25.0
>=20
>=20
