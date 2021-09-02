Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C413FF1DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbhIBQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhIBQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:55:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DABC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=642EGsn3CAgugI9d6ee0+b40u3yojON00QOXQhzKqzc=; b=vOvAANbUzTnwWRDtlQwMjLe1x
        p8/xFwiZNHd3m06Kua45cHNIcAHKk1RzTHhE6z2uW1CCrBcdgXo36vtOKxz1QPOglPu7ypL+2ZI8n
        bX7Ri34ModPn2VBbzRwWjKg28zybAeGmJSS2EbMETvbUkl+vNMnM6U8tq+YS+8qej5g5Qk5v6ilP5
        A4A4GGDWEUtxn3wGUiH21bI2JBz2WyipHHraJ7/X2FXI9zp7w3wwkqZVI0dJyD3/dddh5KX592Xmv
        gswVIWf57OyzOEwnqZ17CELp0nJZ5S6gE8umtdJc0+Qw/qRoE2/O2uHIK0IoOqF3d8UMvUnxwb6do
        ydHB6rwRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48094)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mLpyT-0001hN-PU; Thu, 02 Sep 2021 17:54:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mLpyM-000819-0H; Thu, 02 Sep 2021 17:53:54 +0100
Date:   Thu, 2 Sep 2021 17:53:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Keith Packard <keithp@keithp.com>
Cc:     linux-kernel@vger.kernel.org, Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: Re: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
Message-ID: <20210902165353.GI22278@shell.armlinux.org.uk>
References: <20210902155429.3987201-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902155429.3987201-1-keithp@keithp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> Placing thread_info in the kernel stack leaves it vulnerable to stack
> overflow attacks. This short series addresses that by using the
> existing THREAD_INFO_IN_TASK infrastructure.
> 
> As this is my first patch in this part of the kernel, I'm looking for
> feedback about the general approach as well as specific comments on
> places where I've missed something.
> 
> I've only run this on armhf running under qemu, so while I've tried to
> make patches for other code paths, I haven't been able to test those.
> 
> (yes, I know checkpatch.pl complains about whitespace in asm-offsets.c, I
> decided to leave the existing whitespace alone)
> 
> Signed-off-by: Keith Packard <keithpac@amazon.com>

I think you're introducing a circular dependency with this for
certain kernel configurations:

E.g. Have you tried running this with CONFIG_CPU_V6 enabled?

+#define raw_smp_processor_id() this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
+
+DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);

this_cpu_read() is defined as:

#define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
(which will call this_cpu_read_4)

#define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
=> __this_cpu_generic_read_nopreempt()
=>         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));

#define raw_cpu_ptr(ptr)                                                \
({                                                                      \
        __verify_pcpu_ptr(ptr);                                         \
        arch_raw_cpu_ptr(ptr);                                          \
})

#ifndef arch_raw_cpu_ptr
#define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
#endif

#ifndef __my_cpu_offset
#define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
#endif

... which then leads back to a use of raw_smp_processor_id(), thereby
creating a circular loop of preprocessor definitions that the compiler
can't resolve.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
