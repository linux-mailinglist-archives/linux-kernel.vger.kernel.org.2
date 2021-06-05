Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEA39C6B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:04:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40AC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 01:02:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o27so11714555qkj.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3vs5/z/aVaz7sVwe8HZzwxt5fKtTmUCCoC6h+qr0pU=;
        b=n1OCSbuKQ8GmZqJs4O9nG2OBAKjoH25SuGqPdI6xaC8Sg9XtLLCRKwVVTOo7BbfHH6
         Cgsbqwfg4VXRaIW6HJEdTLf2xB80fXzt85G41DXzyZ1Q/s3SJx8ru7JDKe1L8j74M0sO
         7iW/WA4xtxMUcj7mpw0Zv2G0nUe3h+hJRzRB/KMPP1Y2YbCLSGrLlm8jQ/BpuTY8m0VE
         1wgCNSg61bZcELyozQ26XeOCUmZzsFRhGsK6Ii9W2c7O5ij6RX+L+M1bsEFAg7SZEfeW
         yzD1aRgS2qx+ILwIVbj8estvzJoITPiBjsMCcf0SKWfEhbGFqhiepojoY3JQff20RVrF
         H/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3vs5/z/aVaz7sVwe8HZzwxt5fKtTmUCCoC6h+qr0pU=;
        b=LHXpNxxywfQBA/+e9adPhDtA2qtggvaAjgdo2WPYoiMZY2YZ7JCMmKhvHS0Xm/Ayjh
         BVZqgoqA9/uoCd/oWv5w1eqRXTxaxKCik1JwoAI5dwVRguVsrdSPEPW4J0ubboEF0tLj
         yOCkNjXzBIxx/1dD8rrMfGjpg2CmWgIHZOlsb9rGy8JeyjWK1MzxNrhjinUU7cBy/FHO
         VDtdppecJ8X4ZCgD2a96E5GgOi2fAWhBgsE8f3ujgZPiMl8peLRdx+s2z4nEd6/nYZpG
         fywdy9r8JDNx4eZeG7Ys8jBaQIc3Jc/1EblKuZdfWT2zl/VrOYySy7eEhpLCldNgvQ/u
         XFAg==
X-Gm-Message-State: AOAM530ym0m6eUzxsiJaoEAg26Lh5sWXfgEBCPIRfLHgFs3Pr+v7vqxt
        5T3cIAv3RYDOiHEurGY1GxzSkKBAditlGLk7GWs=
X-Google-Smtp-Source: ABdhPJwQFYERWKhbbdBsVEWBnlIGuPXaC/4w6fI7rhWIUXxXf5ThvRnqz7YVnn9DApWcnfYqWAjI57KP2+ijKoMblpE=
X-Received: by 2002:a37:6f85:: with SMTP id k127mr853833qkc.178.1622880175907;
 Sat, 05 Jun 2021 01:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CACuRN0NjftJDUAsF2pkXbx0jnJ=bba9+j-hJA8Mjj0r4RVicLA@mail.gmail.com>
 <mhng-a3a53753-73e5-4676-93d3-33c4b8760283@palmerdabbelt-glaptop>
