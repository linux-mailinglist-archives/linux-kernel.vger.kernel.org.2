Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96F45F5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhKZUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhKZUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:42:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B62C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:33:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b68so9913633pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=su3YaAtYA3Jm75i9GGPnHnjOmzDIJJuzGPL8eq2UD7s=;
        b=D2BMGYkQ/wHLSfqcV8r7k0xgHB7HxWaHznGtHQ0XNUobSsRUMivzhLU0iBhauEHpkZ
         1Km14sCr0S2Q9RrzNCh9D7quHUYuafNdqnOOiVwxKN2caZH3QhYiBF8im0o6yC42zSDY
         Q22qPsF+gqz3lSVo4nWxWGi1d5dnYQ+4C8l6uhi0MgR6I1NwBHm4Ssk9kpXMR1fnnqB1
         gwxH2ObFnczDTV+3G4gAbQPaIk8SxwD8P2naUY4tGoNN4GBgm+kl7I0pvQ7NfhqZFmpR
         ujzc2reEju+HDg/A0ptNa5UeY7r/21r6DTsiQzUCJaIfcQch1aT2C+fdfg2dltqLd0uo
         1F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=su3YaAtYA3Jm75i9GGPnHnjOmzDIJJuzGPL8eq2UD7s=;
        b=mWcDO4MWvWrs1rBUE1YNRD0x5PkW+ZViZsLd1nTidV7+8rhou8Ei7tZ9bCLnAK3NSW
         8AGjpLNOFYyJk1S4hBOM/kHChVcWDyf8daAvYAsZJ8kFJ9DoGlOwLB5u0fYsc0Bsra4m
         EQC1uFWMXmmNvC5JZQAGA9fpkFC7tzDfZWhDDMq+0xGtSgmSV3UUxmHJqj0WEzKOy1C7
         okxiHi3yKj6Cmj6018ghxrTF2lcMpWpXNKqY/hD7DVw3QJA3+b8DQIJwll1LXR3w00Oj
         CnbVqBB2dvPaP0TlLrBW9o5eWWcjdE+1pSXA6mKW9zXLi5O5aybTxUiZ96vBTpwELdHn
         7ACg==
X-Gm-Message-State: AOAM533GRm60A31UpJrBRQSipr3N+4mzoLWZz3wChKy2N2k0bpR6kfTU
        VjnBeN+SolS7IgiW3GmobL5VH55bP/o83qgLo/g=
X-Google-Smtp-Source: ABdhPJxM1vi5dMbXGJm+eGOMKg6HeXT5ik1Q39qdSa+CORNzQyeMO5R76fqvAd2vwsAiLkNGbkJOw7Qy7IqzTCaLT0I=
X-Received: by 2002:a63:1b1a:: with SMTP id b26mr23279089pgb.338.1637958822426;
 Fri, 26 Nov 2021 12:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
 <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
 <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
 <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com> <CANn89iKkK0eMQkOTSMGbvdtf+G=eRfXJG0Semju5h-C63QytaQ@mail.gmail.com>
In-Reply-To: <CANn89iKkK0eMQkOTSMGbvdtf+G=eRfXJG0Semju5h-C63QytaQ@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 14:33:31 -0600
Message-ID: <CAFUsyf+9F9b2V-YDm8UdbnANrQ0_fYV6cGfRgPciASfvp9p=7w@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:07 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 11:50 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > Bright :) but it will need a BMI support check.
>
> Yes, probably not worth the pain.

Making a V2 for my patch with your optimization for the loop case. Do you think
1 or 2 accum for the 32 byte case?
>
> >
> > I actually get better performance in hyperthread benchmarks with 2 accum:
> >
> > Used:
> >
> >         u64 res;
> >         temp64 = (__force uint64_t)sum;
> >         asm("movq 0*8(%[src]),%[res]\n\t"
> >             "addq 1*8(%[src]),%[res]\n\t"
> >             "adcq 2*8(%[src]),%[res]\n\t"
> >             "adcq   $0, %[res]\n"
> >             "addq 3*8(%[src]),%[temp64]\n\t"
> >             "adcq 4*8(%[src]),%[temp64]\n\t"
> >             "adcq   %[res], %[temp64]\n\t"
> >             "mov  %k[temp64],%k[res]\n\t"
> >             "rorx $32,%[temp64],%[temp64]\n\t"
> >             "adcl %k[temp64],%k[res]\n\t"
> >             "adcl $0,%k[res]"
> >             : [temp64] "+r"(temp64), [res] "=&r"(res)
> >             : [src] "r"(buff)
> >             : "memory");
> >         return (__force __wsum)res;
> >
> > w/ hyperthread:
> > size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
> >   40,       6.511,       7.863,       6.177,       6.157
> >
> > w/o hyperthread:
> > size,    2acc lat,    1acc lat,   2acc tput,   1acc tput
> >   40,       5.577,       6.764,       3.150,       3.210
