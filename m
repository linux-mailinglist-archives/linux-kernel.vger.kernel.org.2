Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC023FFE68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349155AbhICKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235081AbhICKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630666319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHeIw9YVmcEgwNcQqJwIRj/uFxtFE2HXVzkecjvqdww=;
        b=KAluWqWQS9ZeqaHTzID0jIGN3HqFu+gZUY998ZYOQuD8/sSBCEEs09f7ZaVOyCuwdVL9gi
        iMnrQmvZTkz69qf+H4pqVvjxOx3pSh1SS/aku1vFIU8/BVqmkcIEqAfNBujTGjZ+2j6/KO
        39nnC8BwhnNm6HpIANjfFS/vGJCwtj4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-NAHDBvKTOh6nudSzTbcm9Q-1; Fri, 03 Sep 2021 06:51:58 -0400
X-MC-Unique: NAHDBvKTOh6nudSzTbcm9Q-1
Received: by mail-ed1-f72.google.com with SMTP id s25-20020a50d499000000b003c1a8573042so2561435edi.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 03:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHeIw9YVmcEgwNcQqJwIRj/uFxtFE2HXVzkecjvqdww=;
        b=om1FHY1ms+5rkdeK9pdvXma2Lw6pasu/vuaEEgUSE2N+TNPSqfu6wgTDXMqDcZGXUu
         bAQwzVsG2J37Du8PNgCXb8GPlFtaBMDbpat3Hu5EuYtSrZ2nmn3lHVpFWBOLIFBy1Xd/
         IfhHIaKgRXIMhL7NOiOiybRLIgmB80Nv+nU8r4LgyaIXTp5HnbUkvkzO0Qz7GBHFDtYZ
         CEaY+hy7WAzpsgMECMettTXnroJkR7A4t0bNzuH0OdjYNKtW//HDiPZ+1BkT64gOI05C
         6LXk3BMGvxiO/1rIaz0v1vd5I6knT71gkvfczKvTS8mFd0KlhdHr8+YFRUsK6u6I47pF
         7ggQ==
X-Gm-Message-State: AOAM530/VznBH4KXmLn1E4/RGklv7OgqYwmV9aNEjIHCB7eNPX3izWoi
        x21QFyKBMRfx5gl/YQL6+omYig7+AAhRC3hrZ1DEtOEhEQ5M6HisxkwdI+e+oYVz2KTjUbQckHM
        oUYHgJRul/O8pkhzXY419Ura0
X-Received: by 2002:a50:954c:: with SMTP id v12mr3312817eda.313.1630666317337;
        Fri, 03 Sep 2021 03:51:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyAFfqVO/C7ouLWgxFNht3qcnYfHlmXAIA9oHUIyykzFXWNqs4vtSc2/TiLy4hFCGFZQX0Nw==
X-Received: by 2002:a50:954c:: with SMTP id v12mr3312796eda.313.1630666317122;
        Fri, 03 Sep 2021 03:51:57 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id d3sm2560762ejw.18.2021.09.03.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 03:51:56 -0700 (PDT)
Date:   Fri, 3 Sep 2021 12:51:55 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 10/12] KVM: arm64: selftests: Add host support for vGIC
Message-ID: <20210903105155.dgu2bi765ngp3pgi@gator.home>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-11-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-11-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:10PM +0000, Raghavendra Rao Ananta wrote:
> Implement a simple library to do perform vGIC-v3
> setup from a host of view. This includes creating
> a vGIC device, setting up distributor and redistributor
> attributes, and mapping the guest physical addresses.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> 
> ---
>  tools/testing/selftests/kvm/Makefile          |  2 +-
>  .../selftests/kvm/include/aarch64/vgic.h      | 14 ++++
>  .../testing/selftests/kvm/lib/aarch64/vgic.c  | 67 +++++++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/vgic.h
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vgic.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 5476a8ddef60..8342f65c1d96 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -35,7 +35,7 @@ endif
>  
>  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
>  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> -LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c
> +LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>  
>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> new file mode 100644
> index 000000000000..45bbf238147a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ARM Generic Interrupt Controller (GIC) host specific defines
> + */
> +
> +#ifndef SELFTEST_KVM_VGIC_H
> +#define SELFTEST_KVM_VGIC_H
> +
> +#include <linux/kvm.h>
> +
> +int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus,
> +		uint64_t gicd_base_gpa, uint64_t gicr_base_gpa, uint32_t slot);

Having seen 5 arguments used in the vgic_v3_setup call in the next patch I
came back here to refresh my memory on that parameter. 'slot' is the one I
forgot, but...

> +
> +#endif /* SELFTEST_KVM_VGIC_H */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> new file mode 100644
> index 000000000000..a0e4b986d335
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Generic Interrupt Controller (GIC) v3 host support
> + */
> +
> +#include <linux/kvm.h>
> +#include <linux/sizes.h>
> +
> +#include "kvm_util.h"
> +
> +#define VGIC_V3_GICD_SZ		(SZ_64K)
> +#define VGIC_V3_GICR_SZ		(2 * SZ_64K)
> +
> +#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) \
> +	(((uint64_t)(count) << 52) | \
> +	((uint64_t)((base) >> 16) << 16) | \
> +	((uint64_t)(flags) << 12) | \
> +	index)
> +
> +static void vgic_v3_map(struct kvm_vm *vm, uint64_t addr, unsigned int size)
> +{
> +	unsigned int n_pages = DIV_ROUND_UP(size, vm_get_page_size(vm));
> +
> +	virt_map(vm, addr, addr, n_pages);
> +}
> +
> +/*
> + * vGIC-v3 default host setup
> + *
> + * Input args:
> + *	vm - KVM VM
> + *	nr_vcpus - Number of vCPUs for this VM
> + *	gicd_base_gpa - Guest Physical Address of the Distributor region
> + *	gicr_base_gpa - Guest Physical Address of the Redistributor region
> + *
> + * Output args: None
> + *
> + * Return: GIC file-descriptor or negative error code upon failure
> + *
> + * The function creates a vGIC-v3 device and maps the distributor and
> + * redistributor regions of the guest.
> + */
> +int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus,
> +		uint64_t gicd_base_gpa, uint64_t gicr_base_gpa)

...looks like it was forgotten here too.

Thanks,
drew

> +{
> +	uint64_t redist_attr;
> +	int gic_fd;
> +
> +	TEST_ASSERT(nr_vcpus <= KVM_MAX_VCPUS,
> +			"Invalid number of CPUs: %u\n", nr_vcpus);
> +
> +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +
> +	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> +			KVM_VGIC_V3_ADDR_TYPE_DIST, &gicd_base_gpa, true);
> +	vgic_v3_map(vm, gicd_base_gpa, VGIC_V3_GICD_SZ);
> +
> +	redist_attr = REDIST_REGION_ATTR_ADDR(nr_vcpus, gicr_base_gpa, 0, 0);
> +	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> +			KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &redist_attr, true);
> +	vgic_v3_map(vm, gicr_base_gpa, VGIC_V3_GICR_SZ * nr_vcpus);
> +
> +	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +				KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
> +
> +	return gic_fd;
> +}
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

