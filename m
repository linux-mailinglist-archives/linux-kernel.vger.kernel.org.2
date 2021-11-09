Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7E44A396
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbhKIB1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbhKIBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:23:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50138C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:04:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hp8rS2MR3z4xfJ;
        Tue,  9 Nov 2021 12:04:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1636419849;
        bh=3ncpsDBaAJOBAjaA3U7o9lHoQJuHhnA9MDiRmuX4kRw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bS4caBIM6ELDwlRZS2YUoIjcbEsbRrEmqn8tTewbW6wGLB6pgsKDYhxP14wVlMqOQ
         J5yOi8Y2zWNoBKdzjEIgFrzYoYxgi2zdND7kAmoTVB2OH2eoEjgg3CUKHogCr3QwFj
         SYWAH1RwVQMw7N1W/yYEsyR6WT3RDR8/UxCMboj4Sl82iKZMS1TAeaFpyG5060hko9
         AAvrb0djsEr/lpBC5TdXdHAkCR4mkCDZJ9Dp0zwWsZqrIRoXYfUXEpG1LbqBphuBgy
         vyEGisbbHIEaLPK71YAT8w8HUBYPbSQOmSQHCTiNBpcxzw+U8jYIhtUr9pzPM17yS0
         4HUTso0+J1lhw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Waiman Long <longman@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] powerpc/pseries/cpuhp: Use alloc_cpumask_var() in
 pseries_cpu_hotplug_init()
In-Reply-To: <20211108164751.65565-1-longman@redhat.com>
References: <20211108164751.65565-1-longman@redhat.com>
Date:   Tue, 09 Nov 2021 12:04:05 +1100
Message-ID: <87y25ym96i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:
> It was found that the following warning message could be printed out when
> booting the kernel on PowerPC systems that support LPAR:
>
> [    0.129584] WARNING: CPU: 0 PID: 1 at mm/memblock.c:1451 memblock_alloc_internal+0x5c/0x104
> [    0.129593] Modules linked in:
> [    0.129598] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-11.el9.ppc64le+debug #1
> [    0.129605] NIP:  c000000002040134 LR: c00000000204011c CTR: c0000000020241a8
> [    0.129610] REGS: c000000005637760 TRAP: 0700   Not tainted  (5.14.0-11.el9.ppc64le+debug)
> [    0.129616] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000222  XER: 00000002
> [    0.129635] CFAR: c0000000004d1cf4 IRQMASK: 0
> [    0.129635] GPR00: c00000000204011c c000000005637a00 c000000002c94d00 0000000000000001
> [    0.129635] GPR04: 0000000000000080 0000000000000000 0000000000000000 ffffffffffffffff
> [    0.129635] GPR08: 0000000000000000 0000000000000003 c00000000205ac64 0000000000080000
> [    0.129635] GPR12: 0000000000000000 c0000000049d0000 c000000000013078 0000000000000000
> [    0.129635] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.129635] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.129635] GPR24: c000000002003808 c00000000146f7b8 0000000000000000 0000000000000100
> [    0.129635] GPR28: c000000002d7cf80 0000000000000000 0000000000000008 0000000000000000
> [    0.129710] NIP [c000000002040134] memblock_alloc_internal+0x5c/0x104
> [    0.129717] LR [c00000000204011c] memblock_alloc_internal+0x44/0x104
> [    0.129723] Call Trace:
> [    0.129726] [c000000005637a00] [c000000005637a40] 0xc000000005637a40 (unreliable)
> [    0.129735] [c000000005637a60] [c0000000020404d8] memblock_alloc_try_nid+0x94/0xcc
> [    0.129743] [c000000005637af0] [c00000000205ac64] alloc_bootmem_cpumask_var+0x4c/0x9c
> [    0.129751] [c000000005637b60] [c0000000020242e0] __machine_initcall_pseries_pseries_cpu_hotplug_init+0x138/0x1d8
> [    0.129760] [c000000005637bf0] [c000000000012404] do_one_initcall+0xa4/0x4f0
> [    0.129768] [c000000005637cd0] [c000000002005358] do_initcalls+0x140/0x18c
> [    0.129776] [c000000005637d80] [c0000000020055b8] kernel_init_freeable+0x178/0x1d0
> [    0.129783] [c000000005637db0] [c0000000000130a0] kernel_init+0x30/0x190
> [    0.129790] [c000000005637e10] [c00000000000cef4] ret_from_kernel_thread+0x5c/0x64
>
> The warning is printed in memblock_alloc_internal() because the slab
> has been initialized when the initcalls are being processed. To
> avoid the warning, change alloc_bootmem_cpumask_var() call in
> pseries_cpu_hotplug_init() to alloc_cpumask_var() instead. Also
> change cpumask_or() to cpumask_copy() or we will have to use
> zalloc_cpumask_var().
>
> Fixes: bd1dd4c5f528 ("powerpc/pseries: Prevent free CPU ids being reused on another node")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


This looks similar to the patch Nick sent recently:

  https://lore.kernel.org/linuxppc-dev/20211105132923.1582514-1-npiggin@gmail.com/

cheers
