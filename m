Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B5B35A98B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhDJAfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:35:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39478C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 17:35:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t140so5091975pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=duQL5fqfdjVk74WsrRNkd3MzfrtB4pdKonpe19giHo4=;
        b=CvYrswaGjt5112kTOORZzJJImgPjCQpHJRK4HbodBvBxX903ZjhYl1vDQF1avo77bI
         Sb8OnlBn2xCxhjxa2eLpS/czyS3FWho+E6ElgYsuFawLl3GpRJj8npCmCUFRCgO1EZzJ
         WeouNbcbGz7XgvEJ1dMqazt9voLkBN13cly9eGd+8LLljrll9JPcihPDkqNK3At9v3jd
         NejEjh5GXCJ7H5Zmp8tv0KZLh5MKWzvQ3LkJPXTo+Y1p54OddbVwEkyznMpN5RvgWZjZ
         6nfVcXaIc26s4mkEIDR6QCOPU8KYSHv22cr4UWLyf0KCS82FTGniaxVq81Gbn2Z/HlIe
         qCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=duQL5fqfdjVk74WsrRNkd3MzfrtB4pdKonpe19giHo4=;
        b=AYCW/RORbeNKjigt2DRb1dcGuGSWiY7/2bzhdP+6rPOID0xYCdP9+k/m++W2Jg6nn1
         5E4029HeMuxV6+Y5ZKjPd+IIZYOfs5lLpGy9CjBki9yCx0sNSnIASuufiXfoquhCGv4P
         K7OG2tKVgyUGKbmpUtW0iexoWul7blbj+V0y1N8MzmQ5je4nOE6hth9qi9FGiCxJkDKu
         LG6Njhf/QM9mP7tgeRNXvTulzr/gAw1OKoJHOBpSUBV1rwPpZU/lXKaEGm9KksLdLvjK
         24kWMgo0HcgvoIdCWEbUdK4/2UulAoM8eWudELfPhgU0zPsfYCeDBZRNIa6oN64nwDf1
         MSig==
X-Gm-Message-State: AOAM532G9mL4tGccQOAD+tqQgRPs1jMB+DJE53KlORQFOGHSiRJbIAkM
        c9GaNw+Pe65el7UTXE8uUus=
X-Google-Smtp-Source: ABdhPJxmp07NcyypcPCMuuArj1lHKGy23+HGQW2ewFOv0L7xOSZKhigQYnktNwYeeouu0QipzYVumg==
X-Received: by 2002:a63:b91b:: with SMTP id z27mr15753090pge.231.1618014928947;
        Fri, 09 Apr 2021 17:35:28 -0700 (PDT)
Received: from localhost (193-116-90-211.tpgi.com.au. [193.116.90.211])
        by smtp.gmail.com with ESMTPSA id n73sm3396388pfd.196.2021.04.09.17.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 17:35:28 -0700 (PDT)
Date:   Sat, 10 Apr 2021 10:35:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4] powerpc/traps: Enhance readability for trap types
To:     aik@ozlabs.ru, akpm@linux-foundation.org, alistair@popple.id.au,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        benh@kernel.crashing.org, christophe.leroy@csgroup.eu,
        haren@linux.ibm.com, jniethe5@gmail.com, john.ogness@linutronix.de,
        kan.liang@linux.intel.com, kjain@linux.ibm.com,
        maddy@linux.ibm.com, mikey@neuling.org, mpe@ellerman.id.au,
        oleg@redhat.com, paulus@samba.org, peterz@infradead.org,
        pmladek@suse.com, ravi.bangoria@linux.ibm.com, rppt@kernel.org,
        Xiongwei Song <sxwjean@me.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210409142832.26063-1-sxwjean@me.com>
In-Reply-To: <20210409142832.26063-1-sxwjean@me.com>
MIME-Version: 1.0
Message-Id: <1618014353.jyyolglj7u.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this, I think it's a nice cleanup and helps
non-powerpc people understand the code a bit better.

Excerpts from Xiongwei Song's message of April 10, 2021 12:28 am:
> From: Xiongwei Song <sxwjean@gmail.com>
>=20
> Create a new header named traps.h, define macros to list ppc interrupt
> types in traps.h, replace the references of the trap hex values with thes=
e
> macros.
>=20
> Referred the hex numbers in arch/powerpc/kernel/exceptions-64e.S,
> arch/powerpc/kernel/exceptions-64s.S and
> arch/powerpc/include/asm/kvm_asm.h.
>=20
> Reported-by: kernel test robot <lkp@intel.com>

It now looks like lkp asked for this whole cleanup patch. I would
put [kernel test robot <lkp@intel.com>] in your v3->4 changelog
item.

> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>=20
> v3-v4:
> Fix compile issue:
> arch/powerpc/kernel/process.c:1473:14: error: 'INTERRUPT_MACHINE_CHECK' u=
ndeclared (first use in this function); did you mean 'TAINT_MACHINE_CHECK'?
> I didn't add "Reported-by: kernel test robot <lkp@intel.com>" here,
> because it's improper for this patch.

[...]

> diff --git a/arch/powerpc/include/asm/traps.h b/arch/powerpc/include/asm/=
traps.h
> new file mode 100644
> index 000000000000..2e64e10afcef
> --- /dev/null
> +++ b/arch/powerpc/include/asm/traps.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PPC_TRAPS_H
> +#define _ASM_PPC_TRAPS_H

These could go in interrupt.h.

> +#if defined(CONFIG_BOOKE) || defined(CONFIG_4xx)
> +#define INTERRUPT_MACHINE_CHECK   0x000
> +#define INTERRUPT_CRITICAL_INPUT  0x100
> +#define INTERRUPT_ALTIVEC_UNAVAIL 0x200
> +#define INTERRUPT_PERFMON         0x260
> +#define INTERRUPT_DOORBELL        0x280
> +#define INTERRUPT_DEBUG           0xd00
> +#else
> +#define INTERRUPT_SYSTEM_RESET    0x100
> +#define INTERRUPT_MACHINE_CHECK   0x200

[...]

> @@ -1469,7 +1470,9 @@ static void __show_regs(struct pt_regs *regs)
>  	trap =3D TRAP(regs);
>  	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
>  		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
> -	if (trap =3D=3D 0x200 || trap =3D=3D 0x300 || trap =3D=3D 0x600) {
> +	if (trap =3D=3D INTERRUPT_MACHINE_CHECK ||
> +	    trap =3D=3D INTERRUPT_DATA_STORAGE ||
> +	    trap =3D=3D INTERRUPT_ALIGNMENT) {
>  		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
>  			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
>  		else

This is now a change in behaviour because previously BOOKE/4xx tested
0x200, but now it tests 0.

That looks wrong for 4xx. 64e does put 0x000 there but I wonder if it=20
should use 0x200 instead. Bit difficult to test this stuff, I do have
some MCE injection patches for QEMU for 64s, might be able to look at
porting them to 64e although I have no idea about booke machine checks.

Anyway I don't think this patch should change generated code at all.
Either change the code first with smaller patches, or make sure you
keep the tests the same.

Thanks,
Nick