In-Reply-To: <mhng-a3a53753-73e5-4676-93d3-33c4b8760283@palmerdabbelt-glaptop>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Date:   Sat, 5 Jun 2021 17:02:44 +0900
Message-ID: <CACuRN0MV4zNj1rBTnppoSudy98aOj2Pj6Ld1+D8mz0fn8kxGtg@mail.gmail.com>
Subject: Re: [PATCH 0/1] riscv: better network performance with memcpy, uaccess
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        linux-riscv@lists.infradead.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 1:19 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 04 Jun 2021 02:53:33 PDT (-0700), akira.tsukamoto@gmail.com wrote:
> > I am adding a cover letter to explain the history and details since
> > improvement is a combination with Gary's memcpy patch [1].
> >
> > Comparison of iperf3 benchmark results by applying Gary's memcpy patch and
> > my uaccess optimization patch. All results are from the same base kernel,
> > same rootfs and save BeagleV beta board.
> >
> > First left column : beaglev 5.13.rc4 kernel [2]
> > Second column     : Added Palmer's memcpy in C + my uaccess patch [3]
> > Third column      : Added Gary's memcpy + my uaccess patch [4]
> >
> > --- TCP recv ---
> > 686 Mbits/sec  |  700 Mbits/sec  |  904 Mbits/sec
> > 683 Mbits/sec  |  701 Mbits/sec  |  898 Mbits/sec
> > 695 Mbits/sec  |  702 Mbits/sec  |  905 Mbits/sec
> >
> > --- TCP send ---
> > 383 Mbits/sec  |  390 Mbits/sec  |  393 Mbits/sec
> > 384 Mbits/sec  |  393 Mbits/sec  |  392 Mbits/sec
> >
> > --- UDP send ---
> > 307 Mbits/sec  |  358 Mbits/sec  |  402 Mbits/sec
> > 307 Mbits/sec  |  359 Mbits/sec  |  402 Mbits/sec
> >
> > --- UDP recv ---
> > 630 Mbits/sec  |  799 Mbits/sec  |  875 Mbits/sec
> > 730 Mbits/sec  |  796 Mbits/sec  |  873 Mbits/sec
> >
> >
> > The uaccess patch is reducing pipeline stall of read after write (RAW)
> > by unroling load and store.
> > The main reason for using assembler inside uaccess.S is because the
> > __asm_to/copy_from_user() handling page fault must be done manually inside
> > the functions.
> >
> > The above result is combination from Gary $B!G (Bs memcpy speeding up
> > by reducing
> > the S-mode and M-mode switching and my uaccess reducing pipeline stall for
> > user space uses syscall with large data.
> >
> > We had a discussion of improving network performance on the BeagleV beta
> > board with Palmer.
> >
> > Palmer suggested to use C-based string routines, which checks the unaligned
> > address and use 8 bytes aligned copy if the both src and dest are aligned
> > and if not use the current copy function.
> >
> > The Gary's assembly version of memcpy is improving by not using unaligned
> > access in 64 bit boundary, uses shifting it after reading with offset of
> > aligned access, because every misaligned access is trapped and switches to
> > opensbi in M-mode. The main speed up is coming from avoiding S-mode (kernel)
> > and M-mode (opensbi) switching.
> >
> > Processing network packets require a lot of unaligned access for the packet
> > header, which is not able to change the design of the header format to be
> > aligned.
> > And user applications pass large packet data with send/recf() and sendto/
> > recvfrom() to repeat less function calls for reading and writing data for the
> > optimization.
>
> Makes sense.  I'm still not opposed to moving to a C version, but it'd
> need to be a fairly complicated one.  I think having a fast C memcpy
> would likely benefit a handful of architectures, as everything we're
> talking about is an algorithmic improvement that can be expressed in C.
>
> Given that the simple memcpy doesn't perform well for your workload, I'm
> fine taking the assembly version.

Thanks, for merging them.

I agree that having a fast C memcpy would benefit many architectures.
I will make the patches for lib/string.c by extending your memcpy and send
them after I finish other priorities. The current functions in lib/string.c
use a byte copy, while most linux capable cpus moved to 64 bits.

Akira

>
> Thanks!
>
> >
> > Akira
> >
> > [1] https://lkml.org/lkml/2021/2/16/778
> > [2] https://github.com/mcd500/linux-jh7100/tree/starlight-sdimproved
> > [3] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-palmer-string
> > [4] https://github.com/mcd500/linux-jh7100/tree/starlight-sd-gary
> >
> > Akira Tsukamoto (1):
> >   riscv: prevent pipeline stall in __asm_to/copy_from_user
> >
> >  arch/riscv/lib/uaccess.S | 106 +++++++++++++++++++++++++++------------
> >  1 file changed, 73 insertions(+), 33 deletions(-)
