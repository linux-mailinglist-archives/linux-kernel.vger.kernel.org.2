Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE023C2822
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhGIRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:17:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40DC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:15:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g5so15731242ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfAm236+ZW2LhRr62fKnJMwoIctKDz6MX0I8ooLV4Hk=;
        b=Ti/AAu6fROwptWF8bpkOULqE3NuqDJti9uO0acIPfDTodRUrNg0kunoeZmAMhw7eat
         XNCt4Hsw8+Erz0qFR24p9Jj/TCMmVPcVdzb6cKu894/aUOFKeqoGXZ2u3GaZMWRzo3vU
         K0YbzIvlfxGV4u/HDl9u7yhi0Z2G9bBsNMM94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfAm236+ZW2LhRr62fKnJMwoIctKDz6MX0I8ooLV4Hk=;
        b=JPN+ghJheXt8vzE2KrkoIgOM73Z0F6Qq4LpAiYiBU4QtAdvu48DOwClq6Dk1nd17et
         JvqJdlComzXHVTBqqyl9PRDpGn0pEMf6jNBg9seu+ODgudgHFObpxrrnxLxPxAk0jA/V
         1K7mxHX0F5ld1ynwd2+54yv3nWrNedCsS6SfskPZoc/MKLSNBkUNMGKJg8lqXAxHdG2j
         bb6MgHkcbBYP7oxoE7BPBYGMs0XglQtfnu1TO3tOfhtEnrJiIFerwn7qVva3ttA77XI1
         gB2jxd8ubPYiTWvnbne91DShHo3RdI2s4PG5wQCu2meo5GElgjM8+IhI+pWZ8VFESq58
         ox6g==
X-Gm-Message-State: AOAM531nSPjrFMzEroSvjEOJH5ngGyhmzERlFKtby53qZr4u8VaKnY2Z
        VdiNYlcAVoJLVSrB+n44LUGTBRwE47CilFG8N9XG
X-Google-Smtp-Source: ABdhPJyQNjjz+iD+y8t80vrh6c1jtsrqchb4uyODrpPHieb6ZiR1HsxyXwYB4IvCM86/upEIhDFi2E4YhoitiwyInY0=
X-Received: by 2002:a25:3bcb:: with SMTP id i194mr45897853yba.442.1625850900256;
 Fri, 09 Jul 2021 10:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210629134018.62859-1-xypron.glpk@gmx.de> <877di3mfbe.fsf@igel.home>
In-Reply-To: <877di3mfbe.fsf@igel.home>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 9 Jul 2021 10:14:49 -0700
Message-ID: <CAOnJCUJhYZbAL9dMReJt0=y9V33Ed1DaBCXGCdwxH8iUU3bcRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 12:07 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 29 2021, Heinrich Schuchardt wrote:
>
> > Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> > to boot SUSE Linux with GRUB on QEMU, cf.
> > https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
> >
> > Remove the constraint.
> >
> > Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> With that patch the image in
> http://download.opensuse.org/ports/riscv/tumbleweed/iso/ work again.
>

Thanks.
@palmer: Can you take this one in this cycle ?

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Regards,
Atish
