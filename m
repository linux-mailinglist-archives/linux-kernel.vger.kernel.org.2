Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10166421767
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhJDT0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhJDT0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:26:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750AC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:24:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x4so613330pln.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0U7IBsrDQvR7BEZkcrW5Le/tFKp52n4Y9d5zqsAi/H4=;
        b=claLKin48dOn1KbAZAzFb4o1s0eZ9Wb63SspSgP12JgHcxAn8Qih6z262lCfMmRzdV
         5X0yUvVCSoEt4/1WOCCFYg9je4A9dYGkPDem5bqo5DfhAQqzK5M83QqbYDeVqjVzbU2L
         Q+SSowd/MDouxXBq8Zk8kXk/Mc71A/DpGOnc0/h/soXMhD3bLLyPb9NrT3Cn3PTTSM57
         zmYOqv69Kh2NB8PNbrpsCY0vuKDtupzAmKyKvj8sf6iEuFI3uacC1jotgWV0kFYqIz5Z
         nGEh8290vF/fIAjdPYOQV0Z8EP6B1FfE12H+xYBS0YTShzqqk4Tz5ZT2QkdumyxfjAA5
         g3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0U7IBsrDQvR7BEZkcrW5Le/tFKp52n4Y9d5zqsAi/H4=;
        b=kUQ+pkaN2lhdl864wyGAdPjCHMAN9MDNvNwaVP9QIeBmJskea3icqgbNZ6BHxnSaFn
         DrFOCNZEgWysji+4zaHZoWBFQfun0/p2UkQVJy1ngJfDgvjUoltpSD7QioI76FzqlEIX
         bc/xVBnzU4CSH/LsVTSEHrdsao5Fqk2j32+gdMhvjWNn6W6iB//jazukTDp9WNCGawOZ
         efZ7p/s+l16uSnYJ4JmEhw3US7esNY0Aj9p8rsO4ksnU2qg4wlGb1nH3b+hDWwrGUsnX
         8ua8AZhL2Ykb/wFl5MWjPPc6xZW/VInXWtFxl94n5prm5RrzbVLClQzURY9zPI6EdVhA
         z0lg==
X-Gm-Message-State: AOAM533rYYS2ZFu5qfKCprgQFIRWbGdlS9+6iUTJnQxTzI9DVy3qV0nQ
        iCSBNW5K12iBkiQe7kUAMsk=
X-Google-Smtp-Source: ABdhPJxrf3sEF71SLcFd8+fGSLjRiX07BYjC+i4DwK1KJQ3X5TUbLiWFjwBI+lhTrbs1XCykIZNtvw==
X-Received: by 2002:a17:902:8543:b029:12d:461f:a6a8 with SMTP id d3-20020a1709028543b029012d461fa6a8mr1274421plo.1.1633375457875;
        Mon, 04 Oct 2021 12:24:17 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id e6sm5125083pgf.59.2021.10.04.12.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 12:24:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20211003121019.GF4323@worktop.programming.kicks-ass.net>
Date:   Mon, 4 Oct 2021 12:24:14 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <620B1A38-1457-4F77-8666-E73A318392B6@gmail.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
 <20211003121019.GF4323@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2021, at 5:10 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
>=20
>> @@ -338,25 +344,25 @@ static unsigned long =
change_protection_range(struct vm_area_struct *vma,
>> 	struct mm_struct *mm =3D vma->vm_mm;
>> 	pgd_t *pgd;
>> 	unsigned long next;
>> -	unsigned long start =3D addr;
>> 	unsigned long pages =3D 0;
>> +	struct mmu_gather tlb;
>>=20
>> 	BUG_ON(addr >=3D end);
>> 	pgd =3D pgd_offset(mm, addr);
>> 	flush_cache_range(vma, addr, end);
>> 	inc_tlb_flush_pending(mm);
>=20
> That seems unbalanced...

Bad rebase. Thanks for catching it!

>=20
>> +	tlb_gather_mmu(&tlb, mm);
>> +	tlb_start_vma(&tlb, vma);
>> 	do {
>> 		next =3D pgd_addr_end(addr, end);
>> 		if (pgd_none_or_clear_bad(pgd))
>> 			continue;
>> -		pages +=3D change_p4d_range(vma, pgd, addr, next, =
newprot,
>> +		pages +=3D change_p4d_range(&tlb, vma, pgd, addr, next, =
newprot,
>> 					  cp_flags);
>> 	} while (pgd++, addr =3D next, addr !=3D end);
>>=20
>> -	/* Only flush the TLB if we actually modified any entries: */
>> -	if (pages)
>> -		flush_tlb_range(vma, start, end);
>> -	dec_tlb_flush_pending(mm);
>=20
> ... seeing you do remove the extra decrement.

Is it really needed? We do not put this comment elsewhere for
tlb_finish_mmu(). But no problem, I=E2=80=99ll keep it.=
