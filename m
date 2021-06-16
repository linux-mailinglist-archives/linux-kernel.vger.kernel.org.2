Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518793A96EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhFPKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhFPKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:10:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:08:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j184so1960712qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcF1KIN/sST+nKRNaO+sXfmpTGCVE77zQuH/o+QoKck=;
        b=civo79LBCVjD8HaawhbWNgTNs5SepV68owTaENJLtEdCBQ6nY/IvmZd4GGH5SNb69A
         5CilidPV7dJ9U3uf4KKw6d33QonWx4MgSzb0xSxqzxBHr8Bo224YkhU5mrV2An7+gJui
         u2KoGkg4ktDfGJMfa0RXiTdLVcBuwlOZ/vBKnR4OphSDgoqjZsJlpLNzm26/vVsUnk+i
         z4bMwP+0LS6fV6f+3hcaIlMS1D7L9EiQ0hyt8t5BxCrjFgAKQuipzA6G4UhhK5FAIg30
         8dHuyDKTws3WLO6rHznKXHbqxoqY4WQQ07nAg2rPZOTxzASkFKZNi7mW3azn7fUIK3bT
         rTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcF1KIN/sST+nKRNaO+sXfmpTGCVE77zQuH/o+QoKck=;
        b=iC2wz2qyiEoAf4ioeV6cleYPbWa6A5dideunfoFDxax1iX4P8DLxPMaS8XblG1E9em
         WnomBzYRvueWJr4lBW3VNiC3U0xyx9y0ZYIotG28O9g3C555iIOhiEB3JgRQBq5I70vu
         PDgOmqYrSChg/Zldu0i+VXJ+KoHmwtcsOM8LMW8aIE5ZNQuL4NjDAegs7VMPJasFKqag
         YUJ9g2i5iDM4sdy6T5cy3qcQsi9NRwh+mvJFfJJzGjv9awq8u8hd7ath5yYLFJseYDZ4
         jk5Ld7PyyAdAfV81VnyoCxGEDao06Sx/AQgMm+Yf8Tm3ec0Qu56BhcdS7Qc31BIHRQWK
         4piQ==
X-Gm-Message-State: AOAM5317/QyRppgZ1QX08QiASGCE5vJixN8cKtVHMtYBIH2XeoXRESQu
        DVFOzJ/rsqgXN4MuIjK3LOADwfNSzuC+Lgn/MJgPbuS23Gvgur9+
X-Google-Smtp-Source: ABdhPJys78nF5ZRX7kVKSBbb9l4KBV4jYchnx3SG9sfQe1ZJ4yLjRb5K9kDLn8mpAtsC8bxcRklMNAmPtsgOf2aoXxU=
X-Received: by 2002:a37:f50d:: with SMTP id l13mr4331301qkk.298.1623838096013;
 Wed, 16 Jun 2021 03:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <67dab8dc517f4add8b0c29074a6b3f06@AcuMS.aculab.com> <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop>
In-Reply-To: <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Date:   Wed, 16 Jun 2021 19:08:03 +0900
Message-ID: <CACuRN0MK4Em7+5EpPcwCs1q01oHcpALTZWY4PrSDTFFQC2LX-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: prevent pipeline stall in __asm_to/copy_from_user
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     David.Laight@aculab.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        linux-riscv@lists.infradead.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 1:05 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 08 Jun 2021 04:31:40 PDT (-0700), David.Laight@ACULAB.COM wrote:
> > From: Akira Tsukamoto
> >> Sent: 04 June 2021 10:57
> >>
> >> Reducing pipeline stall of read after write (RAW).
> >>
> >> These are the results from combination of the speedup with
> >> Gary's misalign fix. Speeds up from 680Mbps to 900Mbps.
> >>
> >> Before applying these two patches.
> >
> > I think the changes should be in separate patches.
> > Otherwise it is difficult to see what is relevant.
> > It also looks as if there is a register rename.
> > Maybe that should be a precursor patch?
>
> Yes, and I'd also prefer the original patches.  This also doesn't apply.
>
> > ...
> >
> > I think this is the old main copy loop:
> >>  1:
> >> -    fixup REG_L, t2, (a1), 10f
> >> -    fixup REG_S, t2, (a0), 10f
> >> -    addi a1, a1, SZREG
> >> -    addi a0, a0, SZREG
> >> -    bltu a1, t1, 1b
> > and this is the new one:
> >>  3:
> >> +    fixup REG_L a4,       0(a1), 10f
> >> +    fixup REG_L a5,   SZREG(a1), 10f
> >> +    fixup REG_L a6, 2*SZREG(a1), 10f
> >> +    fixup REG_L a7, 3*SZREG(a1), 10f
> >> +    fixup REG_L t0, 4*SZREG(a1), 10f
> >> +    fixup REG_L t1, 5*SZREG(a1), 10f
> >> +    fixup REG_L t2, 6*SZREG(a1), 10f
> >> +    fixup REG_L t3, 7*SZREG(a1), 10f
> >> +    fixup REG_S a4,       0(t5), 10f
> >> +    fixup REG_S a5,   SZREG(t5), 10f
> >> +    fixup REG_S a6, 2*SZREG(t5), 10f
> >> +    fixup REG_S a7, 3*SZREG(t5), 10f
> >> +    fixup REG_S t0, 4*SZREG(t5), 10f
> >> +    fixup REG_S t1, 5*SZREG(t5), 10f
> >> +    fixup REG_S t2, 6*SZREG(t5), 10f
> >> +    fixup REG_S t3, 7*SZREG(t5), 10f
> >> +    addi a1, a1, 8*SZREG
> >> +    addi t5, t5, 8*SZREG
> >> +    bltu a1, a3, 3b
> >
> > I don't know the architecture, but unless there is a stunning
> > pipeline delay for memory reads a simple interleaved copy
> > may be fast enough.
> > So something like:
> >       a = src[0];
> >       do {
> >               b = src[1];
> >               src += 2;
> >               dst[0] = a;
> >               dst += 2;
> >               a = src[0];
> >               dst[-1] = b;
> >       } while (src != src_end);
> >       dst[0] = a;
> >
> > It is probably worth doing benchmarks of the copy loop
> > in userspace.
>
> I also don't know this microarchitecture, but this seems like a pretty
> wacky load-use delay.
>
> Can we split out the misaligned handling fix to get that in sooner,
> that's likely the more urgent issue.

Sure, just give me a few days.

Akira

>
> >
> >       David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
