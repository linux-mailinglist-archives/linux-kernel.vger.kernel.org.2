Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1744A449
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhKIByb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239541AbhKIBy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636422704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFGu9AXrTc44yf7Fd1i9aP2uR3v2xVRM2yfLGR/MsfQ=;
        b=ehL1EjUpTl5/XN/O5v17Bx61NBmuBlScFyZOLQ+H9p40wFD/njD3oH4Sbp5YFMLRUUyS59
        YZfWcZq9rNqsnld8hv32WkoCV7ZEFsLGNs1bSUOWSUPCUvBjornyc/ENer41R5w6LNCQ2I
        c+g4uDo2GBnfJoghP5Wi3fx6FRAZDHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-_gcqOoiRNJyzQkkSpP7lGQ-1; Mon, 08 Nov 2021 20:51:41 -0500
X-MC-Unique: _gcqOoiRNJyzQkkSpP7lGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74361804140;
        Tue,  9 Nov 2021 01:51:39 +0000 (UTC)
Received: from [10.22.16.6] (unknown [10.22.16.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF2960BE5;
        Tue,  9 Nov 2021 01:51:38 +0000 (UTC)
Message-ID: <a90f0361-329b-1e21-90c1-601d6f7c2f24@redhat.com>
Date:   Mon, 8 Nov 2021 20:51:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] powerpc/pseries/cpuhp: Use alloc_cpumask_var() in
 pseries_cpu_hotplug_init()
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
References: <20211108164751.65565-1-longman@redhat.com>
 <87y25ym96i.fsf@mpe.ellerman.id.au> <1636421918.tc1hk6vx8h.astroid@bobo.none>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <1636421918.tc1hk6vx8h.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/21 20:46, Nicholas Piggin wrote:
> Excerpts from Michael Ellerman's message of November 9, 2021 11:04 am:
>> Waiman Long <longman@redhat.com> writes:
>>> It was found that the following warning message could be printed out when
>>> booting the kernel on PowerPC systems that support LPAR:
>>>
>>> [    0.129584] WARNING: CPU: 0 PID: 1 at mm/memblock.c:1451 memblock_alloc_internal+0x5c/0x104
>>> [    0.129593] Modules linked in:
>>> [    0.129598] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-11.el9.ppc64le+debug #1
>>> [    0.129605] NIP:  c000000002040134 LR: c00000000204011c CTR: c0000000020241a8
>>> [    0.129610] REGS: c000000005637760 TRAP: 0700   Not tainted  (5.14.0-11.el9.ppc64le+debug)
>>> [    0.129616] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000222  XER: 00000002
>>> [    0.129635] CFAR: c0000000004d1cf4 IRQMASK: 0
>>> [    0.129635] GPR00: c00000000204011c c000000005637a00 c000000002c94d00 0000000000000001
>>> [    0.129635] GPR04: 0000000000000080 0000000000000000 0000000000000000 ffffffffffffffff
>>> [    0.129635] GPR08: 0000000000000000 0000000000000003 c00000000205ac64 0000000000080000
>>> [    0.129635] GPR12: 0000000000000000 c0000000049d0000 c000000000013078 0000000000000000
>>> [    0.129635] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [    0.129635] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [    0.129635] GPR24: c000000002003808 c00000000146f7b8 0000000000000000 0000000000000100
>>> [    0.129635] GPR28: c000000002d7cf80 0000000000000000 0000000000000008 0000000000000000
>>> [    0.129710] NIP [c000000002040134] memblock_alloc_internal+0x5c/0x104
>>> [    0.129717] LR [c00000000204011c] memblock_alloc_internal+0x44/0x104
>>> [    0.129723] Call Trace:
>>> [    0.129726] [c000000005637a00] [c000000005637a40] 0xc000000005637a40 (unreliable)
>>> [    0.129735] [c000000005637a60] [c0000000020404d8] memblock_alloc_try_nid+0x94/0xcc
>>> [    0.129743] [c000000005637af0] [c00000000205ac64] alloc_bootmem_cpumask_var+0x4c/0x9c
>>> [    0.129751] [c000000005637b60] [c0000000020242e0] __machine_initcall_pseries_pseries_cpu_hotplug_init+0x138/0x1d8
>>> [    0.129760] [c000000005637bf0] [c000000000012404] do_one_initcall+0xa4/0x4f0
>>> [    0.129768] [c000000005637cd0] [c000000002005358] do_initcalls+0x140/0x18c
>>> [    0.129776] [c000000005637d80] [c0000000020055b8] kernel_init_freeable+0x178/0x1d0
>>> [    0.129783] [c000000005637db0] [c0000000000130a0] kernel_init+0x30/0x190
>>> [    0.129790] [c000000005637e10] [c00000000000cef4] ret_from_kernel_thread+0x5c/0x64
>>>
>>> The warning is printed in memblock_alloc_internal() because the slab
>>> has been initialized when the initcalls are being processed. To
>>> avoid the warning, change alloc_bootmem_cpumask_var() call in
>>> pseries_cpu_hotplug_init() to alloc_cpumask_var() instead. Also
>>> change cpumask_or() to cpumask_copy() or we will have to use
>>> zalloc_cpumask_var().
>>>
>>> Fixes: bd1dd4c5f528 ("powerpc/pseries: Prevent free CPU ids being reused on another node")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   arch/powerpc/platforms/pseries/hotplug-cpu.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> This looks similar to the patch Nick sent recently:
>>
>>    https://lore.kernel.org/linuxppc-dev/20211105132923.1582514-1-npiggin@gmail.com/
> Ah, you get CONFIG_CPUMASK_OFFSTACK=y if CONFIG_DEBUG_PER_CPU_MAPS=y.
> I was wondering how Waiman found it.
>
> Differences between the two patches are error checking - no big deal but
> we should just do it. And GFP_NOWAIT - is this required here?

As I have replied in another thread, I added it because it was used in 
memblock_alloc_internal().

Cheers,
Longman

