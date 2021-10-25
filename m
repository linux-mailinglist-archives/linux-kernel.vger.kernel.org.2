Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7A439B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhJYQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:29:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:27:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h193so11461593pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oI5ZgoBumkMPsdg0dKXSGfk+ipx5MuCcFI/OUoaJ4JA=;
        b=fh+pd/l59PDrHZYxexVQVs2VA67U04FFXQfsvO0JKI44kT9n928Ye1TdCuXKUDN4/8
         cb3v3S6mIB3PVPk539SCpNxl2wtWfyGs4mPuhrW1FpdWYa0df+ovqHV8sfAzdy6JR/v5
         mzRjhrUgjZKq5T1Vq7IIMwPqDJsjAlH6/omogDLPFwXDR+dOeS5/fUw1Zql6Rksxs28q
         lAq6ZfsD1+o9OaMYpRnZk5/rM+hQdyfVKJxZ3f0QrIRJJVe24lhnteDDqHA6odfMd+n4
         jaL0p5g4Q1HkttnmcsiFu5u84ytOsidpsZc75GQgX9gW4EHoUk7x6iue63HUfUwPaMxR
         3+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oI5ZgoBumkMPsdg0dKXSGfk+ipx5MuCcFI/OUoaJ4JA=;
        b=JGoQ7ge2403YzD+whqKigxx3JtY8pkVMigwLNISGYqOn35YBGKvbAP82pDg/tJOL0r
         XLpejy3H0F4l1U7Mm2j7YEAkCDGhWIznMrSgLxTKDv1fYu5m1x1KNzPFf/S8Ig05HuY8
         OE+wEiOxkgI7jLYVZjrxSfGawtgtkGzQJfubvy5VRYwpvL9clAt4Uqp3i4P2CU3t39O/
         jFqGBCbSNN8xCAd/da0Zly9jw9krzYFlPfUnjxMl+BH2bM2F0Mh4q8X3KZxLjYPxopwG
         rRww9GmrC9l4BQnWuuSvHOn6o9e5tKAXlJ22M9KjNEF++X/rPHgnBwqU8PmkC2/m9N0+
         8fTg==
X-Gm-Message-State: AOAM532Y9JvHpqIyBSUG9iWgwDZOshPcEClCm+dIxNoFfCDDqOaSltmR
        lrVI7TuhzcMt/fb5KL/cFIs=
X-Google-Smtp-Source: ABdhPJyVnChOrfUjQWFVMEXuuyxIOcxfwuMKx+55q+zKRTCeqtLbCJTrTx7UqD8zWFJEyHm+XqW4IQ==
X-Received: by 2002:a62:648a:0:b0:47b:e1a5:483a with SMTP id y132-20020a62648a000000b0047be1a5483amr12888524pfb.52.1635179231292;
        Mon, 25 Oct 2021 09:27:11 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id u19sm5481523pfk.201.2021.10.25.09.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:27:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 5/5] mm/mprotect: do not flush on permission promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YXaRHE0IrJD2lXeg@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Oct 2021 09:27:08 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94412B55-0E16-4BC1-982F-37C082A0BABD@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-6-namit@vmware.com>
 <YXaRHE0IrJD2lXeg@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2021, at 4:12 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Oct 21, 2021 at 05:21:12AM -0700, Nadav Amit wrote:
>> +/*
>> + * pte_may_need_flush() checks whether permissions were demoted and =
require a
>> + * flush. It should only be used for userspace PTEs.
>> + */
>> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
>> +{
>> +	/* new is non-present: need only if old is present */
>> +	if (!pte_present(newpte))
>> +		return pte_present(oldpte);
>> +
>> +	/* old is not present: no need for flush */
>> +	if (!pte_present(oldpte))
>> +		return false;
>=20
> Would it not be clearer to write the above like:
>=20
> 	/* !PRESENT -> * ; no need for flush */
> 	if (!pte_present(oldpte))
> 		return false;
>=20
> 	/* PRESENT -> !PRESENT ; needs flush */
> 	if (!pte_present(newpte))
> 		return true;
>=20
> ?

I will change the comment to yours. Thanks.

>=20
>=20
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 0f5c87af5c60..6179c82ea72d 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -141,7 +141,8 @@ static unsigned long change_pte_range(struct =
mmu_gather *tlb,
>> 				ptent =3D pte_mkwrite(ptent);
>> 			}
>> 			ptep_modify_prot_commit(vma, addr, pte, oldpte, =
ptent);
>> -			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>> +			if (pte_may_need_flush(oldpte, ptent))
>> +				tlb_flush_pte_range(tlb, addr, =
PAGE_SIZE);
>> 			pages++;
>> 		} else if (is_swap_pte(oldpte)) {
>> 			swp_entry_t entry =3D pte_to_swp_entry(oldpte);
>=20
> One question on naming, "may_need" sounds a bit washy to me, either it
> does or it does not. I suppose you're trying to convey the fact that =
we
> ought to err towards too many TLBi rather than too few, but that's
> always true.
>=20
> That is, would "needs" not be a better name?

The =E2=80=9Cmay=E2=80=9D is indeed intended to be clear that the =
function can error
towards too many TLB flushes (of any kind). For instance, in a change
from (!dirty|write)->(!write), no flush is needed in theory. I was too
chicken to add it, at least for now.

I can change the name and indicate in the comment instead though.=
