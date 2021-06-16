Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC33A9732
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFPK0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhFPK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:26:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95387C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:24:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j62so1967770qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzHc6WO6mMVE18e1Hu2zXOuCxvYGCISfnNTTpoaRCjc=;
        b=Uup97+GxFYt+JQByLgZDSW9o+/Jhq71m8xhCP9Bp/8PH7UKYzpJpXtT42tLm6oPvsR
         KInCZq3j1fKVvceYabwXSkv/UybGqPOL0UhNikwQmQ4JAiYTO3uC6g+VxIwAHhnOG92r
         JUGlk84b1KkYs/vtg0wbhuSYvzNMqKQK2NtKmcP7upRoeswAA9xkzb/lxfJSNx7dMdVM
         /1rjhDvSE8IKyfP+bEaNoYWhlHldQ130ZDvhDftNiO4sxl/pos3KDWeCQrHRjGIWtH5m
         NQa8vyfMLiUfp4ELLJELboD/odTzjJiTVBEUKgj5U4g/mHU8kA2myCK836JAKvBNXh4X
         5OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzHc6WO6mMVE18e1Hu2zXOuCxvYGCISfnNTTpoaRCjc=;
        b=t64PJjsPMUX0WpH7pvGa7Mz5YzKrOhoPd8inrU9MXYBp24G7QUzks4OPM2MFEhV/Lj
         BWc8UoN/UPea3EW9ripZSy/qmiHu5x4TfpjhV0785ImmTUlK3EGaFcTqxcM1nkFfnw9X
         mkQhCJi3kwZ5qIGQe9AfalZdyHDE5ozeLf8RZJpeIVk+iz+q0xkRFh1VzUDbMjUxhRiz
         wJyLhqVMt7+FgURQjj/++JknHuH+1Fw0ta1iB8hJ+p31jwkGwqsHTxaUgy559YqE8FLs
         YiE/3fAgsKHpQv+Tt4GR0gQfoPhtaxAlQt5ezsxDDrGEMGIZLH8SfpYjFNsLMyLtUC7c
         rNKw==
X-Gm-Message-State: AOAM533ACyiODyhtNkGEwuOUCf/eia3vQNBKQoL442I0l63Ac8H3yr8t
        Q8tcJ+c1Ig/SQwJmTHVINofGNPIXGsGqbdnBuNI=
X-Google-Smtp-Source: ABdhPJxTd4Y6r8mDxcDh6ZxSoxhyILfYmP6R8v6TCCUjFva4m9WBJcCzXn3KkEZ6wswT7e41iPGzLzwgc938AAiN1tM=
X-Received: by 2002:a37:f50d:: with SMTP id l13mr4398441qkk.298.1623839064737;
 Wed, 16 Jun 2021 03:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <67dab8dc517f4add8b0c29074a6b3f06@AcuMS.aculab.com>
 <mhng-e4f1484c-052f-4981-83f9-3884ee4d5ea0@palmerdabbelt-glaptop> <de82d455e12e44898a6f14a3885d9f0c@AcuMS.aculab.com>
In-Reply-To: <de82d455e12e44898a6f14a3885d9f0c@AcuMS.aculab.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Date:   Wed, 16 Jun 2021 19:24:12 +0900
Message-ID: <CACuRN0MhtaR+_zngS1WpNSBq2soJpMgLTWmWLSQoq=FN97AVeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: prevent pipeline stall in __asm_to/copy_from_user
To:     David Laight <David.Laight@aculab.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "nylon7@andestech.com" <nylon7@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 9:17 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Palmer Dabbelt
> > Sent: 12 June 2021 05:05
> ...
> > > I don't know the architecture, but unless there is a stunning
> > > pipeline delay for memory reads a simple interleaved copy
> > > may be fast enough.
> > > So something like:
> > >     a = src[0];
> > >     do {
> > >             b = src[1];
> > >             src += 2;
> > >             dst[0] = a;
> > >             dst += 2;
> > >             a = src[0];
> > >             dst[-1] = b;
> > >     } while (src != src_end);
> > >     dst[0] = a;
> > >
> > > It is probably worth doing benchmarks of the copy loop
> > > in userspace.
> >
> > I also don't know this microarchitecture, but this seems like a pretty
> > wacky load-use delay.
>
> It is quite sane really.
>
> While many cpu can use the result of the ALU in the next clock
> (there is typically special logic to bypass the write to the
> register file) this isn't always true for memory (cache) reads.
> It may even be that the read itself takes more than one cycle
> (probably pipelined so they can happen every cycle).
>
> So a simple '*dest = *src' copy loop suffers the 'memory read'
> penalty ever iteration.
> At out-of-order execution unit that uses register renames
> (like most x86) will just defer the writes until the data
> is available - so isn't impacted.
>
> Interleaving the reads and writes means you issue a read
> while waiting for the value from the previous read to
> get to the register file - and be available for the
> write instruction.
>
> Moving the 'src/dst += 2' into the loop gives a reasonable
> chance that they are executed in parallel with a memory
> access (on in-order superscaler cpu) rather than bunching
> them up at the end where the start adding clocks.
>
> If your cpu can only do one memory read or one memory write
> per clock then you only need it to execute two instructions
> per clock for the loop above to run at maximum speed.
> Even with a 'read latency' of two clocks.
> (Especially since riscv has 'mips like' 'compare and branch'
> instructions that probably execute in 1 clock when predicted
> taken.)
>
> If the cpu can do a read and a write in one clock then the
> loop may still run at the maximum speed.
> For this to happen you do need he read data to be available
> next clock and to run load, store, add and compare instructions
> in a single clock.
> Without that much parallelism it might be necessary to add
> an extra read/write interleave (an maybe a 4th to avoid a
> divide by three).

It is becoming like a computer architecture discussion, I agree with David's
simple interleaved copy would speed up with the same hardware
reason.
I used to get this kind of confirmation from cpu designers when they were
working on the same floor.
I am fine either way. I used the simple unrolling just because all other
existing copy functions for riscv and other cpus do the same.

I am lazy of porting C version interlive memcpy to assembly.
I wrote in the cover letter for using assembler inside uaccess.S is
because the
__asm_to/copy_from_user() handling page fault must be done manually inside
the functions.

Akira


>
> The 'elephant in the room' is a potential additional stall
> on reads if the previous cycle is a write to the same cache area.
> For instance the nios2 (a soft cpu for altera fpga) can do
> back to back reads or back to back writes, but since the reads
> are done speculatively (regardless of the opcode!) they have to
> be deferred when a write is using the memory block.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
