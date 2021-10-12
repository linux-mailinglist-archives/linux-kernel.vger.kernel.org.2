Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0842AAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJLRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:33:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072ABC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:31:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c29so185652pfp.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pUEbToLkXzO64sMzwi8hZSFYRVuGFaFClCMCV1JpE/4=;
        b=FuafK/ST/MY15E3ZByuFdbwhEhPuiRWJQtQhsDDMAbRGZep2/+iILYUgLn0Z+LxJhL
         gUco/dBkSrN5/a3IPJuNMW/DZoAyaNGZhj6JMAKwOr71ZNxVW5pn+lc0XZ4hrbKrUGbx
         HO0ngdd9xD1X+nGHuxsQb+2OO4Xnw7OwZc/C8x0CcBnOiBrKmtiE7D1ifhUmD+memw7G
         mnoRAvXHlc8u1uW/0eHruND1Rk//SIwgunzWHq2h9h/ZMe/te8o+sAYBA/MbC/yrpz/2
         5ulyN5+xA1f4z+59P++c2PieBpV1kvSSDEP56sDH1BID7pZhpahLbp3cVFtFVGdeARi5
         qlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pUEbToLkXzO64sMzwi8hZSFYRVuGFaFClCMCV1JpE/4=;
        b=EmJNLeV13MBRK0mJsht+O7br33ZejMFRfYzPpNjd8B4SJ+hwEbJuZq0H2+eC4CXj4G
         nx7QRGccNS6FLxnG8vFm9oxQONKmL8ny1B59tvUmJG9Dimt1bi0YX8ZXIVHYt6G6GI3n
         AuKG7jW4hM8WM+MmWpmwn0nGfmzn05t351RtmhOieLPe7V0zgo0BsK9J5BQrhPPwV2e/
         BOgWTLsd0TbVuqJUE6J2REsh2kYKXoj3aSp+BUp7pckr9r7GX/mP9HznZ/nuizaF8TUx
         /4lGhPrOr0Jhf9+BEXp2wOoTbv6k7BWge8IO8sHK9ESAYm8uAoT9pdRSP07YIuwAIoxy
         IrPg==
X-Gm-Message-State: AOAM533VROOPSOu6ezs7cRZc0jlwJQoRwOm5FxqY7vOFpTogxLWRn14A
        qk+JQzw8KvzPG027/Y/9gwI=
X-Google-Smtp-Source: ABdhPJwXpmp/S4EF2gzYO6qNsdVEIT9OWiwycw7gt/wn++LKHsR/mPbzLTr51ZPTVzNj5pp3vki+CQ==
X-Received: by 2002:aa7:9103:0:b0:44d:4d1d:6f36 with SMTP id 3-20020aa79103000000b0044d4d1d6f36mr1487780pfh.72.1634059909219;
        Tue, 12 Oct 2021 10:31:49 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 11sm11421880pfl.41.2021.10.12.10.31.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:31:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YWVgdmKIFnZcgjeY@t490s>
Date:   Tue, 12 Oct 2021 10:31:45 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CED2F72-4D1C-4DBC-AC03-4B246E1673C2@gmail.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com> <YWVgdmKIFnZcgjeY@t490s>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2021, at 3:16 AM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
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
>> +	tlb_gather_mmu(&tlb, mm);
>> +	tlb_start_vma(&tlb, vma);
>=20
> Pure question:
>=20
> I actually have no idea why tlb_start_vma() is needed here, as =
protection range
> can be just a single page, but anyway.. I do see that tlb_start_vma() =
contains
> a whole-vma flush_cache_range() when the arch needs it, then does it =
mean that
> besides the inc_tlb_flush_pending() to be dropped, so as to the other =
call to
> flush_cache_range() above?

Good point.

tlb_start_vma() and tlb_end_vma() are required since some archs do not
batch TLB flushes across VMAs (e.g., ARM). I am not sure whether =
that=E2=80=99s
the best behavior for all archs, but I do not want to change it.

Anyhow, you make a valid point that the flush_cache_range() should be
dropped as well. I will do so for next version.

Regards,
Nadav=
