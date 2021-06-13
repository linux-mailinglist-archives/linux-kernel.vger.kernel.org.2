Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9E3A518D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFMAx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 20:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhFMAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 20:53:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B1AEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 17:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=DaZ74OPMtx5ZkV7YUIGH2vM4+SOhqjSoTZ
        OAJpitrIc=; b=VQpmGMWoAsrhM18bRe2iu18R2BPimovNnGUEGnAslHJcLYaZCh
        HehUrktT6mywivvl1OZDt8XMgqg0moLHESf81FWMH3K86UhKqMSXI8QFZZg1iOJr
        E12fe9AdoHFj1C4Y2GkhCSJtxjCTFxfffAGvDB0JHVd3aVSBxe5kSAeBI=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCH9JRZVsVg177PAA--.54070S2;
        Sun, 13 Jun 2021 08:50:33 +0800 (CST)
Date:   Sun, 13 Jun 2021 08:44:47 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     emil.renner.berthing@gmail.com, alex@ghiti.fr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        Christoph Hellwig <hch@infradead.org>, zong.li@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED
Message-ID: <20210613084447.6db3cc02@xhacker>
In-Reply-To: <mhng-dfabeabd-e6df-4035-a9d0-c16269390120@palmerdabbelt-glaptop>
References: <CANBLGcy3HrnmrweSpnDZViVstoWJYh4sCBoaX_24AsgWd=Q9XA@mail.gmail.com>
        <mhng-dfabeabd-e6df-4035-a9d0-c16269390120@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCH9JRZVsVg177PAA--.54070S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDuFy7XFyrKF4kJr13urg_yoW5Jr4xpw
        s5AF4vkF15JFy8Jwsrtw18uryjyFsrC343Grn8Ga4YvFyjvF48Xw4DJw15ua4kArn8tr1x
        Xr1rGa4I9w15J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
        wI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07beAp5UUU
        UU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 17:23:51 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> On Sat, 12 Jun 2021 16:23:03 PDT (-0700), emil.renner.berthing@gmail.com wrote:
> > On Fri, 4 Jun 2021 at 13:51, Alexandre Ghiti <alex@ghiti.fr> wrote:  
> >>
> >> Make the physical RAM base address available for all kernels, not only
> >> XIP kernels as it will allow to simplify address conversions macros.  
> >
> > Am I just reading it wrong or won't this patch make it so that the same kernel
> > can't run on two chips with physical ram starting at different addresses?

I mentioned this point in http://lists.infradead.org/pipermail/linux-riscv/2021-June/006840.html  

> 
> IIUC we were in that position, at least without relocatable kernels.  
> Maybe I'm misunderstanding this, though?

Just my humble opinion, before this series patch, at least geneirc Image
for RV64 + MMU + !XIP is doable.

Thanks

> 
> >
> > /Emil
> >  
> >> ---
> >>  arch/riscv/Kconfig | 6 ------
> >>  1 file changed, 6 deletions(-)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index b58596b141fc..3d8e7e4bb45c 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -493,13 +493,8 @@ config STACKPROTECTOR_PER_TASK
> >>         def_bool y
> >>         depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> >>
> >> -config PHYS_RAM_BASE_FIXED
> >> -       bool "Explicitly specified physical RAM address"
> >> -       default n
> >> -
> >>  config PHYS_RAM_BASE
> >>         hex "Platform Physical RAM address"
> >> -       depends on PHYS_RAM_BASE_FIXED
> >>         default "0x80000000"
> >>         help
> >>           This is the physical address of RAM in the system. It has to be
> >> @@ -512,7 +507,6 @@ config XIP_KERNEL
> >>         # This prevents XIP from being enabled by all{yes,mod}config, which
> >>         # fail to build since XIP doesn't support large kernels.
> >>         depends on !COMPILE_TEST
> >> -       select PHYS_RAM_BASE_FIXED
> >>         help
> >>           Execute-In-Place allows the kernel to run from non-volatile storage
> >>           directly addressable by the CPU, such as NOR flash. This saves RAM
> >> --
> >> 2.30.2
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv  
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


