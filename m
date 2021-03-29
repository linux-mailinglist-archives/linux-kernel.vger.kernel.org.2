Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A234D9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhC2VrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2VrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:47:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:47:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c17so10739014pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dINV1jr3ervdCKyPzOLdFI3Vz2vitsmiwNxQTrYH5RQ=;
        b=lDSTz4TCyWcsTpXyixJ6cCMMi+DSjBFqYYBxn6ixhkR4l+vs0gWPYK0MdcjRDYZPL5
         aT6zZGaXRkiKGweqGIY9EN+4NedABb4ZebJkcS/NqYwilL81qPvTNqaNGkQBMZFAcmXE
         WmWLAu0ngZpRcNoslP2q9n6S4+BIy2nIGDA1i16F8dQkiNklH2jSAyUSkJScxlswyyTd
         B0inE0heBvYLO5FbkhufA5uDx6snq+/f0+hucnLbZ6qp43pF6K96RK+SNMLs+mMf6oe1
         lefco/KCRBtPXhg5GGBi4gVGp26j5Lnp1B2tWwnYJIyZGXc3H38ZFdg9PmTKkn+nDEJc
         7l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dINV1jr3ervdCKyPzOLdFI3Vz2vitsmiwNxQTrYH5RQ=;
        b=noysn51nA7TpU+GPhzfktT94JigvPUlmFSyOC/wXKrxQF62Eo6FvobwLsSfQrZ9+BA
         zO2BTGkuqcfFJT+8bIRCMmVx8JfEwotqzagOyM2m6o7+GqrsKFWU8yp0M6W/f2dIjqeu
         MRAguuZjpfP9VltojxCFWDBQxHLVzXbzOln7r2qZjMP3/f6q1lYamrlLtPDxVvyCxwE8
         Eg18CuogEarS777gfp5/5ZP2JhRcZYV8ZQeKFxHUyVqT0pMx+fcNxKT+9G/Wh88wHZqq
         eHMKuHqZSVmeYGz1Jewceqo1VPc0EO/NqOCpBNjZ8nc8rd9jqCarBw0TE8rA+S0lmjBl
         747g==
X-Gm-Message-State: AOAM530tKPgPZ8gdX3H26XW53VGNR/7fhvFKuF0PieWtoLsVbJdaa/No
        5l5Dqhy25F70fmEvrcuJ6gSx+Q==
X-Google-Smtp-Source: ABdhPJxV1s7EAbC9JxMBHqZ4meThDgIpH6f26ghdpuvPuMY2eUAO7z1apJb0TUy04yCdLivEzk6+wg==
X-Received: by 2002:a63:6a84:: with SMTP id f126mr25094745pgc.352.1617054420880;
        Mon, 29 Mar 2021 14:47:00 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e17c:78f7:dc94:55dd? ([2601:646:c200:1ef2:e17c:78f7:dc94:55dd])
        by smtp.gmail.com with ESMTPSA id a70sm17413227pfa.202.2021.03.29.14.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 14:47:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: I915 CI-run with kfence enabled, issues found
Date:   Mon, 29 Mar 2021 14:46:59 -0700
Message-Id: <ED2525DC-4591-46D1-8238-0461D5006502@amacapital.net>
References: <CANpmjNPjj7ocn6rf-9LkwJrYdVw3AuKfuF7FzwMu=hwe7qrEUw@mail.gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        kasan-dev@googlegroups.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNPjj7ocn6rf-9LkwJrYdVw3AuKfuF7FzwMu=hwe7qrEUw@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 29, 2021, at 2:34 PM, Marco Elver <elver@google.com> wrote:
>=20
> =EF=BB=BFOn Mon, 29 Mar 2021 at 23:03, Dave Hansen <dave.hansen@intel.com>=
 wrote:
>>> On 3/29/21 10:45 AM, Marco Elver wrote:
>>>> On Mon, 29 Mar 2021 at 19:32, Dave Hansen <dave.hansen@intel.com> wrote=
:
>>> Doing it to all CPUs is too expensive, and we can tolerate this being
>>> approximate (nothing bad will happen, KFENCE might just miss a bug and
>>> that's ok).
>> ...
>>>> BTW, the preempt checks in flush_tlb_one_kernel() are dependent on KPTI=

>>>> being enabled.  That's probably why you don't see this everywhere.  We
>>>> should probably have unconditional preempt checks in there.
>>>=20
>>> In which case I'll add a preempt_disable/enable() pair to
>>> kfence_protect_page() in arch/x86/include/asm/kfence.h.
>>=20
>> That sounds sane to me.  I'd just plead that the special situation (not
>> needing deterministic TLB flushes) is obvious.  We don't want any folks
>> copying this code.
>>=20
>> BTW, I know you want to avoid the cost of IPIs, but have you considered
>> any other low-cost ways to get quicker TLB flushes?  For instance, you
>> could loop over all CPUs and set cpu_tlbstate.invalidate_other=3D1.  That=

>> would induce a context switch at the next context switch without needing
>> an IPI.
>=20
> This is interesting. And it seems like it would work well for our
> usecase. Ideally we should only flush entries related to the page we
> changed. But it seems invalidate_other would flush the entire TLB.
>=20
> With PTI, flush_tlb_one_kernel() already does that for the current
> CPU, but now we'd flush entire TLBs for all CPUs and even if PTI is
> off.
>=20
> Do you have an intuition for how much this would affect large
> multi-socket systems? I currently can't quite say, and would err on
> the side of caution.

Flushing the kernel TLB for all addresses
Is rather pricy. ISTR 600 cycles on Skylake, not to mention the cost of losi=
ng the TLB.  How common is this?

>=20
> Thanks,
> -- Marco
