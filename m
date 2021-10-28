Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE543E614
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ1Qal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhJ1Qak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:30:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:28:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q129so9135384oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tz2OfuQV0kEFmyf8jZ0f0hPH88C2VfcIKaHxe65/t9M=;
        b=MdTrAkLnnzPUmOLS8u4NzxjSH+wOBQxnJ8lCVwWXDOSGTqqQ6Dn8M1JJs4JcKDgbzM
         RYLQFkB1WEl58I4zWO6kAw4R/5L3voAZs+VuiRW1ytCsNGSLTbKTCBJQC0Qo5Aa/kAtX
         aWVS/eLmdiJcLzkAee5tDR+I6Of6crL/THxlRBjqUdbBb02T/2VUSSnzTkuH/SZlYPKp
         v1QUrS8dgG6Qz7FipieU9dsf8ZELYILf6MGSsHNrQH731F2V7deAUBEhfyBVAZVse2+I
         fngU7Mb1DA4In+S8BL19EVZ/cJmLrpUZsmfBJpDnfa2UWfRvO90oZVCyX1JYKq0Tazgr
         3gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tz2OfuQV0kEFmyf8jZ0f0hPH88C2VfcIKaHxe65/t9M=;
        b=rPalNi6LtU9pEaZiLyddK/s0iliJG9/evq3N+kCCCIr1y2OydfHUiZesnW4P172mua
         24gFUcjMLfrC6p9wuWJnww/pGXUQT7KWvUAuU92fnceIFUYJ9YbQdSemEAOQBJwxk/3K
         HNuKGmG3bPwh7ftEJy3bx/5lzEHuR6SrNo2GOd+fyVOEoqoP/m9kfm5v0VgCsutLxKlr
         iZlj8De1/no7KKIth6AfeooN+Wb5Rgt1E3GB9VPncEnKViHrDSqDlLYkTqYzvrfJ7hJq
         Y8WqW5oL9IjWjJo8kuNlmHxSU97wiQyJrWMastD5Ee1Y19BwO8w0mtsbEXwvBwhRXLIj
         AWrA==
X-Gm-Message-State: AOAM5312jHGkXp9z6TrMEFyWvpepIG4h0xNuT491wLAZu5G8rdJT5B3K
        KLIIpKg+dwUHK1Js8xEjG3HThXO4bW8=
X-Google-Smtp-Source: ABdhPJwcuVGC8R76gj+W52gYFXA5ZWCrDrt6B/Xr9TdZhAdyWvKgtLNXTz1ovQPm4kSNlaCRvZffmA==
X-Received: by 2002:a05:6808:1a05:: with SMTP id bk5mr9429198oib.108.1635438492109;
        Thu, 28 Oct 2021 09:28:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14sm1126098otq.10.2021.10.28.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:28:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 09:28:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <20211028162810.GB470146@roeck-us.net>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net>
 <YXrIlT+2llnwgRpj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrIlT+2llnwgRpj@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 28, 2021 at 08:30:55AM -0700, Guenter Roeck wrote:
> > On Wed, Oct 27, 2021 at 06:03:24PM +0300, Andy Shevchenko wrote:
> > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > especially when there are circular dependencies are involved.
> > > 
> > > Replace kernel.h inclusion with the list of what is really being used.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > In next-20211028:
> > 
> > Building riscv32:defconfig ... failed
> > --------------
> > Error log:
> > arch/riscv/lib/delay.c: In function '__delay':
> > arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> > 
> > Building riscv:defconfig ... failed
> > --------------
> > Error log:
> > arch/riscv/lib/delay.c: In function '__delay':
> > arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
> > 
> > Building s390:defconfig ... failed
> > --------------
> > Error log:
> > <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> > In file included from arch/s390/pci/pci_insn.c:12:
> > arch/s390/include/asm/facility.h: In function '__stfle':
> > arch/s390/include/asm/facility.h:98:22: error: implicit declaration of function 'min_t'
> > 
> > bisect to this patch. Probably more, but it is difficult to find out
> > since -next is too badly broken and has build failures all over the place.
> 
> Thanks for the report!
> 
> I have run it on x86_64 with `kcbench -m ...` and no failures.
> 
> Can you share all build errors you found so far? I believe none of them related
> to x86* code.
> 
> Above just revealed the problematic places in the first place. Why the
> programmers rely on delay.h to include full bloated header pile?! (Yeah, this
> is rhetorical, so please share the errors, I'll try to address them)
> 

The ones listed above are the ones I was able to identify. As I said, there
are so many compile and runtime failures in linux-next that it is difficult
to track down individual failures. Just to give you an idea (this is for
next-20211028):

Build results:
	total: 153 pass: 115 fail: 38
Failed builds:
	alpha:allmodconfig
	arm:allmodconfig
	arm:omap2plus_defconfig
	arm:davinci_all_defconfig
	arm64:defconfig
	arm64:allmodconfig
	csky:allmodconfig
	h8300:allnoconfig
	h8300:tinyconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	m68k:allmodconfig
	mips:defconfig
	mips:allmodconfig
	mips:allnoconfig
	mips:tinyconfig
	mips:bcm47xx_defconfig
	mips:bcm63xx_defconfig
	mips:ath79_defconfig
	mips:ar7_defconfig
	mips:e55_defconfig
	mips:cavium_octeon_defconfig
	mips:malta_defconfig
	mips:rt305x_defconfig
	nds32:allmodconfig
	parisc:allmodconfig
	parisc:generic-32bit_defconfig
	parisc64:generic-64bit_defconfig
	powerpc:allmodconfig
	riscv32:defconfig
	riscv32:allmodconfig
	riscv:defconfig
	riscv:allmodconfig
	s390:defconfig
	s390:allmodconfig
	sparc64:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 480 pass: 315 fail: 165
Failed tests:
	<too many to list them all>

Build and boot logs are as always at https://kerneltests.org/builders
in the 'next' column in case you want to do some digging yourself.

Guenter
