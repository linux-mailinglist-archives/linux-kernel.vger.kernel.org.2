Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBC442949
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKBIZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKBIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:24:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7CC061764;
        Tue,  2 Nov 2021 01:22:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p16so41399169lfa.2;
        Tue, 02 Nov 2021 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ne7EPu6jTpGVLHdvimehHVoEG1G7OTA5OiY+BOnLe4A=;
        b=PjUNJMcSRJ62akTQe/diEaqWuErpiYU8V09h41nU2mp9HKydnky/bk6OV2dQuyewS2
         S9RuIpT48CK73n4qcfBiHUYtyhouUpWA0+J54GBgSj7yynd2vT4DW8fv4ahrzlsrT0E6
         /lijxNB4x8IwycViFV+jzEaUZm/3pQxtQJf916W/qvzbddRwXkIOIm4OiMVLn/WIZ/DY
         N5odBUKp0BxW4l3NBxeuLswtCe3PZ5pflo9kkmST1Cs2eJToB0wimMkmOPSuyQTpfxUg
         oA9KmxcFF04RD5lgmyzKxuHhhF7bgKu7R5M+jFKRFH6KtY1r31FAMN4zM91jGi33Xl0z
         BFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ne7EPu6jTpGVLHdvimehHVoEG1G7OTA5OiY+BOnLe4A=;
        b=1WFLEUF16Ai7gOsHSqGBy/gsqn3ghIsMr0ZOnaIyQMzg9FxHIhe/GSOd1pCRzhmSgJ
         A+23GYFvan8gBDS5jMGfD9IUugvbtyd55BGw9cPC8s6wvoNjBOgly1YZi6qYDL4KJ5qB
         8DOgy3ExtgsPVO+0qf7PFrRYyuFh0/foVVpOcgawrWUWmkdQVoYE3wJp8VXAou7y6Fij
         C18AzTeiiD3s66uNIyQhbxAa4Z7gpyVIf76z+ra74UwRLQAVIPB6vnpoAduyjsUrZ/YW
         XTO06qZkABY+0IYElKEy3MU1MLwv3SfHOKf8D8y8kvDLnE0QfzFoDG4n7651WAN7rT0K
         yuGA==
X-Gm-Message-State: AOAM530bR1n1ELHva8LRKZdm2qD3R2nDuDI6sqUjEMMMEJfcDN/jWaCE
        ziucLvUbU1ZJOxFRTyuIwuCxZvllLnEL/04D0A==
X-Google-Smtp-Source: ABdhPJz2sTRMCaO5nz6DI/gO9EPlcsOXPYF/+nvlvqLAyf4DhHKZV4nnIz1ld2TtCyuBcBxPgayITk4DR6CTKXKkKxk=
X-Received: by 2002:a05:6512:3c9e:: with SMTP id h30mr2097037lfv.93.1635841334320;
 Tue, 02 Nov 2021 01:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-12-lukas.bulwahn@gmail.com> <CAK8P3a0Nq9hLbGiPCQTjVTiGFPR9-tdhN8Tf06Q=cWTgMK78yw@mail.gmail.com>
 <CACPK8XfiN5qziPHLU6J=bC34mcjz+ix7jjSX=xk9zsr7+vyTdw@mail.gmail.com> <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com>
In-Reply-To: <CAKXUXMyrhrM2o-OEW_qTTKjfKgxt-Z6Nt69geU80AoFnM1OuMA@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Tue, 2 Nov 2021 10:22:03 +0200
Message-ID: <CAKKbWA7OiU_pp33=EQoCTOeyd3Ecmm-dtTFeu1VB_Xcpt0gMvg@mail.gmail.com>
Subject: Re: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At Nuvoton we implied this WA in the past, not because we encountered
a specific problem but since the errata says so and we saw this in
other patches like:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/1396298072-13254-2-git-send-email-nitin.garg@freescale.com/
But we didn't upstream the arch/arm/mm/proc-v7.S

