Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421CC3C295D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhGITBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:01:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2455C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:58:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id e14so10324683qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rq09e4FzKVmC8coozmBf2Y4P9tsiDVwZ27Wjq/A92M=;
        b=DXZ7xOOrb+im+tg33i8mbTwsKlZOJPAfSLVS1lRsLDqp2+R0vdcuS+0zSmf1hozWid
         h8N38TsVQ1QPBClHpe5emLu45mi3w5tBd5vkYjiI6beSJjrXTQS9Lis5m+m60gBYrsC3
         Jtaz1JParBBvM4YHj99L6tC2DD0jJWHj3QIQZ+3nIZDUcW68SbAYvmvI8sPsQ8rrBf9m
         DIbU5xPKHNZtJodbP2/6ps301q+e0hoyKM6Fse04usXf1IDGbmbscr/M14PPeovJ8vNW
         Z0jX0S9BplBgXLHzIJNTXSkc81ZwJBu7AYVTyYRZxK2MfH9BfbKUzQx/G8a7Ik/pB8aU
         o1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rq09e4FzKVmC8coozmBf2Y4P9tsiDVwZ27Wjq/A92M=;
        b=JLZ4BoZK8Qt1VrceCKEKZ6WIkZsfO5z2qm1NYdNC7oD2LDCzUjvzPbrDQMQqQRbo/0
         3viOtrU66g+J+mHinDVa0sZxIS3VG5r7ONSikwkcUKyF9Yy+6ufOlwM/H7q//Y9AJIEB
         dgPHFvRhLeEjq2jlg20bwmBAkUjN97YOrTkxY06tTGU0C8gYNLmRZnDvhJWNZz4TISxx
         6qzB3hKAp5IWAeuaHtSxUI+HL8TEbBp3VSBC1XgN4BwEZNZSN3Su98aJhJCA9Pu+Q1j3
         IvjyXHixZ/x85ngTde/TJBhyTAhqTqL8hHJUD5yD/6GFN++uesla+j10sm9sX8LPCzor
         01hg==
X-Gm-Message-State: AOAM5333Y20Mk4fDsasRbfWv7H6h8cyf1ImMdS6Nx1F365z9Nqnce6xc
        GDhisUbOS2ZLuu9X6JVabJPdYy+cIoVJJQyDhXjQfw==
X-Google-Smtp-Source: ABdhPJx38EbV1FTTGhhuDjA8CTzpk9q6mzakZBUDCGz1zQ1TzLXHZcfuZU3Lo65MlCEwO1gJjRbol4iuazm9D4flAsc=
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr38651885qkf.216.1625857103581;
 Fri, 09 Jul 2021 11:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210709043713.887098-1-senozhatsky@chromium.org> <20210709043713.887098-3-senozhatsky@chromium.org>
In-Reply-To: <20210709043713.887098-3-senozhatsky@chromium.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 9 Jul 2021 14:58:11 -0400
Message-ID: <CAJWu+opFedsq6CdgUYErnxsv3-Pr7MHi0vz9=hhpMCujFPp8+A@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Just few nits, patch itself LGTM:

