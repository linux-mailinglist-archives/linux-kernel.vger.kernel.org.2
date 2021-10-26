Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD143B87A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhJZRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhJZRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:46:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E77C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:44:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s24so123174plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kXRXS8Y6TbgPFlvpdFdUOZ/XrEjgtr0lNIGMPXzFPQM=;
        b=LzGqEyDvC7gPkF2MEXReZdkjI3Zj8Qc/uVx65GGc+qFI+SbU8ptu06Jrs0j+ZcsYMa
         ZBfDK/b/wxHTPgY2neme4toglimWMBTL8JzAECboOHJSvR1VcfIh3QXOldFEaYY4uNCv
         O55nN3ChgSAREx0nLlR7Y1A0re8iaxknP/d0Jiocir8qbXFFyKC/RJIKm7bnAhGfcYWR
         PBteDTtQlKyUmbLGU+cgGExdlVFFlQ6MDFBmPGYE9eG8L2UK/m0SEhuehm/Gmmbh89Bx
         XrQHfqZRi7Ofs/N1u5m3ffHmFHRiiDa3ygR3YwVLUyQLLA2W2oT4ujVMRVqYAKVoBOS+
         owEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kXRXS8Y6TbgPFlvpdFdUOZ/XrEjgtr0lNIGMPXzFPQM=;
        b=eJoTzg+mJQNT+4Owz7tdeIJ4Cs/AQG3s6Q+OEDQWILkhYaIoXqu24UDMMfYIsOQwmC
         PqbA0rYycuJiZ0B+uwQV3rZC5bEJUAkKy12DewY44ZeAc3uAmv7qdtrpPRWkQ2fAeF+6
         QaJCElmW+SpIjeGz9+GXOoaz0JI2n0yER+/b1wkJe71khzR4nQqKHY6Dv/NytNzvoed6
         TP2v6dSl7IFTiVZ1z+Cj/VZf0RYaA9QPb1j1UFvm1AhsRyi1ZHrRBu+7dXZG4Wnu45XK
         0NQVFMTrCFs5FCy2A21VCTElbfyl9dNZ0VgqGWzsoi1J8W2/wwge6hUQjCCT/274Sl7G
         ci9Q==
X-Gm-Message-State: AOAM531V7cHcVrw97op4KDS0MkCKJY7sPeQYlotayjEkE7hivdYHuPU0
        IVXokV5fyTjgNvVqhlftncrYq2NeKr7IiQ==
X-Google-Smtp-Source: ABdhPJzkWColX6WDq9s+VEMYbSV4sVULqSFenGNLcBIbjrJZFvs5uzvhB4Am6FP1R/ct/8d5n7YBqQ==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr191780pjb.12.1635270257465;
        Tue, 26 Oct 2021 10:44:17 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id nn14sm1499045pjb.27.2021.10.26.10.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:44:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
Date:   Tue, 26 Oct 2021 10:44:15 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29E7E8A4-C400-40A5-ACEC-F15C976DDEE0@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
 <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
To:     Nadav Amit <namit@vmware.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2021, at 9:47 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
>=20
>=20
>> On Oct 26, 2021, at 9:06 AM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>>=20
>> On 10/21/21 5:21 AM, Nadav Amit wrote:
>>> The first TLB flush is only necessary to prevent the dirty bit (and =
with
>>> a lesser importance the access bit) from changing while the PTE is
>>> modified. However, this is not necessary as the x86 CPUs set the
>>> dirty-bit atomically with an additional check that the PTE is =
(still)
>>> present. One caveat is Intel's Knights Landing that has a bug and =
does
>>> not do so.
>>=20
>> First, did I miss the check in this patch for X86_BUG_PTE_LEAK?  I =
don't
>> see it anywhere.
>=20
> No, it is me who missed it. It should have been in =
pmdp_invalidate_ad():
>=20
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3481b35cb4ec..f14f64cc17b5 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -780,6 +780,30 @@ int pmd_clear_huge(pmd_t *pmd)
> 	return 0;
> }
>=20
> +/*
> + * pmdp_invalidate_ad() - prevents the access and dirty bits from =
being further
> + * updated by the CPU.
> + *
> + * Returns the original PTE.
> + *
> + * During an access to a page, x86 CPUs set the dirty and access bit =
atomically
> + * with an additional check of the present-bit. Therefore, it is =
possible to
> + * avoid the TLB flush if we change the PTE atomically, as =
pmdp_establish does.
> + *
> + * We do not make this optimization on certain CPUs that has a bug =
that violates
> + * this behavior (specifically Knights Landing).
> + */
> +pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long =
address,
> +			 pmd_t *pmdp)
> +{
> +	pmd_t old =3D pmdp_establish(vma, address, pmdp, =
pmd_mkinvalid(*pmdp));
> +
> +	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
> +		flush_pmd_tlb_range(vma, address, address + =
HPAGE_PMD_SIZE);
> +	return old;
> +}
>=20
>>=20
>>> -	 * pmdp_invalidate() is required to make sure we don't miss
>>> -	 * dirty/young flags set by hardware.
>>=20
>> This got me thinking...  In here:
>>=20
>>> =
https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.k=
ernel.org%2Flkml%2F20160708001909.FB2443E2%40viggo.jf.intel.com%2F&amp;dat=
a=3D04%7C01%7Cnamit%40vmware.com%7Cf6a2a69eec094b12638108d9989afb60%7Cb391=
38ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637708613735772213%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C1000&amp;sdata=3Do8fYbm8BKHvWxYC9aO5e3MFLkaOnQxvDMy%2BEnYxz56I%3D&amp;r=
eserved=3D0
>>=20
>> I wrote:
>>=20
>>> These bits are truly "stray".  In the case of the Dirty bit, the
>>> thread associated with the stray set was *not* allowed to write to
>>> the page.  This means that we do not have to launder the bit(s); we
>>> can simply ignore them.
>>=20
>> Is the goal of your proposed patch here to ensure that the dirty bit =
is
>> not set at *all*?  Or, is it to ensure that a dirty bit which we need =
to
>> *launder* is never set?
>=20
> At *all*.
>=20
> Err=E2=80=A6 I remembered from our previous discussions that the dirty =
bit cannot
> be set once the R/W bit is cleared atomically. But going back to the =
SDM,
> I see the (relatively new?) note:
>=20
> "If software on one logical processor writes to a page while software =
on
> another logical processor concurrently clears the R/W flag in the
> paging-structure entry that maps the page, execution on some =
processors may
> result in the entry=E2=80=99s dirty flag being set (due to the write =
on the first
> logical processor) and the entry=E2=80=99s R/W flag being clear (due =
to the update
> to the entry on the second logical processor). This will never occur =
on a
> processor that supports control-flow enforcement technology (CET)=E2=80=9D=

>=20
> So I guess that this optimization can only be enabled when CET is =
enabled.
>=20
> :(

I still wonder whether the SDM comment applies to present bit vs dirty
bit atomicity as well.

On AMD=E2=80=99s APM I find:

"The processor never sets the Accessed bit or the Dirty bit for a not
present page (P =3D 0). The ordering of Accessed and Dirty bit updates
with respect to surrounding loads and stores is discussed below.=E2=80=9D

( The later comment regards ordering to WC memory ).

I don=E2=80=99t know if I read it too creatively...

