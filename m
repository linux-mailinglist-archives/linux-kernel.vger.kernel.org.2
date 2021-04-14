Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6335EC95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbhDNFy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233304AbhDNFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:54:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49CED611C9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618379671;
        bh=e0GvAqItKrgC7xw+mYTZm1jWGWMl1RtZC+QudRQVvVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AKyiMYAOp5u74Mfl8iLk7Sxh1yYch8Aicyz+bYIOBK6sJoTIco/QV2z1X/6ORQ8RO
         k13lHshi4pwQIEK3wXLN66kASyFjysW5HY5pK0v0qcksfMY1EgbEgAkDtK2uijwBU3
         uqLHomJ8D0hoNH0oaTyWU4NiyrcofypIE3IdiMVV+L1fAh8kNLtZpgeatZBL08UsxG
         x8u/OfJL3M/2EA6xntC5qiD/LPkeDXPjBryw2h8selY9QFa9MPqXpGUUe6Bjm2khZK
         vJBITiYaZMmWPlmUH62OTo0xpRX7sC30OeZTrkKNNi6CbJRVp5uM/o8ut0p+ILEGjL
         JMLwk0dKJ0V/w==
Received: by mail-lj1-f180.google.com with SMTP id l22so14642205ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:54:31 -0700 (PDT)
X-Gm-Message-State: AOAM530u5RN15j1JdVNCPgNjnaEXjkb33X+HSC9Ei5IKxatPwfxeZy0r
        yW91KLC4PPqi+GznVZWDLjFeeqH1/62uBAVizQ4=
X-Google-Smtp-Source: ABdhPJzLhQOFkp2cNfza5RPwNjXsLt4AjtmrFdQ9MA3JHT7YIse6wTSnxKU/n/GZ0uYgcHLjxzwDlxV5nnIYOxZkYsU=
X-Received: by 2002:a2e:919a:: with SMTP id f26mr22943414ljg.508.1618379669738;
 Tue, 13 Apr 2021 22:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net> <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
 <20210413104503.GD15806@arm.com> <73cab48b63ea4ba3b1ef532f47d146f4@AcuMS.aculab.com>
In-Reply-To: <73cab48b63ea4ba3b1ef532f47d146f4@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 14 Apr 2021 13:54:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTE54rDfFeVGbc0BL7br3hy+6oN6KMFQDx5+aKPSSviKw@mail.gmail.com>
Message-ID: <CAJF2gTTE54rDfFeVGbc0BL7br3hy+6oN6KMFQDx5+aKPSSviKw@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     David Laight <David.Laight@aculab.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 6:54 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Catalin Marinas
> > Sent: 13 April 2021 11:45
> ...
> > This indeed needs some care. IIUC RISC-V has similar restrictions as arm
> > here, no load/store instructions are allowed between LR and SC. You
> > can't guarantee that the compiler won't spill some variable onto the
> > stack.
>
> You can probably never guarantee the compiler won't spill to stack.
> Especially if someone compiles with -O0.
>
> Which probably means that anything using LR/SC must be written in
> asm and the C wrappers disabled.
Agree, and cmpxchg has been widely used in Linux. I think it's the
last requirement for complex atomic API, although cmpxchg has ABA
problem:

CPU0
                          CPU1
=======
                        ======
do {
  old32 = load32;

                               *ptr32 = new32_tmp;

                               *ptr32 = old32;
  load32 = cmpxchg(ptr32, old32, new32); //still success
} while (load32 != old32);

That means cmpxhg only cares about the result but not the middle
situation. It's different from LR/SC or AMO instructions.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
