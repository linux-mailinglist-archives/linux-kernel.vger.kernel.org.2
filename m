Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4699632ADED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360175AbhCBWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350878AbhCBUhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:37:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC7164F21;
        Tue,  2 Mar 2021 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614717373;
        bh=uZjEZpIetpV+hFdhoSnIL5zsoadYNrSIn5ew9suqCwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvLC87MaFvnJJDMhXcu0HWBmEd+/EjSjuP7/iApEZOtvzgkYh5Ht+NkWw1ntLbVyk
         5OHTfW793+crp8lXIeVsIuBb1fod6FO7QEAE/7O/+NXMtObx87O4DCQ2ZH+uvqDeMF
         K8y5I02VMJpIU75YTlWE25/QEtKIXKQp7agShLTOjCygu9boEpUCJ+eeCUbtKozUfm
         IRVa7dlArx0xpa/7LSi2mmuL727JLdjxJN3K7wj3RtBgtgDVQHD1jtwACDKiYOP3cf
         MI+YaSyJL8dOQkRdguYsgoKyBc6B7bOYD85DAYCwb3Fw4dJQ6pIouNRDIE4sI1EabU
         2RNNC+Q7O4VOQ==
Received: by mail-ot1-f47.google.com with SMTP id h10so10683376otm.1;
        Tue, 02 Mar 2021 12:36:13 -0800 (PST)
X-Gm-Message-State: AOAM532Mabag59bNpUCSYYY7k3uqaHxi7ZHAWfwiSV2onQvWlx+l1cBM
        wLjznI5ZEcAnVunFU7hd//ewjYoNlIRiF6nX4zc=
X-Google-Smtp-Source: ABdhPJy5LqwmQdNUTI4GHNVDze0j03fJULS/7XS7Zx7Hn47gzXxK/MeQKRSPDbvcFEEnUcJcg/H/Zhv1RizwMDzcFog=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr20154541otq.251.1614717372783;
 Tue, 02 Mar 2021 12:36:12 -0800 (PST)
MIME-Version: 1.0
References: <202103021826.7KKJWxQ2-lkp@intel.com> <CAKwvOdnCq7S68chEwSjFBPv5vsKDuzumOX19peOFDCSBCUm0jg@mail.gmail.com>
 <2e40a84f-15c6-2764-dcfd-9f5aa368b400@gmx.de> <CAKwvOdkXUAfYv415U9aE+ycLKT1rzujrBFfFHmvX47V5xHz1sA@mail.gmail.com>
 <fc099004-dbb4-b9b3-b377-ad459219c7c5@gmx.de> <YD6f2WqmYdJiNyQX@ls3530>
In-Reply-To: <YD6f2WqmYdJiNyQX@ls3530>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Mar 2021 21:35:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3H2c5-LE_TPkW4s8sHteKSM8FYtVUMCv9qCc20tVrniw@mail.gmail.com>
Message-ID: <CAK8P3a3H2c5-LE_TPkW4s8sHteKSM8FYtVUMCv9qCc20tVrniw@mail.gmail.com>
Subject: Re: hppa64-linux-ld: kernel/sched/core.o(.init.text+0x90): cannot
 reach printk
To:     Helge Deller <deller@gmx.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 9:28 PM Helge Deller <deller@gmx.de> wrote:
> * Helge Deller <deller@gmx.de>:
> > On 3/2/21 7:07 PM, Nick Desaulniers wrote:
> > > + Arnd
> > >
> > > On Tue, Mar 2, 2021 at 10:03 AM Helge Deller <deller@gmx.de> wrote:
> > > >
> > > >
> From: Helge Deller <deller@gmx.de>
> Date: Tue, 2 Mar 2021 21:07:07 +0100
> Subject: [PATCH] parisc: Enable -mlong-calls gcc option with
>  CONFIG_COMPILE_TEST
>
> The kernel test robot reported multiple linkage problems like this:
>
>     hppa64-linux-ld: init/main.o(.init.text+0x56c): cannot reach printk
>     init/main.o: in function `unknown_bootoption':
>     (.init.text+0x56c): relocation truncated to fit: R_PARISC_PCREL22F against
>         symbol `printk' defined in .text.unlikely section in kernel/printk/printk.o
>
> There are two ways to solve it:
> a) Enable the -mlong-call compiler option (CONFIG_MLONGCALLS),
> b) Add long branch stub support in 64-bit linker.
>
> While b) is the long-term solution, this patch works around the issue by
> automatically enabling the CONFIG_MLONGCALLS option when
> CONFIG_COMPILE_TEST is set, which indicates that a non-production kernel
> (e.g. 0-day kernel) is built.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 00e35f2b0e8a ("parisc: Enable -mlong-calls gcc option by default when !CONFIG_MODULES")
> Cc: stable@vger.kernel.org # v5.6+
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 4e53ac46e857..afc3b8d03572 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -203,9 +203,12 @@ config PREFETCH
>         def_bool y
>         depends on PA8X00 || PA7200
>
> +config PARISC_HUGE_KERNEL
> +       def_bool y if !MODULES || UBSAN || FTRACE || COMPILE_TEST
> +
>  config MLONGCALLS
> -       def_bool y if !MODULES || UBSAN || FTRACE
> -       bool "Enable the -mlong-calls compiler option for big kernels" if MODULES && !UBSAN && !FTRACE
> +       def_bool y if PARISC_HUGE_KERNEL
> +       bool "Enable the -mlong-calls compiler option for big kernels" if !PARISC_HUGE_KERNEL
>         depends on PA8X00
>         help
>           If you configure the kernel to include many drivers built-in instead


Looks good to me, we should probably do something similar on arm with
CONFIG_{ARM,ARM64}_MODULE_PLTS, though that only affects loadable
modules, as the linker would insert its own trampolines during the final
link when branch relocations are out of range.

      Arnd
