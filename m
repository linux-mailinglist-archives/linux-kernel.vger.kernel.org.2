Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2931C98E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBPLSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBPLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:18:25 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:17:43 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b14so9051094qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yi48HIfDpj5+7cpoyDCNHw6yQcq1pcG1ot9n73mhd0=;
        b=YxaffVO7zp8rEiGeTbUX5Ki7tJ11g4dLfSxGlgdZKFGK+KHuDT0SyDQ4UZT9KqKHnJ
         PoA1Jd/7CZfFmqu6gfGH0WTjueyUz5dR778ADBSSVfKqYgCXQYzhrrn15o8FvpD3wahn
         cZzilJtE3Y+oxQ1168aV2Ewfth8SUlPyWcfrTkiETPp5e6qIytcY4Ru3vRwC3Ret2fnY
         s8+DxfClW49UgRZhNDCa0sxVclRXzpZQ6WqMZS3krzNGOYK6niAh5aDw2gkWU8GGQkc7
         fFfyB6OaiYnO3EsONDuqdH5L8VvZ/tfU9NlpKMSddG3pc4SkYCOC98ACXwOnK6t0+wQc
         SGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yi48HIfDpj5+7cpoyDCNHw6yQcq1pcG1ot9n73mhd0=;
        b=Odf7pO4xj2Net9XfWZKRNhY6lsrt1myYDWvFs5ERkwF8f53+Mtk+rggzoUn3Sr6b+6
         eCNAC1MCcBbiYBM08TIqhK9APQJv1ba32dniOdw0Af1i1g0JaFjNeHikDoxkVbVymKnn
         29c0roJ/KsX9sMeywk3xzr6464nufwvzV4soKIRheOSvThwRCJgMx4xrPDmXvlQlfDTi
         HsNJaCb5kMdgT9yPL1DXEVJwVGMS6tiHe3BmLEYWhpyzKKg5MY5+ppMNKaKu/Thkkvc9
         g2RQKtHjK9Rm5HqTWGXSd5+P/Wxq+WD9BTz72zHlGcOzaM0+tWsZ1tuMW4PyDvgLx/AG
         iGWA==
X-Gm-Message-State: AOAM531HtfufLqWHvdrMxEmJUtWxHzNLIH0SabQFU8gMy87RhyTM2d+a
        dwOscbKitPM6kullpwasiEIi8f6lZScCQlXK2DYivg==
X-Google-Smtp-Source: ABdhPJw2r0P+hO2e4Iij8XvdrpsMfa2arPuuYzhNYRXRfcj44xEPwBv3l/b8pplhPflEoRK8Fk16ikz1mbXxTpXZixg=
X-Received: by 2002:a37:a757:: with SMTP id q84mr18474346qke.501.1613474262101;
 Tue, 16 Feb 2021 03:17:42 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bDqMiC+ou5ghb=XB3Oyjw3p-GTDvNw4NkkQqQthw1yuQ@mail.gmail.com>
 <mhng-02b88d43-ede8-48f9-82f1-c84201acb7a8@palmerdabbelt-glaptop>
 <CACT4Y+aN3LvgaBc_zmW=t=D7ChU-jrWYnjt5sZ2GEDQhg_BC9A@mail.gmail.com>
 <CACT4Y+aC19DaNOm87EO3cER2=MEmO9pmtUxzVmRtg9YhZKuMVA@mail.gmail.com>
 <20210118145310.crnqnh6kax5jqicj@distanz.ch> <CACT4Y+bFV6m1LCYb1nO7ioKJK99916D76sJ+H-LgBjWx6biF5w@mail.gmail.com>
 <CACT4Y+bmDKNnykeTP9yKjje3XZjbXY3De+_e3fMFOMoe0dnARw@mail.gmail.com>
 <6e9ee3a1-0e16-b1fc-a690-f1ca8e9823a5@ghiti.fr> <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
In-Reply-To: <CACT4Y+adSjve7bXRPh5UybCQx6ubOUu5RbwuT620wdcxHzVYJg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Feb 2021 12:17:30 +0100
Message-ID: <CACT4Y+ZNJBnkKHXUf=tm_yuowvZvHwN=0rmJ=7J+xFd+9r_6pQ@mail.gmail.com>
Subject: Re: riscv+KASAN does not boot
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        LKML <linux-kernel@vger.kernel.org>, nylon7@andestech.com,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 9:11 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > I was fixing KASAN support for my sv48 patchset so I took a look at your
> > issue: I built a kernel on top of the branch riscv/fixes using
> > https://github.com/google/syzkaller/blob/269d24e857a757d09a898086a2fa6fa5d827c3e1/dashboard/config/linux/upstream-riscv64-kasan.config
> > and Buildroot 2020.11. I have the warnings regarding the use of
> > __virt_to_phys on wrong addresses (but that's normal since this function
> > is used in virt_addr_valid) but not the segfaults you describe.
>
> Hi Alex,
>
> Let me try to rebuild buildroot image. Maybe there was something wrong
> with my build, though, I did 'make clean' before doing. But at the
> same time it worked back in June...
>
> Re WARNINGs, they indicate kernel bugs. I am working on setting up a
> syzbot instance on riscv. If there a WARNING during boot then the
> kernel will be marked as broken. No further testing will happen.
> Is it a mis-use of WARN_ON? If so, could anybody please remove it or
> replace it with pr_err.


Hi,

I've localized one issue with riscv/KASAN:
KASAN breaks VDSO and that's I think the root cause of weird faults I
saw earlier. The following patch fixes it.
Could somebody please upstream this fix? I don't know how to add/run
tests for this.
Thanks

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 0cfd6da784f84..cf3a383c1799d 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -35,6 +35,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
+KASAN_SANITIZE := n

 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
