Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03C4408264
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhIMAUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 20:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236714AbhIMAUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 20:20:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3B8B60F8F;
        Mon, 13 Sep 2021 00:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631492373;
        bh=oUeraY7TurYsgFrjSJmhJwuIcgYrW238vjWptkZ9W7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=suXS44WRTcKd6gDAfMj+4bd+PJhoqrhbA63UXmhrrRkNDAr/+UgJUKyn3v6UiB07a
         YnQZaDUBa0sBydRYS6NdUHf6BlRYvRD8LtWfJpnlxaUMMcYUZRixHp9h5Ni/xc6hBb
         AFMzciqqonMeHC7kEVUKBTFLVItYfV0P0ASpS+ZqkMBOvyCy5muagvW7lwfHCDojuM
         pgRRuUPo+iY1JaBGi6ZlSHPcX2Twz9aEl+APuwCTJzlF0OMXscj6C3ZfHfbutZDKDw
         s+LWmjWj6SO7NsFaFOPXSbkjemsRqaWYXERz6j9JMj7dc1RcJmFLxQzlWU4tNxm7aq
         5siChmWKgekzA==
Date:   Mon, 13 Sep 2021 09:19:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [init]  40caa127f3: kernel_BUG_at_arch/x86/mm/physaddr.c
Message-Id: <20210913091931.534edc0f13d8937267a75450@kernel.org>
In-Reply-To: <20210912140820.GD25450@xsang-OptiPlex-9020>
References: <20210912140820.GD25450@xsang-OptiPlex-9020>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oops, sorry this is my mistake that I mixed kfree() behevior and memblock_free() behevior.
(memblock_free() is NOT NULL safe)

Let me fix that soon.

Thank you,

On Sun, 12 Sep 2021 22:08:20 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-14):
> 
> commit: 40caa127f3c7279c75cb0c9684559fa314ee3a66 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> [   17.504659][    T1] ------------[ cut here ]------------
> [   17.505585][    T1] kernel BUG at arch/x86/mm/physaddr.c:76!
> [   17.506561][    T1] invalid opcode: 0000 [#1] SMP
> [   17.507339][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc2-00062-g40caa127f3c7 #1 00c78f7b688292d34ec614a62bcd66d7bca8c06c
> [   17.509340][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   17.510823][    T1] EIP: __phys_addr+0x48/0x80
> [   17.511538][    T1] Code: 1d 16 00 84 80 12 f8 c2 80 12 f8 c2 89 f1 c1 e9 89 f1 c1 e9 29 89 f8 e8 29 89 f8 e8 39 f0 75 2a 39 f0 75 2a 5d c3 0f 0b 5d c3 <0f> 0b c2 e8 6c 69 c2 e8 6c 69 68 10 c0 28 68 10 c0 28 6a 00 0f 0b
> [   17.514699][    T1] EAX: 00000000 EBX: c1d19f90 ECX: 00000000 EDX: c10878dc
> [   17.515909][    T1] ESI: 40000000 EDI: 00000000 EBP: c016ff90 ESP: c016ff88
> [   17.517114][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010207
> [   17.518380][    T1] CR0: 80050033 CR2: 00000000 CR3: 02895000 CR4: 00040690
> [   17.519575][    T1] Call Trace:
> [   17.520137][    T1]  xbc_destroy_all+0x22/0x3b
> [   17.520863][    T1]  kernel_init+0x1c/0x180
> [   17.521533][    T1]  ret_from_fork+0x19/0x24
> [   17.522233][    T1] Modules linked in:
> [   17.522923][    T1] ---[ end trace a86c2af2528aa089 ]---
> [   17.523863][    T1] EIP: __phys_addr+0x48/0x80
> [   17.524612][    T1] Code: 1d 16 00 84 80 12 f8 c2 80 12 f8 c2 89 f1 c1 e9 89 f1 c1 e9 29 89 f8 e8 29 89 f8 e8 39 f0 75 2a 39 f0 75 2a 5d c3 0f 0b 5d c3 <0f> 0b c2 e8 6c 69 c2 e8 6c 69 68 10 c0 28 68 10 c0 28 6a 00 0f 0b
> [   17.527796][    T1] EAX: 00000000 EBX: c1d19f90 ECX: 00000000 EDX: c10878dc
> [   17.528969][    T1] ESI: 40000000 EDI: 00000000 EBP: c016ff90 ESP: c016ff88
> [   17.530128][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010207
> [   17.531302][    T1] CR0: 80050033 CR2: 00000000 CR3: 02895000 CR4: 00040690
> [   17.532427][    T1] Kernel panic - not syncing: Fatal exception
> [   17.533500][    T1] Kernel Offset: disabled
> 
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.14.0-rc2-00062-g40caa127f3c7 .config
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
