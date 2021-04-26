Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338636B51C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhDZOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhDZOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:41:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D68C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 07:40:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q9so1990829wrs.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tn3qrOsiMw1/IX0OSROoijHoB0OaqBUuIka8PgnTleU=;
        b=nj5G6vFXID5n9XiC+ZVR+NRFdPOwz3XcN/NyXhlq0NSQLw14Ck9S06jNdqxZJzcJHm
         +Va6zYhD8mIQCNK1qboIAl4EFazRrn8iZ2fM9o7bZP+RBvqrae0Pacca7m4BPrR/5rYJ
         PozEMPB1G50RNup98uiuSDq1Ay1H9ojwFQephOO0ex2//smmKNm+wBq3sLWmrr63W8j7
         koYKMtxgGzYeV+J7/ztv4PMU24fOjJQLVIB0y0J+FLvo09PzV2mlaCScE7/jBav6qdAs
         Kp07s/9eUAk6sYB4/36bVyRplVSMoZH4/KeMrS5hjs/jdf0HsXCemzx87bID3KvaZRGE
         tW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tn3qrOsiMw1/IX0OSROoijHoB0OaqBUuIka8PgnTleU=;
        b=slwSMY1NsPIaEqJaUYaQFADCBbT3xV/tdC4eiBXlqzKloYclkwafrN65EpQC1f2Tud
         Jjcjz4lqJpaIYBSo07pXXn668fmOnbdI34OFEO7Ac/DaQFCuhFioxJ1HEi3Hv0PaggiQ
         /N69JKADlGyI/fgNK2BtPsyqtC45qfGDA0aW8ra3TitktmwuQoqtpaeyLsw7JbXd1JDC
         ngu3LjZnxaSZngTCXV9m6eug54ftOO6gDRsvHdKGseofrfUUx/fqVT+CKWu/NjqsD3on
         qFflpo/ciwRUHY3shDdOMZyRvvurEb09gVqIhysK3GuO6/v6Eq2zvSX6NJAES99wS3GQ
         3MxQ==
X-Gm-Message-State: AOAM5304XrsU0lJrSOklJNYsH8nxC0qNRZr4c1AzygMD2g9v9jdu4ejp
        scP4QT88gUdELNVBLj0tbAyRI54Kv8/k
X-Google-Smtp-Source: ABdhPJwK9v1cxTWILnlXaUnVUct8iApwqddngaa7udITL+7ryp25CVekyU9vkEZ0IdP0ZF0WHCtVxA==
X-Received: by 2002:a5d:4acf:: with SMTP id y15mr23535602wrs.245.1619448034253;
        Mon, 26 Apr 2021 07:40:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:209:12fe:7da3:d4af:86a4])
        by smtp.gmail.com with ESMTPSA id t206sm17852026wmb.11.2021.04.26.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:40:33 -0700 (PDT)
Date:   Mon, 26 Apr 2021 15:40:29 +0100
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, ojeda@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <YIbQ3dHOpyD/yymW@google.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com>
 <CACRpkdat8bny=D2mAsUXcDQvFJ=9jSZSccMMZzH=10dHQ_bXrQ@mail.gmail.com>
 <YIGVFCymUn+4HBIj@google.com>
 <CACRpkdat-4BbKHMBerdxXBseMb9O3PiDRZmMLP_OWFE2ctSgEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdat-4BbKHMBerdxXBseMb9O3PiDRZmMLP_OWFE2ctSgEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, again thanks for taking the time to look into this. I think it's great
for us to get into this level of detail.

On Mon, Apr 26, 2021 at 02:18:33AM +0200, Linus Walleij wrote:
> For device drivers you will certainly have to wrap assembly as well.
> Or C calls that only contain assembly to be precise.

Sure, I don't think this would be a problem.

