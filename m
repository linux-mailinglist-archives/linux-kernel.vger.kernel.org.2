Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DB13A9492
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFPIBR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Jun 2021 04:01:17 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:37820 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhFPIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:01:11 -0400
Received: by mail-ua1-f52.google.com with SMTP id f34so468421uae.4;
        Wed, 16 Jun 2021 00:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ok+NL5CmU/Ob0IX9KPH9BgLLQFejvOXElq4ySZvO/eg=;
        b=GMYFFijM+Jrxe+eHWUS/xuz/yvshwMnO1eGGNSGwuDMQivExCvCex49e9Xllf5B7Rv
         r1mkkP7n5VmFTZVRmuXEWQT2AHQGwnaAXnBKnJ1Pr6B7Wx8XtyqTJ7zMn2J1WBtd+jKH
         enPi02tBpfqiYC2N+LPJsY2w8fdC17lTGEwcvntdvSkijBuBDg2PJ8QSPHGPNRW8OA6p
         ECxi4QY/ZXvzDM0CHjB8Yerqnr1z+wCEFHlvzpWU3rAkIhWtpE+wK+MCF3kQmFJP7jWu
         8XD36x7OU5dTbHtY/rl2gLYMAMZBXPUQzPmWdd44m9ZsQXAsOHt4Xf7ZlXTqx1O1xDOM
         8Hgw==
X-Gm-Message-State: AOAM5305cr3rVEmLNBSZ/JcKa9ZzShMRp2Fq/N9eXgoY0PmBjEt3s7NN
        kscueIgSFwJrO3JU09DNTzJUV9hXm4u7Fos3PcA=
X-Google-Smtp-Source: ABdhPJwQclxKI9oMkHq5wLHstPwtEsioniamAyg9w4TFoM8Z0IMpscNcKv+xD94ZERSu4Luuuw60gUOzCY4HQzoD7j0=
X-Received: by 2002:ab0:288f:: with SMTP id s15mr2815194uap.2.1623830345737;
 Wed, 16 Jun 2021 00:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623780059.git.geert+renesas@glider.be> <8661d652968d050489852ccb50df5ad4cc048900.1623780059.git.geert+renesas@glider.be>
 <96476719da53fe67dbb91268e2ad7492@mailhost.ics.forth.gr>
In-Reply-To: <96476719da53fe67dbb91268e2ad7492@mailhost.ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 09:58:54 +0200
Message-ID: <CAMuHMdWjXFGHuT5OBcoyNrQ3C_+r3jnvGLsoDn-sv-yNe+GZVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: fdt: Add generic support for parsing elf core
 header properties
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Jun 16, 2021 at 1:28 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Στις 2021-06-15 21:17, Geert Uytterhoeven έγραψε:
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>
> I believe drivers/of/kexec.c is better suited for this.

From an earlier response from me to a comment from Rob:

| > Also, note that there is now a drivers/of/kexec.c (in -next) though
| > not sure if all this would go there or stay in fdt.c with the rest of
| > the memory parsing.
|
| It's gonna be the latter, as that file handles the FDT during early
| kernel startup, for both normal and kdump kernels.
|
| Despite the name, drivers/of/kexec.c is not for kexec, but for
| kexec_file.  This is the "new" fancy syscall that prepares the DTB
| for the new kernel itself, unlike the classic kexec syscall, where
| userspace is responsible for preparing the DTB for the new kernel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
