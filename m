Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDD40EA16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348328AbhIPSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348247AbhIPSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:42:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3153AC0ECD01
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:09:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631812171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4r4VCDRNhn5NuXXhrpjE/K0L0acR/ljmw/oylxT1VSA=;
        b=YC419Uh4QoFwbWT8W+nR8DV2hyIK337Yf3wjf259qhd5/sBeQYj7Ts/p+j9H6+qYihiJ3f
        MusMYcl008Hchd9zfu7SGC9cMGvjyeF3vr8BwmnuSruwGsGEe1KUZWoJAWMqCeDhcV3S35
        Y+ZO5fWOg0SExlXDTOX9cSiJFGT2CMYJdJFrVqxtL4ks63IL+a/Up4ce5Fl27rjWHHHHfC
        SgQdJ55T8gQkBlm4eq3ecn2SZQaBwe1YH1znAJbHn69CzAo0IqGmftjKaEF51Qe+iUnWou
        JFdKc0T8PZw+gA1VQKet8sIqS4QxKMrr/gd4LRBkMHIv0VvcblJQkLWMtjdZWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631812171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4r4VCDRNhn5NuXXhrpjE/K0L0acR/ljmw/oylxT1VSA=;
        b=i/khbvyNGFWaUevd8PtOS2y8Ftus8lJ0VVR22w6uQU9Crcyq9d7HAnA6FZRpEV8PSXbdKu
        tdUGbusA49hHP5Cg==
To:     Ondrej Zary <linux@zary.sk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IOPL emulation breaks hpasmd (hp-health) needed by HP DL380 G4
 servers
In-Reply-To: <202109151423.43604.linux@zary.sk>
References: <202109151423.43604.linux@zary.sk>
Date:   Thu, 16 Sep 2021 19:09:31 +0200
Message-ID: <87pmt8a1mc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej,

On Wed, Sep 15 2021 at 14:23, Ondrej Zary wrote:
> after upgrading Debian from 10 (kernel 4.19.194) to 11 (kernel 5.10.46) on HP
> DL380 G4 servers, hpasmd segfaults. Booting the 4.19.194 kernel allows hpasmd
> to work.
>
> Noticed the iopl(3) call. Checked out a kernel before "x86/iopl: Remove legacy IOPL option"
> (a24ca9976843156eabbc5f2d798954b5674d1b61) and built with CONFIG_X86_IOPL_LEGACY.
> It works!.
>
> I even disassembled /opt/hp/hp-health/bin/IrqRouteTbl (it's only 5952 bytes
> and does not use any hp libs). There's no CLI, only a couple of INs and OUTs:
> ...
>  8048f75:       66 ba 84 00             mov    dx,0x84
>  8048f79:       66 b8 00 00             mov    ax,0x0
>  8048f7d:       ee                      out    dx,al
>  8048f7e:       66 ba 85 00             mov    dx,0x85
>  8048f82:       ee                      out    dx,al
>
> But I still don't know what's going on.

That's weird. Let me think about a way to debug that. I just ran a
trivial test program which issues iopl(3) and reads all ports from
0-65535. That works like a charm.

#include <stdio.h>
#include <sys/io.h>

int main(void)
{
	unsigned int i;
	int ret;

	ret = iopl(3);
	if (ret)
		return ret;

	for (i = 0; i < 65536; i++)
		printf("%5u: %02x\n", i, inb(i));

	return 0;
}

Which CPU is in that machine?

Can you please run that failing program with GDB and figure out which
instruction causes #GP and what the register content is.

Thanks,

        tglx
