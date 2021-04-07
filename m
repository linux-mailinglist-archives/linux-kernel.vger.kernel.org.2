Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7143565C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbhDGHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbhDGHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:48:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738DC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:48:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x207so17908430oif.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSkDmnD6jYWKdbDVG0d7Or7vQx48fRvJDXWQ+AEJf5o=;
        b=Ib1FObJ0TiZpb8fnrkhwNgmMTDO2qhjE7PsN/95QBFKc8TexrPjEUWjuVwACce0jHh
         hpYjctFVKcBp9YbuNeFRJMBs97CasPLpedql7aCyLTYcq41kGsI9SS1sW+DWbyPvRHWF
         2ZQmPjVBZpphloas7bFXTIpB7Sjm1afMojU+r29yVRtRgw7xC+vSHON2BLANH47RuRkg
         Y8t2w4zzACJui2vnFwnJpdFArHUt1oZaE4k7XCKh41EYIrf2xw4XJQfsQRz4NFhW0VWZ
         S8GU9gvlviaYaws21klr9b+AN/gUpYoJNU1WfaESaz22mCcXP/hXSWal7nZ/kksy+8es
         RjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSkDmnD6jYWKdbDVG0d7Or7vQx48fRvJDXWQ+AEJf5o=;
        b=q5wLaxHtZApqTZCm/ldcykSng9AGsSmGBkc+3cwSz+vIDmBoJTuIcsyiX/s3gAAays
         i23ay7V964+z+spdpZmiUCSI6PusQy5ZnriYq78Hzwc6o95cROH1L5uivTgEzRxuhRPc
         ngQhEOAd/kgvVB4gFybLKtrVnPOjEBHZjdz3tPStXR3yvUaDkZ0W5I0LGwPoe12UvuR4
         nr8D/WVSJI+AIVvFCzcPkkOlgbvqK1i7riHj5btHHo9l204w57cjLYjeVca0cML2yyqG
         EElxuON6kZIW2NXkayEjuTGL7EQDj5bNBYHc3HJs2abQmrVFgFwo4lacb7GrVM/qk4aM
         s0fg==
X-Gm-Message-State: AOAM531Ef4aEq4YFPg8BFjkrk5L1j4Q93s5BkLKnZOkd7pPB2Gx9AmI4
        1gyaY8+NrT0mzZXHrFi1nQg9pPBkSXpkrg/KkKtKtq0C
X-Google-Smtp-Source: ABdhPJzl64tM8CKIZ95YDdKpiWCoXJxnvV+k4J9fL5F8/0Uei93uZFyas9apbrXr2UCmvukuPvtwigRyQ4LSA08zxjk=
X-Received: by 2002:aca:b7d5:: with SMTP id h204mr1435846oif.18.1617781703030;
 Wed, 07 Apr 2021 00:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210405085712.1953848-1-mick@ics.forth.gr>
In-Reply-To: <20210405085712.1953848-1-mick@ics.forth.gr>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Wed, 7 Apr 2021 07:45:17 +0000
Message-ID: <CALecT5iJjxh_0+thLVib2psF9wh7m2Ev+V99jMnFHAzO9igtYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
To:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

On 4/5/21 8:57 AM, Nick Kossifidis wrote:
> This patch series adds kexec/kdump and crash kernel
> support on RISC-V. For testing the patches a patched
> version of kexec-tools is needed (still a work in
> progress) which can be found at:
>
> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>
> v3:
>   * Rebase on newer kernel tree
>   * Minor cleanups
>   * Split UAPI changes to a separate patch
>   * Improve / cleanup init_resources
>   * Resolve Palmer's comments
>
> v2:
>   * Rebase on newer kernel tree
>   * Minor cleanups
>   * Properly populate the ioresources tre, so that it
>     can be used later on for implementing strict /dev/mem
>   * Use linux,usable-memory on /memory instead of a new binding
>   * USe a reserved-memory node for ELF core header
>
> Nick Kossifidis (5):
>    RISC-V: Add EM_RISCV to kexec UAPI header
>    RISC-V: Add kexec support
>    RISC-V: Improve init_resources
>    RISC-V: Add kdump support
>    RISC-V: Add crash kernel support
>
>   arch/riscv/Kconfig                  |  25 ++++
>   arch/riscv/include/asm/elf.h        |   6 +
>   arch/riscv/include/asm/kexec.h      |  54 +++++++
>   arch/riscv/kernel/Makefile          |   6 +
>   arch/riscv/kernel/crash_dump.c      |  46 ++++++
>   arch/riscv/kernel/crash_save_regs.S |  56 +++++++
>   arch/riscv/kernel/kexec_relocate.S  | 222 ++++++++++++++++++++++++++++
>   arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
>   arch/riscv/kernel/setup.c           | 113 ++++++++------
>   arch/riscv/mm/init.c                | 110 ++++++++++++++
>   include/uapi/linux/kexec.h          |   1 +
>   11 files changed, 787 insertions(+), 45 deletions(-)
>   create mode 100644 arch/riscv/include/asm/kexec.h
>   create mode 100644 arch/riscv/kernel/crash_dump.c
>   create mode 100644 arch/riscv/kernel/crash_save_regs.S
>   create mode 100644 arch/riscv/kernel/kexec_relocate.S
>   create mode 100644 arch/riscv/kernel/machine_kexec.c
>

Just ask out of curiosity (maybe out of topic)..
Is crash analysis [1] capable of parsing RISC-V kdump image? No?

Or, any plan working on it?

[1] https://github.com/crash-utility/crash

Yxun Lan
