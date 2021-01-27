Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B23065D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhA0VRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:17:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58922 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhA0VQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:16:57 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611782175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pt8iJeoz5jaMdNGfAhhR1JW/P7EauYDRzpGcBYEn3Tk=;
        b=bBGPWbZ12InF8fPm8+tcRukgbK6Ng8+v66QB7nlo5YjXvGFPsSikhHzLqNsZYzH5C3S2LB
        SdcrqRDfZLyjeLCiSWnrnTmaHOw8k+v3PaY1Gi+rCxq3VFjHavSkqxrITekUv9r5SyEVz3
        NMjWlQ7k++qSA/djdkMQJkTAksmTeIZpYZeyF5ZwEB1+ZjMu0HqPK+RtYXQKRvgleKKNR8
        ge/NTMKkOMBKfo50c04dBSoIfIUgMVVxfYsDNQqBHIWVZJql8Q+a1nOhOEAcd3N14b67zI
        RgRYtcdiyNUIFCdfxX9a1PxF6kLS4j15cNjLAL8bE1bTyqXlS2LL29PuUvM9fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611782175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pt8iJeoz5jaMdNGfAhhR1JW/P7EauYDRzpGcBYEn3Tk=;
        b=PEoT6Qr8M5Ju8lzY0Ae8SvuYBrvwRbIU+hoetlkgw/k+TT+LFEhiCOyKp/jb+4FxJbB5e/
        4EE//ntEDm4A9ODw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus lock
In-Reply-To: <20201124205245.4164633-3-fenghua.yu@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com> <20201124205245.4164633-3-fenghua.yu@intel.com>
Date:   Wed, 27 Jan 2021 22:16:15 +0100
Message-ID: <87v9bidqsg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:

> #DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL MSR
> while #AC for split lock is enabled by split lock detection bit 29 in
> TEST_CTRL MSR.
>
> Delivery of #DB for bus lock in userspace clears DR6[11]. To avoid
> confusion in identifying #DB, #DB handler sets the bit to 1 before
> returning to the interrupted task.
>
> Use the existing kernel command line option "split_lock_detect=" to handle
> #DB for bus lock:
>
> split_lock_detect=
> 		#AC for split lock		#DB for bus lock
>
> off		Do nothing			Do nothing
>
> warn		Kernel OOPs			Warn once per task and
> 		Warn once per task and		and continues to run.
> 		disable future checking 	When both features are
> 						supported, warn in #DB

Which means that we don't catch kernel split locks anymore with 'warn'
if bus lock detection is supported. WHY? There is zero rationale for
this change in the changelog.

> fatal		Kernel OOPs			Send SIGBUS to user
> 		Send SIGBUS to user		When both features are
> 						supported, split lock
> 						triggers #AC and bus lock
> 						from non-WB triggers #DB.


>  /*
> - * Default to sld_off because most systems do not support split lock detection
> - * split_lock_setup() will switch this to sld_warn on systems that support
> - * split lock detect, unless there is a command line override.
> + * Default to sld_off because most systems do not support split lock detection.
> + * sld_state_setup() will switch this to sld_warn on systems that support
> + * split lock/bus lock detect, unless there is a command line override.
>   */
>  static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
>  static u64 msr_test_ctrl_cache __ro_after_init;
> +/* Split lock detection is enabled if it's true. */
> +static bool sld;

Why did you bother with 3 letters? bool s, b; along with comments
explaining what it means would have been sufficient, right?

sld_enable/bld_enable would be too self explaining and this also lacks
__ro_after_init

Aside of that it's beyond silly because bld and sld are just shadowing
the corresponding CPU feature bits. So what are these variables gaining
aside of confusion?

> +/* Bus lock detection is enabled if it's true. */
> +static bool bld;
>  
> +static void __init sld_state_setup(void)

This is confusing as hell. sld_state_setup() is used for bus lock as
well and split_lock_detect_state is not less confusing. It took me five
reads to figure out how all of that works.

> +static void __init _split_lock_setup(void)

We generally use two underscores for readability sake.

> +{
> +	if (!split_lock_verify_msr(false)) {
> +		pr_info("MSR access failed: Disabled\n");

>  /*
> @@ -1079,6 +1084,15 @@ static void sld_update_msr(bool on)
>  
>  static void split_lock_init(void)
>  {
> +	/*
> +	 * If supported, #DB for bus lock will handle warn
> +	 * and #AC for split lock is disabled.

Why does this disable the kernel detection? Just because?

> +void handle_bus_lock(struct pt_regs *regs)
> +{
> +	if (!bld)
> +		return;

How is #DB ever calling this function when the debug MSR bit is not set?

> -void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
> +static void __init split_lock_setup(struct cpuinfo_x86 *c)
>  {
>  	const struct x86_cpu_id *m;
>  	u64 ia32_core_caps;
> @@ -1189,5 +1237,43 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
>  	}
>  
>  	cpu_model_supports_sld = true;
> -	split_lock_setup();
> +	_split_lock_setup();
> +}
> +
> +static void sld_state_show(void)
> +{
> +	if (!bld && !sld)
> +		return;
> +
> +	switch (sld_state) {
> +	case sld_off:
> +		pr_info("disabled\n");
> +		break;
> +	case sld_warn:
> +		if (bld)
> +			pr_info("#DB: warning about user-space bus_locks\n");
> +		else
> +			pr_info("#AC: crashing the kernel about kernel split_locks and warning about user-space split_locks\n");

crashing about?

> +		break;
> +	case sld_fatal:
> +		if (sld)
> +			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
> +		if (bld)
> +			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n", sld ? " from non-WB" : "");
> +		break;
> +	}

Thanks,

        tglx