On Fri, Jul 9, 2021 at 12:37 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> PV-vcpu-state is a per-CPU struct, which, for the time being,
> holds boolean `preempted' vCPU state. During the startup,
> given that host supports PV-state, each guest vCPU sends
> a pointer to its per-CPU variable to the host as a payload
> with the SMCCC HV call, so that host can update vCPU state
> when it puts or loads vCPU.
>
> This has impact on the guest's scheduler:
>
> [..]
>   wake_up_process()
>    try_to_wake_up()
>     select_task_rq_fair()
>      available_idle_cpu()
>       vcpu_is_preempted()
>
> Some sched benchmarks data is available on the github page [0].
>
> [0] https://github.com/sergey-senozhatsky/arm64-vcpu_is_preempted
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  arch/arm64/include/asm/paravirt.h | 19 +++++++
>  arch/arm64/kernel/paravirt.c      | 94 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/smp.c           |  4 ++
>  3 files changed, 117 insertions(+)
>
> diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
> index 9aa193e0e8f2..a3f7665dff38 100644
> --- a/arch/arm64/include/asm/paravirt.h
> +++ b/arch/arm64/include/asm/paravirt.h
> @@ -2,6 +2,11 @@
>  #ifndef _ASM_ARM64_PARAVIRT_H
>  #define _ASM_ARM64_PARAVIRT_H
>
> +struct vcpu_state {
> +       bool    preempted;
> +       u8      reserved[63];
> +};
> +
>  #ifdef CONFIG_PARAVIRT
>  #include <linux/static_call_types.h>
>
> @@ -20,8 +25,22 @@ static inline u64 paravirt_steal_clock(int cpu)
>
>  int __init pv_time_init(void);
>
> +bool dummy_vcpu_is_preempted(unsigned int cpu);
> +
> +extern struct static_key pv_vcpu_is_preempted_enabled;.

pv_vcpu_is_preempted_enabled static_key is not used in any patch.
Maybe it is stale?

> +DECLARE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> +
> +static inline bool paravirt_vcpu_is_preempted(unsigned int cpu)
> +{
> +       return static_call(pv_vcpu_is_preempted)(cpu);
> +}
> +
> +int __init pv_vcpu_state_init(void);
> +
>  #else
>
> +#define pv_vcpu_state_init() do {} while (0)
> +
>  #define pv_time_init() do {} while (0)
>
>  #endif // CONFIG_PARAVIRT
> diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> index 75fed4460407..d8fc46795d94 100644
> --- a/arch/arm64/kernel/paravirt.c
> +++ b/arch/arm64/kernel/paravirt.c
> @@ -40,6 +40,11 @@ struct pv_time_stolen_time_region {
>
>  static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
>
> +static DEFINE_PER_CPU(struct vcpu_state, vcpus_states);
> +struct static_key pv_vcpu_is_preempted_enabled;
> +
> +DEFINE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);

Could we use DEFINE_STATIC_CALL_NULL and get rid of the dummy
function? I believe that makes the function trampoline as return
instruction, till it is updated.

> +
>  static bool steal_acc = true;
>  static int __init parse_no_stealacc(char *arg)
>  {
> @@ -165,3 +170,92 @@ int __init pv_time_init(void)
>
>         return 0;
>  }
> +
> +bool dummy_vcpu_is_preempted(unsigned int cpu)
> +{
> +       return false;
> +}
> +
> +static bool __vcpu_is_preempted(unsigned int cpu)
> +{
> +       struct vcpu_state *st;
> +
> +       st = &per_cpu(vcpus_states, cpu);
> +       return READ_ONCE(st->preempted);

I guess you could just do:
{
  return READ_ONCE(per_cpu(vcpus_states, cpu).preempted);
}

> +}
> +
> +static bool has_pv_vcpu_state(void)
> +{
> +       struct arm_smccc_res res;
> +
> +       /* To detect the presence of PV time support we require SMCCC 1.1+ */
> +       if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
> +               return false;
> +
> +       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +                            ARM_SMCCC_HV_PV_VCPU_STATE_FEATURES,
> +                            &res);
> +
> +       if (res.a0 != SMCCC_RET_SUCCESS)
> +               return false;
> +       return true;
> +}
> +
> +static int __pv_vcpu_state_hook(unsigned int cpu, int event)
> +{
> +       struct arm_smccc_res res;
> +       struct vcpu_state *st;
> +
> +       st = &per_cpu(vcpus_states, cpu);
> +       arm_smccc_1_1_invoke(event, virt_to_phys(st), &res);
> +       if (res.a0 != SMCCC_RET_SUCCESS)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int vcpu_state_init(unsigned int cpu)
> +{
> +       int ret = __pv_vcpu_state_hook(cpu, ARM_SMCCC_HV_PV_VCPU_STATE_INIT);
> +
> +       if (ret)
> +               pr_warn("Unable to ARM_SMCCC_HV_PV_STATE_INIT\n");
> +       return ret;
> +}
> +
> +static int vcpu_state_release(unsigned int cpu)
> +{
> +       int ret = __pv_vcpu_state_hook(cpu, ARM_SMCCC_HV_PV_VCPU_STATE_RELEASE);
> +
> +       if (ret)
> +               pr_warn("Unable to ARM_SMCCC_HV_PV_STATE_RELEASE\n");
> +       return ret;
> +}
> +
> +static int pv_vcpu_state_register_hooks(void)
> +{
> +       int ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                               "hypervisor/arm/pvstate:starting",
> +                               vcpu_state_init,
> +                               vcpu_state_release);
> +       if (ret < 0)
> +               pr_warn("Failed to register CPU hooks\n");
> +       return 0;
> +}
> +
> +int __init pv_vcpu_state_init(void)
> +{
> +       int ret;
> +
> +       if (!has_pv_vcpu_state())
> +               return 0;
> +
> +       ret = pv_vcpu_state_register_hooks();
> +       if (ret)
> +               return ret;
> +
> +       static_call_update(pv_vcpu_is_preempted, __vcpu_is_preempted);
> +       static_key_slow_inc(&pv_vcpu_is_preempted_enabled);

I think this static key inc is also stale.

thanks,

-Joel