> A typical example is the way device drivers talk to actual hardware:
> readl()/writel(), readw()/writew(), readb()/writeb() for memory-mapped
> IO or inb()/outb() for port-mapped I/O.
> 
> So there is for example this (drivers/gpio/gpio-pl061.c):
> 
>         writeb(pl061->csave_regs.gpio_is, pl061->base + GPIOIS);
>         writeb(pl061->csave_regs.gpio_ibe, pl061->base + GPIOIBE);
>         writeb(pl061->csave_regs.gpio_iev, pl061->base + GPIOIEV);
>         writeb(pl061->csave_regs.gpio_ie, pl061->base + GPIOIE);
> 
> We write a number of u32 into u32 sized registers, this
> pl061->base is a void __iomem * so a pretty unsafe thing to
> begin with and then we add an offset to get to the register
> we want.
> 
> writel() on ARM for example turns into (arch/arm/include/asm/io.h):
> 
> static inline void __raw_writel(u32 val, volatile void __iomem *addr)
> {
>         asm volatile("str %1, %0"
>                      : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
> }
> 
> This is usually sprinkled all over a device driver, called in loops etc.
> Some of these will contain things like buffer drains and memory
> barriers. Elaborately researched for years so they will need to
> be there.
> 
> I have no clue how this thing would be expressed in Rust.
> Even less how it would call the right code in the end.
> That makes me feel unsafe and puzzled so this is a specific
> area where "the Rust way" needs to be made very tangible
> and easy to understand.
> 
> How would I write these 4 registers in Rust? From the actual
> statements down to the CPU instructions, top to bottom,
> that is what a driver writer wants to know.

Here's an example of how this could be implemented. Again, we're happy to
iterate on this (just like any other piece of software, independently of
language), but I think this will give you an idea. We'd begin with an
abstraction for a mapped io region:

pub struct IoMemBlock<const SIZE: usize> {
    ptr: *mut u8
}

Note here that we encode the size of the block at compile time. We'll get our
safety guarantees from it.

For this abstraction, we provide the following implementation of the write
function:

impl<const SIZE: usize> IoMemBlock<SIZE> {
    pub fn write<T>(&self, value: T, offset: usize) {
        if let Some(end) = offset.checked_add(size_of::<T>()) {
            if end <= SIZE {
                // SAFETY: We just checked above that offset was within bounds.
                let ptr = unsafe { self.ptr.add(offset) } as *mut T;
                // SAFETY: We just checked that the offset+size was within bounds.
                unsafe { ptr.write_volatile(value) };
                return;
            }
        }
        // SAFETY: Unimplemented function to cause compilation error.
        unsafe { bad_write() };
    }
}

Now suppose we have some struct like:

pub struct MyDevice {
    base: IoMemBlock<100>,
    reg1: u32,
    reg2: u64,
}

Then a function similar to your example would be this:

pub fn do_something(pl061: &MyDevice) {
    pl061.base.write(pl061.reg1, GPIOIS);
    pl061.base.write(pl061.reg2, GPIOIBE);
    pl061.base.write(20u8, 99);
}

I have this example here: https://rust.godbolt.org/z/chE3vjacE

The x86 compiled output of the code above is as follows:

        mov     eax, dword ptr [rdi + 16]
        mov     rcx, qword ptr [rdi]
        mov     dword ptr [rcx + 16], eax
        mov     rax, qword ptr [rdi + 8]
        mov     qword ptr [rcx + 32], rax
        mov     byte ptr [rcx + 99], 20
        ret

Some observations:
1. do_something is completely safe: all accesses to memory are checked.
2. The only unsafe part that could involve the driver for this would be the
creation of IoMemBlock: my expectation is that this would be implemented by the
bus driver or some library that maps the appropriate region and caps the size.
That is, we can also build a safe abstraction for this.
3. All checks are optimised away because they uses compile-time constants. The
code presented above is as efficient as C.
4. All code is Rust code and therefore type-checked during compilation, there is
no need for macros.
5. Note that the code supports all sizes, and selects which one to use based on
the type of the first argument (the example above has 8, 32, 64 bit examples).
6. If the developer writing a driver accidentally uses an offset beyond the
limit, they will get a compilation error (bad_write is left unimplemented).
Perhaps we could find a better way to indicate this, but a compilation error is
definitely better than corrupting state (potentially silently) at runtime.
7. We could potentially design a way to limit which offsets are available for a
given IoMemBlock, I just haven't thought through it yet, but it would also
reduce the number of mistakes a developer could make.


> If the result of the exercise is that a typical device driver
> will contain more unsafe code than not, then device drivers
> are not a good starting point for Rust in the Linux kernel.
> In that case I would recommend that Rust start at a point
> where there is a lot of abstract code that is prone to the
> kind of problems that Rust is trying to solve. My intuition
> would be such things as network protocols. But I may be
> wrong.

Agreed. But based on the example above, I don't expect a lot (if any) of unsafe
code in drivers due accessing io memory.

> This is really neat. I think it is a good example where Rust
> really provides the right tool for the job.
> 
> And it is very far away from any device driver. Though some
> drivers need pages.

Sure, I didn't mean to imply that this is useful in drivers, I just meant it as
an example.

> This is true for any constrained language. I suppose we could write
> kernel modules in Haskell as well, or Prolog, given the right wrappers,
> and that would also attain the same thing: you get the desired
> restrictions in the target language by way of this adapter.

Agreed. Rust is different in that it doesn't need a garbage collector, so it can
achieve performance comparable to C, which is something that we can't claim
about Haskell and Prolog atm -- I actually like Haskell better than Rust, but
it's not practical at the moment for kernel development.

> The syntax and semantic meaning of things with lots of
> impl <T: ?Sized> Wrapper<T> for ... is just really intimidating
> but I suppose one can learn it. No big deal.

I agree it's intimidating, but so are macros like ____MAKE_OP in bitfield.h --
the former has the advantage of being type-checked. Writing macros like
____MAKE_OP is a hit-and-miss exercise in my experience. However, I feel that
both cases benefit from being specialised implementations that are somewhat
rare.

> What I need to know as device driver infrastructure maintainer is:
> 
> 1. If the language is expressive enough to do what device driver
>    authors need to do in an efficient and readable manner which
>    is as good or better than what we have today.

What do you think of the example I provided above? I think that generics give
Rust an edge over C in terms of expressiveness, though abusing it may
significantly reduce readability.

> 2. Worry about double implementations of core library functions.

This indeed may be a problem, but I'm happy to have Rust wrappers call
C/assembly functions. With LTO this should not affect performance.

> 3. Kickback in practical problem solving.
> 
> This will be illustrated below.
> 
> Here is a device driver example that I wrote and merged
> just the other week (drivers/iio/magnetometer/yamaha-yas530.c)
> it's a nasty example, so I provide it to make a point.
> 
> static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
> {
>         u64 val = get_unaligned_be64(data);
> 
>         /*
>          * Bitfield layout for the axis calibration data, for factor
>          * a2 = 2 etc, k = k, c = clock divider
>          *
>          * n   7 6 5 4 3 2 1 0
>          * 0 [ 2 2 2 2 2 2 3 3 ] bits 63 .. 56
>          * 1 [ 3 3 4 4 4 4 4 4 ] bits 55 .. 48
>          * 2 [ 5 5 5 5 5 5 6 6 ] bits 47 .. 40
>          * 3 [ 6 6 6 6 7 7 7 7 ] bits 39 .. 32
>          * 4 [ 7 7 7 8 8 8 8 8 ] bits 31 .. 24
>          * 5 [ 8 9 9 9 9 9 9 9 ] bits 23 .. 16
>          * 6 [ 9 k k k k k c c ] bits 15 .. 8
>          * 7 [ c x x x x x x x ] bits  7 .. 0
>          */
>         c->a2 = FIELD_GET(GENMASK_ULL(63, 58), val) - 32;
>         c->a3 = FIELD_GET(GENMASK_ULL(57, 54), val) - 8;
>         c->a4 = FIELD_GET(GENMASK_ULL(53, 48), val) - 32;
>         c->a5 = FIELD_GET(GENMASK_ULL(47, 42), val) + 38;
>         c->a6 = FIELD_GET(GENMASK_ULL(41, 36), val) - 32;
>         c->a7 = FIELD_GET(GENMASK_ULL(35, 29), val) - 64;
>         c->a8 = FIELD_GET(GENMASK_ULL(28, 23), val) - 32;
>         c->a9 = FIELD_GET(GENMASK_ULL(22, 15), val);
>         c->k = FIELD_GET(GENMASK_ULL(14, 10), val) + 10;
>         c->dck = FIELD_GET(GENMASK_ULL(9, 7), val);
> }
> 
> This extracts calibration for the sensor from an opaque
> chunk of bytes. The calibration is stuffed into sequences of
> bits to save space at different offsets and lengths. So we turn
> the whole shebang passed in the u8 *data into a 64bit
> integer and start picking out the pieces we want.
> 
> We know a priori that u8 *data will be more than or equal
> to 64 bits of data. (Which is another problem but do not
> focus on that, let us look at this function.)
> 
> I have no idea how to perform this in
> Rust despite reading quite a lot of examples. We have
> created a lot of these helpers like FIELD_GET() and
> that make this kind of operations simple.

Would you mind sharing more about which aspect of this you feel is challenging?

I see now that Miguel has already responded to this thread so I'll stop here.
Happy to follow up on anything.

Thanks,
-Wedson
