Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952EB439B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhJYQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhJYQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:22:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDFC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:19:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v20so8286792plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CV9xop57N44Xoc3ELL1tfkVbPt6ec4IJCZX741zNY1A=;
        b=IVxTXSin5BglUw4bXJHX+dRiUU5dDRS/G8xMx7vrIAKQGjUrGJoafbgQcoyySh8izD
         QOHQyTU2CzqkphZ631WAQqBJFo3HqbzSPddnHSqGtyhAvIzzqqpRCnD9EcKXn5pQ0DZc
         gRWIcFSA9GRZLWqHqxTjLYOPVWcrdV453x9sZKnHvJgSJUqKgcIaTRph9nJ0bzV7w1Bz
         6eL5sn21ezzZ2AMqBJOEyIr90Hhcdu/A3YvL5tFpGCLZjnWGCLhTTxwzL5SlOkXP4BbT
         IWeqM5ekgmOkOFHbVV8yyCIlg0Es5Ebss7lPx0ECXG302ElTCnfd2VLON4PqHymGPzgU
         0Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CV9xop57N44Xoc3ELL1tfkVbPt6ec4IJCZX741zNY1A=;
        b=BOZ8ZRP4YvLTzD80lB1ytCkr3cmqnA+PK69T4bOcfsvy7U6W+QuP/UFpJ8xxwSpMHt
         f9TjYOQSFdxZugYuTgeOtgrPG0oycwpn4EQ+MJClFp0l1KyP0qiQg5zwnUgvDl8BZEhZ
         NORWqYgvyKEQP5HgEVG7dqRDt4ud8q4x3e00wwI9FlAoU8paR2Ege1Fp10j51nqerzxB
         BbaVhF6Qe3A3YipGqO/TFHUIYpdeJIVQNkuatQPxcRgP7qnd6U9f7TQksYavgGtkjUfm
         r8Wwgd3sJ5RmHIqcQpHl0jyJXTgwY5CtnzFq8XglkGBHj3UDEBnU4uaJf8pt+rijZERK
         mlKw==
X-Gm-Message-State: AOAM531fD3k7b5efJwTKzN4mC1mOOryTtdv+loThk7z4gDKre5cs455O
        7UNhi+ysQ4n5ox+JBylL5o0=
X-Google-Smtp-Source: ABdhPJyMTuhfDNWd3bvHGuBmf0uJfF0cYE7S48+Y4SY1LpFsL5Dsb1AM/rwGEpkbzKD67eBZ00Tvcw==
X-Received: by 2002:a17:90a:c088:: with SMTP id o8mr17219078pjs.1.1635178778487;
        Mon, 25 Oct 2021 09:19:38 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id gp21sm3727491pjb.47.2021.10.25.09.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:19:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 3/5] x86/mm: check exec permissions on fault
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e55875fa-1264-7e08-3bb8-ed984f6ea5b3@intel.com>
Date:   Mon, 25 Oct 2021 09:19:35 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00C2DC4B-A77D-4B32-B7F7-2291830BC2D2@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-4-namit@vmware.com>
 <e55875fa-1264-7e08-3bb8-ed984f6ea5b3@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 25, 2021, at 7:20 AM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 10/21/21 5:21 AM, Nadav Amit wrote:
>> access_error() currently does not check for execution permission
>> violation.=20
> Ye
>=20
>> As a result, spurious page-faults due to execution permission
>> violation cause SIGSEGV.
>=20
> While I could totally believe that something is goofy when VMAs are
> being changed underneath a page fault, I'm having trouble figuring out
> why the "if (error_code & X86_PF_WRITE)" code is being modified.

In the scenario I mentioned the VMAs are not changed underneath the
page-fault. They change *before* the page-fault, but there are
residues of the old PTE in the TLB.=20

>=20
>> It appears not to be an issue so far, but the next patches avoid TLB
>> flushes on permission promotion, which can lead to this scenario. =
nodejs
>> for instance crashes when TLB flush is avoided on permission =
promotion.
>=20
> Just to be clear, "promotion" is going from something like:
>=20
> 	W=3D0->W=3D1
> or
> 	NX=3D1->NX=3D0
>=20
> right?  I tend to call that "relaxing" permissions.

I specifically talk about NX=3D1>NX=3D0.

I can change the language to =E2=80=9Crelaxing=E2=80=9D.

>=20
> Currently, X86_PF_WRITE faults are considered an access error unless =
the
> VMA to which the write occurred allows writes.  Returning "no access
> error" permits continuing and handling the copy-on-write.
>=20
> It sounds like you want to expand that.  You want to add a whole class
> of new faults that can be ignored: not just that some COW handling =
might
> be necessary, but that the PTE itself might be out of date.    Just =
like
> a "COW fault" may just result in setting the PTE.W=3D1 and moving on =
with
> our day, an instruction fault might now just end up with setting
> PTE.NX=3D0 and also moving on with our day.

You raise an interesting idea (which can easily be implemented with =
uffd),
but no - I had none of that in my mind.

My only purpose is to deal with actual spurious page-faults that I
encountered when I removed the TLB flush the happens after NX=3D1->NX=3D0.=


I am actually surprised that the kernel makes such a strong assumption
that every change of NX=3D1->NX=3D0 would be followed by a TLB flush, =
and
that during these changes the mm is locked for write. But that is the
case. If you do not have this change and a PTE is changed from
NX=3D1->NX=3D0 and *later* you access the page, you can have a =
page-fault
due to stale PTE, and get a SIGSEGV since access_error() is wrong to
assume that this is an invalid access.

I did not change and there are no changes to the VMA during the
page-fault. The page-fault handler would do pretty much nothing and
return to user-space which would retry the instruction. [ page-fault
triggers an implicit TLB flush of the offending PTE ]

>=20
> I'm really confused why the "error_code & X86_PF_WRITE" case is =
getting
> modified.  I would have expected it to be something like just adding:
>=20
> 	/* read, instruction fetch */
> 	if (error_code & X86_PF_INSN) {
>                /* Avoid enforcing access error if spurious: */
>                if (unlikely(!(vma->vm_flags & VM_EXEC)))
>                        return 1;
>                return 0;
>        }
>=20
> I'm really confused what X86_PF_WRITE and X86_PF_INSN have in common
> other than both being able to (now) be generated spuriously.

That was my first version, but I was concerned that perhaps there is
some strange scenario in which both X86_PF_WRITE and X86_PF_INSN can
be set. That is the reason that Peter asked you whether this is
something that might happen.

If you confirm they cannot be both set, I would the version you just
mentioned.