From the errata document.
"794072 A short loop including a DMB instruction might cause a denial
of service on
another processor which executes a CP15 broadcast operation
Status
Affects:
Fault Type:
Fault Status: Cortex-A9 MPCore.
Programmer Category B
Present in: All r1, r2, r3 and r4 revisions Open
Description
A processor which continuously executes a short loop containing a DMB
instruction might prevent a CP15
operation broadcast by another processor making further progress,
causing a denial of service.
Configurations affected
This erratum affects all Cortex-A9 MPCore processors with two or more
processors.
Conditions
The erratum requires the following conditions:
- Two or more processors are working in SMP mode (ACTLR.SMP=1)
- One of the processors continuously executes a short loop containing
at least one DMB instruction.
- Another processor executes a CP15 maintenance operation that is
broadcast. This requires that this
processor has enabled the broadcasting of CP15 operations (ACTLR.FW=1)
For the erratum to occur, the short loop containing the DMB
instruction must meet all of the following additional
conditions:
- No more than 10 instructions other than the DMB are executed between each DMB
- No non-conditional Load or Store, or conditional Load or Store which
pass the condition code check, are
executed between each DMB
When all the conditions for the erratum are met, the short loop
creates a continuous stream of DMB instructions.
This might cause a denial of service, by preventing the processor
executing the short loop from executing the
received broadcast CP15 operation. As a result, the processor that
originally executed the broadcast CP15
operation is stalled until the execution of the loop is interrupted.
Note that because the process issuing the CP15 broadcast operation
cannot complete operation, it cannot enter
any debug-mode, and cannot take any interrupt. If the processor
executing the short loop also cannot be
interrupted, for example if it has disabled its interrupts, or if no
interrupts are routed to this processor, this
erratum might cause a system livelock.
Implications
The erratum might create performance issues, or in the worst case it
might cause a system livelock if the
processor executing the DMB is in an infinite loop that cannot be interrupted.
Workaround
This erratum can be worked round by setting bit[4] of the undocumented
Diagnostic Control Register to 1. This
register is encoded as CP15 c15 0 c0 1.
This bit can be written in Secure state only, with the following
Read/Modify/Write code sequence:
MRC p15,0,rt,c15,c0,1
ORR rt,rt,#0x10
MCR p15,0,rt,c15,c0,1
When it is set, this bit causes the DMB instruction to be decoded and
executed like a DSB.
Using this software workaround is not expected to have any impact on
the overall performance of the processor
on a typical code base.
Other workarounds are also available for this erratum, to either
prevent or interrupt the continuous stream of
DMB instructions that causes the deadlock. For example:
- Inserting a non-conditional Load or Store instruction in the loop
between each DMB
- Inserting additional instructions in the loop, such as NOPs, to
avoid the processor seeing back to back
DMB instructions.
- Making the processor executing the short loop take regular interrupts."

Avi

On Tue, Nov 2, 2021 at 9:31 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Oct 29, 2021 at 8:36 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 28 Oct 2021 at 14:57, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > >
> > > > There is no and never was a Kconfig for ARM_ERRATA_794072 in the kernel
> > > > tree. So, there is no need to select ARM_ERRATA_794072 in
> > > > ./arch/arm/mach-npcm/Kconfig.
> > > >
> > > > Simply drop selecting the non-existing ARM_ERRATA_794072.
> > > >
> > > > This issue was discovered with ./scripts/checkkconfigsymbols.py.
> > > >
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > ---
> > >
> > > Could this be a typo? Maybe we need to enable a different errata workaround
> > > here, or maybe that code is actually needed and has to get sent.
> >
> > Doing some searching, u-boot had a workaround for something called
> > ARM_ERRATA_794072.
> >
> > https://github.com/u-boot/u-boot/commit/f71cbfe3ca5d2ad20159871700e8e248c8818ba8
> >
> > Lore has the review history for that patch:
> >
> > https://lore.kernel.org/all/6be32e0b5b454ed7b609317266a8e798@BLUPR03MB358.namprd03.prod.outlook.com/
> >
> > It looks like it's the same workaround as ARM_ERRATA_742230, which the
> > kernel does implement.
> >
> > It would be good to hear from the Nuvoton people, or an Arm person.
> >
>
> I will happily update the patch to select ARM_ERRATA_742230 instead of
> the dead non-existing ARM_ERRATA_794072.
>
> In contrast to the current patch that basically only cleans up "dead
> config" and has no effective functional change, the new patch would
> change the behaviour. I cannot test this patch (beyond some basic
> compile test) on the hardware; so, we certainly need someone to have
> that hardware, knows how to test it or confirm otherwise that we
> should select the ARM_ERRATA_742230 fix for this hardware.
>
> The current patch should be subsumed by the new patch; the submission
> of the new patch is deferred until that person shows up. Let's see.
>
> Lukas



-- 
Regards,
Avi
