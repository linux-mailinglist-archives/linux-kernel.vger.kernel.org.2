Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63630CD57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhBBUwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhBBUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:52:40 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A95C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 12:51:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o63so15680318pgo.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DDCp9RzMvHUJbmD5LpwsO8bBYL0TirlWe1D2XxSeIec=;
        b=soYgdc0akMR2yNT+0SjjRn09zRvM8VuwOB37mrA3+A3bD8gJIaIpsZXCLzZoErNewV
         ctpjwF0nZcP++xPNnFuDBlfxXX655ud2S7vGUdC7Huf2TRCmtA1VfnVFSPl6uf7nLDQz
         o+yxr3/Zob+DlVrbAViaObQAoxYfJkPL/uoHMhCAmplBlBAZRjrM2YF02ZtWJRIh+FRK
         PWlD5XpoAIJtD0K5O9ACLiGv2HyQLF+daaqgqP9YB9kcoADDhvExjmggLzyJZLPtf5SV
         3eE9x4fBJ12ulr6rNt7UEnGcFmkEnyZEeK0zVnZV6nbiSerUF0Ex5cXC++EokZAZvK7M
         Sw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DDCp9RzMvHUJbmD5LpwsO8bBYL0TirlWe1D2XxSeIec=;
        b=AjJuMSjDlwA31E9Gf51DJK+CkisvHZBRk802e0TRjKcLazOYpK3IL10cDPF2CwoPOE
         JW2u6XkKJ0glGO72BSkPYuvcaUKSRr4NKQMoQmDUgT8jNoTXDgy5vF38SJsRjz5jZL3q
         UfHCieqV/r+pmX+3tVH0ywLAUyoMme92jqpQ+mvnSfs6OMiiO1xyVz1vEzihv26bE7Fl
         pfajo28QyiaJY6AbeKzxoIhnPxqr6BP3c+q6GzGfD9/Etp9TSg8chj4OUkFEKdI5R+KW
         witLjsPhQPO57QxPYHKCEWYf6X0jktdHEoAdN6gMjmXgkW4IVs9JxwhjqbgVbCKfstk/
         bZmg==
X-Gm-Message-State: AOAM53170zJSR/N/uCzwHnCPSvXX5KHcBW91StSWzCkjtArCs39FpQdM
        qN2wBBgYWB6Cw2Q91HzBntY=
X-Google-Smtp-Source: ABdhPJxl5hps3mFiW7ZYdF3geeF1j8ghVcsy6A2Dcx1bcMfNOGmNgsL/+w0WUBTH4ECwwVyvL+uGbw==
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id q20-20020a056a000854b02901b762330c5fmr23374045pfk.73.1612299119233;
        Tue, 02 Feb 2021 12:51:59 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 76sm22819171pfz.174.2021.02.02.12.51.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 12:51:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 15/20] mm: detect deferred TLB flushes in vma granularity
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <8F37526F-8189-483A-A16E-E0EB8662AD98@amacapital.net>
Date:   Tue, 2 Feb 2021 12:51:56 -0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <846661D8-0963-4DCF-AE8D-1417064CB721@gmail.com>
References: <A6E4897D-8D5A-4084-8288-8E43F3039921@gmail.com>
 <8F37526F-8189-483A-A16E-E0EB8662AD98@amacapital.net>
To:     Andy Lutomirski <luto@amacapital.net>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 1, 2021, at 4:14 PM, Andy Lutomirski <luto@amacapital.net> =
wrote:
>=20
>=20
>> On Feb 1, 2021, at 2:04 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>=20
>> Andy=E2=80=99s comments managed to make me realize this code is =
wrong. We must
>> call inc_mm_tlb_gen(mm) every time.
>>=20
>> Otherwise, a CPU that saw the old tlb_gen and updated it in its local
>> cpu_tlbstate on a context-switch. If the process was not running when =
the
>> TLB flush was issued, no IPI will be sent to the CPU. Therefore, =
later
>> switch_mm_irqs_off() back to the process will not flush the local =
TLB.
>>=20
>> I need to think if there is a better solution. Multiple calls to
>> inc_mm_tlb_gen() during deferred flushes would trigger a full TLB =
flush
>> instead of one that is specific to the ranges, once the flush =
actually takes
>> place. On x86 it=E2=80=99s practically a non-issue, since anyhow any =
update of more
>> than 33-entries or so would cause a full TLB flush, but this is still =
ugly.
>=20
> What if we had a per-mm ring buffer of flushes?  When starting a =
flush, we would stick the range in the ring buffer and, when flushing, =
we would read the ring buffer to catch up.  This would mostly replace =
the flush_tlb_info struct, and it would let us process multiple partial =
flushes together.

I wanted to sleep on it, and went back and forth on whether it is the =
right
direction, hence the late response.

I think that what you say make sense. I think that I even tried to do =
once
something similar for some reason, but my memory plays tricks on me.

So tell me what you think on this ring-based solution. As you said, you =
keep
per-mm ring of flush_tlb_info. When you queue an entry, you do something
like:

#define RING_ENTRY_INVALID (0)

  gen =3D inc_mm_tlb_gen(mm);
  struct flush_tlb_info *info =3D mm->ring[gen % RING_SIZE];
  spin_lock(&mm->ring_lock);
  WRITE_ONCE(info->new_tlb_gen, RING_ENTRY_INVALID);
  smp_wmb();
  info->start =3D start;
  info->end =3D end;
  info->stride_shift =3D stride_shift;
  info->freed_tables =3D freed_tables;
  smp_store_release(&info->new_tlb_gen, gen);
  spin_unlock(&mm->ring_lock);
 =20
When you flush you use the entry generation as a sequence lock. On =
overflow
of the ring (i.e., sequence number mismatch) you perform a full flush:

  for (gen =3D mm->tlb_gen_completed; gen < mm->tlb_gen; gen++) {
	struct flush_tlb_info *info =3D &mm->ring[gen % RING_SIZE];

	// detect overflow and invalid entries
	if (smp_load_acquire(info->new_tlb_gen) !=3D gen)
		goto full_flush;

	start =3D min(start, info->start);
	end =3D max(end, info->end);
	stride_shift =3D min(stride_shift, info->stride_shift);
	freed_tables |=3D info.freed_tables;
	smp_rmb();

	// seqlock-like check that the information was not updated=20
	if (READ_ONCE(info->new_tlb_gen) !=3D gen)
		goto full_flush;
  }

On x86 I suspect that performing a full TLB flush would anyhow be the =
best
thing to do if there is more than a single entry. I am also not sure =
that it
makes sense to check the ring from flush_tlb_func_common() (i.e., in =
each
IPI handler) as it might cause cache thrashing.

Instead it may be better to do so from flush_tlb_mm_range(), when the
flushes are initiated, and use an aggregated flush_tlb_info for the =
flush.

It may also be better to have the ring arch-independent, so it would
resemble more of mmu_gather (the parts about the TLB flush information,
without the freed pages stuff).

We can detect deferred TLB flushes either by storing =E2=80=9Cdeferred_gen=
=E2=80=9D in the
page-tables/VMA (as I did) or by going over the ring, from =
tlb_gen_completed
to tlb_gen, and checking for an overlap. I think page-tables would be =
most
efficient/scalable, but perhaps going over the ring would be easier to
understand logic.

Makes sense? Thoughts?=
