Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4785543C144
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhJ0E0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhJ0E0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:26:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07812C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:23:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v1-20020a17090a088100b001a21156830bso4100000pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Ul79m/M1HnPNYtc1PDlNeFGvkwGm8q9L++VHfOLlPQo=;
        b=hvkT3zgVsdaXITUAj/SHNqsk6b2ykzu8zCNZSa582mw2xlpWGrCCEnqudMvBK62WF/
         66Nli4Ca2KEWEEp5IzyqTM4uM/zKotYwneHNjVREkOVVnMVWR/toZB7GM3bGuMGpnj45
         NsYKBXinzxnQphPmjGffTj6/19cWrOg1+Mo/6P3j8YVxOTVKcd47YVQIX+y/Z+Lt8xIO
         v5Wlvj2PB0qGkKKLyREH0K+vMAPU7IhjNlzW1IRO85VgHP5zu64TumKzoUmtUQ429J5A
         oTj/UEmGvw4ZjNQhRsyBHT0ZK+n3DwKXQV7mc08qMKg4hOtRN4GHIHRMc74BNNrW8tBs
         rUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Ul79m/M1HnPNYtc1PDlNeFGvkwGm8q9L++VHfOLlPQo=;
        b=sa5q/Al4iMexvSSsq3/IHiK0X9OjTqpbPi7W4uab05y7ZzIU59o4qUqtMmshyhBkft
         1hKo4tvCy7OAsVXUZJlAMCAujGj999uLFxm8IN1kjr2qk90ObMSNNRFSl3VxaWh3V8SM
         C5oMYl+ynOG3sVryg/WzYOh1Km17fHCdRPK2zDK/2ixjAyQBjIluJDMOazNhX59xhBiV
         pA5TitvEK/hCtm2LLTVSFGuGcAmkTmRnJJmTf71eFzfiXTQZAaKX4Su16by/iRH/p9P3
         2jKD0BNuhFr6zFd/TYs1iPibH1joV7W03HUz2TlLVReGHktB4lpuIF/jJo4a2jEfk3Nj
         RIfw==
X-Gm-Message-State: AOAM532sr93OvPBKI/sC5b60ez1DjDEGI5gAzCXFEK4ADoS9R7J9Olw0
        xm9STAqCJIrMFZLvnjx7ABc=
X-Google-Smtp-Source: ABdhPJxpvRtQI7yeOQF4rsiQq+b8i4vacZR4d+WonEWc+QGL2QkDqCfwsUop3NlUEzAw5ELyxi21fg==
X-Received: by 2002:a17:902:758c:b0:141:4c99:22b3 with SMTP id j12-20020a170902758c00b001414c9922b3mr8967343pll.40.1635308628373;
        Tue, 26 Oct 2021 21:23:48 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id 8sm2251659pjt.46.2021.10.26.21.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:23:47 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:23:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/nohash: Fix __ptep_set_access_flags() and
 ptep_set_wrprotect()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
In-Reply-To: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1635308538.6vye6lbbh8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of October 26, 2021 3:39 pm:
> Commit 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> changed those two functions to use pte helpers to determine which
> bits to clear and which bits to set.
>=20
> This change was based on the assumption that bits to be set/cleared
> are always the same and can be determined by applying the pte
> manipulation helpers on __pte(0).
>=20
> But on platforms like book3e, the bits depend on whether the page
> is a user page or not.
>=20
> For the time being it more or less works because of _PAGE_EXEC being
> used for user pages only and exec right being set at all time on
> kernel page. But following patch will clean that and output of
> pte_mkexec() will depend on the page being a user or kernel page.
>=20
> Instead of trying to make an even more complicated helper where bits
> would become dependent on the final pte value, come back to a more
> static situation like before commit 26973fa5ac0e ("powerpc/mm: use
> pte helpers in generic code"), by introducing an 8xx specific
> version of __ptep_set_access_flags() and ptep_set_wrprotect().

What is this actually fixing? Does it change anything itself, or
just a preparation patch?

Thanks,
Nick

>=20
> Fixes: 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v3: No change
> v2: New
> ---
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 17 +++++++--------
>  arch/powerpc/include/asm/nohash/32/pte-8xx.h | 22 ++++++++++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/=
include/asm/nohash/32/pgtable.h
> index 34ce50da1850..11c6849f7864 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -306,30 +306,29 @@ static inline pte_t ptep_get_and_clear(struct mm_st=
ruct *mm, unsigned long addr,
>  }
> =20
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
> +#ifndef ptep_set_wrprotect
>  static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned lon=
g addr,
>  				      pte_t *ptep)
>  {
> -	unsigned long clr =3D ~pte_val(pte_wrprotect(__pte(~0)));
> -	unsigned long set =3D pte_val(pte_wrprotect(__pte(0)));
> -
> -	pte_update(mm, addr, ptep, clr, set, 0);
> +	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
>  }
> +#endif
> =20
> +#ifndef __ptep_set_access_flags
>  static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>  					   pte_t *ptep, pte_t entry,
>  					   unsigned long address,
>  					   int psize)
>  {
> -	pte_t pte_set =3D pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(=
0)))));
> -	pte_t pte_clr =3D pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(=
~0)))));
> -	unsigned long set =3D pte_val(entry) & pte_val(pte_set);
> -	unsigned long clr =3D ~pte_val(entry) & ~pte_val(pte_clr);
> +	unsigned long set =3D pte_val(entry) &
> +			    (_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
>  	int huge =3D psize > mmu_virtual_psize ? 1 : 0;
> =20
> -	pte_update(vma->vm_mm, address, ptep, clr, set, huge);
> +	pte_update(vma->vm_mm, address, ptep, 0, set, huge);
> =20
>  	flush_tlb_page(vma, address);
>  }
> +#endif
> =20
>  static inline int pte_young(pte_t pte)
>  {
> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/=
include/asm/nohash/32/pte-8xx.h
> index fcc48d590d88..1a89ebdc3acc 100644
> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
> @@ -136,6 +136,28 @@ static inline pte_t pte_mkhuge(pte_t pte)
> =20
>  #define pte_mkhuge pte_mkhuge
> =20
> +static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long=
 addr, pte_t *p,
> +				     unsigned long clr, unsigned long set, int huge);
> +
> +static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned lon=
g addr, pte_t *ptep)
> +{
> +	pte_update(mm, addr, ptep, 0, _PAGE_RO, 0);
> +}
> +#define ptep_set_wrprotect ptep_set_wrprotect
> +
> +static inline void __ptep_set_access_flags(struct vm_area_struct *vma, p=
te_t *ptep,
> +					   pte_t entry, unsigned long address, int psize)
> +{
> +	unsigned long set =3D pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED | =
_PAGE_EXEC);
> +	unsigned long clr =3D ~pte_val(entry) & _PAGE_RO;
> +	int huge =3D psize > mmu_virtual_psize ? 1 : 0;
> +
> +	pte_update(vma->vm_mm, address, ptep, clr, set, huge);
> +
> +	flush_tlb_page(vma, address);
> +}
> +#define __ptep_set_access_flags __ptep_set_access_flags
> +
>  static inline unsigned long pgd_leaf_size(pgd_t pgd)
>  {
>  	if (pgd_val(pgd) & _PMD_PAGE_8M)
> --=20
> 2.31.1
>=20
>=20
