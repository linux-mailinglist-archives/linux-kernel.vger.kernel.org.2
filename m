Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644253F0FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhHSBWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhHSBWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:22:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C876C061796;
        Wed, 18 Aug 2021 18:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e1g4fm4pHbXHceCWS5qNThiEoBl2hlIvJwHlUDw9S24=; b=Pe7fU/YFhGpHf8sEUV+vDTIiVr
        lPaKd3yjXtiBM2sn1C0eJQS9veREYqYqdm5Uy6K1G2I/dEkSB2iay/C/Iwvdv1PWlkVS5RI2YoQaj
        Y/Xny8mk4aVmqOecbd9rpsZFcapmOAAdFnet5Tx085YAckg9uLSF+uPvnAPzxpOLQl6yklK7dW3MD
        t5VlOo6ahbgAiJ7Grp5N2cAm3BMQmmLtX3NKsb6IOcYHAj+WdLkqFmpk2ZTgiJJUJwPGLLTwMNaB3
        tNyg3AUCmYjSTeutsEPVEKW64rERD5Cl06g+A6SWEyHhgE0mK9gGRWbMXh7hpRr2xhJFKG1NvLd7w
        ismhBe8g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGWkz-006uXW-5O; Thu, 19 Aug 2021 01:22:09 +0000
Subject: Re: [PATCH v3] platform/x86: intel_pmc_core: Prevent possibile
 overflow
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, novikov@ispras.ru,
        gayatri.kammela@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, andy.shevchenko@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210814014728.520856-1-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83282625-9a6f-0d05-90c9-22b67107537f@infradead.org>
Date:   Wed, 18 Aug 2021 18:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210814014728.520856-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 6:47 PM, David E. Box wrote:
> Substate priority levels are encoded in 4 bits in the LPM_PRI register.
> This value was used as an index to an array whose element size was less
> than 16, leading to the possibility of overflow should we read a larger
> than expected priority.  In addition to the overflow, bad values could lead
> to incorrect state reporting.  So rework the priority code to prevent the
> overflow and perform some validation of the register. Use the priority
> register values if they give an ordering of unique numbers between 0 and
> the maximum number of states.  Otherwise, use a default ordering instead.
> 
> Reported-by: Evgeny Novikov <novikov@ispras.ru>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> v3:	Modifying Andy's suggestion, just place the entire verification
> 	in a separate function. If it fails, then keep the default
> 	ordering. If it passes, overwrite with the verified ordering.
> 
> 	Fix error in default order array.
> 
> 	Also fix spelling noted by Andy drop the size comment since
> 	the array size is set when declared.
> 
> v2:	Remove lpm_priority size increase. Instead, remove that array and
> 	create 2 new local arrays, one to save priority levels in mode order,
> 	and one to save modes in priority order. Use the mode_order list to
> 	validate that no priority level is above the maximum and to validate
> 	that they are all unique values. Then we can safely create a
> 	priority_order list that will be the basis of how we report substate
> 	information.
> 
>   drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
>   drivers/platform/x86/intel_pmc_core.h |  2 +
>   2 files changed, 53 insertions(+), 14 deletions(-)

Hi,
I was seeing this:

