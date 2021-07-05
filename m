Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160173BC34D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGEUDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGEUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:03:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F7C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 13:00:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h6so25981670ljl.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXK5Wghrl9BeWboFjUDcBDDUgIC21r7QCQo7y9N1Uyk=;
        b=C1F9GG+UVYMMnH/FtuKwkTJG0r7T913cOjzk11gw2ExCjJEhm54rd74ohsuH2tRaJn
         lqQlfJFwhGysJHUK5mhYA6w1mi/NcmvJPAG82ii+nP3jwE85bnZ93bucVHsUshGTdxYT
         rRjiMrljpf4QL9z5Zj5nZ+67zJI7a3iApeucs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXK5Wghrl9BeWboFjUDcBDDUgIC21r7QCQo7y9N1Uyk=;
        b=ovuRVLy7PB9yd3tb4fIsImvdvAP9HVQ+osxC/NghqZY5eM3ZrJfDmCvZP1sxeC6JAn
         CBpchwGZHlrQFZwlAgUgwsbjbUzIUqaXcntAi+zIRTDIzEHrJZpFdlDAeIMaTj34bp82
         gM8lsdCJC6bf88M/Yjd2hntS2hG4oQFvP0yQt+qIidLFwl5AdWBwJwPFSCtsM7ICr0hD
         ceK5XzxEzu7oydk4PCrRfAOoCTlBmgNXcwCFrqjvgEoxZAAqjYKXRgyaVkGaQR0rI+ey
         qNUOQvAv1wshbDHZcDQDwsEEbUiEvaWLtBBECp50l6DS3bEDMDA+YphxoU2RVOkxKBv/
         ctjw==
X-Gm-Message-State: AOAM533gXGIDhqFU/SFMqswemkrQrJXanv/fIN0eSzLAAd3QUDXZUlwr
        nrf/d6/W4WNPkr2KhdN3yeZ3Y9mH6SAOwsWo
X-Google-Smtp-Source: ABdhPJy7qfZBz4yUpwHQprmFLT7m7podskDpZF3156b/zlXrCeXGe5lp0f1ws71wWa/zEuO6y9hGEQ==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr83737lji.196.1625515227068;
        Mon, 05 Jul 2021 13:00:27 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g20sm1469466lja.2.2021.07.05.13.00.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 13:00:26 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v14so8714704lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:00:26 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr11494157lfs.377.1625515225977;
 Mon, 05 Jul 2021 13:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210704150025.GC21572@xsang-OptiPlex-9020> <20210705125756.GA25141@lst.de>
In-Reply-To: <20210705125756.GA25141@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Jul 2021 13:00:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com>
Message-ID: <CAHk-=wj_Gfqkdp+K3iCiqMjAZQK_BrRWDs2eOS_BAw=bB=CdRw@mail.gmail.com>
Subject: Re: [ide] b7fb14d3ac: EIP:ioread32_rep
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 5:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This looks very obviously caused by the fact that this test before
> used the old IDE driver and now uses libata.  And I have to admit I'm
> pretty lost at the magic of the iomap indirection and x86 rep prefixed
> ioport instructions.  Adding some folks that might understand the
> OOPS output..

"rep insl" is a fairly simple instruction. It just does multiple
(count in %ecx)  32-bit PIO "in" instructions from one PIO address (in
%edx), and writes the result to memory at %edi (generally
incrementing, although you can set the DF flag to write backwards in
memory, which would be insane and is never done in practice).

So in this case, you have

        rep insl (%dx),%es:(%rdi)               <-- trapping instruction

which is a bogus disassembly because it's been disassembled as if it
was 64-bit code, but it's close enough apart from the register name
(it should be %edi, not %rdi).

And we have:

    ECX: 00000080
    EDX: 00000170
    EDI: fffb9ec0
    EFLAGS: 00010002

which is all normal: DF is clear, the source IO port is 0x170, the
count is 128 (32-bit words, remember) which means that it's still has
512 bytes to go, which presumably means that it failed on the very
first access.

And the failure is because %edi points to fffb9ec0, which while a
_possible_ address does look like garbage.

Now, the only *odd* part here is the oops report:

     BUG: unable to handle page fault for address: fffba000

because that "fffba000" address looks wrong. It *should* have faulted
at that address fffb9ec0 in %edi. What I suspect is going on is that
this part of the thing is actually a qemu bug, and  what happens is
that qemu sees that "oh, 512-byte 'rep insl'" and then does a emulated
512-byte disk sector read, and when it then copies those 512 bytes to
fffb9ec0, it takes a fault on the next page, and reports that as the
faulting address. But it never updated the registers for the partially
succeeding IO.

IOW, the 512-byte transfer should have written four bytes at a time to
the range fffb9ec0 -> fffba0c0, and the fault should have happened at
the page crossing at fffba000. But %edi and %ecx should have been
updated to reflect the part that *did* work, and they haven't.

So there is a qemu bug there, in the report, in that clearly the page
fault error reporting happens incorrectly.

That said, the way to trigger that qemu bug is likely that there _is_
some problem in the kernel, because it's certainly never valid to have
that kind of odd "try to rep;insl into a non-existing page". So I
think the qemu device emulation bug is a symptom, not the cause, of
the problem.

Of course, it's entirely possible that if qemu is bad at emulating
"rep insl" instructions, it did something wrong on a previous
iteration and didn't update the registers correctly, which then caused
the problem when the rep insl continued.

So it's _possible_ that this whole thing is entirely on qemu. That
sounds unlikely: a "rep movs" that doesn't fault is what the kernel
norm should be, and I'd expect qemu to handle that full 512-byte case
perfectly well.

To summarize: to me it looks like ata_pio_sector() is using the wrong
target address. It's in this code:

        /* do the actual data transfer */
        buf = kmap_atomic(page);
        ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size, do_write);
        kunmap_atomic(buf);

and that "kmap_atomic()" does explain the odd high virtual address,
but it really looks like the range

   (buf + offset), qc->sect_size

ends up being more than the one page that kmap_atomic() mapped.

In particular, it looks like "offset" is those low 12 bits of the
address in %edi, ie 0xec0. And qc->sect_size is 512, so the
sff_data_xfer() ends up trying to transferr past the one page that
kmap_atomic() mapped.

Of course, I have no idea how a sector transfer would ever not be
512-byte aligned in memory.

It might perhaps be worth adding some kind of

     WARN_ON_ONCE(offset & 511);

in the callchain somewhere for that ata_queued_cmd(). But at that
point I no longer know the code.

             Linus
