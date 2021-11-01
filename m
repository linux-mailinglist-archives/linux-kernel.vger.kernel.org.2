Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5315E441D91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhKAPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhKAPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:48:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF47C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:45:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j9so9387773pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IVZ+3X2Rjxc+ixerGwp7ypsajfDVTMwoHCpW87XMd9Q=;
        b=YZIbU4b61z7pDrPpqweZEq0UqGyo7ETxXPHWJDNP1+FgfC2iDskbORWARv/fI7lOVL
         NR5yknrkpN4/NBnaFhD3pRWNWuchtY2I4tR2MsYzcaf/CcXJsBb/jt/yYG1PAni0D8hj
         JGeeB2JJn9rJvjPAQcL5ejfB57MlOz16KjmNLVGhfBn1C46/pTVwpRzmtIaTY1LXP7Bk
         RieDSgfzQ95Dsi3VJfQ5WC3UdO7N5rzN4qkgqLMqTCJd4GSaFJIzLbCiRB7puq41x0pZ
         2Vh6D3hRQIsCjzukm/WVbGe98o9dEtqAZ35jaLYTdkyzyU5O3hzJZSv3meH+6jqOxKPG
         T8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IVZ+3X2Rjxc+ixerGwp7ypsajfDVTMwoHCpW87XMd9Q=;
        b=Vcb2ee10ScpmfJrlucgDqnPcowpJd84fSGkfg1z4plKA/leyU3jfAxT7obmx4HeNQ9
         TJfSj3ONg1j2S9rVFPGv/iIws5f0CksUl2klPWsmxU1sTnPqs5ysdCjFLLl8sP+wCcP9
         6ew1pEnIUPEIphNwYIVzPEZk5XRQZtCwJO+22Fqp5ERrDFxfy9vBJLmh9WvzjfVbxO7U
         8Xg4Kiivb0DieYaWAZj9d+bF1Y0SGSjto6lzt1OTJMYy8VrFF86g6zXmm5bF9UxLJw1k
         6Pv5da4IlZiMmR0sDgaKiOC6NzLSEy/R0UXKuOr4X4CRs9uqwXM/HyVPSPIDKqrUFKv0
         hEWQ==
X-Gm-Message-State: AOAM531QfZgSn7MKxwl0EYXlUun03tGbyC5GQdrJRsyNqFKmRteRWeWw
        AM6cf+ieHdqcbsYao7+lVmA=
X-Google-Smtp-Source: ABdhPJwGqDUkx3ky3N5utKupudoUHdzvzb3peFtCfxnm7yrUouJqtUBw1lGwerJKX1PD3tPI/k59SQ==
X-Received: by 2002:a05:6a00:c81:b029:30e:21bf:4c15 with SMTP id a1-20020a056a000c81b029030e21bf4c15mr29362219pfv.70.1635781527011;
        Mon, 01 Nov 2021 08:45:27 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n11sm13386812pgm.74.2021.11.01.08.45.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 08:45:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] mm: use correct VMA flags when freeing page-tables
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <80283a1e-dfab-c02b-7a6a-424e2f7fda4@google.com>
Date:   Mon, 1 Nov 2021 08:45:24 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CAB8AAB-D6E2-47B3-BE00-E3D68310EB2D@gmail.com>
References: <20211021122322.592822-1-namit@vmware.com>
 <80283a1e-dfab-c02b-7a6a-424e2f7fda4@google.com>
