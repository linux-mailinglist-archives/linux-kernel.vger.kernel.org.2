Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E656330FFBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBDVwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhBDVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:51:40 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32086C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yPJqHn1HxKlAeb4Xz5DuRyDCntFfH5AIxoghocthOno=; b=zXDdgagBbnrUhvlW8IFuRdlVi
        XgmndcR3XYK33CiTRnN/pZ9niHaYTARNLGxXbrxUVSrUi1WnHUtc4JmFWU+MbbbjiZ9iZLzTdEFTE
        CU23mzkQtBnMsV9UoJ5sKbuYM2EcxfuOZU/RWt7UFB022umZrpcIVoFMCfDi8r92Uf1z/qwGzhQv2
        Trr8s90WZrP0KPNxXzr1bDZ+vodXdlP6iH5x0MFNYaqR7hTyjWlEhxNhFSd8RDKxnfBw003503nFB
        J5MRfcS7PSlQyNgrKV1imDdpMbjWkSQ8WzRmlgNshZBi8UXpozZ3ahd9dUSnFMcBuewv7Z2903ize
        aqX8Girbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39256)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7mWK-00076a-3E; Thu, 04 Feb 2021 21:50:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7mWH-0005Xk-M5; Thu, 04 Feb 2021 21:50:33 +0000
Date:   Thu, 4 Feb 2021 21:50:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
Message-ID: <20210204215033.GD1463@shell.armlinux.org.uk>
References: <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com>
 <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <CAMj1kXEshuPTrKvN4LpXQMftHJG+yH8+fgU7uVc6GYn0qd8-xA@mail.gmail.com>
 <7c685184-8688-9319-075b-66133cb0b0c3@collabora.com>
 <CAMj1kXH_CCYyd5zNVRL=KWpBXtsKamV7Bfg=O1YWBJL0f_eXLQ@mail.gmail.com>
 <CAKwvOd=ziPWHmBiPtW3h2VYLZ-CTMp4=aEonmMLM7c=Y0SeG1Q@mail.gmail.com>
 <20210204181216.GB2989696@localhost>
 <CAKwvOd=UYuKPp6rO7aWGFEsc9yLa_UCLnAL-vwqzi_5sZg7O3g@mail.gmail.com>
 <253b2987-c8e9-fcb6-c1b9-81e765c0cc2a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253b2987-c8e9-fcb6-c1b9-81e765c0cc2a@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:31:06PM +0000, Guillaume Tucker wrote:
> On 04/02/2021 18:23, Nick Desaulniers wrote:
> > You're right, I missed `LLVM=1`. Adding `LD=ld.bfd` I think should
> > permit fallback to BFD.
> 
> That was close, except we're cross-compiling with GCC for arm.
> So I've now built a plain next-20210203 (without Ard's fix) using
> this command line:
> 
>     make LD=arm-linux-gnueabihf-ld.bfd -j18 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LLVM=1 CC="ccache clang" zImage
> 
> I'm using a modified Docker image gtucker/kernelci-build-clang-11
> with the very latest LLVM 11 and gcc-8-arm-linux-gnueabihf
> packages added to be able to use the GNU linker.  BTW I guess we
> should enable this kind of hybrid build setup on kernelci.org as
> well.

...

> And this booted fine, which confirms it's really down to how
> ld.lld puts together the kernel image.  Does it actually solve
> the debate whether this is an issue to fix in the assembly code
> or at link time?

Well... as I mentioned previously, we don't really understand what
is going on between the decompressor running with the caches on,
turning the caches off, jumping into the decompressed kernel, and
then getting to the v7 setup code.

The results from various attempts at solving the problem which lead
to Ard's original patch that caused your breakage were not making a
whole lot of sense (I think I wrote that all up in a previous email
thread, so won't repeat it here.)

So, I was slightly nervous about merging Ard's fix - and your report
suggested that there is indeed more going on here that we don't
understand.

When I was tracking down what was going on, I had this patch applied
(I've had to recreate it, so may not be exactly what I had), with the
DEBUG_LL stuff appropriately enabled. It may be worth applying this
patch, enabling the DEBUG_LL stuff appropriately for one of your
failing boards, and try booting it.

You should get two strings of identical hex numbers that look
something like:

ffffffff480000000900040140003000000000004820071d40008090

If they're looking like instructions, for example:

ee060f37e3a00080ee020f10ee020f30ee030f10e3a00903ee050f30

Then it's likely that you are seeing a very similar problem as I was
without Ard's patch. If you do get instruction-like content, then
you will likely find the sequence of instructions in the decompressor
code.

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 28c9d32fa99a..19fa93ae282c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -475,7 +475,39 @@ ENDPROC(cpu_pj4b_do_resume)
 	ldr	r12, [r0]
 	add	r12, r12, r0			@ the local stack
 	stmia	r12, {r1-r6, lr}		@ v7_invalidate_l1 touches r0-r6
+	ldr	r0, [r12, #0]
+	bl	printhex8
+	ldr	r0, [r12, #4]
+	bl	printhex8
+	ldr	r0, [r12, #8]
+	bl	printhex8
+	ldr	r0, [r12, #12]
+	bl	printhex8
+	ldr	r0, [r12, #16]
+	bl	printhex8
+	ldr	r0, [r12, #20]
+	bl	printhex8
+	ldr	r0, [r12, #24]
+	bl	printhex8
+	mov	r0, #'\n'
+	bl	printch
 	bl      v7_invalidate_l1
+	ldr	r0, [r12, #0]
+	bl	printhex8
+	ldr	r0, [r12, #4]
+	bl	printhex8
+	ldr	r0, [r12, #8]
+	bl	printhex8
+	ldr	r0, [r12, #12]
+	bl	printhex8
+	ldr	r0, [r12, #16]
+	bl	printhex8
+	ldr	r0, [r12, #20]
+	bl	printhex8
+	ldr	r0, [r12, #24]
+	bl	printhex8
+	mov	r0, #'\n'
+	bl	printch
 	ldmia	r12, {r1-r6, lr}
 
 __v7_setup_cont:

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
