Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6683B462E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFYO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhFYO7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:59:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA71761976
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624633001;
        bh=OHAJngScxTflJC6y+iyde/Ux1VrinksxZhWYrn874TY=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=VQ+1eXIDiETjGnlnbRKfxcJfNLOzlR3Jj0gmkaAWCaiKeaYq5DuQeFKibUFulxKo3
         JOWZD5pVw6TJ43MZTTM2uh7A0HioQ0NgzNiGzB5ebV1xeDYCxi0FLoZrkkGDfja08m
         yxLoHRsRa3QcvmWSzIWZgYpgl3LHnw8mOBpqbgISU3Xml+S4tIRfnu2cdxJtrTE7i0
         tPThBE4PkDgVKr88d0yZqTTf/gSOEyjDsxmOK5w8hQ/94myN86k18PEl3K5NAf8RNL
         5yvk7TgVhSLuV1/eNRxok1LsFQW7OrbcsPDLNvRfmsDYp2ip6rEUG9c3noP9k6IDkB
         yc/V7/g/rJ+4g==
Received: by mail-lf1-f42.google.com with SMTP id i13so16725883lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:56:41 -0700 (PDT)
X-Gm-Message-State: AOAM532rkBi7ya2rTuN8fFqJ6Z633xiO/rN7rYaHo5+hZV5G8L1nzacg
        J8DpcazEQ3uASqT9HifIS6l1sFDfh0aZ0fp2qvk=
X-Google-Smtp-Source: ABdhPJym3ipYxPCJYO13wFC1xswqpU5a9NTpnZETeH3HBv8d3OQUt8tsZyH99Y/CJLnfI0/4pYnkoTCvgI+r1Zgsqw0=
X-Received: by 2002:a05:6512:744:: with SMTP id c4mr8540080lfs.296.1624633000064;
 Fri, 25 Jun 2021 07:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 25 Jun 2021 22:56:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mVoWiCibjq25d3Z8OvbWNO9p+vMo761RJLiD-BqVbqw@mail.gmail.com>
Message-ID: <CAGb2v66mVoWiCibjq25d3Z8OvbWNO9p+vMo761RJLiD-BqVbqw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] arm64: Add framework to turn an IPI as NMI
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        daniel.thompson@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        tsbogend@alpha.franken.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>, ito-yuichi@fujitsu.com,
        mpe@ellerman.id.au, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>, mingo@redhat.com,
        bp@alien8.de, julien.thierry.kdev@gmail.com,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>, msys.mizuma@gmail.com,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 7:46 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> With pseudo NMIs support available its possible to configure SGIs to be
