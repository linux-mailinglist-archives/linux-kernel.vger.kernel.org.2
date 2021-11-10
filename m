Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAC44CB72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 22:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhKJVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 16:55:14 -0500
Received: from office.oderland.com ([91.201.60.5]:54762 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKJVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 16:55:02 -0500
Received: from [155.4.220.82] (port=44962 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1mkvVr-003x6N-T7; Wed, 10 Nov 2021 22:52:11 +0100
Message-ID: <6a7edbff-e255-661d-c68f-c07b7519e421@oderland.se>
Date:   Wed, 10 Nov 2021 22:52:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [PATCH] x86/smp: Factor out parts of native_smp_prepare_cpus()
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com
References: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 00:36, Boris Ostrovsky wrote:
> Commit 66558b730f25 ("sched: Add cluster scheduler level for x86")
> introduced cpu_l2c_shared_map mask which is expected to be initialized
> by smp_op.smp_prepare_cpus(). That commit only updated
> native_smp_prepare_cpus() version but not xen_pv_smp_prepare_cpus().
> As result Xen PV guests crash in set_cpu_sibling_map().
>
> While the new mask can be allocated in xen_pv_smp_prepare_cpus() one can
> see that both versions of smp_prepare_cpus ops share a number of common
> operations that can be factored out. So do that instead.
>
> Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  arch/x86/include/asm/smp.h |  1 +
>  arch/x86/kernel/smpboot.c  | 19 +++++++++++++------
>  arch/x86/xen/smp_pv.c      | 11 ++---------
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 08b0e90623ad..81a0211a372d 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -126,6 +126,7 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
>  
>  void cpu_disable_common(void);
>  void native_smp_prepare_boot_cpu(void);
> +void smp_prepare_cpus_common(void);
>  void native_smp_prepare_cpus(unsigned int max_cpus);
>  void calculate_max_logical_packages(void);
>  void native_smp_cpus_done(unsigned int max_cpus);
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 8241927addff..d7429198c22f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1350,12 +1350,7 @@ static void __init smp_get_logical_apicid(void)
>  		cpu0_logical_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
>  }
>  
> -/*
> - * Prepare for SMP bootup.
> - * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
> - *            for common interface support.
> - */
> -void __init native_smp_prepare_cpus(unsigned int max_cpus)
> +void __init smp_prepare_cpus_common(void)
>  {
>  	unsigned int i;
Testing out this patch I got a warning that i is unused. Which it is,
since for_each_possible_cpu(i) is removed.
>  
> @@ -1386,6 +1381,18 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>  	set_sched_topology(x86_topology);
>  
>  	set_cpu_sibling_map(0);
> +}
> +
> +/*
> + * Prepare for SMP bootup.
> + * @max_cpus: configured maximum number of CPUs, It is a legacy parameter
> + *            for common interface support.
> + */
> +void __init native_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +
> +	smp_prepare_cpus_common();
> +
>  	init_freq_invariance(false, false);
>  	smp_sanity_check();
>  
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index 9e55bcbfcd33..69e91d0d3ca4 100644
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -238,16 +238,9 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  	xen_init_lock_cpu(0);
>  
> -	smp_store_boot_cpu_info();
> -	cpu_data(0).x86_max_cores = 1;
> +	smp_prepare_cpus_common();
>  
> -	for_each_possible_cpu(i) {
> -		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
> -		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
> -	}
> -	set_cpu_sibling_map(0);
> +	cpu_data(0).x86_max_cores = 1;
>  
>  	speculative_store_bypass_ht_init();
>  

