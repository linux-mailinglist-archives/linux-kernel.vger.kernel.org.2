Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4C439B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhJYQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:31:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA552C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:29:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t7so11455063pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g/bHWNbEVTUu1p1pY3zhFaw/B4nH/Dtxkz7BbwLJ14U=;
        b=aaaJn8CeCvh2LyKQmHk811Z9LqBaCi8WSPoU+cUqJghexKlravjNGfOOPb8ssVCCAX
         LwjqULdEu/3SYG7DlaswU9DD8m4LPHy9SCRh28KbqUFkVu/Xhxd1ISDw4Qb6uo9VoI7D
         jc5CSwlbCKJLhLKdVddBFpskz5Sa08QlKNyiiiGL6E7F/cWxTZa3ist4cLyR129HIZ6u
         cE+VolALQkWNdzM7Y6zfWLEwLPGmeqPSi0fhgZNSU69618ZdCutkVPjod/CHdqBIXmPr
         XDjAG9MPPCO4jGAQTSCkaD67ke8TpkR0gnKS0GSNER6NoKI82P+z+RFBTcc8eio8qykI
         Y84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g/bHWNbEVTUu1p1pY3zhFaw/B4nH/Dtxkz7BbwLJ14U=;
        b=7uDnAAqb4INTGka3nwMObP8k4nS+6sEo/UExMSwByYKSNmdqDO94ox5zmnycUK3kzb
         P1k4vsBZdvzUUKj50SMnCPSoQCNa5qOZ6APChdeTRZ6/+/u/e9FS48f+M+gMk6/Pz6M7
         RlQO82x5s4y2e9tVCcFZdyXInL7kxbsHrxY8uJFH4LIBuELpwocymaxRuxYQb2nrsH+V
         EClk0Gjxr7eQCkz6WGjWT7BAsuiP9M6PYIVdDfx4wuWRo56KDsJcUT6nPuwfVy2eg3zm
         rrR+LwV1iH+v/+VQJEGMFN/4VFTYnKsRtl4wZJjDwoSg5kF8FyJ3+TpY4oM0iXcg8Rt2
         heWQ==
X-Gm-Message-State: AOAM5306yLEkNMj/CIyl2FxU4P1160/OtsSwbPDma1I2Q32NvOCZ5sGx
        dPUz08i2cKdHqFDcP80XqL8=
X-Google-Smtp-Source: ABdhPJxolYbehxB+mzV13Kboc6Y9AiTm0yykP/kkPo0UxWNJC43oVo/DFlNrgmd3/JxDpsQMHng7HA==
X-Received: by 2002:a05:6a00:b85:b0:47b:ff97:841e with SMTP id g5-20020a056a000b8500b0047bff97841emr3612045pfj.48.1635179352143;
        Mon, 25 Oct 2021 09:29:12 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id s3sm22337446pfu.84.2021.10.25.09.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:29:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YXaMaUbdDOxMTstc@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Oct 2021 09:29:09 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5E4E2C2-5F1C-42AC-8707-0D0B8C00D251@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <YXaMaUbdDOxMTstc@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2021, at 3:52 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Oct 21, 2021 at 05:21:09AM -0700, Nadav Amit wrote:
>> diff --git a/arch/x86/include/asm/pgtable.h =
b/arch/x86/include/asm/pgtable.h
>> index 448cd01eb3ec..18c3366f8f4d 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1146,6 +1146,14 @@ static inline pmd_t pmdp_establish(struct =
vm_area_struct *vma,
>> 	}
>> }
>> #endif
>> +
>> +#define __HAVE_ARCH_PMDP_INVALIDATE_AD
>> +static inline pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
>> +				       unsigned long address, pmd_t =
*pmdp)
>> +{
>> +	return pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
>=20
> Did this want to be something like:
>=20
> 	pmd_t old =3D pmdp_establish(vma, address, pmdp, =
pmd_mkinvalid(*pmdp));
> 	if (cpu_feature_enabled(X86_BUG_PTE_LEAK))
> 		flush_pmd_tlb_range(vma, address, address + =
HPAGE_PMD_SIZE);
> 	return old;
>=20
> instead?

Yes. Of course. Where did my code go to? :(

>=20
>> +}
>> +
>> /*
>>  * Page table pages are page-aligned.  The lower half of the top
>>  * level is used for userspace and the top half for the kernel.
>=20
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e5ea5f775d5c..435da011b1a2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1795,10 +1795,11 @@ int change_huge_pmd(struct vm_area_struct =
*vma, pmd_t *pmd,
>> 	 * The race makes MADV_DONTNEED miss the huge pmd and don't =
clear it
>> 	 * which may break userspace.
>> 	 *
>> -	 * pmdp_invalidate() is required to make sure we don't miss
>> -	 * dirty/young flags set by hardware.
>> +	 * pmdp_invalidate_ad() is required to make sure we don't miss
>> +	 * dirty/young flags (which are also known as access/dirty) =
cannot be
>> +	 * further modifeid by the hardware.
>=20
> "modified", I think is the more common spelling.

I tried to start a new trend. I will fix it.

>=20
>> 	 */
>> -	entry =3D pmdp_invalidate(vma, addr, pmd);
>> +	entry =3D pmdp_invalidate_ad(vma, addr, pmd);
>>=20
>> 	entry =3D pmd_modify(entry, newprot);
>> 	if (preserve_write)
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 4e640baf9794..b0ce6c7391bf 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -200,6 +200,14 @@ pmd_t pmdp_invalidate(struct vm_area_struct =
*vma, unsigned long address,
>> }
>> #endif
>>=20
>> +#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
>=20
> /*
> * Does this deserve a comment to explain the intended difference vs
> * pmdp_invalidate() ?
> */

I will add a comment.

