Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D50422E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhJEQgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhJEQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:36:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F467C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:34:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q7-20020a17090a2e0700b001a01027dd88so813012pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X4UAiILtlqpir+FKeoRNV4x1N5OoKpbqJcIeFt+W4z0=;
        b=nPm8hTbqUolq9owT0eCIHb76kdbcP5YHuG5BQyo8HY1K6RvkqbAfWq6nmqyZo7GiUd
         GAguWZYspMeuvCoUKLVNNxDPn5CzvNhycCDWqc6m9RSgYkm75l7rKMnEpimHFyChAf05
         GzHnpYiU0clKjLrVya+Z6AyBJWgO+lu3SuONZSDzLv9wa40I1JIV9ICKxTkgfCOo5PWG
         vnFLa+SI7PBWwaTS2go3m0HuStM1lAZ5dFgLPh/aE/zPayfZTTKqPPd3GvrvRFkHjTnA
         e6B96CMfaMdVR4jMMoLtDgQRB2KtM6mY8l1ffCi/rq9jbdZxJxKcLxkMekF8yOOAiTS3
         YQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X4UAiILtlqpir+FKeoRNV4x1N5OoKpbqJcIeFt+W4z0=;
        b=vZdI7yAV6+RD71ZVQYfqCKxe8/xVlv6XQkdsn8mwaTuSrjOapSotq+dcmQ8mrmRFDN
         qxS1yF/DUjuyF2lg7cK6/YYbBXdcLcy9Z4VMUZPTKWFaIFbm1O1GS/399zu4a2OK0/yZ
         +KFEtvjEBax4TDlZzJLozOOvHzlBxNX9HIeLUWutKZnfjcalBMBbFc2gOzFKNAqUtdTb
         nuyKpi22/Oz0t4dMQIh3/gmy65mF9kGK3aLicWUMOJd41Cc5c8Sl2EobrOHfHAEkoNM4
         FmdQYFhcMnpYlL4XfuGdx2sjs494mykMAMG1EzVaXcjDOAYazWonSvZcQEJIsLHxyugC
         iuGA==
X-Gm-Message-State: AOAM532/L01XdkfcOLHUSjrGNNM6V5zueKOvsCZFh+cA5SNzpGXg/ZuN
        GAWK7XouHGgp4eBVau0BQ1SkhWKZf2A=
X-Google-Smtp-Source: ABdhPJy3Ix8ec/7oD0cABogXjyNkqGO7ZAx56JZRzbtMtRkrerIhsPASRZW9d87zn7PVLJmJr99uJQ==
X-Received: by 2002:a17:90a:ee87:: with SMTP id i7mr4911672pjz.139.1633451649582;
        Tue, 05 Oct 2021 09:34:09 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 23sm17615107pgk.89.2021.10.05.09.34.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:34:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20211005065335.GG4323@worktop.programming.kicks-ass.net>
Date:   Tue, 5 Oct 2021 09:34:06 -0700
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
Message-Id: <00EDCFA2-5BFE-4C7A-A41A-DD8902F0E494@gmail.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com>
 <20211003121019.GF4323@worktop.programming.kicks-ass.net>
 <620B1A38-1457-4F77-8666-E73A318392B6@gmail.com>
 <20211005065335.GG4323@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2021, at 11:53 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Mon, Oct 04, 2021 at 12:24:14PM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Oct 3, 2021, at 5:10 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
>>>=20
>>>> @@ -338,25 +344,25 @@ static unsigned long =
change_protection_range(struct vm_area_struct *vma,
>>>> 	struct mm_struct *mm =3D vma->vm_mm;
>>>> 	pgd_t *pgd;
>>>> 	unsigned long next;
>>>> -	unsigned long start =3D addr;
>>>> 	unsigned long pages =3D 0;
>>>> +	struct mmu_gather tlb;
>>>>=20
>>>> 	BUG_ON(addr >=3D end);
>>>> 	pgd =3D pgd_offset(mm, addr);
>>>> 	flush_cache_range(vma, addr, end);
>>>> 	inc_tlb_flush_pending(mm);
>>>=20
>>> That seems unbalanced...
>>=20
>> Bad rebase. Thanks for catching it!
>>=20
>>>=20
>>>> +	tlb_gather_mmu(&tlb, mm);
>>>> +	tlb_start_vma(&tlb, vma);
>>>> 	do {
>>>> 		next =3D pgd_addr_end(addr, end);
>>>> 		if (pgd_none_or_clear_bad(pgd))
>>>> 			continue;
>>>> -		pages +=3D change_p4d_range(vma, pgd, addr, next, =
newprot,
>>>> +		pages +=3D change_p4d_range(&tlb, vma, pgd, addr, next, =
newprot,
>>>> 					  cp_flags);
>>>> 	} while (pgd++, addr =3D next, addr !=3D end);
>>>>=20
>>>> -	/* Only flush the TLB if we actually modified any entries: */
>>>> -	if (pages)
>>>> -		flush_tlb_range(vma, start, end);
>>>> -	dec_tlb_flush_pending(mm);
>>>=20
>>> ... seeing you do remove the extra decrement.
>>=20
>> Is it really needed? We do not put this comment elsewhere for
>> tlb_finish_mmu(). But no problem, I=E2=80=99ll keep it.
>=20
> -ENOPARSE, did you read decrement as comment? In any case, I don't
> particularly care about the comment, and tlb_*_mmu() imply the inc/dec
> thingies.
>=20
> All I tried to do is point out that removing the dec but leaving the =
inc
> is somewhat inconsistent :-)

The autocorrect in my mind was broken so I read as =E2=80=9Cdocumentation=E2=
=80=9D
instead of =E2=80=9Cdecrement=E2=80=9D.

I will send v2 soon.

Thanks again!
Nadav=20=