> triggered as pseudo NMIs running in NMI context. And kernel features
> such as:
> - NMI backtrace can leverage IPI turned as NMI to get a backtrace of CPU
>   stuck in hard lockup using magic SYSRQ.
> - kgdb relies on NMI support to round up CPUs which are stuck in hard
>   lockup state with interrupts disabled.
>
> This patch-set adds framework to turn an IPI as NMI which can be triggered
> as a pseudo NMI which in turn invokes registered NMI handlers.
>
> After this patch-set we should be able to get a backtrace for a CPU
> stuck in HARDLOCKUP. Have a look at an examples below from a hard lockup
> testcase run on Developerbox:
>
> $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>
> NMI backtrace:
> ==============
>
> # Issue Magic SysRq to dump backtrace
>
> [  376.894502] NMI backtrace for cpu 8
> [  376.894506] CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
> [  376.894510] Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> [  376.894514] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
> [  376.894517] pc : lkdtm_HARDLOCKUP+0x8/0x18
> [  376.894520] lr : lkdtm_do_action+0x24/0x30
> [  376.894524] sp : ffff800012cebd20
> [  376.894527] pmr_save: 00000060
> [  376.894530] x29: ffff800012cebd20 x28: ffff000875ae8000
> [  376.894540] x27: 0000000000000000 x26: 0000000000000000
> [  376.894550] x25: 000000000000001a x24: ffff800012cebe40
> [  376.894560] x23: 000000000000000b x22: ffff800010fc5040
> [  376.894569] x21: ffff000878b61000 x20: ffff8000113b2870
> [  376.894579] x19: 000000000000001b x18: 0000000000000010
> [  376.894588] x17: 0000000000000000 x16: 0000000000000000
> [  376.894598] x15: ffff000875ae8470 x14: 00000000000002ad
> [  376.894613] x13: 0000000000000000 x12: 0000000000000000
> [  376.894622] x11: 0000000000000007 x10: 00000000000009c0
> [  376.894631] x9 : ffff800012ceba80 x8 : ffff000875ae8a20
> [  376.894641] x7 : ffff00087f6b3280 x6 : ffff00087f6b3200
> [  376.894651] x5 : 0000000000000000 x4 : ffff00087f6a91f8
> [  376.894660] x3 : ffff00087f6b0120 x2 : 1aa310cec69eb500
> [  376.894670] x1 : 0000000000000000 x0 : 0000000000000060
> [  376.894679] Call trace:
> [  376.894683]  lkdtm_HARDLOCKUP+0x8/0x18
> [  376.894686]  direct_entry+0x124/0x1c0
> [  376.894689]  full_proxy_write+0x60/0xb0
> [  376.894693]  vfs_write+0xf0/0x230
> [  376.894696]  ksys_write+0x6c/0xf8
> [  376.894699]  __arm64_sys_write+0x1c/0x28
> [  376.894703]  el0_svc_common.constprop.0+0x74/0x1f0
> [  376.894707]  do_el0_svc+0x24/0x90
> [  376.894710]  el0_sync_handler+0x180/0x2f8
> [  376.894713]  el0_sync+0x158/0x180
>
> KGDB:
> =====
>
> # Enter kdb via Magic SysRq
>
> [6]kdb> btc
> btc: cpu status: Currently on cpu 6
> Available cpus: 0-5(I), 6, 7(I), 8, 9-23(I)
> <snip>
> Stack traceback for pid 555
> 0xffff000875ae8000      555      554  1    8   R  0xffff000875ae89c0  bash
> CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
> Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
> Call trace:
>  dump_backtrace+0x0/0x1a0
>  show_stack+0x18/0x28
>  dump_stack+0xc0/0x11c
>  kgdb_cpu_enter+0x648/0x660
>  kgdb_nmicallback+0xa0/0xa8
>  ipi_kgdb_nmicallback+0x24/0x30
>  ipi_nmi_handler+0x48/0x60
>  handle_percpu_devid_fasteoi_ipi+0x74/0x88
>  generic_handle_irq+0x30/0x48
>  handle_domain_nmi+0x48/0x80
>  gic_handle_irq+0x18c/0x34c
>  el1_irq+0xcc/0x180
>  lkdtm_HARDLOCKUP+0x8/0x18
>  direct_entry+0x124/0x1c0
>  full_proxy_write+0x60/0xb0
>  vfs_write+0xf0/0x230
>  ksys_write+0x6c/0xf8
>  __arm64_sys_write+0x1c/0x28
>  el0_svc_common.constprop.0+0x74/0x1f0
>  do_el0_svc+0x24/0x90
>  el0_sync_handler+0x180/0x2f8
>  el0_sync+0x158/0x180
> <snip>
>
> Changes in v7:
> - Add a new library function: kgdb_smp_call_nmi_hook() to expose fallback
>   mechanism to arch specific code.
> - Addressed other misc comments from Daniel.
>
> Changes in v6:
> - Two new patches: #4 and #6 which adds runtime fallback framework for
>   sysrq backtrace and kgdb roundup features.
> - Reversed order of NMI backtrace and kgdb roundup feaure patches.
> - Addressed other misc. comments from Marc.
> - I haven't picked any tags from v5 since I think there is major rework
>   involved. Masayoshi, could you please confirm if these features still
>   work for you?
>
> Changes in v5:
> - Rebased to head of upstream master.
> - Remove redundant invocation of ipi_nmi_setup().
> - Addressed misc. comments.
>
> Changes in v4:
> - Move IPI NMI framework to a separate file.
> - Get rid of hard-coded IPI_CALL_NMI_FUNC allocation.
> - Add NMI backtrace support leveraged via magic SYSRQ.
>
> Changes in v3:
> - Rebased to Marc's latest IPIs patch-set [1].
>
> [1] https://lkml.org/lkml/2020/9/1/603
>
> Changes since RFC version [1]:
> - Switch to use generic interrupt framework to turn an IPI as NMI.
> - Dependent on Marc's patch-set [2] which turns IPIs into normal
>   interrupts.
> - Addressed misc. comments from Doug on patch #4.
> - Posted kgdb NMI printk() fixup separately which has evolved since
>   to be solved using different approach via changing kgdb interception
>   of printk() in common printk() code (see patch [3]).
>
> [1] https://lkml.org/lkml/2020/4/24/328
> [2] https://lkml.org/lkml/2020/5/19/710
> [3] https://lkml.org/lkml/2020/5/20/418
>
> Sumit Garg (7):
>   arm64: Add framework to turn IPI as NMI
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>   arm64: smp: Assign and setup an IPI as NMI
>   nmi: backtrace: Allow runtime arch specific override
>   arm64: ipi_nmi: Add support for NMI backtrace
>   kgdb: Expose default CPUs roundup fallback mechanism
>   arm64: kgdb: Roundup cpus using IPI as NMI

Tested-by: Chen-Yu Tsai <wens@csie.org>

on an ROC-RK3399-PC.
