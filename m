Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B532391482
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhEZKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhEZKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:10:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XifbQzEQk6a/Kpk0B7BIp9QvaOtr11rfSpq3pzNWwU4=; b=HCLMzQxXzZdxVKoDmsZIg+DDP
        laVqE2hLq+I4pJd7Hf+x3RDE/hRJh7Qa0RFsvACyuZM576biypZHX9nmlnVft12uiTNukLsE1xhF0
        wNwoi6u50fbbbamkmF8TZTGRHCeEO4pp1R/ik/l4VZEYTbdCD7Z0kgKmoy7NsUDdumxykeaXdOzv/
        oZk4cwW3qRWyAmpHcFXAthiMEATZ4Yf12XUQNRHIIt5KzhqtonYRov9oLe5liY2y15GFqdN4teRfi
        kUiN68iwCvSPoMp9fVgKBU73l6iJuiBlbBC3uTWKIoZvaZwmHepikm1X4ybwDMntPcztMKBDY4dIK
        clU5RmjNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44366)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1llqT1-0005RN-Fs; Wed, 26 May 2021 11:08:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1llqSy-0002iX-3C; Wed, 26 May 2021 11:08:44 +0100
Date:   Wed, 26 May 2021 11:08:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
Message-ID: <20210526100843.GD30436@shell.armlinux.org.uk>
References: <m3y2c1uchh.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3y2c1uchh.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:26:50AM +0200, Krzysztof Hałasa wrote:
> Hello,
> 
> I've encountered an interesting case of data corruption while accessing
> IPU (Image Processing Unit) on i.MX6 (rev1.2, Cortex A9). What I'm doing
> here is basically:
> 
> openat(AT_FDCWD, "/dev/mem", O_RDWR|O_SYNC) = 3
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x2630000) = ptr
> write(1, ptr, 32)                = 32
> 
> Normally, the write() should end up with:
>  04008A00 02FF03FF 02FF03FF 00000000 00000000 00000000 00000000 00000000
> 
> However, with current kernels, the first 32 bits (the first IPU
>  register) are dropped:
>  02FF03FF 02FF03FF 00000000 00000000 00000000 00000000 00000000 00000000
> 
> 0x2630000 is IPU1 CSI0 address (i.e., a register block). The same
> happens with other IPU regions. Writes shorter than 8 * 32 bits are not
> affected.
> 
> write() uses arm_copy_from_user() and since commit f441882a5229:
>     ARM: 8812/1: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
> 
>     ARMv6+ processors do not use CONFIG_CPU_USE_DOMAINS and use privileged
>     ldr/str instructions in copy_{from/to}_user.  They are currently
>     unnecessarily using single ldr/str instructions and can use ldm/stm
>     instructions instead like memcpy does (but with appropriate fixup
>     tables).
> 
> apparently uses 8 * 32-bit ldmia instruction to copy data:
>     .macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
>     USERL(\abort, ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8})
>     .endm
> 
> Before this commit it used ldr instruction (single 32-bit value) and the
> problem didn't show up (reverting f441882a5229 on v5.11 fixes it as
> well). The i.MX6 errata doesn't seem to list this problem.
> 
> I wonder what the theory says about this case. Is it at all valid to
> read 8 IPU registers at a time using LDM instruction? If so, should
> something be done with this problem, or should it be left as is?

Surely someone is not using copy_*_user() to copy data from userspace
direct to MMIO space... that would be crazy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
