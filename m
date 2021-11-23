Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089A45AAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhKWSQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:16:47 -0500
Received: from foss.arm.com ([217.140.110.172]:57066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234236AbhKWSQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:16:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8E71FB;
        Tue, 23 Nov 2021 10:13:37 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F59E3F5A1;
        Tue, 23 Nov 2021 10:13:35 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Longpeng \(Mike\, Cloud Infrastructure Service Product Dept.\)" 
        <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
In-Reply-To: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
References: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
Date:   Tue, 23 Nov 2021 18:13:30 +0000
Message-ID: <87r1b6d9kl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/21 16:47, Sebastian Andrzej Siewior wrote:
> From: "Longpeng(Mike)" <longpeng2@huawei.com>
>
> A CPU will not show up in virtualized environment which includes an
> Enclave. The VM splits its resources into a primary VM and a Enclave
> VM. While the Enclave is active, the hypervisor will ignore all requests
> to bring up a CPU and this CPU will remain in CPU_UP_PREPARE state.
> The kernel will wait up to ten seconds for CPU to show up
> (do_boot_cpu()) and then rollback the hotplug state back to
> CPUHP_OFFLINE leaving the CPU state in CPU_UP_PREPARE. The CPU state is
> set back to CPUHP_TEARDOWN_CPU during the CPU_POST_DEAD stage.
>

For my own education, this is talking about *host* CPU hotplug, right?

> After the Enclave VM terminates, the primary VM can bring up the CPU
> again.
>
> Allow to bring up the CPU if it is in the CPU_UP_PREPARE state.
>
> [bigeasy: Rewrite commit description.]
>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/r/20210901051143.2752-1-longpeng2@huawei.com
> ---
>
> For XEN: this changes the behaviour as it allows to invoke
> cpu_initialize_context() again should it have have earlier. I *think*
> this is okay and would to bring up the CPU again should the memory
> allocation in cpu_initialize_context() fail.

Virt stuff notwithstanding, that looks OK to me.
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

That said, AFAICT only powerpc makes actual use of the state being set to
CPU_UP_PREPARE, it looks to be needless bookkeeping for everyone else (and
there's archs that seem happy using only CPU_DEAD / CPU_POST_DEAD).

>
>  kernel/smpboot.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index f6bc0bc8a2aab..34958d7fe2c1c 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
>                */
>               return -EAGAIN;
>
> +	case CPU_UP_PREPARE:
> +		/*
> +		 * Timeout while waiting for the CPU to show up. Allow to try
> +		 * again later.
> +		 */
> +		return 0;
> +
>       default:
>
>               /* Should not happen.  Famous last words. */
> --
> 2.33.1
