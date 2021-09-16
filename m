Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6136F40EC74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhIPV0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhIPV0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:26:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:25:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631827518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MJS34XxO1/RQwVuwfaoPiVBOxbkvrD4slCkuJpi2rI=;
        b=BHokm5nMjofA0H5hPVDpjwjnYZoY3M3v28Ojslx43g+5kdi6HqwTjm9pueFizZpvUTEjxr
        iqs2uyzXaJ6FAfvaQnF17KWVghMlBSCBVTk1z5gKBiSKuCbVVzzGOJcIYhOSI4DpuailoX
        mXXzNo80UAwC9Yutc19due2ppTNLL3H1GIZNX4ic+wk+DEOOVpyHNpkgm2ywNs4q/FDyA+
        MBe8QvH3+kS0Je0mah+zUhVeodWEJXDJvzmN1NIPU1PcuuYYQU4NFOLGGlPg2apUbhGN7K
        2H0LFc2Y0weuAHe6SIO9tGYfj9WlkDYSPtD9eKPdcjefnbNMGhcNLtI4jGfcHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631827518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MJS34XxO1/RQwVuwfaoPiVBOxbkvrD4slCkuJpi2rI=;
        b=+welx+8l3LrGBZdWcl2ZN7ewiVGoOCZVYjUstm5KElaKouPjeowvVAXE/lbqtbpquAiMg/
        jcpE8u+LInuZQlCg==
To:     Ondrej Zary <linux@zary.sk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4
 servers
In-Reply-To: <202109162227.17415.linux@zary.sk>
References: <202109151423.43604.linux@zary.sk> <87pmt8a1mc.ffs@tglx>
 <202109162227.17415.linux@zary.sk>
Date:   Thu, 16 Sep 2021 23:25:17 +0200
Message-ID: <87h7ek9ps2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2021 at 22:27, Ondrej Zary wrote:
> On Thursday 16 September 2021 19:09:31 Thomas Gleixner wrote:
>> Can you please run that failing program with GDB and figure out which
>> instruction causes #GP and what the register content is.
>
> (gdb) run
> Starting program: /opt/hp/hp-health/bin/IrqRouteTbl
>
> Program received signal SIGSEGV, Segmentation fault.
> 0xf7fc509b in ?? ()
> (gdb) bt
> #0  0xf7fc509b in ?? ()
> #1  0x08048848 in ?? ()
> #2  0x08048aa1 in ?? ()
> #3  0x08048e05 in ?? ()
> #4  0xf7df9e46 in __libc_start_main () from /lib32/libc.so.6
> #5  0xf7ffd000 in ?? () from /lib/ld-linux.so.2
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> (gdb) x/3i $pc
> => 0xf7fc509b:  cli
>    0xf7fc509c:  push   %ebp
>    0xf7fc509d:  mov    %esp,%ebp
>
> OMG, maybe is it calling into the mmapped BIOS area?

Pretty much so. From your initial report:

openat(AT_FDCWD, "/dev/mem", O_RDWR)    = 3
mmap2(NULL, 8342, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, 3, 0xf0000) = 0xf7fc1000
close(3)                                = 0
iopl(3)                                 = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=NULL} ---

offset 0xf0000 of /dev/mem is clearly the BIOS area. Daft.

That's really qualiteee stuff.

Thanks,

        tglx
