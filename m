Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628EB401CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbhIFO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhIFO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:27:23 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2868C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:26:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w144so8997527oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+maAuwalXSsguMLnJAfhhVerYs8jlKHmc+ZEHM5brrE=;
        b=iElyC6jr3F8A3HEbC+wYPfN/MfbHDSZKnP9jjiu+0Hkqb0U+Mk/wuyiqrbOecL1Q7c
         ahsqAp0embgb6tNptivvq2FEbKuOD7aT+Hc6AzbuG3du2+BhICS02ajg45M6gvLo388R
         mOB1/6U4d5RH3hYgMrEZMwRQBxgmW0FNvFV8ScshaHzHwQrQ1i4MaERMY8kew094fOOS
         VJzskfR0GFo0KYwXqZ6i7gYCln2x6ygOYY+7CJTZyo9o06JOGKbqNJSoojnHdG4iuFHG
         AfWjQ0Q/t3k4ec3SzAij7wH9plxLyHbjBbKVBQ8nSYXd9P+FsIxgj/nBEDzy45O4IgqN
         ILKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+maAuwalXSsguMLnJAfhhVerYs8jlKHmc+ZEHM5brrE=;
        b=GG5MdpK23esexDF+0q6RyDw7KBKZVuEGF7QCGvcEE3xdHn08lJ5sBpVuSbTlgJ6QqQ
         LYEpTO28ttgq56d6Tt0i3WfGzRZSEE6GTI9AjQ4/B1rwAGkmrzuLpPxP7j4bPC4TSsnX
         bx8C1RiIb0L2LFBEQvRNHz27z6MqoYv7modYKlaZ3kEZocyhVJNJ1j+kLtIGvvUqBSEw
         oQCunXp0mklu5WFcbfSZDGI24+SP4J5TZupHs1T/G/1JWuqswpL0J+mw08sTxOIP2zi6
         L2K6lUNpFHsXGEb5JrC1W9R5jFFM26bPhimSzTXYQ0jIoz/TmCDic4EJ+dGo2BSjFHsJ
         RzTw==
X-Gm-Message-State: AOAM530q+umJm69T/77tpfLQAPYoWIzAP2E+hKhVbCBgtPwrnflCvIi3
        PIoInA/k+/EEw8xQlSDbQEfIZmFLRak=
X-Google-Smtp-Source: ABdhPJyORXYbd0pl2BrFZzKOfE825aFHGQrCW8axa7wIFYDJoiG7k4Z8RFUzn1lG0TJ+E0rDG47vPA==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr8751534oie.93.1630938377939;
        Mon, 06 Sep 2021 07:26:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b3sm1508101oie.1.2021.09.06.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 07:26:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Sep 2021 07:26:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <20210906142615.GA1917503@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 11:24:05AM -0700, Linus Torvalds wrote:
> ... but make it a config option so that broken environments can disable
> it when required.
> 
> We really should always have a clean build, and will disable specific
> over-eager warnings as required, if we can't fix them.  But while I
> fairly religiously enforce that in my own tree, it doesn't get enforced
> by various build robots that don't necessarily report warnings.
> 
> So this just makes '-Werror' a default compiler flag, but allows people
> to disable it for their configuration if they have some particular
> issues.
> 
> Occasionally, new compiler versions end up enabling new warnings, and it
> can take a while before we have them fixed (or the warnings disabled if
> that is what it takes), so the config option allows for that situation.
> 
> Hopefully this will mean that I get fewer pull requests that have new
> warnings that were not noticed by various automation we have in place.
> 
> Knock wood.
> 

I guess the good news is that some builds still pass.

Build results:
	total: 153 pass: 89 fail: 64
Failed builds:
	alpha:defconfig
	alpha:allmodconfig
	arcv2:defconfig
	arcv2:axs103_defconfig
	arcv2:vdk_hs38_smp_defconfig
	arm:s3c2410_defconfig
	arm:ixp4xx_defconfig
	arm:omap1_defconfig
	arm:footbridge_defconfig
	arm:keystone_defconfig
	arm:vexpress_defconfig
	arm:imx_v4_v5_defconfig
	arm:s3c6400_defconfig
	arm:s5pv210_defconfig
	arm:integrator_defconfig
	arm:pxa910_defconfig
	arm:clps711x_defconfig
	csky:defconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	hexagon:defconfig
	i386:allyesconfig
	i386:allmodconfig
	ia64:defconfig
	m68k:defconfig
	m68k:allmodconfig
	m68k:sun3_defconfig
	m68k_nommu:m5272c3_defconfig
	m68k_nommu:m5307c3_defconfig
	m68k_nommu:m5249evb_defconfig
	m68k_nommu:m5407c3_defconfig
	m68k_nommu:m5475evb_defconfig
	microblaze:mmu_defconfig
	mips:allmodconfig
	mips:bcm63xx_defconfig
	mips:e55_defconfig
	mips:malta_defconfig
	nds32:defconfig
	nds32:allmodconfig
	nios2:3c120_defconfig
	parisc:allmodconfig
	parisc:generic-32bit_defconfig
	parisc64:generic-64bit_defconfig
	powerpc:allmodconfig
	powerpc:cell_defconfig
	powerpc:maple_defconfig
	powerpc:ppc6xx_defconfig
	powerpc:mpc83xx_defconfig
	powerpc:tqm8xx_defconfig
	powerpc:83xx/mpc834x_mds_defconfig
	riscv32:allmodconfig
	riscv:allmodconfig
	s390:allmodconfig
	sh:defconfig
	sh:dreamcast_defconfig
	sh:microdev_defconfig
	sh:shx3_defconfig
	sparc32:defconfig
	sparc64:allmodconfig
	sparc64:defconfig
	um:defconfig
	xtensa:defconfig
	xtensa:allmodconfig
Qemu test results:
	total: 479 pass: 340 fail: 139
Failed tests:
	<many>

Guenter
