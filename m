Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1743C5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhJ0JBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:01:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54080
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241138AbhJ0JB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:01:28 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CAA813F172
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635325142;
        bh=a9x0VT35zZ6DKokrr3tUZmRN5kTv6DVJhdONoSV2YHg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Wmd9duBlxuXSt9PsDzNLhXnOS+hoq7r0LgbdivvSo7xpxyS4GLmZKvURsGZdTV3ba
         EUDYdSg1dCvzLZO1XYpIMthuEjqWaf9mK34QRdE/7WpHRKmzKevdOYECnVg1G9WlEI
         ktsl9dbuIUcelhxsIZGEG/FiTkNvZTwQ1OQyj9tLRqFi5Hc+8R/31cwCDM27rNKmAY
         HTVAS3FV+Q7zzfCwaPce7NDyArO5OqlVhoKzxfEsUpT9cfFt3oExOHiOLs3gmOQ+rB
         qOQg1tEEdqWTAWqF5jb/P2/50CyWxefEfG0roC82OXZ636F+dfxZTsvqjpfDAMCW7B
         6vkkSAdlnEHIg==
Received: by mail-ed1-f70.google.com with SMTP id t1-20020a056402524100b003dd9a419eb5so1701732edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9x0VT35zZ6DKokrr3tUZmRN5kTv6DVJhdONoSV2YHg=;
        b=5Qow276jMDCM2ImdTD5vijE0Zhgn2iWBFYdMKn4H0xGcAFDnhKO9ErTgQwNKTBx8A+
         O8IAn8y5OrGHNlKMTIVYfkjq8ey4yUwxoVha+oLCHhyVFOp8ZYMv31+xBwM3t2hbgSGy
         Daw0HacCuBS0zItfXNW1+pOSBv+/iZj/uJ2wQvmYPYEoCxVX4g6vFyjS3LJ3A5gR3ziU
         HjYJSnhRVJFJa73XQY6mgRsxb1gdYgkMa4SfXmyloxlJRQVy4d89hfFT/To83jsfyjce
         K1ZNP3LfYRjkig6C7+ytOZ5lAHRrO2myvHPXKQfIuvA4feUO/LCvllRqQhk8M/FkROLR
         g2RA==
X-Gm-Message-State: AOAM530rQpQll67epKz0UARUo4j4VadIRymxfu91PRFjBSYRMsToHgja
        TXBMy1qKQ7gmmHwaweuNpVYzZKdWL/FLwMHtqTlnUni0feRDeUOMWjSTceCFOlimg1Yd+qzZaG2
        dWtJqWv8t/y8MLgFT8UweFoVjRUFe4lyyUnTESMWuqkwJIoXuhaHtrX/X9g==
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr12537373ejc.156.1635325141458;
        Wed, 27 Oct 2021 01:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVKzkkb7tEEtIpvhL9AV3Q+PLqfs6DJ4yTteGGG8ihHj8wuZo0CiHvCyo/76FzZ/nHMUnn7I4Mj8zmvSHSzvk=
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr12536862ejc.156.1635325135141;
 Wed, 27 Oct 2021 01:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211026212847.43108-1-palmer@dabbelt.com> <87mtmuaodc.fsf@igel.home>
In-Reply-To: <87mtmuaodc.fsf@igel.home>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 27 Oct 2021 10:58:44 +0200
Message-ID: <CA+zEjCuRuKtZAhkS_RFyby6UhLvYmg=4BdnXEwUdaCdtbB7ZAA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, alex@ghiti.fr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:03 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Okt 26 2021, Palmer Dabbelt wrote:
>
> > +config RELOCATABLE
> > +     bool "Build a relocatable kernel"
> > +     depends on MMU && 64BIT && !XIP_KERNEL
> > +     help
> > +          This builds a kernel as a Position Independent Executable (PIE),
> > +          which retains all relocation metadata required to relocate the
> > +          kernel binary at runtime to a different virtual address than the
> > +          address it was linked at.
> > +          Since RISCV uses the RELA relocation format, this requires a
> > +          relocation pass at runtime even if the kernel is loaded at the
> > +          same address it was linked at.
>
> When in doubt, do what?

Then do not enable. it will be automatically selected by other configs
like KASLR, but otherwise you should not say yes since you'll just
have an identical slightly slower kernel.

But I imagine you mean adding a default value for this config? That
sounds right and it should be "default n".

Alex

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
