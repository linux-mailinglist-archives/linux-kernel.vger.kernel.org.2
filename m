Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF375456E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhKSLPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:15:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232004AbhKSLPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637320342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9aM8Q9WTgCdAcq1DwTYBIbHacVjNPNyPuk3SIn5Ogo=;
        b=L68nIsvyS5LHQ7LIZ1yuCUbZ7hR3v2s2GXLypu1k/osc6egBYBg719oKkzdLWYCne9eIXO
        22ifVj7se1A/u8YXmOs4+WUoEdUnG9sYstmqAMrR9jv7QAKGz/Nv7F4VEKHXunhRqLwzwv
        P7EWktap1rt2OIArIehMsn8OJeBylSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-q9Xl1pdfPpq0qtRHegRmsg-1; Fri, 19 Nov 2021 06:12:19 -0500
X-MC-Unique: q9Xl1pdfPpq0qtRHegRmsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1B81006AA0;
        Fri, 19 Nov 2021 11:12:17 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B6196060F;
        Fri, 19 Nov 2021 11:12:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C39744172ED4; Fri, 19 Nov 2021 08:11:50 -0300 (-03)
Date:   Fri, 19 Nov 2021 08:11:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        rostedt@goodmis.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, nilal@redhat.com
Subject: Re: [RFC PATCH 2/2] KVM: arm64: export cntvoff in debugfs
Message-ID: <20211119111150.GA43513@fuller.cnet>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
 <20211119102117.22304-3-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211119102117.22304-3-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:21:18AM +0100, Nicolas Saenz Julienne wrote:
> While using cntvct as the raw clock for tracing, it's possible to
> synchronize host/guest traces just by knowing the virtual offset applied
> to the guest's virtual counter.
> 
> This is also the case on x86 when TSC is available. The offset is
> exposed in debugfs as 'tsc-offset' on a per vcpu basis. So let's
> implement the same for arm64.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Hi Nicolas,

ARM:

CNTVCTSS_EL0, Counter-timer Self-Synchronized Virtual Count register
The CNTVCTSS_EL0 characteristics are:

Purpose
Holds the 64-bit virtual count value. The virtual count value is equal to the 
physical count value visible in CNTPCT_EL0 minus the virtual offset visible in CNTVOFF_EL2.
					   ^^^^^

x86:

24.6.5 Time-Stamp Counter Offset and Multiplier
The VM-execution control fields include a 64-bit TSC-offset field. If the “RDTSC exiting” control is 0 and the “use
TSC offsetting” control is 1, this field controls executions of the RDTSC and RDTSCP instructions. It also controls
executions of the RDMSR instruction that read from the IA32_TIME_STAMP_COUNTER MSR. For all of these, the
value of the TSC offset is added to the value of the time-stamp counter, and the sum is returned to guest software
			   ^^^^^
in EDX:EAX.

So it would be nice to keep the formula consistent for userspace:

GUEST_CLOCK_VAL = HOST_CLOCK_VAL + CLOCK_OFFSET

So would have to add a negative sign to the value to userspace.

Other than that, both the clock value (VCNTPCT_EL0) and the offset
(CNTVOFF_EL2) are not modified during guest execution? That is, CNTVOFF_EL2 is
written once during guest initialization.


> ---
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  arch/arm64/kvm/Makefile           |  2 +-
>  arch/arm64/kvm/arch_timer.c       |  2 +-
>  arch/arm64/kvm/debugfs.c          | 25 +++++++++++++++++++++++++
>  include/kvm/arm_arch_timer.h      |  3 +++
>  5 files changed, 31 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kvm/debugfs.c
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 2a5f7f38006f..130534c9079e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -29,6 +29,7 @@
>  #include <asm/thread_info.h>
>  
>  #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> +#define __KVM_HAVE_ARCH_VCPU_DEBUGFS
>  
>  #define KVM_HALT_POLL_NS_DEFAULT 500000
>  
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 989bb5dad2c8..17be7cf770f2 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -14,7 +14,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
>  	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
>  	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
>  	 inject_fault.o va_layout.o handle_exit.o \
> -	 guest.o debug.o reset.o sys_regs.o \
> +	 guest.o debug.o debugfs.o reset.o sys_regs.o \
>  	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
>  	 arch_timer.o trng.o\
>  	 vgic/vgic.o vgic/vgic-init.o \
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 3df67c127489..ee69387f7fb6 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -82,7 +82,7 @@ u64 timer_get_cval(struct arch_timer_context *ctxt)
>  	}
>  }
>  
> -static u64 timer_get_offset(struct arch_timer_context *ctxt)
> +u64 timer_get_offset(struct arch_timer_context *ctxt)
>  {
>  	struct kvm_vcpu *vcpu = ctxt->vcpu;
>  
> diff --git a/arch/arm64/kvm/debugfs.c b/arch/arm64/kvm/debugfs.c
> new file mode 100644
> index 000000000000..f0f5083ea8d4
> --- /dev/null
> +++ b/arch/arm64/kvm/debugfs.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Red Hat Inc.
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <linux/debugfs.h>
> +
> +#include <kvm/arm_arch_timer.h>
> +
> +static int vcpu_get_cntv_offset(void *data, u64 *val)
> +{
> +	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
> +
> +	*val = timer_get_offset(vcpu_vtimer(vcpu));
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(vcpu_cntvoff_fops, vcpu_get_cntv_offset, NULL, "%lld\n");
> +
> +void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
> +{
> +	debugfs_create_file("cntvoff", 0444, debugfs_dentry, vcpu, &vcpu_cntvoff_fops);
> +}
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index 51c19381108c..de0cd9be825c 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -106,4 +106,7 @@ void kvm_arm_timer_write_sysreg(struct kvm_vcpu *vcpu,
>  u32 timer_get_ctl(struct arch_timer_context *ctxt);
>  u64 timer_get_cval(struct arch_timer_context *ctxt);
>  
> +/* Nedded for debugfs */
> +u64 timer_get_offset(struct arch_timer_context *ctxt);
> +
>  #endif
> -- 
> 2.33.1
> 
> 