[    2.027295] ================================================================================
[    2.028593] UBSAN: shift-out-of-bounds in ../drivers/platform/x86/intel_pmc_core.c:1484:9
[    2.029683] shift exponent 255 is too large for 64-bit type 'long unsigned int'
[    2.030775] CPU: 11 PID: 312 Comm: systemd-udevd Tainted: G     U  W         5.14.0-rc6 #3 7cd0fa64f79977022e75f1a75abe17c80d128fc2
[    2.032485] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H470M-STX, BIOS P2.10 03/16/2021
[    2.034325] Call Trace:
[    2.040611]  dump_stack_lvl+0x38/0x49
[    2.042513]  dump_stack+0x10/0x12
[    2.044438]  ubsan_epilogue+0x9/0x80
[    2.048462]  __ubsan_handle_shift_out_of_bounds+0xfa/0x140
[    2.050430]  ? __ioremap_caller.constprop.18+0x1e9/0x380
[    2.054850]  pmc_core_probe+0x5cc/0x700 [intel_pmc_core 0d273a9f7ee2dddcef3fc0b98322787b4774a615]
[    2.055856] snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to polling mode: last cmd=0x200f0000
[    2.056248]  ? pmc_core_probe+0x5cc/0x700 [intel_pmc_core 0d273a9f7ee2dddcef3fc0b98322787b4774a615]
[    2.059664]  ? __cond_resched+0x19/0x40
[    2.065564]  ? acpi_device_wakeup_disable+0x50/0x80
[    2.067391]  platform_probe+0x49/0x100
[    2.068684]  ? platform_probe+0x49/0x100
[    2.069942]  ? driver_sysfs_add+0x7a/0x100
[    2.071181]  really_probe+0x1f4/0x4c0
[    2.072413]  __driver_probe_device+0x11d/0x1c0
[    2.073642]  driver_probe_device+0x24/0xc0
[    2.074857]  __driver_attach+0xae/0x180
[    2.076055]  ? __device_attach_driver+0x180/0x180
[    2.077247]  ? __device_attach_driver+0x180/0x180
[    2.078454]  bus_for_each_dev+0x72/0xc0
[    2.079646]  driver_attach+0x1e/0x40
[    2.080824]  bus_add_driver+0x156/0x240
[    2.082011]  ? 0xffffffffc0119000
[    2.083184]  driver_register+0x60/0x100
[    2.084331]  ? 0xffffffffc0119000
[    2.085474]  __platform_driver_register+0x1e/0x40
[    2.086612]  pmc_core_driver_init+0x1c/0x1000 [intel_pmc_core 0d273a9f7ee2dddcef3fc0b98322787b4774a615]
[    2.087776]  do_one_initcall+0x43/0x200
[    2.088927]  ? kmem_cache_alloc_trace+0x4e/0x500
[    2.090078]  ? __vunmap+0x1c9/0x240
[    2.091223]  do_init_module+0x5f/0x235
[    2.092350]  load_module+0x29d0/0x2e80
[    2.093476]  ? kernel_read_file+0x2d2/0x300
[    2.094589]  __do_sys_finit_module+0xbe/0x140
[    2.095702]  ? __do_sys_finit_module+0xbe/0x140
[    2.096789]  __x64_sys_finit_module+0x1a/0x40
[    2.097880]  do_syscall_64+0x58/0x80
[    2.098971]  ? syscall_exit_to_user_mode+0x16/0x40
[    2.100064]  ? do_syscall_64+0x67/0x80
[    2.101140]  ? exit_to_user_mode_prepare+0x138/0x1c0
[    2.102213]  ? syscall_exit_to_user_mode+0x16/0x40
[    2.103278]  ? do_syscall_64+0x67/0x80
[    2.104343]  ? exc_page_fault+0x6d/0x140
[    2.105391]  ? asm_exc_page_fault+0x8/0x30
[    2.106429]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    2.107470] RIP: 0033:0x7f1638f19569
[    2.108506] Code: 2d 00 b8 ca 00 00 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f7 38 2d 00 f7 d8 64 89 01 48
[    2.109585] RSP: 002b:00007fff1d6c7758 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    2.110677] RAX: ffffffffffffffda RBX: 000055d99d2f0780 RCX: 00007f1638f19569
[    2.111757] RDX: 0000000000000000 RSI: 00007f163987ff9d RDI: 0000000000000006
[    2.112841] RBP: 00007f163987ff9d R08: 0000000000000000 R09: 000055d99d0c1940
[    2.113916] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
[    2.115347] R13: 000055d99d0c1d20 R14: 0000000000000000 R15: 000055d99d0c8610
[    2.116470] ================================================================================

and couldn't tell if this patch was supposed to fix that, so I tested it and I no longer
see the UBSAN report.

So Thanks and

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