To:     Hugh Dickins <hughd@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 1, 2021, at 12:28 AM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Thu, 21 Oct 2021, Nadav Amit wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Consistent use of the mmu_gather interface requires a call to
>> tlb_start_vma() and tlb_end_vma() for each VMA. free_pgtables() does =
not
>> follow this pattern.
>>=20
>> Certain architectures need tlb_start_vma() to be called in order for
>> tlb_update_vma_flags() to update the VMA flags (tlb->vma_exec and
>> tlb->vma_huge), which are later used for the proper TLB flush to be
>> issued. Since tlb_start_vma() is not called, this can lead to the =
wrong
>> VMA flags being used when the flush is performed.
>>=20
>> Specifically, the munmap syscall would call unmap_region(), which =
unmaps
>> the VMAs and then frees the page-tables. A flush is needed after
>> the page-tables are removed to prevent page-walk caches from holding
>> stale entries, but this flush would use the flags of the VMA flags of
>> the last VMA that was flushed. This does not appear to be right.
>>=20
>> Use tlb_start_vma() and tlb_end_vma() to prevent this from happening.
>> This might lead to unnecessary calls to flush_cache_range() on =
certain
>> arch's. If needed, a new flag can be added to mmu_gather to indicate
>> that the flush is not needed.
>>=20
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Cc: x86@kernel.org
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> mm/memory.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 12a7b2094434..056fbfdd3c1f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -412,6 +412,8 @@ void free_pgtables(struct mmu_gather *tlb, struct =
vm_area_struct *vma,
>> 		unlink_anon_vmas(vma);
>> 		unlink_file_vma(vma);
>>=20
>> +		tlb_start_vma(tlb, vma);
>> +
>> 		if (is_vm_hugetlb_page(vma)) {
>> 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>> 				floor, next ? next->vm_start : ceiling);
>> @@ -429,6 +431,8 @@ void free_pgtables(struct mmu_gather *tlb, struct =
vm_area_struct *vma,
>> 			free_pgd_range(tlb, addr, vma->vm_end,
>> 				floor, next ? next->vm_start : ceiling);
>> 		}
>> +
>> +		tlb_end_vma(tlb, vma);
>> 		vma =3D next;
>> 	}
>> }
>> --=20
>> 2.25.1
>=20
> No.
>=20
> This is an experiment to see whether reviewers look at a wider context
> than is seen in the patch itself?  Let's take a look:
>=20
> 		tlb_start_vma(tlb, vma);
>=20
> 		if (is_vm_hugetlb_page(vma)) {
> 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
> 				floor, next ? next->vm_start : ceiling);
> 		} else {
> 			/*
> 			 * Optimization: gather nearby vmas into one =
call down
> 			 */
> 			while (next && next->vm_start <=3D vma->vm_end + =
PMD_SIZE
> 			       && !is_vm_hugetlb_page(next)) {
> 				vma =3D next;
> 				next =3D vma->vm_next;
> 				unlink_anon_vmas(vma);
> 				unlink_file_vma(vma);
> 			}
> 			free_pgd_range(tlb, addr, vma->vm_end,
> 				floor, next ? next->vm_start : ceiling);
> 		}
>=20
> 		tlb_end_vma(tlb, vma);
> 		vma =3D next;
>=20
> So, the vma may well have changed in between the new tlb_start_vma()
> and tlb_end_vma(): which defeats the intent of the patch.

Indeed, I made a an embarrassing bug. Having said that, I do not
understand the experiment and whether I conducted it or was the
object of it.

>=20
> And I doubt that optimization should be dropped to suit the patch:
> you admit to limited understanding of those architectures which need
> tlb_start_vma(), me too; but they seem to have survived many years
> without it there in free_pgtables(), and I think that tlb_start_vma()
> is for when freeing pages, not for when freeing page tables.  Surely
> all architectures have to accommodate the fact that a single page
> table can be occupied by many different kinds of vma.

When it comes to TLB flushing, the assumption that if something is
in the code for many years it must be working is questionable, and
I have already encountered (and fixed) many such cases before.

Freeing page-tables, as I mentioned before, is needed for the
invalidation the page-walk caches after the page-tables are dropped,
if a speculative page-walk takes place. I can post v2 and fix my
embarrassing bug. I am not going to force this patch - I just
encountered the issue as I was modifying a different piece of code
and the behavior seems very inconsistent.

