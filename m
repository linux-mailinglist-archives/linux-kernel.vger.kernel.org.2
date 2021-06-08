Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3A39EFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFHHp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:45:56 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:45723 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:45:54 -0400
Received: by mail-ej1-f50.google.com with SMTP id k7so30965369ejv.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dYN2E/UOLxzz8iE288V6NyDoHcM0cOKkoMDS0Zqbr78=;
        b=FnlyyAbTd/huTcrr4Itaakc06ksxsuHU4NAHQkKGluZnCaszbYKPNSki1aE93KBGEv
         hw6DA9G+snkayiPsgAtkskhSZb0EN7mtaLJ/vEW2HcL2PNXDGM5Ub4avhlPfp92xdtEd
         s/D+1BJgTBQhm5aR9kQDpZDrV9ZE5+K9t7nOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYN2E/UOLxzz8iE288V6NyDoHcM0cOKkoMDS0Zqbr78=;
        b=nVIaOZkQVckMbqQPbS7fEcL3Q6hhaHWKZWiLK+Cms6ORErGGBsV4YeFqZ6nI+6a59L
         E0wt0X7ic8+GSxCp5ieNsEyA1luqS00u1QQodK83rn26qK9jPCKFMvSqMAn8jhqe1Xhx
         //iq7D5+uFE2Xx+yXG9gYvGX5tMohx7QsDl05GpT3tLgIz7WUXER8zxaAV1nkt/ztrdF
         2TK4AFsriQbcuS9tU8U+JOZ6AKPiLVdro3MUBuNIlLyfP/vDQaHr7+eiElTsGmOU0wX8
         ChLwljX1z/8MfjTM4syvhj0idFwnEjmzRLMsU0l3CuyRsSCN7WI1mA94LTbkWD8ZgxBU
         eE+Q==
X-Gm-Message-State: AOAM530Z0fBkpdWBFAqfBWbxaFkheHdjnPOKSGuaWP211VvKb6QbNqKA
        qNzE+yuJV40sWV1dnkzVbuSJOA==
X-Google-Smtp-Source: ABdhPJylfR4kEftdm1ureRTmz+HK5wBLjb0ExLXz7UFi0loIWyfLdX/ojLmlb1r9QQnoI6kmzAn/dg==
X-Received: by 2002:a17:906:4e05:: with SMTP id z5mr21807694eju.520.1623138181170;
        Tue, 08 Jun 2021 00:43:01 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id o64sm8388680eda.83.2021.06.08.00.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 00:43:00 -0700 (PDT)
Subject: Re: [init/initramfs.c] e7cb072eb9: invoked_oom-killer:gfp_mask=0x
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210607144419.GA23706@xsang-OptiPlex-9020>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d28354fd-0f72-559d-771f-fb2a80b51b05@rasmusvillemoes.dk>
Date:   Tue, 8 Jun 2021 09:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607144419.GA23706@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 16.44, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: e7cb072eb988e46295512617c39d004f9e1c26f8 ("init/initramfs.c: do unpacking asynchronously")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: locktorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 
> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> please be noted that we use 'vmalloc=512M' for both parent and this commit.
> since it's ok on parent but oom on this commit, we want to send this report
> to show the potential problem of the commit on some cases.
> 
> we also tested by changing to use 'vmalloc=128M', it will succeed.
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    4.443950] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    4.716374] ACPI: _SB_.LNKC: Enabled at IRQ 11
> [    5.081518] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [    5.082999] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [    5.085275] VFIO - User Level meta-driver version: 0.3
> [    8.029204] kworker/u4:0 invoked oom-killer: gfp_mask=0x100cc0(GFP_USER), order=0, oom_score_adj=0
> [    8.031021] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.12.0-11533-ge7cb072eb988 #1
> [    8.031988] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    8.031988] Workqueue: events_unbound async_run_entry_fn
> [    8.031988] Call Trace:
> [    8.031988] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122) 
> [    8.031988] dump_header (kbuild/src/consumer/mm/oom_kill.c:463) 
> [    8.031988] ? lock_release (kbuild/src/consumer/kernel/locking/lockdep.c:5190 kbuild/src/consumer/kernel/locking/lockdep.c:5532) 
> [    8.031988] ? out_of_memory (kbuild/src/consumer/include/linux/rcupdate.h:710 kbuild/src/consumer/mm/oom_kill.c:379 kbuild/src/consumer/mm/oom_kill.c:1102 kbuild/src/consumer/mm/oom_kill.c:1048) 
> [    8.031988] out_of_memory.cold (kbuild/src/consumer/mm/oom_kill.c:1106 kbuild/src/consumer/mm/oom_kill.c:1048) 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.12.0-11533-ge7cb072eb988 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz

So I got this far...

>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

Is there some way to reproduce which doesn't require adding an lkp user?
Also, I don't have 16G to give to a virtual machine. I tried running the
bzImage with that modules.cgz under qemu with some naive parameters just
to get some output [1], but other than failing because there's no rootfs
to mount (as expected), I only managed to make it fail when providing
too little memory (the .cgz is around 70M, decompressed about 200M -
giving '-m 1G' to qemu works fine). You mention the vmalloc= argument,
but I can't make the decompression fail when passing either vmalloc=128M
or vmalloc=512M or no vmalloc= at all.

As an extra data point, what happens if you add initramfs_async=0 to the
command line?

[1] qemu-system-x86_64 -kernel arch/i386/boot/bzImage -initrd
../../tmp/header-install/modules.cgz -append "console=ttyAMA0
console=ttyS0 vmalloc=512M" -serial stdio -smp 2 -m 1G

Rasmus
