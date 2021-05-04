Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F803731AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhEDUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEDUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:54:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:53:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620161626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0d+wC9ngM2LGyyQqRCKJ9/0SOMWmZ5kn2xSFhbIYHM=;
        b=ReKj41rkHJXOC1+AZYE02fANJ/GDymegOHysZVTsn+ph2qWbtxNvqaZ8QivawM3qQhV0KC
        tAuhpbsEDg3FAjhqaVE1a3GNFYe6Cyhj+M4NKsypS7BQ1siDI5PjP1I4VR/3c/UxslYVCN
        C9BHnJAOWYZhxQpi78M21IMwdMrEMb7uQMdaDZeS3YrRk86Py5U7DeZlTlx2eVtkUK0P/Q
        Fy2vG7ivo7X8CdzpDLafQwDW5KFjZuwKcgPUncPaDEv8FPzvwXMghSwI5189c8UKqP7Kd6
        5G3kto4u36urhgkGv0FCipjDyWI9vnxGwN5NgDOMSkkNAATSjBvP7mDWGfQ8TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620161626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0d+wC9ngM2LGyyQqRCKJ9/0SOMWmZ5kn2xSFhbIYHM=;
        b=+5skIosHLbcUBt3Ln8R+NyVdnFJfX7rKIdC5NrctrASPvd4ORD27gsRuhzIwKnMZxYLvyR
        zSHdA6kYpQ5mx+Dg==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>
Subject: Re: [RFC PATCH v5 07/16] x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
In-Reply-To: <20210504190526.22347-8-ricardo.neri-calderon@linux.intel.com>
References: <20210504190526.22347-1-ricardo.neri-calderon@linux.intel.com> <20210504190526.22347-8-ricardo.neri-calderon@linux.intel.com>
Date:   Tue, 04 May 2021 22:53:46 +0200
Message-ID: <87o8dqi5k5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo,

On Tue, May 04 2021 at 12:05, Ricardo Neri wrote:
> +static int hardlockup_detector_nmi_handler(unsigned int type,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	int cpu = smp_processor_id();
> +
> +	if (is_hpet_wdt_interrupt(hdata)) {
> +		/*
> +		 * Make a copy of the target mask. We need this as once a CPU
> +		 * gets the watchdog NMI it will clear itself from ipi_cpumask.
> +		 * Also, target_cpumask will be updated in a workqueue for the
> +		 * next NMI IPI.
> +		 */
> +		cpumask_copy(hld_data->ipi_cpumask, hld_data->monitored_cpumask);
> +		/*
> +		 * Even though the NMI IPI will be sent to all CPUs but self,
> +		 * clear the CPU to identify a potential unrelated NMI.
> +		 */
> +		cpumask_clear_cpu(cpu, hld_data->ipi_cpumask);
> +		if (cpumask_weight(hld_data->ipi_cpumask))
> +			apic->send_IPI_mask_allbutself(hld_data->ipi_cpumask,
> +						       NMI_VECTOR);

How is this supposed to work correctly?

x2apic_cluster:
 x2apic_send_IPI_mask_allbutself()
  __x2apic_send_IPI_mask()
    	tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
	cpumask_copy(tmpmsk, mask);

So if an NMI hits right after or in the middle of the cpumask_copy()
then the IPI sent from that NMI overwrites tmpmask and when its done
then tmpmask is empty. Similar to when it hits in the middle of
processing, just with the difference that maybe a few IPIs have been
sent already. But the not yet sent ones are lost...

Also anything which ends up in __default_send_IPI_dest_field() is
borked:

__default_send_IPI_dest_field()
	cfg = __prepare_ICR2(mask);
	native_apic_mem_write(APIC_ICR2, cfg);

          <- NMI hits and invokes IPI which invokes __default_send_IPI_dest_field()...

	cfg = __prepare_ICR(0, vector, dest);
	native_apic_mem_write(APIC_ICR, cfg);
        
IOW, when the NMI returns ICR2 has been overwritten and the interrupted
IPI goes into lala land.

Thanks,

        tglx
